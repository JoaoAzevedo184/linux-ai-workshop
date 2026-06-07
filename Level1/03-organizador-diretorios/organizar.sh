#!/usr/bin/env bash
#
# organizar.sh - Organiza arquivos de um diretório em subpastas por extensão.
#
# Uso:
#   chmod +x organizar.sh
#   ./organizar.sh [diretório]      # se omitido, usa o diretório atual
#
# Exemplo:
#   ./organizar.sh ~/Downloads
#
# Cria pastas como "pdf/", "jpg/", "txt/" e move os arquivos correspondentes.

set -euo pipefail

# Diretório alvo: primeiro argumento, ou o diretório atual se nenhum for passado.
# "${1:-.}" significa "use $1, mas se estiver vazio use '.'"
ALVO="${1:-.}"

# Valida se o alvo existe e é um diretório
if [[ ! -d "$ALVO" ]]; then
  echo "Erro: '$ALVO' não é um diretório válido." >&2
  exit 1
fi

echo "Organizando arquivos em: $ALVO"

# Entra no diretório alvo para trabalhar com nomes relativos
cd "$ALVO"

# Contador de arquivos movidos
contador=0

# Percorre apenas arquivos (não pastas) do diretório atual.
# 'find . -maxdepth 1 -type f' = só arquivos no nível atual, sem entrar em subpastas.
while IFS= read -r -d '' arquivo; do
  # Remove o "./" do começo do nome
  nome=$(basename "$arquivo")

  # Pula o próprio script, para não se mover sozinho
  if [[ "$nome" == "organizar.sh" ]]; then
    continue
  fi

  # Extrai a extensão (tudo depois do último ponto).
  # Se o nome não tiver ponto, classificamos como "sem_extensao".
  if [[ "$nome" == *.* ]]; then
    ext="${nome##*.}"          # ##*. = remove tudo até o último ponto
    # Converte a extensão para minúsculas para padronizar (jpg = JPG)
    ext="${ext,,}"
  else
    ext="sem_extensao"
  fi

  # Cria a pasta da extensão se ainda não existir
  mkdir -p "$ext"

  # Move o arquivo para a pasta correspondente
  mv -- "$nome" "$ext/"
  echo "  $nome -> $ext/"
  contador=$((contador + 1))

done < <(find . -maxdepth 1 -type f -print0)
# Nota: -print0 + read -d '' lida corretamente com nomes que têm espaços.

echo "Concluído. $contador arquivo(s) organizado(s)."