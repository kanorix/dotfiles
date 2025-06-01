# kanorix's dotfiles

## MacOS

### 事前準備

```sh
xcode-select --install
```

### インストール

```sh
curl -sf https://raw.githubusercontent.com/kanorix/dotfiles/main/setup.sh | bash -s
```

### デフォルトのシェルをzshに変更

```sh
sudo chsh -s $(which zsh)
```

```
$ brew bundle dump --describe 'comment' --file=.brewfile
```
