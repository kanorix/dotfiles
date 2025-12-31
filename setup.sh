#!/bin/zsh

## Nixのインストール

curl -fsSL https://install.determinate.systems/nix | sh -s -- install

## nixを使用できるようにする(もしくは新しいシェルを立ち上げる)
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

## 組み込みのgitを使えるようにする

xcode-select --install

## このdotifilesリポジトリのクローン

cd $HOME && git clone https://github.com/kanorix/dotfiles.git

## デフォルトのzshenvをリネームしておく(既存を上書きしようとしてエラーが出るため)

sudo mv /etc/zshenv /etc/zshenv.before-nix-darwin

## nixの設定を反映する

sudo nix run nix-darwin -- switch --flake ~/dotfiles/nix#MacBookAir-3rd

## シンボリックリンクを貼る

./setup-link.sh