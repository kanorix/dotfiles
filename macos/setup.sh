#!/bin/zsh
set -eu -o pipefail
# set -x

# docker buildx
if [ ! -L ~/.docker/cli-plugins/docker-buildx ]; then
    mkdir -p ~/.docker/cli-plugins
    ln -sfn $(which docker-buildx) ~/.docker/cli-plugins/docker-buildx
fi
