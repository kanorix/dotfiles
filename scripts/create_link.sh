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

function create_symbolic_link() {
    profile=$1
    mapping=`\cat $dotfiles_dir/$profile/mapping | grep -v '^$' | grep -v '^#'`
    echo $mapping | while IFS='"' read _ source _ target _;
    do
        # echo $source : $target
        if [[ ! -e $target ]]; then
            mkdir -p $(dirname $target)
            touch "$target"
        fi

        ln -svf $dotfiles_dir/$profile/$source ~/$target
    done
}

create_symbolic_link common
create_symbolic_link $profile
