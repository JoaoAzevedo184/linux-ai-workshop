#!/usr/bin/env bash
#
# monitor.sh - Verifica se serviços estão de pé e alerta se algum cair.
#
# Por padrão monitora apache2 e mariadb. Edite a lista SERVICOS abaixo.
#
# Uso manual:
#   chmod +x monitor.sh
#   ./monitor.sh
#
# Uso agendado (cron) — ver README. Registra tudo em log e, se um serviço
# estiver parado, tenta reiniciar e grava um alerta.

set -uo pipefail

# --- Configuração ---
SERVICOS=("apache2" "mariadb")            # serviços a monitorar
LOG_DIR="${HOME}/monitor-logs"
LOG_FILE="${LOG_DIR}/uptime.log"
TENTAR_REINICIAR=true                      # true = tenta reiniciar serviço caído

mkdir -p "$LOG_DIR"
DATA=$(date '+%Y-%m-%d %H:%M:%S')

# Escreve no log e também na tela
registrar() {
  echo "[$DATA] $1" | tee -a "$LOG_FILE"
}

# --- Verifica cada serviço ---
for svc in "${SERVICOS[@]}"; do
  # systemctl is-active retorna "active" se estiver rodando
  if systemctl is-active --quiet "$svc"; then
    registrar "OK    - $svc está ativo."
  else
    registrar "ALERTA - $svc está PARADO!"

    if [[ "$TENTAR_REINICIAR" == true ]]; then
      # Reiniciar precisa de privilégio; no cron, rode o script como root.
      if systemctl restart "$svc" 2>/dev/null; then
        registrar "ACAO  - tentativa de reiniciar $svc executada."
        # Confirma se subiu
        if systemctl is-active --quiet "$svc"; then
          registrar "OK    - $svc reiniciado com sucesso."
        else
          registrar "FALHA - $svc NÃO subiu após reinício. Verificar manualmente!"
        fi
      else
        registrar "FALHA - sem permissão para reiniciar $svc (rode como root)."
      fi
    fi

    # --- Ponto de extensão para notificação ---
    # Aqui você pode disparar um alerta externo. Exemplos (descomente o que usar):
    #
    # E-mail (precisa de 'mailutils' configurado):
    #   echo "$svc caiu em $(hostname) às $DATA" | mail -s "[ALERTA] $svc" voce@email.com
    #
    # Notificação desktop (se houver ambiente gráfico):
    #   notify-send "Serviço caiu" "$svc parou às $DATA"
    #
    # Webhook (Telegram, Discord, etc.) via curl:
    #   curl -s -X POST "$WEBHOOK_URL" -d "text=$svc caiu em $(hostname)"
  fi
done