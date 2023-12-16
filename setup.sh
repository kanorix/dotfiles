#!/bin/bash
set -eu
# set -x

UNAME_OS=`uname -s`
if [[ $UNAME_OS == "Darwin" ]]; then
    #mac用のコード
    echo "mac"
elif [[ $UNAME_OS == "Linux" ]]; then
    #Linux用のコード
    apt update
    apt install -y git make
    if ! (type rustup > /dev/null 2>&1); then
        # rustがなければインストールする
        curl https://sh.rustup.rs -sSf | sh -s -- -y
        source "$HOME/.cargo/env"
    fi
else
    echo nomatch
fi

cd ~/
git clone https://github.com/kanorix/dotfiles.git
cd dotfiles
git switch experimental

make setup
