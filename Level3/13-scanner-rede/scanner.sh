#!/usr/bin/env bash
#
# scanner.sh - Descobre dispositivos na rede local e portas abertas.
#
# Uso:
#   chmod +x scanner.sh
#   ./scanner.sh                 # detecta a rede automaticamente e escaneia
#   ./scanner.sh 192.168.1.0/24  # escaneia uma faixa específica
#   sudo ./scanner.sh            # com sudo o nmap traz mais detalhes
#
# Depende de: nmap (sudo apt install nmap)

set -uo pipefail

CYA='\033[1;36m'; GRN='\033[1;32m'; YEL='\033[1;33m'; RED='\033[1;31m'; RST='\033[0m'

# --- Verifica se o nmap está instalado ---
if ! command -v nmap >/dev/null 2>&1; then
  echo -e "${RED}nmap não encontrado.${RST} Instale com: sudo apt install nmap"
  exit 1
fi

# --- Descobre a faixa de rede ---
# Se o usuário passar a faixa como argumento, usa ela. Senão, detecta.
if [[ -n "${1:-}" ]]; then
  REDE="$1"
else
  # Pega a rota padrão e monta a faixa /24 a partir do IP local.
  IP_LOCAL=$(ip -4 route get 1.1.1.1 2>/dev/null | awk '{print $7; exit}')
  if [[ -z "$IP_LOCAL" ]]; then
    echo -e "${RED}Não consegui detectar o IP local. Passe a faixa manualmente.${RST}"
    echo "Ex: ./scanner.sh 192.168.1.0/24"
    exit 1
  fi
  # Troca o último octeto por 0/24 (ex: 192.168.1.42 -> 192.168.1.0/24)
  REDE="$(echo "$IP_LOCAL" | sed 's/\.[0-9]*$/.0\/24/')"
fi

echo -e "${CYA}=== Scanner de rede local ===${RST}"
echo -e "IP local : ${GRN}${IP_LOCAL:-(informado)}${RST}"
echo -e "Faixa    : ${GRN}${REDE}${RST}\n"

# --- 1. Descoberta de hosts (ping scan) ---
echo -e "${YEL}[1] Procurando dispositivos ativos...${RST}"
# -sn = ping scan (só descobre quem está vivo, não escaneia portas)
hosts=$(nmap -sn "$REDE" -oG - 2>/dev/null | awk '/Up$/{print $2}')

if [[ -z "$hosts" ]]; then
  echo -e "${RED}Nenhum dispositivo encontrado.${RST}"
  exit 0
fi

qtd=$(echo "$hosts" | wc -l)
echo -e "${GRN}$qtd dispositivo(s) encontrado(s):${RST}"
echo "$hosts" | sed 's/^/  /'
echo

# --- 2. Scan de portas em cada host ---
echo -e "${YEL}[2] Escaneando portas comuns de cada dispositivo...${RST}"
while IFS= read -r host; do
  echo -e "\n${CYA}--- $host ---${RST}"
  # -F = fast scan (100 portas mais comuns); --open = só mostra abertas
  nmap -F --open "$host" 2>/dev/null \
    | awk '/^[0-9]+\/(tcp|udp)/ {print "  " $0} /Nmap scan/{next}' \
    || echo "  (sem portas abertas detectadas)"
done <<< "$hosts"

echo -e "\n${GRN}Scan concluído.${RST}"
echo -e "${YEL}Dica:${RST} 'sudo nmap -O $REDE' tenta identificar o sistema operacional dos hosts."