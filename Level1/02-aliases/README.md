# 02 — Gerador de aliases inteligente

Conjunto de aliases úteis (navegação, listagem, git, sistema), cada um comentado. Bom exercício de edição de arquivos de configuração com Vim/Nano.

## Como instalar

**Opção A — colar direto no `.bashrc`:**

```bash
nano ~/.bashrc          # ou: vim ~/.bashrc
# cole o conteúdo de aliases.sh no final do arquivo
source ~/.bashrc        # recarrega
```

**Opção B — manter o arquivo separado (recomendado):**

```bash
# copie aliases.sh para o seu home
cp aliases.sh ~/.bash_aliases

# adicione esta linha ao final do ~/.bashrc (se ainda não existir):
echo 'source ~/.bash_aliases' >> ~/.bashrc

# recarregue
source ~/.bashrc
```

> O Ubuntu já costuma carregar `~/.bash_aliases` automaticamente pelo `.bashrc` padrão — vale conferir antes de duplicar a linha.

## Conceitos praticados

- Edição de `.bashrc` com Vim/Nano.
- Sintaxe de `alias nome='comando'`.
- `source` para recarregar configuração sem reabrir o terminal.

## Testar

```bash
ll        # deve listar em formato longo
myip      # deve mostrar seu IP público
reload    # recarrega o .bashrc
```