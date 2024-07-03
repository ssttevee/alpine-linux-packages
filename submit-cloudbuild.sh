/opt/homebrew/bin/gcloud builds submit \
    --project stevie-coding-grounds \
    --substitutions "_REPOS=custom,_PKGS=hailort,_TARGETARCH=amd64,_ALPINE_VERSION=3.19"