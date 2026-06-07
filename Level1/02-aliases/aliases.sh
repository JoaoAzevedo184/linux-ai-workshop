# =============================================================
# aliases.sh - Conjunto de aliases úteis para o dia a dia.
#
# Como usar:
#   1. Copie este conteúdo para o final do seu ~/.bashrc
#      OU salve este arquivo e adicione no ~/.bashrc a linha:
#         source ~/caminho/para/aliases.sh
#   2. Recarregue: source ~/.bashrc
#
# Cada alias tem um comentário explicando o que faz.
# =============================================================

# --- Navegação ---
alias ..='cd ..'                  # sobe um diretório
alias ...='cd ../..'              # sobe dois diretórios
alias ....='cd ../../..'          # sobe três diretórios
alias ~='cd ~'                    # vai para o home

# --- Listagem (usando exibição detalhada e legível) ---
alias ll='ls -lah'                # lista tudo, formato longo, tamanhos legíveis
alias la='ls -A'                  # lista incluindo ocultos (sem . e ..)
alias l='ls -CF'                  # lista em colunas com marcadores de tipo
alias lt='ls -laht'               # lista ordenando por data (mais recente primeiro)

# --- Segurança (pede confirmação antes de sobrescrever/apagar) ---
alias cp='cp -i'                  # confirma antes de sobrescrever
alias mv='mv -i'                  # confirma antes de mover por cima
alias rm='rm -i'                  # confirma antes de remover

# --- Sistema ---
alias update='sudo apt update && sudo apt upgrade -y'  # atualiza o sistema
alias ports='ss -tulanp'          # mostra portas em uso
alias mem='free -h'               # uso de memória legível
alias disk='df -h'                # uso de disco legível
alias myip='curl -s ifconfig.me'  # mostra o IP público

# --- Git (atalhos comuns) ---
alias gs='git status'             # status do repositório
alias ga='git add'                # adiciona arquivos ao stage
alias gc='git commit -m'          # commit com mensagem
alias gp='git push'               # envia commits
alias gl='git log --oneline --graph --decorate'  # histórico resumido

# --- Utilidades ---
alias c='clear'                   # limpa a tela
alias h='history'                 # mostra histórico de comandos
alias path='echo $PATH | tr ":" "\n"'  # mostra cada item do PATH em uma linha
alias reload='source ~/.bashrc'   # recarrega o .bashrc