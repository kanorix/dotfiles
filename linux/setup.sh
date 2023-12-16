#!/bin/bash
set -eu
# set -x

### Rust install

if ! (type gcc > /dev/null 2>&1); then
    # gccがなければインストールする
    apt install -y gcc
fi

if ! (type rustup > /dev/null 2>&1); then
    # rustがなければインストールする
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$HOME/.cargo/env"
fi

### install cargo-binstall
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

### install application
cargo binstall --no-confirm --locked bat
cargo binstall --no-confirm eza
# install_app git-secrets
cargo binstall --no-confirm sheldon
cargo binstall --no-confirm --locked starship
