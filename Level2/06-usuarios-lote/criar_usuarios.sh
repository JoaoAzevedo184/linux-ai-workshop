#!/usr/bin/env bash
#
# criar_usuarios.sh - Cria usuários e grupos em lote a partir de um CSV.
#
# Formato do CSV (com cabeçalho):
#   usuario,grupo,shell,comentario
#   ana.silva,dev,/bin/bash,Ana Silva - Backend
#
# Uso:
#   chmod +x criar_usuarios.sh
#   sudo ./criar_usuarios.sh usuarios.csv
#
# Para cada linha:
#   - cria o grupo (se não existir)
#   - cria o usuário com home e shell definidos
#   - adiciona o usuário ao grupo
#   - define senha temporária e força troca no primeiro login
#   - ajusta permissões da home (chmod 700)

set -euo pipefail

# --- Validações iniciais ---
if [[ $EUID -ne 0 ]]; then
  echo "Este script precisa de sudo (cria usuários/grupos)." >&2
  exit 1
fi

CSV="${1:-}"
if [[ -z "$CSV" ]]; then
  echo "Uso: sudo ./criar_usuarios.sh <arquivo.csv>" >&2
  exit 1
fi
if [[ ! -f "$CSV" ]]; then
  echo "Erro: arquivo '$CSV' não encontrado." >&2
  exit 1
fi

# Senha temporária padrão (o usuário será obrigado a trocar no 1º login)
SENHA_PADRAO="Trocar@123"

log() { echo -e "\033[1;36m[*]\033[0m $1"; }
ok()  { echo -e "\033[1;32m[+]\033[0m $1"; }
err() { echo -e "\033[1;31m[!]\033[0m $1"; }

# --- Processamento do CSV ---
# 'tail -n +2' pula a linha de cabeçalho.
# IFS=',' separa os campos por vírgula.
linha_num=1
tail -n +2 "$CSV" | while IFS=',' read -r usuario grupo shell comentario; do
  linha_num=$((linha_num + 1))

  # Ignora linhas em branco
  [[ -z "$usuario" ]] && continue

  # Remove espaços em volta dos campos
  usuario=$(echo "$usuario" | xargs)
  grupo=$(echo "$grupo" | xargs)
  shell=$(echo "$shell" | xargs)

  log "Processando '$usuario' (grupo: $grupo)"

  # 1. Cria o grupo se ainda não existir
  if ! getent group "$grupo" >/dev/null; then
    groupadd "$grupo"
    ok "Grupo '$grupo' criado."
  fi

  # 2. Verifica se o usuário já existe
  if id "$usuario" >/dev/null 2>&1; then
    err "Usuário '$usuario' já existe — pulando."
    continue
  fi

  # 3. Cria o usuário
  #   -m: cria a home   -s: shell   -g: grupo primário   -c: comentário (nome)
  useradd -m -s "$shell" -g "$grupo" -c "$comentario" "$usuario"

  # 4. Define a senha temporária
  echo "$usuario:$SENHA_PADRAO" | chpasswd

  # 5. Força troca de senha no primeiro login
  passwd --expire "$usuario" >/dev/null

  # 6. Restringe a home só ao dono
  chmod 700 "/home/$usuario"

  ok "Usuário '$usuario' criado (senha temporária: $SENHA_PADRAO)."
done

echo
ok "Processamento concluído."
echo "Confira com: getent passwd | tail -n 10"