# 08 — Dashboard de monitoramento no terminal

Painel que resume o estado da máquina: host, CPU, memória, disco e usuários logados, formatado de forma legível.

## Como rodar

```bash
chmod +x dashboard.sh
./dashboard.sh            # snapshot único
./dashboard.sh --watch    # atualiza a cada 2s (Ctrl+C para sair)
```

## O que mostra

- **Host**: hostname, kernel, uptime.
- **CPU**: número de núcleos, load average (1/5/15 min) e uso instantâneo.
- **Memória**: RAM e swap (total / usado / livre).
- **Disco**: partições reais com tamanho, uso e % ocupado.
- **Usuários**: quem está logado e desde quando.

## Conceitos praticados

- `top -bn1` (modo batch, sem interatividade).
- `free -h`, `df -h`, `who`, `uptime`, `nproc`, `uname`.
- Formatação de colunas com `awk`.
- Loop com `sleep` + `trap` para o modo `--watch`.

## Por que `top -bn1`?

O `top` normalmente é interativo. As flags `-b` (batch) e `-n1` (uma iteração) fazem ele imprimir uma única leitura e sair — ideal para capturar dentro de um script.