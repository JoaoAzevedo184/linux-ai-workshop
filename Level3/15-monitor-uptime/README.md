# 15 — Monitor de uptime de serviços

Verifica periodicamente se serviços críticos (Apache, MariaDB) estão de pé. Se algum cair, registra um alerta no log e tenta reiniciar. Pensado para rodar via `cron`.

## Como rodar manualmente

```bash
chmod +x monitor.sh
./monitor.sh                  # verifica e registra (sem reiniciar, se não for root)
sudo ./monitor.sh             # com sudo, consegue reiniciar serviços caídos
```

Log em `~/monitor-logs/uptime.log`.

## O que ele faz

1. Para cada serviço da lista `SERVICOS`, checa com `systemctl is-active`.
2. Se estiver ativo → registra "OK".
3. Se estiver parado → registra "ALERTA", tenta reiniciar e confirma se subiu.

Edite no topo do script: `SERVICOS=(...)` e `TENTAR_REINICIAR`.

## Agendar com cron

Como reiniciar serviços exige privilégio, agende no **crontab do root**:

```bash
sudo crontab -e
```

Exemplo — a cada 5 minutos:

```
*/5 * * * * /home/joao/Level3/15-monitor-uptime/monitor.sh
```

> `*/5` no campo de minutos = "a cada 5 minutos".

## Notificações (opcional)

O script tem um bloco comentado com exemplos de alerta externo: e-mail (`mail`), notificação desktop (`notify-send`) e webhook (`curl` para Telegram/Discord). Descomente e configure o que preferir.

## Conceitos praticados

- `systemctl is-active --quiet` para checar serviços.
- `systemctl restart` com verificação de sucesso.
- Log com timestamp (`tee -a`).
- Agendamento frequente via `cron` (`*/5`).

## Ver o log

```bash
tail -f ~/monitor-logs/uptime.log     # acompanhar em tempo real
grep ALERTA ~/monitor-logs/uptime.log # só os alertas
```

## Testar o alerta

Pare um serviço de propósito e rode o monitor:

```bash
sudo systemctl stop apache2
sudo ./monitor.sh
# deve registrar ALERTA, reiniciar e confirmar OK
```