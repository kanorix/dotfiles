#!/bin/bash
set -eu
# set -x

function install_app() {
    apt install -y $1
}

install_app bat
install_app eza
install_app git-secrets
install_app sheldon
install_app starship
