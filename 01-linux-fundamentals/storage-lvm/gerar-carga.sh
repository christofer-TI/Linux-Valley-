#!/bin/bash
echo "Gerando carga para teste na pasta da aplicação..."

# Cria 5 blocos de 100MB cada (totalizando 500MB)
for i in {1..5}
do
  dd if=/dev/zero of=/mnt/app-data/arquivo_teste_$i.dat bs=100M count=1 status=progress
  sleep 1
done

echo "Carga concluída! Verifica o espaço com 'df -h'."
