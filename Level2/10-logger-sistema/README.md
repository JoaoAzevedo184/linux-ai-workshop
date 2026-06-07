# 10 — Logger de atividades do sistema

Gera um snapshot diário da atividade da máquina (logins, disco, processos pesados) num arquivo de log por dia, e apaga logs antigos automaticamente (rotação).

## Como rodar manualmente

```bash
chmod +x logger.sh
./logger.sh
```

Saída em `~/system-logs/atividade-AAAA-MM-DD.log`.

## O que ele registra

1. Últimos 10 logins (`last`).
2. Usuários logados no momento (`who`).
3. Uso de disco (`df -h`).
4. Top 5 processos por CPU (`ps --sort=-%cpu`).
5. Top 5 processos por memória (`ps --sort=-%mem`).

Se rodar várias vezes no mesmo dia, ele **anexa** novos snapshots ao log do dia (com horário no cabeçalho de cada bloco).

## Agendar com cron

```bash
crontab -e
```

Exemplo — todo dia às 23h (caminho absoluto obrigatório):

```
0 23 * * * /home/joao/Level2/10-logger-sistema/logger.sh
```

## Rotação

A linha:

```bash
find "$LOG_DIR" -name 'atividade-*.log' -mtime +14 -delete
```

remove logs com mais de 14 dias. Ajuste `DIAS_RETENCAO` no topo do script.

## Conceitos praticados

- `last`, `who`, `df`, `ps --sort`.
- Redirecionamento com append (`>>`).
- Funções para organizar a saída.
- Rotação de arquivos com `find -mtime +N -delete`.
- Agendamento via `cron`.

## Ver o log

```bash
cat ~/system-logs/atividade-$(date +%Y-%m-%d).log
tail -f ~/system-logs/atividade-$(date +%Y-%m-%d).log   # acompanhar em tempo real
```