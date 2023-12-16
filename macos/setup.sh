#!/bin/zsh
set -eu -o pipefail
# set -x

dotfiles_dir=~/dotfiles
profile=macos

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

\cat $dotfiles_dir/$profile/homebrew/Brewfile > .brewcache
# if [ ! -e $dotfiles_dir/$profile/homebrew/Brewfile ]; then
#     # Brewfileが存在しない場合、共通のBrewfileを使う
#     \cat $dotfiles_dir/common/homebrew/Brewfile > .brewcache
# else
    # # Brewfileが存在する場合、Brewfileを結合したものを使う
    # \cat $dotfiles_dir/common/homebrew/Brewfile $dotfiles_dir/$profile/homebrew/Brewfile \
    #     | sort --unique \
    #     | grep -v '^$' \
    #     | grep -v '^#' \
    #     > .brewcache
# fi

# デフォルトのシェルをzshに変更
# chsh -s $(which zsh)

brew bundle install --no-lock --cleanup --file=.brewcache
rm .brewcache

# docker buildx
if [ ! -L ~/.docker/cli-plugins/docker-buildx ]; then
    mkdir -p ~/.docker/cli-plugins
    ln -sfn $(which docker-buildx) ~/.docker/cli-plugins/docker-buildx
fi
