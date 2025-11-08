#!/usr/bin/env bash

set -euo pipefail

rm "${XDG_BIN_HOME:-$HOME/.local/bin}/compress-media"
rm "${XDG_DATA_HOME:-$HOME/.local/share}/kio/servicemenus/compress-media.desktop"

LOCALE_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/locale
find "$LOCALE_HOME" -type f -name "ua.damglador.compress-media.mo" -exec rm {} \;
