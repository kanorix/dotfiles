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
    _profile=$1
    if [ ! -e $dotfiles_dir/$_profile/mapping ]; then
        echo "Not found: $dotfiles_dir/$prof/mapping"
        return 0
    fi

    # 空行、コメントを削除したmappingファイルを作る
    cat $dotfiles_dir/$_profile/mapping | grep -v '^$' | grep -v '^#' > .linkcache

    while IFS='"' read _ source _ target _;
    do
        # echo $source : $target
        echo "file: ~/$target"
        if [ ! -e ~/"$target" ]; then
            echo "created file: ~/$target"
            mkdir -p $(dirname ~/"$target")
            touch ~/"$target"
        fi

        ln -svf $dotfiles_dir/$_profile/$source ~/$target
    done < .linkcache
    rm .linkcache
}

create_symbolic_link common
create_symbolic_link $profile
