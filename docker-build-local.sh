set -ex

KEY_DIR=.abuild
KEY_FILE=$(basename "$(find "$KEY_DIR" -name '*.rsa' | head -n1)")
CT_NAME=apkbuild
ALPINE_VERSION=3.19
REPO=custom
PACKAGE=hailort

docker run --name "$CT_NAME" -v "$(dirname $(realpath $0)):/opt" -w /opt -dt "alpine:$ALPINE_VERSION"
trap 'docker rm -f "$CT_NAME"' EXIT

docker exec "$CT_NAME" mkdir -p /root/.abuild
docker cp "$KEY_DIR/$KEY_FILE" "$CT_NAME:/root/.abuild/$KEY_FILE"
docker cp "$KEY_DIR/$KEY_FILE.pub" "$CT_NAME:/root/.abuild/$KEY_FILE.pub"
docker cp "$KEY_DIR/$KEY_FILE.pub" "$CT_NAME:/etc/apk/keys/$KEY_FILE.pub"

docker exec "$CT_NAME" apk add alpine-sdk

docker exec \
    -e PACKAGER_PRIVKEY="/root/.abuild/$KEY_FILE" \
    -w "/opt/$REPO/$PACKAGE" "$CT_NAME" \
    abuild -r -F
