DOTFILES_DIR=$(cd $(dirname $0); pwd)

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

    # 引数があるかチェックする
    # if ((${+opthash})); then
    #     for key in ${(@k)opthash}; do
    #         echo "flags: ${key} => value: ${opthash[$key]}"
    #     done
    # fi

    # if [ ! -e "$config_dir" ]; then
    #     # リンクする側が存在しない場合
    #     # mkdir -p $(dirname "$target")
    #     if [ ! -d "$source" ]; then
    #         touch "$target"
    #     fi
    #     echo $name "touch: " "$config_dir"
    # fi

    # dotfilesの指定されたディレクトリを取得する
    local source_dir=$DOTFILES_DIR/configs/$name
    # ディレクトリ内の全てのファイルを取得する
    local files=$(find $source_dir -type f)
    for file_path in $files; do
        # configとsourceで被っていない部分だけ取り出す
        local file_name=$(echo $file_path | sed "s|$source_dir/||")
        local source_path="$source_dir/$file_name"
        local target_path="$config_dir/$file_name"

        # すでにリンクが貼ってある場合、_backupを作成する
        if [ -h "$target_path" ]; then
            echo "create backup: " "$target_path"
            mv "$target_path" "$target_path.backup"
        fi

        if [ ! -e "$target_path" ]; then
            # リンクする側が存在しない場合
            mkdir -p $(dirname "$target_path")
        fi

        # リンクを貼る
        ln -sv "$source_path" "$target_path"
    done
}

# symlink starship
# symlink sheldon
# symlink zsh --config-dir ~/
# symlink zshenv --config-dir ~/.config/zshenv
# symlink colima --config-dir ~/.colima
# symlink kitty
# symlink docker --config-dir ~/.docker
