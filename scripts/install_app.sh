#!/bin/zsh
set -u
# set -x

dotfiles_dir=~/dotfiles
profiles=(macos linux)

if [ $# != 1 ]; then
    echo "引数エラー: expected:[PROFILE]. but got [$*]"
    exit 1
fi

if [[ ${profiles[(ie)$1]} -gt ${#profiles} ]]; then
    # 引数で指定されたプロファイルが存在しない
    echo "No such profile: $1"
    exit 1
fi

profile=$1

##################################################
# brew install
##################################################

if ! (type brew > /dev/null 2>&1); then
    # Homebrewがなければインストールする
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "run brew doctor ..."
brew doctor

##################################################
# application install
##################################################

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

brew bundle install --no-lock --cleanup --force --file=.brewcache
rm .brewcache

# init zsh plugin
sheldon lock
