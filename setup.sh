#!/bin/zsh

# 組み込みのgitを使えるようにする（TODO: コメント合ってるか確認）
xcode-select --install

# nixのインストールをする
# https://github.com/DeterminateSystems/nix-installer
curl -fsSL https://install.determinate.systems/nix | sh -s -- install

# TODO: 冪等性のため、すでにあればcloneしないようにしたい
cd $HOME && git clone https://github.com/kanorix/dotfiles.git
cd $HOME/dotfiles

# --install コマンドであればnixでのアプリインストール
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
cd nix

# sudo darwin-rebuild switch --flake ~/dotfiles/nix#kanorix
sudo nix run nix-darwin -- switch --flake ~/dotfiles/nix#kanorix
