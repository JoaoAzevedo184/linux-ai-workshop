#!/usr/bin/env bash
#
# backup.sh - Faz backup compactado de uma pasta, com data no nome do arquivo.
#
# Uso manual:
#   chmod +x backup.sh
#   ./backup.sh
#
# Uso agendado (cron): veja o README para o passo a passo.
#
# O script gera um arquivo .tar.gz em $DESTINO e mantém só os N backups mais recentes.

set -euo pipefail

# --- Configuração (ajuste os caminhos) ---
ORIGEM="$HOME/documentos"        # pasta que será copiada
DESTINO="$HOME/backups"          # onde os backups serão guardados
MANTER=7                         # quantos backups manter (apaga os mais antigos)

# Data/hora no formato AAAA-MM-DD_HH-MM-SS para nomear o arquivo
DATA=$(date +%Y-%m-%d_%H-%M-%S)
ARQUIVO="$DESTINO/backup_$DATA.tar.gz"

# --- Validação ---
if [[ ! -d "$ORIGEM" ]]; then
  echo "Erro: pasta de origem '$ORIGEM' não existe." >&2
  exit 1
fi

# Cria o destino se não existir
mkdir -p "$DESTINO"

# --- Backup ---
echo "Criando backup de '$ORIGEM'..."
# tar -czf: cria (c), comprime com gzip (z), no arquivo indicado (f)
# -C "$(dirname "$ORIGEM")" entra na pasta pai para não gravar o caminho absoluto
tar -czf "$ARQUIVO" -C "$(dirname "$ORIGEM")" "$(basename "$ORIGEM")"
echo "Backup criado: $ARQUIVO"

# --- Rotação: mantém apenas os $MANTER backups mais recentes ---
echo "Removendo backups antigos (mantendo os $MANTER mais recentes)..."
# Lista por data (mais novo primeiro), pula os primeiros $MANTER e apaga o resto
ls -1t "$DESTINO"/backup_*.tar.gz 2>/dev/null \
  | tail -n +$((MANTER + 1)) \
  | xargs -r rm -v

echo "Concluído."

# --- Alternativa com rsync (cópia incremental, sem compactar) ---
# Descomente as linhas abaixo se preferir espelhar a pasta em vez de gerar .tar.gz:
#
# ESPELHO="$DESTINO/espelho"
# mkdir -p "$ESPELHO"
# rsync -a --delete "$ORIGEM/" "$ESPELHO/"
# echo "Espelho atualizado em $ESPELHO"