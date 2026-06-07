# 11 — Instalação automatizada do LAMP

Script **idempotente** que monta uma stack LAMP (Apache + MariaDB + PHP), garante que os serviços estão ativos e cria uma página de teste.

> Usamos **MariaDB** em vez do MySQL — é o padrão no Ubuntu, 100% compatível e instala sem prompts.

## Como rodar

```bash
chmod +x instalar_lamp.sh
sudo ./instalar_lamp.sh
```

Pode rodar de novo a qualquer momento: ele só instala/inicia o que ainda falta.

## O que significa "idempotente"

Cada passo checa o estado antes de agir:
- `dpkg -s pacote` → só instala se não estiver instalado.
- `systemctl is-active` → só inicia o serviço se estiver parado.
- A página de teste só é criada se ainda não existir.

Resultado: rodar 1x ou 5x leva ao mesmo estado final, sem erros nem duplicação.

## Validação

Ao final, o script confirma que `apache2` e `mariadb` estão rodando e mostra as versões. Teste no navegador:

```
http://localhost/info.php
```

## Conceitos praticados

- `apt-get install`, `dpkg -s`.
- `systemctl enable/start/reload/is-active`.
- Funções reutilizáveis em Bash.
- Idempotência em scripts de provisionamento.

## Segurança (importante)

Depois de instalar:

```bash
sudo mysql_secure_installation     # define senha root, remove acessos de teste
sudo rm /var/www/html/info.php     # info.php expõe detalhes do servidor — remova após testar
```