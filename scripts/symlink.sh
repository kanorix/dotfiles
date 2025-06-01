#!/bin/zsh

DOTFILES_DIR=$(cd $(dirname $0)/..; pwd)

# echo "DOTFILES_DIR: " $DOTFILES_DIR

# symlink $1
# $1: name
# -config-dir: symbolicリンクを貼るディレクトリ
function symlink() {
    # 関数の引数をハッシュに格納する
    local -A opthash
    zparseopts -D -E -A opthash -- \
        -config-dir: \
        -help

    local name=$1
    local config_dir=${opthash[--config-dir]:-$HOME/.config/$name}
    # 末尾のスラッシュを削除
    config_dir=${config_dir%/}

    echo "setup: $name in $config_dir"

    # 引数があるかチェックする
    # if ((${+opthash})); then
    #     for key in ${(@k)opthash}; do
    #         echo "flags: ${key} => value: ${opthash[$key]}"
    #     done
    # fi

    # dotfilesの指定されたディレクトリを取得する
    local source_dir=$DOTFILES_DIR/configs/$name
    # ディレクトリ内の全てのファイルを取得する
    # -A: 隠しファイルを含むが、./..は除外される
    \ls -A $source_dir | while read file_path; do
        # echo "file_path: " $file_path
        # configとsourceで被っていない部分だけ取り出す
        local file_name=$(echo $file_path | sed "s|$source_dir/||")
        local source_path="$source_dir/$file_name"
        local target_path="$config_dir/$file_name"

        # すでにリンクが貼ってある場合、リンクを削除
        if [ -h "$target_path" ]; then
            # echo "\tdelete link: " "$target_path"
            unlink "$target_path"
        fi

        # すでにファイルが存在する場合、バックアップを作成
        if [ -e "$target_path" ]; then
            echo "\tcreate backup: " "$target_path"
            mv "$target_path" "$target_path.backup"
        fi

        # リンクする先のディレクトリが存在しない場合、ディレクトリを作成
        if [ ! -e "$target_path" ]; then
            mkdir -p $(dirname "$target_path")
        fi

        # リンクする先のファイルが存在しない場合、ファイルを作成する
        if [ ! -e "$source_path" ]; then
            touch "$source_path"
        fi

        # リンクを貼る
        ln -s "$source_path" "$target_path"
        echo "\tcreate link: " "$source_path"
    done
}
