module github.com/anchore/syft

go 1.18

require (
	github.com/acarl005/stripansi v0.0.0-20180116102854-5a71ef0e047d
	github.com/acobaugh/osrelease v0.1.0
	github.com/adrg/xdg v0.4.0
	github.com/anchore/go-macholibre v0.0.0-20220308212642-53e6d0aaf6fb
	github.com/anchore/go-testutils v0.0.0-20200925183923-d5f45b0d3c04
	github.com/anchore/go-version v1.2.2-0.20200701162849-18adb9c92b9b
	github.com/anchore/packageurl-go v0.1.1-0.20230104203445-02e0a6721501
	github.com/bmatcuk/doublestar/v4 v4.0.2
	github.com/dustin/go-humanize v1.0.0
	github.com/facebookincubator/nvdtools v0.1.4
	github.com/go-test/deep v1.0.8
	github.com/google/go-cmp v0.5.9
	github.com/google/uuid v1.3.0
	github.com/gookit/color v1.4.2
	github.com/hashicorp/go-multierror v1.1.1
	github.com/jinzhu/copier v0.3.2
	github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d // indirect
	github.com/mholt/archiver/v3 v3.5.1
	github.com/microsoft/go-rustaudit v0.0.0-20220730194248-4b17361d90a5
	github.com/mitchellh/go-homedir v1.1.0
	github.com/mitchellh/hashstructure/v2 v2.0.2
	github.com/mitchellh/mapstructure v1.5.0
	github.com/olekukonko/tablewriter v0.0.5
	github.com/pelletier/go-toml v1.9.5
	// pinned to pull in 386 arch fix: https://github.com/scylladb/go-set/commit/cc7b2070d91ebf40d233207b633e28f5bd8f03a5
	github.com/scylladb/go-set v1.0.3-0.20200225121959-cc7b2070d91e
	github.com/sergi/go-diff v1.2.0
	github.com/sirupsen/logrus v1.9.3
	github.com/spdx/tools-golang v0.3.1-0.20221108182156-8a01147e6342
	github.com/spf13/afero v1.8.2
	github.com/spf13/cobra v1.6.1
	github.com/spf13/pflag v1.0.5
	github.com/spf13/viper v1.13.0
	github.com/stretchr/testify v1.8.4
	github.com/vifraa/gopom v0.1.0
	github.com/wagoodman/go-partybus v0.0.0-20210627031916-db1f5573bbc5
	github.com/wagoodman/go-progress v0.0.0-20230925121702-07e42b3cdba0
	github.com/wagoodman/jotframe v0.0.0-20211129225309-56b0d0a4aebb
	github.com/xeipuuv/gojsonschema v1.2.0
	golang.org/x/mod v0.11.0
	golang.org/x/net v0.23.0
	golang.org/x/term v0.18.0
	gopkg.in/yaml.v2 v2.4.0
)

require (
	github.com/CycloneDX/cyclonedx-go v0.7.1-0.20221222100750-41a1ac565cce
	github.com/Masterminds/sprig/v3 v3.2.2
	github.com/anchore/go-logger v0.0.0-20220728155337-03b66a5207d8
	github.com/anchore/stereoscope v0.0.1
	github.com/docker/docker v23.0.3+incompatible
	github.com/google/go-containerregistry v0.14.0
	github.com/invopop/jsonschema v0.7.0
	github.com/knqyf263/go-rpmdb v0.0.0-20221030135625-4082a22221ce
	github.com/opencontainers/go-digest v1.0.0
	github.com/sassoftware/go-rpmutils v0.2.0
	github.com/vbatts/go-mtree v0.5.0
	golang.org/x/exp v0.0.0-20220823124025-807a23277127
	gopkg.in/yaml.v3 v3.0.1
)

require (
	github.com/AdaLogics/go-fuzz-headers v0.0.0-20230811130428-ced1acdcaa24 // indirect
	github.com/AdamKorcz/go-118-fuzz-build v0.0.0-20230306123547-8075edf89bb0 // indirect
	github.com/DataDog/zstd v1.4.5 // indirect
	github.com/Masterminds/goutils v1.1.1 // indirect
	github.com/Masterminds/semver/v3 v3.1.1 // indirect
	github.com/Microsoft/go-winio v0.6.1 // indirect
	github.com/Microsoft/hcsshim v0.11.4 // indirect
	github.com/becheran/wildmatch-go v1.0.0 // indirect
	github.com/containerd/cgroups v1.1.0 // indirect
	github.com/containerd/containerd v1.7.11 // indirect
	github.com/containerd/continuity v0.4.2 // indirect
	github.com/containerd/fifo v1.1.0 // indirect
	github.com/containerd/log v0.1.0 // indirect
	github.com/containerd/stargz-snapshotter/estargz v0.14.3 // indirect
	github.com/containerd/ttrpc v1.2.2 // indirect
	github.com/containerd/typeurl/v2 v2.1.1 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/docker/cli v23.0.3+incompatible // indirect
	github.com/docker/distribution v2.8.2+incompatible // indirect
	github.com/docker/docker-credential-helpers v0.7.0 // indirect
	github.com/docker/go-connections v0.4.0 // indirect
	github.com/docker/go-events v0.0.0-20190806004212-e31b211e4f1c // indirect
	github.com/docker/go-units v0.5.0 // indirect
	github.com/dsnet/compress v0.0.2-0.20210315054119-f66993602bf5 // indirect
	github.com/felixge/httpsnoop v1.0.3 // indirect
	github.com/fsnotify/fsnotify v1.6.0 // indirect
	github.com/gabriel-vasile/mimetype v1.4.0 // indirect
	github.com/go-logr/logr v1.2.4 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-restruct/restruct v1.2.0-alpha // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/golang/snappy v0.0.4 // indirect
	github.com/hashicorp/errwrap v1.1.0 // indirect
	github.com/hashicorp/hcl v1.0.0 // indirect
	github.com/huandu/xstrings v1.3.2 // indirect
	github.com/iancoleman/orderedmap v0.0.0-20190318233801-ac98e3ecb4b0 // indirect
	github.com/imdario/mergo v0.3.13 // indirect
	github.com/inconshreveable/mousetrap v1.1.0 // indirect
	github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51 // indirect
	github.com/klauspost/compress v1.16.4 // indirect
	github.com/klauspost/pgzip v1.2.5 // indirect
	github.com/logrusorgru/aurora v0.0.0-20200102142835-e9ef32dff381 // indirect
	github.com/magiconair/properties v1.8.6 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.16 // indirect
	github.com/mattn/go-runewidth v0.0.13 // indirect
	github.com/mitchellh/copystructure v1.2.0 // indirect
	github.com/mitchellh/reflectwalk v1.0.2 // indirect
	github.com/moby/locker v1.0.1 // indirect
	github.com/moby/sys/mountinfo v0.6.2 // indirect
	github.com/moby/sys/sequential v0.5.0 // indirect
	github.com/moby/sys/signal v0.7.0 // indirect
	github.com/moby/term v0.0.0-20210619224110-3f7ff695adc6 // indirect
	github.com/nwaples/rardecode v1.1.0 // indirect
	github.com/opencontainers/image-spec v1.1.0-rc2.0.20221005185240-3a7f492d3f1b // indirect
	github.com/opencontainers/runc v1.1.5 // indirect
	github.com/opencontainers/runtime-spec v1.1.0-rc.1 // indirect
	github.com/opencontainers/selinux v1.11.0 // indirect
	github.com/pelletier/go-toml/v2 v2.0.5 // indirect
	github.com/pierrec/lz4/v4 v4.1.15 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/remyoudompheng/bigfft v0.0.0-20200410134404-eec4a21b6bb0 // indirect
	github.com/rivo/uniseg v0.2.0 // indirect
	github.com/rogpeppe/go-internal v1.8.0 // indirect
	github.com/shopspring/decimal v1.2.0 // indirect
	github.com/spf13/cast v1.5.0 // indirect
	github.com/spf13/jwalterweatherman v1.1.0 // indirect
	github.com/stretchr/objx v0.5.0 // indirect
	github.com/subosito/gotenv v1.4.1 // indirect
	github.com/sylabs/sif/v2 v2.8.1 // indirect
	github.com/sylabs/squashfs v0.6.1 // indirect
	github.com/therootcompany/xz v1.0.1 // indirect
	github.com/ulikunitz/xz v0.5.10 // indirect
	github.com/vbatts/tar-split v0.11.2 // indirect
	github.com/xeipuuv/gojsonpointer v0.0.0-20190905194746-02993c407bfb // indirect
	github.com/xeipuuv/gojsonreference v0.0.0-20180127040603-bd5ef7bd5415 // indirect
	github.com/xi2/xz v0.0.0-20171230120015-48954b6210f8 // indirect
	github.com/xo/terminfo v0.0.0-20210125001918-ca9a967f8778 // indirect
	go.opencensus.io v0.24.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.45.0 // indirect
	go.opentelemetry.io/otel v1.19.0 // indirect
	go.opentelemetry.io/otel/metric v1.19.0 // indirect
	go.opentelemetry.io/otel/trace v1.19.0 // indirect
	golang.org/x/sync v0.3.0 // indirect
	golang.org/x/sys v0.18.0 // indirect
	golang.org/x/text v0.14.0 // indirect
	golang.org/x/time v0.0.0-20220922220347-f3bd1da661af // indirect
	golang.org/x/tools v0.10.0 // indirect
	golang.org/x/xerrors v0.0.0-20220907171357-04be3eba64a2 // indirect
	google.golang.org/genproto v0.0.0-20230711160842-782d3b101e98 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20230711160842-782d3b101e98 // indirect
	google.golang.org/grpc v1.58.3 // indirect
	google.golang.org/protobuf v1.31.0 // indirect
	gopkg.in/ini.v1 v1.67.0 // indirect
	lukechampine.com/uint128 v1.1.1 // indirect
	modernc.org/cc/v3 v3.36.0 // indirect
	modernc.org/ccgo/v3 v3.16.6 // indirect
	modernc.org/libc v1.16.7 // indirect
	modernc.org/mathutil v1.4.1 // indirect
	modernc.org/memory v1.1.1 // indirect
	modernc.org/opt v0.1.1 // indirect
	modernc.org/sqlite v1.17.3 // indirect
	modernc.org/strutil v1.1.1 // indirect
	modernc.org/token v1.0.0 // indirect
)

require (
	// we are hinting brotli to latest due to warning when installing archiver v3:
	// go: warning: github.com/andybalholm/brotli@v1.0.1: retracted by module author: occasional panics and data corruption
	github.com/andybalholm/brotli v1.0.4 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	golang.org/x/crypto v0.21.0 // indirect
)

retract (
	v0.53.2
	v0.53.1 // Published accidentally with incorrect license in depdencies
)
