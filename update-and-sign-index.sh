apk index -o ~/packages/custom/aarch64/APKINDEX.tar.gz --rewrite-arch aarch64 ~/packages/custom/aarch64/*.apk
abuild-sign ~/packages/custom/aarch64/APKINDEX.tar.gz
