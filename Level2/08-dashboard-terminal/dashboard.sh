#!/usr/bin/env bash
#
# dashboard.sh - Painel de monitoramento no terminal (CPU, RAM, disco, usuários).
#
# Uso:
#   chmod +x dashboard.sh
#   ./dashboard.sh            # mostra uma vez
#   ./dashboard.sh --watch    # atualiza a cada 2s (Ctrl+C para sair)
#
# Usa apenas ferramentas padrão do Ubuntu (top, free, df, who, uptime).

set -uo pipefail

# Cores
CYA='\033[1;36m'; GRN='\033[1;32m'; YEL='\033[1;33m'; RST='\033[0m'; BOLD='\033[1m'

mostrar() {
  clear
  echo -e "${CYA}╔════════════════════════════════════════════════╗${RST}"
  echo -e "${CYA}║${RST}  ${BOLD}PAINEL DO SISTEMA${RST}  ·  $(date '+%d/%m/%Y %H:%M:%S')      ${CYA}║${RST}"
  echo -e "${CYA}╚════════════════════════════════════════════════╝${RST}"

  # --- Host e uptime ---
  echo -e "\n${YEL}» Host${RST}"
  echo "  Hostname : $(hostname)"
  echo "  Kernel   : $(uname -r)"
  echo "  Uptime   :$(uptime -p | sed 's/up//')"

  # --- CPU ---
  echo -e "\n${YEL}» CPU${RST}"
  # 'load average' = média de carga em 1, 5 e 15 minutos
  carga=$(uptime | awk -F'load average:' '{print $2}')
  echo "  Núcleos      : $(nproc)"
  echo "  Load average :$carga"
  # Uso de CPU instantâneo via top em modo batch (1 iteração)
  cpu=$(top -bn1 | grep -i "%Cpu" | head -1 | awk '{print $2 "% us, " $4 "% sy, " $8 "% idle"}')
  echo "  Uso          : $cpu"

  # --- Memória ---
  echo -e "\n${YEL}» Memória${RST}"
  free -h | awk 'NR==1{printf "  %-8s %8s %8s %8s\n","","total","usado","livre"}
                 NR==2{printf "  %-8s %8s %8s %8s\n","RAM:",$2,$3,$4}
                 NR==3{printf "  %-8s %8s %8s %8s\n","Swap:",$2,$3,$4}'

  # --- Disco ---
  echo -e "\n${YEL}» Disco (partições montadas)${RST}"
  # Filtra só sistemas de arquivos reais (ignora tmpfs etc.).
  # Mostra ponto de montagem, tamanho, usado, disponível e % de uso.
  df -h -x tmpfs -x devtmpfs 2>/dev/null \
    | awk 'NR==1{printf "  %-14s %6s %6s %6s %5s\n","Montado","Tam","Uso","Livre","%"; next}
           {printf "  %-14s %6s %6s %6s %5s\n",$6,$2,$3,$4,$5}'

  # --- Usuários logados ---
  echo -e "\n${YEL}» Usuários logados${RST}"
  if who | grep -q .; then
    who | awk '{printf "  %-12s %-8s %s %s\n",$1,$2,$3,$4}'
  else
    echo "  (nenhum)"
  fi

  echo -e "\n${GRN}Atualizado.${RST}"
}

# Modo watch: repete a cada 2 segundos
if [[ "${1:-}" == "--watch" ]]; then
  trap "echo; echo 'Encerrado.'; exit 0" INT
  while true; do
    mostrar
    echo "(--watch ativo · Ctrl+C para sair)"
    sleep 2
  done
else
  mostrar
fi