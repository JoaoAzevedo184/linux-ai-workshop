# 14 — Configurador de firewall (UFW)

Menu interativo que aplica perfis de firewall prontos usando o **UFW** (Uncomplicated Firewall), a interface simplificada do iptables no Ubuntu.

## Como rodar

```bash
chmod +x firewall.sh
sudo ./firewall.sh
```

## Perfis disponíveis

| Perfil | Portas liberadas (entrada) |
|--------|----------------------------|
| **Servidor Web** | 22 (SSH), 80 (HTTP), 443 (HTTPS) |
| **Desenvolvimento** | 22 (SSH), 3000, 5000, 8000, 8080 |
| **Fechado** | só 22 (SSH) |

Política padrão em todos: **bloqueia entrada, libera saída**.

## ⚠️ Cuidado para não se trancar fora

Todos os perfis mantêm o **SSH (porta 22) aberto** de propósito. Se você estiver acessando a VM remotamente e bloquear o SSH, perde o acesso. Por isso o SSH nunca é removido aqui.

Se for mudar a porta do SSH, ajuste o número nos perfis antes de aplicar.

## Conceitos praticados

- `ufw default deny/allow`, `ufw allow porta/tcp`, `ufw enable/disable/reset`.
- Comentários em regras (`comment '...'`) para documentar o porquê de cada uma.
- Menu interativo com `case`.

## Verificar

```bash
sudo ufw status verbose      # lista regras ativas
sudo ufw status numbered     # com números (útil para remover regra específica)
```

## Remover uma regra específica

```bash
sudo ufw status numbered     # veja o número
sudo ufw delete <numero>
```