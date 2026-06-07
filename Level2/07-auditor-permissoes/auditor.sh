#!/usr/bin/env bash
#
# auditor.sh - Audita permissões inseguras em um diretório.
#
# Detecta:
#   - arquivos/pastas com permissão de escrita para "outros" (world-writable, ex: 777, 666)
#   - arquivos com bit SUID/SGID (potencial escalonamento de privilégio)
#   - arquivos sem dono válido (órfãos)
#
# Uso:
#   chmod +x auditor.sh
#   ./auditor.sh [diretório]      # padrão: diretório atual
#
# Não altera nada — só reporta. Pode rodar sem sudo (mas com sudo vê mais coisas).

set -uo pipefail

ALVO="${1:-.}"

if [[ ! -d "$ALVO" ]]; then
  echo "Erro: '$ALVO' não é um diretório válido." >&2
  exit 1
fi

# Cores
RED='\033[1;31m'; YEL='\033[1;33m'; GRN='\033[1;32m'; CYA='\033[1;36m'; RST='\033[0m'

echo -e "${CYA}=== Auditoria de permissões em: $ALVO ===${RST}\n"

# --- 1. World-writable (escrita para "outros") ---
echo -e "${YEL}[1] Arquivos/pastas graváveis por qualquer usuário (world-writable):${RST}"
# -perm -0002 = bit de escrita para "outros" está ligado
# 2>/dev/null silencia erros de "permissão negada" em pastas protegidas
encontrados=$(find "$ALVO" -perm -0002 ! -type l 2>/dev/null)
if [[ -n "$encontrados" ]]; then
  while IFS= read -r f; do
    # %a = permissão em octal, %u = dono — formato do stat
    perm=$(stat -c '%a' "$f" 2>/dev/null)
    echo -e "  ${RED}$perm${RST}  $f"
  done <<< "$encontrados"
else
  echo -e "  ${GRN}Nenhum encontrado.${RST}"
fi
echo

# --- 2. SUID / SGID ---
echo -e "${YEL}[2] Arquivos com SUID/SGID (executam com privilégio do dono/grupo):${RST}"
suid=$(find "$ALVO" -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null)
if [[ -n "$suid" ]]; then
  while IFS= read -r f; do
    perm=$(stat -c '%A' "$f" 2>/dev/null)   # %A = permissão simbólica (rwx)
    echo -e "  ${RED}$perm${RST}  $f"
  done <<< "$suid"
else
  echo -e "  ${GRN}Nenhum encontrado.${RST}"
fi
echo

# --- 3. Arquivos sem dono válido ---
echo -e "${YEL}[3] Arquivos órfãos (sem usuário ou grupo válido):${RST}"
orfaos=$(find "$ALVO" \( -nouser -o -nogroup \) 2>/dev/null)
if [[ -n "$orfaos" ]]; then
  while IFS= read -r f; do
    echo -e "  ${RED}órfão${RST}  $f"
  done <<< "$orfaos"
else
  echo -e "  ${GRN}Nenhum encontrado.${RST}"
fi
echo

echo -e "${CYA}=== Fim da auditoria ===${RST}"