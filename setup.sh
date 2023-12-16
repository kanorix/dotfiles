#!/bin/bash
set -eu
# set -x

UNAME_OS=`uname -s`
if [[ $UNAME_OS == "Darwin" ]]; then
    #mac用のコード
elif [[ $UNAME_OS == "Linux" ]]; then
    #Linux用のコード
    apt update
    apt install -y git make
else
    echo nomatch
fi

cd ~/
git clone https://github.com/kanorix/dotfiles.git
cd dotfiles
git switch experimental

make setup
