#!/bin/bash

APP_NAME="linux-valley-worker"
LOG="/var/log/linux-valley-worker.log"
INTERVAL=2
JOB_ID=0

log() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') [$APP_NAME] $1" >> "$LOG"
}

process_job() {
	JOB_ID=$((JOB_ID + 1))
        echo "A processar o job numero: $JOB_ID"	
	log "Processando tarefa #$JOB_ID"
	
	for i in {1..8000000}; do
		resultado=$((i * i))
	done &

	dd if=/dev/zero of="/dev/shm/lixo_memoria_$JOB_ID" bs=1M count=120 status=none

	sleep "$INTERVAL"

	rm -f "/dev/shm/lixo_memoria_$JOB_ID"
}

log "Worker iniciado"

while true; do
	process_job
done
