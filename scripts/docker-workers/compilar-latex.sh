#!/bin/bash

set -euo pipefail

IMAGE="texlive/texlive:latest"
PROJECT_DIR="$(pwd)"
CACHE_DIR="$HOME/DatosContenedores/lualatex-cache"
FONTS_DIR="/usr/share/fonts"

mkdir -p "$CACHE_DIR"

if [[ ! -f "$PROJECT_DIR/latexmkrc" ]]; then
    echo "Error: No se encontró el archivo latexmkrc para la configuración."
    exit 1
fi

docker run -i --rm \
    -v $PROJECT_DIR:/usr/src/app:z \
    -v $CACHE_DIR:/home/texlive/.texlive2026:z \
    -v $FONTS_DIR:/usr/local/share/fonts/host-sys:ro \
    -w /usr/src/app \
    -u $(id -u):$(id -g) \
    $IMAGE \
    latexmk
