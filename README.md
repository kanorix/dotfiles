
## MacOS

### 事前準備

```sh
xcode-select --install
```

### インストール

```sh
curl -sf https://raw.githubusercontent.com/kanorix/dotfiles/experimental/setup.sh | bash -s
```

## Linux(ubuntu)

### インストール

```sh
apt update && apt install -y curl && \
    curl -sf https://raw.githubusercontent.com/kanorix/dotfiles/experimental/setup.sh | bash -s
```
### デフォルトのシェルをzshに変更

```sh
sudo chsh -s $(which zsh)
```

## GUI Application

|      Name       | Config |         MacOS         | Linux |
| :-------------: | :----: | :-------------------: | :---: |
|     `curl`      |   -    | (Xcode cmd line tool) |   ○   |
|      `git`      |   -    | (Xcode cmd line tool) |   ○   |
|     `make`      |   -    |       (default)       |   ○   |
|      `zsh`      |   ○    |       (default)       |   ○   |
|      `bat`      |   -    |           ○           |   ○   |
|      `eza`      |   -    |           ○           |   ○   |
|  `git-secret`   |   -    |           ○           |   -   |
|    `sheldon`    |   ○    |           ○           |   ○   |
|   `starship`    |   ○    |           ○           |   ○   |
|     `rust`      |   -    |           -           |   ○   |
|   `homebrew`    |   ○    |           ○           |   -   |
|    `colima`     |   ○    |           ○           |   -   |
|    `docker`     |   -    |           ○           |   -   |
| `docker-buildx` |   -    |           ○           |   -   |
|     `volta`     |   -    |           ○           |   -   |
|      `fvm`      |   -    |           ○           |   -   |

## GUI Application

|         Name         | Config | MacOS | Linux |
| :------------------: | :----: | :---: | :---: |
|       `kitty`        |   ○    |   ○   |   -   |
| `visual-studio-code` |   -    |   ○   |   -   |
|      `xquartz`       |   -    |   ○   |   -   |
