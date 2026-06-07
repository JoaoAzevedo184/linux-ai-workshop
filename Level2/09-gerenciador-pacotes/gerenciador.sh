#!/usr/bin/env bash
#
# gerenciador.sh - Menu interativo para gerenciar grupos de pacotes via apt.
#
# Uso:
#   chmod +x gerenciador.sh
#   sudo ./gerenciador.sh
#
# Permite instalar/remover grupos pré-definidos (dev, multimídia, rede, sistema)
# e atualizar o sistema, tudo por um menu numérico.

set -uo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Este script precisa de sudo (instala/remove pacotes)." >&2
  echo "Tente: sudo ./gerenciador.sh" >&2
  exit 1
fi

# Cores
CYA='\033[1;36m'; GRN='\033[1;32m'; YEL='\033[1;33m'; RED='\033[1;31m'; RST='\033[0m'

# --- Grupos de pacotes (edite à vontade) ---
# Cada grupo é uma string com os pacotes separados por espaço.
GRUPO_DEV="git curl wget build-essential python3 python3-pip"
GRUPO_MULTIMIDIA="vlc ffmpeg gimp"
GRUPO_REDE="net-tools nmap traceroute dnsutils"
GRUPO_SISTEMA="htop tree ncdu unzip"

instalar() {
  local nome="$1"; shift
  local pacotes="$*"
  echo -e "${YEL}Instalando grupo '$nome': $pacotes${RST}"
  apt-get install -y $pacotes
  echo -e "${GRN}Grupo '$nome' instalado.${RST}"
}

remover() {
  local nome="$1"; shift
  local pacotes="$*"
  echo -e "${YEL}Removendo grupo '$nome': $pacotes${RST}"
  apt-get remove -y $pacotes
  echo -e "${GRN}Grupo '$nome' removido.${RST}"
}

pausar() { echo; read -rp "Pressione ENTER para voltar ao menu..."; }

menu() {
  clear
  echo -e "${CYA}=========================================${RST}"
  echo -e "${CYA}    GERENCIADOR DE PACOTES (apt)${RST}"
  echo -e "${CYA}=========================================${RST}"
  echo "  1) Atualizar sistema (update + upgrade)"
  echo "  2) Instalar grupo DEV         ($GRUPO_DEV)"
  echo "  3) Instalar grupo MULTIMÍDIA  ($GRUPO_MULTIMIDIA)"
  echo "  4) Instalar grupo REDE        ($GRUPO_REDE)"
  echo "  5) Instalar grupo SISTEMA     ($GRUPO_SISTEMA)"
  echo "  6) Remover um grupo"
  echo "  7) Limpar pacotes órfãos (autoremove)"
  echo -e "  0) ${RED}Sair${RST}"
  echo -e "${CYA}=========================================${RST}"
}

menu_remover() {
  echo "Qual grupo remover?"
  echo "  a) DEV   b) MULTIMÍDIA   c) REDE   d) SISTEMA"
  read -rp "Opção: " r
  case "$r" in
    a) remover "DEV" $GRUPO_DEV ;;
    b) remover "MULTIMÍDIA" $GRUPO_MULTIMIDIA ;;
    c) remover "REDE" $GRUPO_REDE ;;
    d) remover "SISTEMA" $GRUPO_SISTEMA ;;
    *) echo -e "${RED}Opção inválida.${RST}" ;;
  esac
}

# --- Loop principal ---
while true; do
  menu
  read -rp "Escolha uma opção: " opcao
  case "$opcao" in
    1) echo -e "${YEL}Atualizando...${RST}"; apt-get update && apt-get upgrade -y; pausar ;;
    2) instalar "DEV" $GRUPO_DEV; pausar ;;
    3) instalar "MULTIMÍDIA" $GRUPO_MULTIMIDIA; pausar ;;
    4) instalar "REDE" $GRUPO_REDE; pausar ;;
    5) instalar "SISTEMA" $GRUPO_SISTEMA; pausar ;;
    6) menu_remover; pausar ;;
    7) echo -e "${YEL}Limpando...${RST}"; apt-get autoremove -y; pausar ;;
    0) echo "Saindo."; exit 0 ;;
    *) echo -e "${RED}Opção inválida.${RST}"; sleep 1 ;;
  esac
done