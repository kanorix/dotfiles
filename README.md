# kanorix's dotfiles

## セットアップ


```sh
curl -sf https://raw.githubusercontent.com/kanorix/dotfiles/main/setup.sh | bash -s
```

## 個別に設定を反映する場合

### 1. 設定と共通なソフトウェアをMacに反映

```sh
sudo nix run nix-darwin -- switch --flake ~/dotfiles/nix#MacBookAir-3rd
```

### 2. 設定ファイルにシンボリックリンクを貼る

```sh
./link.sh
```

## そのほかの設定

### 1passwordログイン

1. iCloudにログインしておく
2. 1passwordにicloudでログインしてパスワード入力

### ターミナルのフォントを変更

- `HackGen　Console NF`に変更する

### GitHubにpushできるようにする

```sh
gh auth login
```