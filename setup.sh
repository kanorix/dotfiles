#!/bin/zsh
set -eu -o pipefail
# set -x

cd ~/
git clone https://github.com/kanorix/dotfiles.git
cd dotfiles

make setup
