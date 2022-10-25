# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.2/containers/alpine/.devcontainer/base.Dockerfile

# [Choice] Alpine version: 3.16, 3.15, 3.14, 3.13
ARG VARIANT="3.16"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-alpine-${VARIANT}

RUN git config --global core.autocrlf input && \
    git config --global --add safe.directory /home/vscode/aports && \
    git config --global --add safe.directory /workspaces/alpine-linux-packages

RUN apk update && \
    apk add --no-cache alpine-sdk apkbuild-pypi lua-aports pigz && \
    addgroup vscode abuild && \
    mkdir -p /var/cache/distfiles && \
    chgrp abuild /var/cache/distfiles && \
    chmod g+w /var/cache/distfiles
