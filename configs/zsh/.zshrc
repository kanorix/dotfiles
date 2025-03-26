export LANG=ja_JP.UTF-8

# cargo (rust module binary path)
source "$HOME/.cargo/env"

# abd
export PATH=$PATH:/Users/ryu/Library/Android/sdk/platform-tools

# Homebrewでインストールしたアプリにパスを通す
UNAME_OS=`uname -s`
if [[ $UNAME_OS == "Darwin" ]]; then
    #mac用のコード
    # Path to fvm (flutter version management)
    export PATH=$PATH:$HOME/fvm/default/bin

    # volta (nodejs version management)
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export FZF_DEFAULT_OPTS='--layout=reverse --border --select-1'
# elif [[ $UNAME_OS == "Linux" ]]; then
#     #Linux用のコード
#     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# sheldonを起動する
# https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache

# ファイル名を変数に入れる
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$HOME/.config/sheldon/plugins.toml"
# キャッシュがない、またはキャッシュが古い場合にキャッシュを作成
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
    mkdir -p $cache_dir
    sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
# 使い終わった変数を削除
unset cache_dir sheldon_cache sheldon_toml
