# インストールするフォントの設定
TAG=v1.3.1
FONT_URL=https://github.com/yuru7/udev-gothic/releases/download/${TAG}/UDEVGothic_NF_${TAG}.zip

# 一時的なフォルダを作成し、移動する
DIR=$(mktemp -d "${TMPDIR:-/tmp}/${1:-tmpspace}.XXXXXX") && cd "$d" || exit 1

# ファイルを取得する
curl -LO $FONT_URL

unzip *.zip

# ファイルをフラットにする
find . -type f -exec cp '{}' . ';'

# fontを登録する
cp *.ttf ~/Library/fonts/

rm -rf "$d"
