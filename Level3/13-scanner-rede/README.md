# 13 — Scanner de rede local

Descobre quais dispositivos estão ativos na sua rede e quais portas eles têm abertas, usando `nmap`.

## Pré-requisito

```bash
sudo apt install nmap
```

## Como rodar

```bash
chmod +x scanner.sh
./scanner.sh                  # detecta sua rede automaticamente
./scanner.sh 192.168.1.0/24   # ou informe a faixa manualmente
sudo ./scanner.sh             # com sudo o nmap traz mais detalhes
```

## O que ele faz

1. Detecta seu IP e monta a faixa `/24` da rede (ou usa a que você passar).
2. **Ping scan** (`nmap -sn`): lista os dispositivos vivos.
3. **Fast scan** (`nmap -F --open`): mostra as portas abertas de cada um.

## Conceitos praticados

- `ip route get` para descobrir o IP/rota local.
- `nmap -sn` (descoberta) vs `nmap -F` (portas).
- Manipulação da saída com `awk` e `sed`.
- Notação CIDR (`/24` = 256 endereços).

## ⚠️ Uso responsável

Escaneie **apenas redes que você administra ou tem permissão**. Fazer port scan em redes de terceiros pode ser ilegal e/ou violar termos de serviço. Em rede corporativa/escola, confirme antes com quem administra.

## Ideias de evolução

- `nmap -O` para fingerprint do SO (precisa de sudo).
- Resolver nomes via `nmap -sn -R`.
- Exportar resultado para CSV/JSON.