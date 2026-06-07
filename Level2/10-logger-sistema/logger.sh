#!/usr/bin/env bash
#
# logger.sh - Registra um snapshot diário da atividade do sistema, com rotação.
#
# Coleta:
#   - últimos logins (last)
#   - uso de disco (df)
#   - top 5 processos por CPU e por memória
#   - usuários logados no momento (who)
#
# Uso manual:
#   chmod +x logger.sh
#   ./logger.sh
#
# Uso agendado (cron) — ver README. Grava em $LOG_DIR/atividade-AAAA-MM-DD.log
# e remove logs com mais de $DIAS_RETENCAO dias.

set -uo pipefail

# --- Configuração ---
LOG_DIR="${HOME}/system-logs"
DIAS_RETENCAO=14
DATA=$(date +%Y-%m-%d)
HORA=$(date '+%H:%M:%S')
LOG_FILE="${LOG_DIR}/atividade-${DATA}.log"

mkdir -p "$LOG_DIR"

# Função: escreve um cabeçalho de seção no log
secao() {
  {
    echo ""
    echo "=================================================="
    echo ">> $1  [$HORA]"
    echo "=================================================="
  } >> "$LOG_FILE"
}

# --- Início do registro ---
echo "########## SNAPSHOT ${DATA} ${HORA} ##########" >> "$LOG_FILE"

# 1. Últimos logins
secao "ÚLTIMOS LOGINS (last -n 10)"
last -n 10 >> "$LOG_FILE" 2>&1

# 2. Usuários logados agora
secao "USUÁRIOS LOGADOS AGORA (who)"
who >> "$LOG_FILE" 2>&1

# 3. Uso de disco
secao "USO DE DISCO (df -h)"
df -h -x tmpfs -x devtmpfs >> "$LOG_FILE" 2>&1

# 4. Top 5 processos por CPU
secao "TOP 5 PROCESSOS POR CPU"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 6 >> "$LOG_FILE" 2>&1

# 5. Top 5 processos por memória
secao "TOP 5 PROCESSOS POR MEMÓRIA"
ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n 6 >> "$LOG_FILE" 2>&1

echo "" >> "$LOG_FILE"

# --- Rotação: remove logs antigos ---
# -mtime +N = modificados há mais de N dias
find "$LOG_DIR" -name 'atividade-*.log' -mtime +"$DIAS_RETENCAO" -delete

echo "Log gravado em: $LOG_FILE"
echo "Logs com mais de $DIAS_RETENCAO dias foram removidos."