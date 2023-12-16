# 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[-_.]=**' '+m:{[:upper:]}={[:lower:]}'

# 補完関数の表示を強化する(https://voidy21.hatenablog.jp/entry/20090902/1251918174)
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _list _history
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:options' description 'yes'

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2

### キャッシュを使用
zstyle ':completion:*' use-cache true

### Brewによって追加されるコマンドの補完をONにする
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# enable completion
autoload -Uz compinit && compinit
