#!/usr/bin/env bash

set -euo pipefail

basedir="$(dirname "$0")"

### Install the script
if [ -f "${XDG_BIN_HOME:-$HOME/.local/bin}/compress-media" ] && [ "$1" != "-f" ]; then
    cat << EOF
File «${XDG_BIN_HOME:-$HOME/.local/bin}/compress-media» already exists.
(Use -f as first argument to automatically replace)
EOF
    while true; do
        read -rp "Replace the file? [y/N] " input
        [ -z "$input" ] && input=n
        [ "${input,,}" == n ] && break
        [ "${input,,}" == y ] && \
            install -Dm755 "$basedir/compress-media" \
                "${XDG_BIN_HOME:-$HOME/.local/bin}/compress-media" && break
    done
else
    install -Dm755 "$basedir/compress-media" \
        "${XDG_BIN_HOME:-$HOME/.local/bin}/compress-media"
fi

### Install service menu
install -Dm755 "$basedir/compress-media.desktop" \
    "${XDG_DATA_HOME:-$HOME/.local/share}/kio/servicemenus/compress-media.desktop"

### Install locale
LOCALE_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/locale
mkdir -p "$LOCALE_HOME"
[ ! -d "$basedir/locale" ] && translation/build
cp -r locale/* "$LOCALE_HOME"
