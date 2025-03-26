#################################  OTHERS  #################################
# automatically change directory when dir name is typed
setopt auto_cd
# ディレクトリ移動時に履歴を積む
DIRSTACKSIZE=100
setopt auto_pushd
# 同ディレクトリを履歴に追加しない
setopt pushd_ignore_dups

# 末尾から自動的に/を除かない
setopt noautoremoveslash

# 末尾に自動的に/を追加
setopt auto_param_slash

setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)

# disable ctrl+s, ctrl+q
setopt no_flow_control

setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt print_eight_bit  #日本語ファイル名等8ビットを通す

# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true
