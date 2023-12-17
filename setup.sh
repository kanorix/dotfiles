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
    (type git > /dev/null 2>&1) || apt install -y git
    (type make > /dev/null 2>&1) || apt install -y make
    (type zsh > /dev/null 2>&1) || apt install -y zsh
else
    echo "No supported OS!"
    exit 0
fi

cd ~/
git clone https://github.com/kanorix/dotfiles.git
cd dotfiles
git switch experimental

make setup
