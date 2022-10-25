apk index -o ~/packages/custom/aarch64/APKINDEX.tar.gz ~/packages/custom/aarch64/*.apk
abuild-sign -k ~/.abuild/steve-5f397f18.rsa ~/packages/custom/aarch64/APKINDEX.tar.gz
