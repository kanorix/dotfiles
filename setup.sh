#!/bin/sh
set -eu
# set -x

cd ~/
git clone https://github.com/kanorix/dotfiles.git
cd dotfiles
git switch experimental

make setup
