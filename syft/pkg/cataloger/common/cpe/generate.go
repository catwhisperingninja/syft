package cpe

import (
	"bufio"
	"bytes"
	"fmt"
	"sort"
	"strings"

	"github.com/facebookincubator/nvdtools/wfn"
	"github.com/scylladb/go-set/strset"

	"github.com/anchore/syft/internal"
	"github.com/anchore/syft/syft/cpe"
	"github.com/anchore/syft/syft/pkg"
)

// knownVendors contains vendor strings that are known to exist in
// the CPE database, so they will be preferred over other candidates:
var knownVendors = strset.New("apache")

func newCPE(product, vendor, version, targetSW string) *wfn.Attributes {
	c := *(wfn.NewAttributesWithAny())
	c.Part = "a"
	c.Product = product
	c.Vendor = vendor
	c.Version = version
	c.TargetSW = targetSW
	if cpe.ValidateString(cpe.String(c)) != nil {
		return nil
	}
	return &c
}

// Generate Create a list of CPEs for a given package, trying to guess the vendor, product tuple. We should be trying to
// generate the minimal set of representative CPEs, which implies that optional fields should not be included
// (such as target SW).
func Generate(p pkg.Package) []cpe.CPE {
	vendors := candidateVendors(p)
	products := candidateProducts(p)
	if len(products) == 0 {
		return nil
	}

	keys := internal.NewStringSet()
	cpes := make([]cpe.CPE, 0)
	for _, product := range products {
		for _, vendor := range vendors {
			// prevent duplicate entries...
			key := fmt.Sprintf("%s|%s|%s", product, vendor, p.Version)
			if keys.Contains(key) {
				continue
			}
			keys.Add(key)
			// add a new entry...
			if c := newCPE(product, vendor, p.Version, wfn.Any); c != nil {
				cpes = append(cpes, *c)
			}
		}
	}

	// filter out any known combinations that don't accurately represent this package
	cpes = filter(cpes, p, cpeFilters...)

	sort.Sort(cpe.BySpecificity(cpes))

	return cpes
}

func candidateVendors(p pkg.Package) []string {
	// in ecosystems where the packaging metadata does not have a clear field to indicate a vendor (or a field that
	// could be interpreted indirectly as such) the project name tends to be a common stand in. Examples of this
	// are the elasticsearch gem, xstream jar, and rack gem... all of these cases you can find vulnerabilities
	// with CPEs where the vendor is the product name and doesn't appear to be derived from any available package
	// metadata.
	vendors := newFieldCandidateSet(candidateProducts(p)...)

	switch p.Language {
	case pkg.JavaScript:
		// for JavaScript if we find node.js as a package then the vendor is "nodejs"
		if p.Name == "node.js" {
			vendors.addValue("nodejs")
		}
	case pkg.Ruby:
		vendors.addValue("ruby-lang")
	case pkg.Go:
		// replace all candidates with only the golang-specific helper
		vendors.clear()

		vendor := candidateVendorForGo(p.Name)
		if vendor != "" {
			vendors.addValue(vendor)
		}
	}

	// some ecosystems do not have enough metadata to determine the vendor accurately, in which case we selectively
	// allow * as a candidate. Note: do NOT allow Java packages to have * vendors.
	switch p.Language {
	case pkg.Ruby, pkg.JavaScript:
		vendors.addValue(wfn.Any)
	}

	switch p.MetadataType {
	case pkg.RpmMetadataType:
		vendors.union(candidateVendorsForRPM(p))
	case pkg.GemMetadataType:
		vendors.union(candidateVendorsForRuby(p))
	case pkg.PythonPackageMetadataType:
		vendors.union(candidateVendorsForPython(p))
	case pkg.JavaMetadataType:
		vendors.union(candidateVendorsForJava(p))
	}

	// try swapping hyphens for underscores, vice versa, and removing separators altogether
	addDelimiterVariations(vendors)

	// generate sub-selections of each candidate based on separators (e.g. jenkins-ci -> [jenkins, jenkins-ci])
	addAllSubSelections(vendors)

	// add more candidates based on the package info for each vendor candidate
	for _, vendor := range vendors.uniqueValues() {
		vendors.addValue(findAdditionalVendors(defaultCandidateAdditions, p.Type, p.Name, vendor)...)
	}

	// remove known mis
	vendors.removeByValue(findVendorsToRemove(defaultCandidateRemovals, p.Type, p.Name)...)

	uniqueVendors := vendors.uniqueValues()

	// if any known vendor was detected, pick that one.
	for _, vendor := range uniqueVendors {
		if knownVendors.Has(vendor) {
			return []string{vendor}
		}
	}

	return uniqueVendors
}

func candidateProducts(p pkg.Package) []string {
	products := newFieldCandidateSet(p.Name)

	switch {
	case p.Language == pkg.Python:
		if !strings.HasPrefix(p.Name, "python") {
			products.addValue("python-" + p.Name)
		}
	case p.Language == pkg.Java || p.MetadataType == pkg.JavaMetadataType:
		products.addValue(candidateProductsForJava(p)...)
	case p.Language == pkg.Go:
		// replace all candidates with only the golang-specific helper
		products.clear()

		prod := candidateProductForGo(p.Name)
		if prod != "" {
			products.addValue(prod)
		}
	}
	// it is never OK to have candidates with these values ["" and "*"] (since CPEs will match any other value)
	products.removeByValue("")
	products.removeByValue("*")

	// try swapping hyphens for underscores, vice versa, and removing separators altogether
	addDelimiterVariations(products)

	// add known candidate additions
	products.addValue(findAdditionalProducts(defaultCandidateAdditions, p.Type, p.Name)...)

	// remove known candidate removals
	products.removeByValue(findProductsToRemove(defaultCandidateRemovals, p.Type, p.Name)...)

	return products.uniqueValues()
}

func addAllSubSelections(fields fieldCandidateSet) {
	candidatesForVariations := fields.copy()
	candidatesForVariations.removeWhere(subSelectionsDisallowed)

	for _, candidate := range candidatesForVariations.values() {
		fields.addValue(generateSubSelections(candidate)...)
	}
}

// generateSubSelections attempts to split a field by hyphens and underscores and return a list of sensible sub-selections
// that can be used as product or vendor candidates. E.g. jenkins-ci-tools -> [jenkins-ci-tools, jenkins-ci, jenkins].
func generateSubSelections(field string) (results []string) {
	scanner := bufio.NewScanner(strings.NewReader(field))
	scanner.Split(scanByHyphenOrUnderscore)
	var lastToken uint8
	for scanner.Scan() {
		rawCandidate := scanner.Text()
		if len(rawCandidate) == 0 {
			break
		}

		// trim any number of hyphen or underscore that is prefixed/suffixed on the given candidate. Since
		// scanByHyphenOrUnderscore preserves delimiters (hyphens and underscores) they are guaranteed to be at least
		// prefixed.
		candidate := strings.TrimFunc(rawCandidate, trimHyphenOrUnderscore)

		// capture the result (if there is content)
		if len(candidate) > 0 {
			if len(results) > 0 {
				results = append(results, results[len(results)-1]+string(lastToken)+candidate)
			} else {
				results = append(results, candidate)
			}
		}

		// keep track of the trailing separator for the next loop
		lastToken = rawCandidate[len(rawCandidate)-1]
	}
	return results
}

// trimHyphenOrUnderscore is a character filter function for use with strings.TrimFunc in order to remove any hyphen or underscores.
func trimHyphenOrUnderscore(r rune) bool {
	switch r {
	case '-', '_':
		return true
	}
	return false
}

// scanByHyphenOrUnderscore splits on hyphen or underscore and includes the separator in the split
func scanByHyphenOrUnderscore(data []byte, atEOF bool) (advance int, token []byte, err error) {
	if atEOF && len(data) == 0 {
		return 0, nil, nil
	}
	if i := bytes.IndexAny(data, "-_"); i >= 0 {
		return i + 1, data[0 : i+1], nil
	}

	if atEOF {
		return len(data), data, nil
	}

	return 0, nil, nil
}

func addDelimiterVariations(fields fieldCandidateSet) {
	candidatesForVariations := fields.copy()
	candidatesForVariations.removeWhere(delimiterVariationsDisallowed)

	for _, candidate := range candidatesForVariations.list() {
		field := candidate.value
		hasHyphen := strings.Contains(field, "-")
		hasUnderscore := strings.Contains(field, "_")

		if hasHyphen {
			// provide variations of hyphen candidates with an underscore
			newValue := strings.ReplaceAll(field, "-", "_")
			underscoreCandidate := candidate
			underscoreCandidate.value = newValue
			fields.add(underscoreCandidate)
		}

		if hasUnderscore {
			// provide variations of underscore candidates with a hyphen
			newValue := strings.ReplaceAll(field, "_", "-")
			hyphenCandidate := candidate
			hyphenCandidate.value = newValue
			fields.add(hyphenCandidate)
		}
	}
}
