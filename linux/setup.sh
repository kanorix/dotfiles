#!/bin/bash
set -eu
# set -x

### Rust install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install cargo-binstall
cargo binstall --locked bat
cargo binstall eza
# install_app git-secrets
cargo binstall sheldon
cargo binstall --locked starship
