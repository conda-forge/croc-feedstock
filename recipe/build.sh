#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

# https://github.com/golang/go/issues/82324
# golang.org/x/sys v0.49.0 ppc64le syscall trampolines crash PIE binaries at startup
if [[ "${target_platform}" == "linux-ppc64le" ]]; then
    export GOFLAGS="${GOFLAGS:-} -buildmode=exe"
fi

go build -o=${PREFIX}/bin/${PKG_NAME} -ldflags="-s -w"
go-licenses save . --save_path=license-files
