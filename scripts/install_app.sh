#!/bin/bash
set -eu
# set -x

dotfiles_dir=~/dotfiles
profiles=(macos linux)

if [ $# != 1 ]; then
    echo "引数エラー: expected:[PROFILE]. but got [$*]"
    exit 1
fi

if [[ ! ${profiles[*]} =~ (^|[[:space:]])"$1"($|[[:space:]]) ]]; then
    # 引数で指定されたプロファイルが存在しない
    echo "No such profile: $1"
    exit 1
fi

# if [[ ${profiles[(ie)$1]} -gt ${#profiles} ]]; then
#     # 引数で指定されたプロファイルが存在しない
#     echo "No such profile: $1"
#     exit 1
# fi

profile=$1

##################################################
# brew install
##################################################

if ! (type brew > /dev/null 2>&1); then
    # Homebrewがなければインストールする
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Homebrewにパスを通す
UNAME_OS=`uname -s`
if [ UNAME_OS = "Darwin" ]; then
    #mac用のコード
    echo "brew setup finished brew for Mac"
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ UNAME_OS = "Linux" ]; then
    #Linux用のコード
    echo "brew setup finished brew for Linux"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo ##################################################
echo # application install
echo ##################################################

if [ ! -e $dotfiles_dir/$profile/homebrew/Brewfile ]; then
    # Brewfileが存在しない場合、共通のBrewfileを使う
    \cat $dotfiles_dir/common/homebrew/Brewfile > .brewcache
else
    # Brewfileが存在する場合、Brewfileを結合したものを使う
    \cat $dotfiles_dir/common/homebrew/Brewfile $dotfiles_dir/$profile/homebrew/Brewfile \
        | sort --unique \
        | grep -v '^$' \
        | grep -v '^#' \
        > .brewcache
fi

# デフォルトのシェルをzshに変更
# chsh -s $(which zsh)

brew bundle install --no-lock --cleanup --file=.brewcache
rm .brewcache

# init zsh plugin
sheldon lock
