# 09 — Gerenciador de pacotes interativo

Menu de terminal para instalar/remover grupos de pacotes (dev, multimídia, rede, sistema) e atualizar o sistema, sem decorar comandos `apt`.

## Como rodar

```bash
chmod +x gerenciador.sh
sudo ./gerenciador.sh
```

Navegue digitando o número da opção e ENTER.

## Grupos pré-definidos

| Grupo | Pacotes |
|-------|---------|
| DEV | git, curl, wget, build-essential, python3, python3-pip |
| MULTIMÍDIA | vlc, ffmpeg, gimp |
| REDE | net-tools, nmap, traceroute, dnsutils |
| SISTEMA | htop, tree, ncdu, unzip |

Edite as variáveis `GRUPO_*` no topo do script para customizar.

## Conceitos praticados

- Loop de menu com `while true` + `case`.
- Leitura de entrada com `read -rp`.
- Funções em Bash (`instalar`, `remover`, `menu`).
- `apt-get install/remove/update/upgrade/autoremove`.

## Observações

- Roda em loop até você escolher `0` (Sair).
- A opção 6 abre um submenu para escolher qual grupo remover.
- Como mexe em pacotes do sistema, exige `sudo`. Teste numa VM.