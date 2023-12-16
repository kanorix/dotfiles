#!/bin/zsh
set -eu -o pipefail
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

brew bundle check --file=.brewcache
rm .brewcache
