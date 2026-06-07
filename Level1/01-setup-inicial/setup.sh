#!/usr/bin/env bash
#
# setup.sh - Configuração inicial de uma VM Ubuntu recém-instalada.
# Define timezone, locale e instala pacotes essenciais.
#
# Uso:
#   chmod +x setup.sh
#   sudo ./setup.sh
#
# OBS: precisa de sudo porque mexe em configurações do sistema e instala pacotes.

# 'set -euo pipefail' = boas práticas de script seguro:
#   -e: aborta se qualquer comando falhar
#   -u: erro se usar variável não definida
#   -o pipefail: erro se qualquer comando de um pipe falhar
set -euo pipefail

# --- Variáveis de configuração (ajuste conforme quiser) ---
TIMEZONE="America/Recife"
LOCALE="pt_BR.UTF-8"

# Lista de pacotes essenciais para um ambiente de dev/estudo
PACOTES=(
  curl
  wget
  git
  vim
  nano
  htop
  net-tools
  build-essential
  tree
  unzip
)

# --- Funções auxiliares ---

# Imprime mensagens com destaque para acompanhar o progresso
log() {
  echo -e "\n\033[1;32m==> $1\033[0m"
}

# Garante que o script roda como root (sudo)
if [[ $EUID -ne 0 ]]; then
  echo "Este script precisa ser executado com sudo." >&2
  echo "Tente: sudo ./setup.sh" >&2
  exit 1
fi

# --- 1. Timezone ---
log "Definindo timezone para $TIMEZONE"
timedatectl set-timezone "$TIMEZONE"

# --- 2. Locale ---
log "Configurando locale $LOCALE"
locale-gen "$LOCALE"
update-locale LANG="$LOCALE"

# --- 3. Atualização da base de pacotes ---
log "Atualizando lista de pacotes (apt update)"
apt-get update -y

log "Aplicando atualizações disponíveis (apt upgrade)"
apt-get upgrade -y

# --- 4. Instalação dos pacotes essenciais ---
log "Instalando pacotes essenciais"
# "${PACOTES[@]}" expande o array em itens separados
apt-get install -y "${PACOTES[@]}"

# --- 5. Limpeza ---
log "Removendo pacotes desnecessários (autoremove)"
apt-get autoremove -y

log "Setup concluído com sucesso!"
echo "Timezone: $(timedatectl | grep 'Time zone')"
echo "Pacotes instalados: ${PACOTES[*]}"