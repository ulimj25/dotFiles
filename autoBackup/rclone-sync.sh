#!/bin/bash

set -euo pipefail

LOG_DIR="${HOME}/.local/state/rclone-sync"
LOG_FILE="${LOG_DIR}/sync.log"

mkdir -p $LOG_DIR

Remote=Gdrive

jobs=(
    "/home/ula/Drive/Bases|${Remote}:Bases"
    "/home/ula/Drive/Documentos|${Remote}:Documentos"
    "/home/ula/Drive/Obsidian|${Remote}:Obsidian"
    "/home/ula/Drive/Libros|${Remote}:Libros"
    "/home/ula/Drive/Recursos|${Remote}:Recursos"
)

log() {
    echo "$(date -Is) $1" >>$LOG_FILE
}

log "====Iniciando sincronización===="

for job in "${jobs[@]}"; do
    IFS='|' read -r source remote <<<$job

    log "===Iniciando: ${source} -> ${remote}==="

    if rclone sync $source $remote \
        --log-file "${LOG_FILE}" \
        --log-level INFO; then
        log "==Éxito ${source} -> ${remote}=="
    else
        log "==Error al sincornizar ${source} -> ${remote} (Código $?)"
    fi
done

log "====Trabajos de sincronización finalizados con éxito===="
