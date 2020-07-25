#!/usr/bin/env bash
# ****************************************
# **    WARNING: THIS FILE IS A STUB    **
# ****************************************

# It is automatically replaced by a file with the same name in this repo when packaged:
# https://github.com/microsoft/vscode-dev-containers/tree/master/script-library
#
#  You can also opt to manually copy the script here instead.

# Verify running as root / using sudo
if [ "$(id -u)" -ne 0 ]; then
    echo 'Script must be run a root. Use sudo or set "USER root" before running the script.'
    exit 1
fi

set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install --no-install-recommends curl ca-certificates
curl -sSL -o- "https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/script-library/$(basename $0)" | bash -s -- "$@" 
