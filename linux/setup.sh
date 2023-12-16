#!/bin/bash
set -eu
# set -x

### Rust install
curl https://sh.rustup.rs -sSf | sh -s -- -y

cargo install cargo-binstall
cargo binstall --locked bat
cargo binstall eza
# install_app git-secrets
cargo binstall sheldon
cargo binstall --locked starship
