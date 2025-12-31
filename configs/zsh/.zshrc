export LANG=ja_JP.UTF-8

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

########################################################
# 環境変数
########################################################

export FZF_DEFAULT_OPTS='--layout=reverse --border --select-1'
