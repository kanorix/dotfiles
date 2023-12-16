#!/bin/bash
set -eu
# set -x

### Rust install
apt install -y gcc
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"

### install application
cargo install cargo-binstall
cargo binstall --locked bat
cargo binstall eza
# install_app git-secrets
cargo binstall sheldon
cargo binstall --locked starship
