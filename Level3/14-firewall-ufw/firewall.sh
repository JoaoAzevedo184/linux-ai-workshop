#!/usr/bin/env bash
#
# firewall.sh - Configurador interativo de firewall com UFW.
#
# Aplica perfis prontos de regras:
#   - Servidor web : permite SSH(22), HTTP(80), HTTPS(443)
#   - Desenvolvimento : SSH + portas comuns de dev (3000,5000,8000,8080)
#   - Fechado : bloqueia tudo de entrada, exceto SSH (para não se trancar fora)
#   - Status / Reset
#
# Uso:
#   chmod +x firewall.sh
#   sudo ./firewall.sh
#
# Depende de: ufw (já vem no Ubuntu; se não, sudo apt install ufw)

set -uo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Este script precisa de sudo (configura o firewall)." >&2
  exit 1
fi

if ! command -v ufw >/dev/null 2>&1; then
  echo "ufw não encontrado. Instale com: sudo apt install ufw"
  exit 1
fi

CYA='\033[1;36m'; GRN='\033[1;32m'; YEL='\033[1;33m'; RED='\033[1;31m'; RST='\033[0m'

# Reseta as regras antes de aplicar um perfil novo (começa do zero).
# --force evita o prompt de confirmação do ufw.
resetar() {
  ufw --force reset >/dev/null
  ufw default deny incoming  >/dev/null   # bloqueia tudo que entra
  ufw default allow outgoing >/dev/null   # libera tudo que sai
}

perfil_web() {
  echo -e "${YEL}Aplicando perfil: Servidor Web${RST}"
  resetar
  ufw allow 22/tcp   comment 'SSH'   >/dev/null
  ufw allow 80/tcp   comment 'HTTP'  >/dev/null
  ufw allow 443/tcp  comment 'HTTPS' >/dev/null
  ufw --force enable >/dev/null
  echo -e "${GRN}Perfil web ativo (SSH, HTTP, HTTPS liberados).${RST}"
}

perfil_dev() {
  echo -e "${YEL}Aplicando perfil: Desenvolvimento${RST}"
  resetar
  ufw allow 22/tcp   comment 'SSH'        >/dev/null
  ufw allow 3000/tcp comment 'Node/React' >/dev/null
  ufw allow 5000/tcp comment 'Flask/API'  >/dev/null
  ufw allow 8000/tcp comment 'Dev server' >/dev/null
  ufw allow 8080/tcp comment 'Tomcat/alt' >/dev/null
  ufw --force enable >/dev/null
  echo -e "${GRN}Perfil dev ativo (SSH + portas 3000/5000/8000/8080).${RST}"
}

perfil_fechado() {
  echo -e "${YEL}Aplicando perfil: Fechado${RST}"
  resetar
  # Mantém só o SSH para você não perder o acesso remoto à máquina.
  ufw allow 22/tcp comment 'SSH' >/dev/null
  ufw --force enable >/dev/null
  echo -e "${GRN}Perfil fechado ativo (só SSH liberado).${RST}"
  echo -e "${RED}Atenção:${RST} todo o resto da entrada está bloqueado."
}

status() {
  echo -e "${CYA}--- Status atual do UFW ---${RST}"
  ufw status verbose
}

menu() {
  clear
  echo -e "${CYA}=====================================${RST}"
  echo -e "${CYA}   CONFIGURADOR DE FIREWALL (UFW)${RST}"
  echo -e "${CYA}=====================================${RST}"
  echo "  1) Perfil Servidor Web   (SSH, HTTP, HTTPS)"
  echo "  2) Perfil Desenvolvimento (SSH + dev ports)"
  echo "  3) Perfil Fechado         (só SSH)"
  echo "  4) Ver status"
  echo "  5) Desativar firewall"
  echo -e "  0) ${RED}Sair${RST}"
  echo -e "${CYA}=====================================${RST}"
}

pausar() { echo; read -rp "ENTER para continuar..."; }

while true; do
  menu
  read -rp "Opção: " op
  case "$op" in
    1) perfil_web; pausar ;;
    2) perfil_dev; pausar ;;
    3) perfil_fechado; pausar ;;
    4) status; pausar ;;
    5) ufw --force disable; echo -e "${YEL}Firewall desativado.${RST}"; pausar ;;
    0) echo "Saindo."; exit 0 ;;
    *) echo -e "${RED}Opção inválida.${RST}"; sleep 1 ;;
  esac
done