#!/bin/bash

set -euo pipefail

IMAGE="texlive/texlive:latest"
PROJECT_DIR="$(pwd)"

if [[ ! -f "$PROJECT_DIR/latexmkrc" ]]; then
    echo "Error: No se encontró el archivo latexmkrc para la configuración."
    exit 1
fi

docker run -i --rm \
    -v $PROJECT_DIR:/usr/src/app:z \
    -w /usr/src/app \
    -u $(id -u):$(id -g) \
    $IMAGE \
    latexmk -c
