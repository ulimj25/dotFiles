#!/data/data/com.termux/files/usr/bin/bash

set -euo pipefail

ROOT_DIR="/data/data/com.termux/files"
LOG_DIR="${ROOT_DIR}/home/.local/state/rclone-sync"
LOG_FILE="${LOG_DIR}/sync.log"

mkdir -p $LOG_DIR

Remote=Gdrive

jobs=(
    #"/home/ula/Drive/Bases|${Remote}:Bases"
    #"/home/ula/Drive/Documentos|${Remote}:Documentos"
    "${ROOT_DIR}/home/Drive/Obsidian|${Remote}:Obsidian"
    "${ROOT_DIR}/home/Drive/Libros|${Remote}:Libros"
    #"/home/ula/Drive/Recursos|${Remote}:Recursos"
)

log() {
    echo "$(date -Is) $1" >>$LOG_FILE
}

log "====Iniciando sincronización===="

for job in "${jobs[@]}"; do
    IFS='|' read -r source remote <<<$job

    log "===Iniciando: ${remote} -> ${source}==="

    if rclone sync $remote $source \
        --dry-run \
        --log-file "${LOG_FILE}" \
        --log-level INFO; then
        log "==Éxito ${remote} -> ${source}=="
    else
        log "==Error al sincornizar ${remote} -> ${source} (Código $?)"
    fi
done

log "====Trabajos de sincronización finalizados con éxito===="
