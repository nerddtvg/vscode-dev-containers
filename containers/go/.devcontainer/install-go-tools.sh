# Verify running as root / using sudo
if [ "$(id -u)" -ne 0 ]; then
    echo 'Script must be run a root. Use sudo or set "USER root" before running the script.'
    exit 1
fi

set -e

# Create a temporary location for getting go tools
export GOPATH=/tmp/gotools
mkdir -p ${GOPATH}
cd ${GOPATH}

# Get tools that have Go modules
export GO111MODULE=on
GO_MODULE_TOOLS="golang.org/x/tools/cmd/gorename@latest \
    golang.org/x/tools/gopls@latest \
    honnef.co/go/tools/...@latest \
    golang.org/x/tools/cmd/goimports@latest \
    golang.org/x/tools/cmd/guru@latest \
    golang.org/x/lint/golint@latest \
    github.com/mdempsky/gocode@latest \
    github.com/cweill/gotests/...@latest \
    github.com/haya14busa/goplay/cmd/goplay@latest \
    github.com/sqs/goreturns@latest \
    github.com/josharian/impl@latest \
    github.com/davidrjenni/reftools/cmd/fillstruct@latest \
    github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest \
    github.com/ramya-rao-a/go-outline@latest \
    github.com/acroca/go-symbols@latest \
    github.com/godoctor/godoctor@latest \
    github.com/rogpeppe/godef@latest \
    github.com/zmb3/gogetdoc@latest \
    github.com/fatih/gomodifytags@latest \
    github.com/go-delve/delve/cmd/dlv@latest \
    github.com/mgechev/revive@latest"
(echo "${GO_MODULE_TOOLS}" | xargs -n 1 go get )2>&1

# Get tools w/o modules
export GO111MODULE=auto
go get github.com/alecthomas/gometalinter 2>&1

# Get and build gocode-gomod
go get -d github.com/stamblerre/gocode 2>&1
go build -o gocode-gomod github.com/stamblerre/gocode

# Install golangci-lint
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin 2>&1

# Move all tools to /usr/local/bin
mv /tmp/gotools/bin/* /usr/local/bin/
mv gocode-gomod /usr/local/bin/

# Clean up
rm -rf /tmp/gotools