#!/usr/bin/env bash
#
# instalar_lamp.sh - Instala e configura uma stack LAMP de forma idempotente.
#   LAMP = Linux + Apache + MySQL (MariaDB) + PHP
#
# Idempotente = pode rodar quantas vezes quiser; só faz o que ainda falta.
#
# Uso:
#   chmod +x instalar_lamp.sh
#   sudo ./instalar_lamp.sh
#
# Ao final, valida cada serviço e cria uma página de teste em /var/www/html.

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "Este script precisa de sudo." >&2
  exit 1
fi

GRN='\033[1;32m'; YEL='\033[1;33m'; RED='\033[1;31m'; CYA='\033[1;36m'; RST='\033[0m'
log() { echo -e "\n${CYA}==>${RST} $1"; }
ok()  { echo -e "${GRN}[OK]${RST} $1"; }
warn(){ echo -e "${YEL}[..]${RST} $1"; }

# Função idempotente: instala um pacote só se ainda não estiver instalado.
instala_se_preciso() {
  local pkg="$1"
  if dpkg -s "$pkg" >/dev/null 2>&1; then
    warn "$pkg já instalado."
  else
    log "Instalando $pkg..."
    apt-get install -y "$pkg"
    ok "$pkg instalado."
  fi
}

# Função idempotente: garante que um serviço está ativo e habilitado no boot.
garante_servico() {
  local svc="$1"
  systemctl enable "$svc" >/dev/null 2>&1 || true
  if systemctl is-active --quiet "$svc"; then
    ok "Serviço $svc ativo."
  else
    log "Iniciando $svc..."
    systemctl start "$svc"
    ok "Serviço $svc iniciado."
  fi
}

# --- 1. Atualiza índice de pacotes ---
log "Atualizando índice do apt..."
apt-get update -y

# --- 2. Apache ---
instala_se_preciso apache2
garante_servico apache2

# --- 3. MariaDB (substituto livre e padrão do MySQL no Ubuntu) ---
instala_se_preciso mariadb-server
garante_servico mariadb

# --- 4. PHP + módulos comuns ---
instala_se_preciso php
instala_se_preciso libapache2-mod-php
instala_se_preciso php-mysql

# Recarrega Apache para reconhecer o PHP (idempotente: reload é seguro)
log "Recarregando Apache para ativar PHP..."
systemctl reload apache2

# --- 5. Página de teste ---
PAGINA="/var/www/html/info.php"
if [[ ! -f "$PAGINA" ]]; then
  log "Criando página de teste em $PAGINA..."
  cat > "$PAGINA" <<'EOF'
<?php
// Página de teste da stack LAMP
echo "<h1>LAMP funcionando!</h1>";
echo "<p>PHP versão: " . phpversion() . "</p>";
echo "<hr><h2>Detalhes do PHP</h2>";
phpinfo();
EOF
  ok "Página de teste criada."
else
  warn "Página de teste já existe."
fi

# --- 6. Validação final ---
log "Validando serviços..."
for svc in apache2 mariadb; do
  if systemctl is-active --quiet "$svc"; then
    ok "$svc está rodando."
  else
    echo -e "${RED}[ERRO]${RST} $svc NÃO está rodando."
  fi
done

# Mostra versões instaladas
echo
ok "Versões instaladas:"
apache2 -v | head -1
mariadb --version
php -v | head -1

IP=$(hostname -I | awk '{print $1}')
echo
ok "Acesse no navegador:"
echo "   http://localhost/info.php"
echo "   http://${IP}/info.php   (de outra máquina na mesma rede)"
echo
warn "Segurança: rode 'sudo mysql_secure_installation' para proteger o MariaDB."
warn "Depois de testar, remova a página info.php (expõe detalhes do servidor)."