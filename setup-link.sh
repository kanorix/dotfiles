#!/bin/zsh
source scripts/symlink.sh

symlink zsh      --config-dir ~/
symlink starship --config-dir ~/.config
symlink sheldon
symlink kitty
symlink colima   --config-dir ~/.colima/_templates
symlink docker   --config-dir ~/.docker
