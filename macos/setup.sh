#!/bin/zsh
set -eu -o pipefail
# set -x

dotfiles_dir=~/dotfiles

##################################################
# brew install
##################################################

if ! (type brew > /dev/null 2>&1); then
    # Homebrewがなければインストールする
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Homebrewにパスを通す
UNAME_OS=`uname -s`
if [[ $UNAME_OS == "Darwin" ]]; then
    #mac用のコード
    echo "brew setup finished brew for Mac"
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ $UNAME_OS == "Linux" ]]; then
    #Linux用のコード
    echo "brew setup finished brew for Linux"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

##################################################
# application install
##################################################

cat $dotfiles_dir/macos/homebrew/Brewfile > .brewcache

brew bundle install --no-lock --cleanup --file=.brewcache
rm .brewcache

# docker buildx
if [ ! -L ~/.docker/cli-plugins/docker-buildx ]; then
    mkdir -p ~/.docker/cli-plugins
    ln -sfn $(which docker-buildx) ~/.docker/cli-plugins/docker-buildx
fi
