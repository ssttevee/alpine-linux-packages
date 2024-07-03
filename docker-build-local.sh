set -ex

SCRIPT_DIR=$(dirname $(realpath $0))
KEY_DIR=$SCRIPT_DIR/.abuild
KEY_FILE=$(basename "$(find "$KEY_DIR" -name '*.rsa' | head -n1)")
CT_NAME=apkbuild
ALPINE_VERSION=3.19
REPO=custom
PACKAGE=hailort

mkdir -p "$SCRIPT_DIR/packages"
docker run --name "$CT_NAME" -v "$SCRIPT_DIR:$SCRIPT_DIR" -v "$SCRIPT_DIR/packages:/root/packages" -w "$SCRIPT_DIR" -dt "alpine:$ALPINE_VERSION"
trap 'docker rm -f "$CT_NAME"' EXIT

docker exec "$CT_NAME" mkdir -p /root/.abuild
docker cp "$KEY_DIR/$KEY_FILE" "$CT_NAME:/root/.abuild/$KEY_FILE"
docker cp "$KEY_DIR/$KEY_FILE.pub" "$CT_NAME:/root/.abuild/$KEY_FILE.pub"
docker cp "$KEY_DIR/$KEY_FILE.pub" "$CT_NAME:/etc/apk/keys/$KEY_FILE.pub"

docker exec "$CT_NAME" apk add alpine-sdk

docker exec \
    -e PACKAGER_PRIVKEY="/root/.abuild/$KEY_FILE" \
    -w "$SCRIPT_DIR/$REPO/$PACKAGE" "$CT_NAME" \
    abuild -F -r
