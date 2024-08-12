#!/bin/bash
# set -eu
# set -x

### Argumant ###

# PROFILE=$1
DOTFILES_DIR=~/dotfiles

function exists() {
    local command=$1
    return $(type $command > /dev/null 2>&1)
}

function symlink() {
    local name=$1
    # yq -oy ".$name" $DOTFILES_DIR/configs/mappings.toml
    # ls -al $DOTFILES_DIR/configs/mappings.toml
    yq -oy ".$name" "$DOTFILES_DIR/configs/mappings.toml" | while IFS=":" read -r key value; do
        # keyとvalueの前後の空白をトリム
        local source=$DOTFILES_DIR/configs/$name/$(echo $key)
        local target=$(echo $value)

        if [ -h ~/"$target" ]; then
            # シンボリックリンクがすでに貼ってある場合、一度Unlilnkする
            unlink ~/"$target"
        fi
        if [ ! -e ~/"$target" ]; then
            # リンクする側が存在しない場合
            mkdir -p $(dirname ~/"$target")
            if [ ! -d $source ]; then
                touch ~/"$target"
            fi
        fi

        # シンボリックリンクの作成
        ln -svf "$source" ~/"$target"
    done
}

### Pre install ###

UNAME_OS=`uname -s`
if [[ $UNAME_OS == "Darwin" ]]; then
    #mac用のコード
    echo "mac"
    exists yq || brew install yq
elif [[ $UNAME_OS == "Linux" ]]; then
    #Linux用のコード
    apt update
    exists git || apt install -y git
    # (type make > /dev/null 2>&1) || apt install -y make
    exists zsh || apt install -y zsh
else
    echo "No supported OS!"
    exit 0
fi

# ### Clone repository ###

# cd ~/

# git clone https://github.com/kanorix/dotfiles.git

# cd dotfiles

# ### Install

# exists yq || brew install yq
