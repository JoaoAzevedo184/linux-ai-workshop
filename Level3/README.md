# 🟠 Level 3 — Avançado

> Ambiente LAMP e redes

Montagem de um servidor web completo (Apache, MySQL, PHP), aplicação CRUD, e exploração/segurança de rede com scanner, firewall e monitoramento de serviços.

## 📋 Projetos

| # | Projeto | Descrição | Conceitos | Status |
|---|---------|-----------|-----------|:------:|
| 11 | **Instalação automatizada do LAMP** | Script idempotente que instala e configura Apache, MySQL e PHP, valida serviços e cria página de teste. | script idempotente, Apache/MySQL/PHP | ✅ |
| 12 | **App PHP+MySQL (CRUD)** | Pequeno sistema CRUD (lista de tarefas) rodando no LAMP, com virtual hosts no Apache. | virtual hosts, CRUD | ✅ |
| 13 | **Scanner de rede local** | Descobre dispositivos na rede e portas abertas. | `ip`, `ping`, `nmap` | ✅ |
| 14 | **Configurador de firewall (UFW)** | Script interativo com regras para diferentes perfis (web, dev, fechado). | UFW, perfis de regras | ✅ |
| 15 | **Monitor de uptime de serviços** | Verifica se Apache/MySQL estão de pé e envia alerta se caírem, via cron. | checagem + alerta, cron | ✅ |

> Legenda: ⬜ a fazer · 🟨 em andamento · ✅ concluído

## 🎯 O que vou aprender

- Instalar e configurar uma stack LAMP de forma idempotente.
- Criar virtual hosts no Apache e uma aplicação CRUD.
- Descobrir dispositivos e portas com `nmap`.
- Configurar firewall com UFW por perfil.
- Monitorar disponibilidade de serviços com alertas.

## 🗂️ Estrutura

```
Level3/
├── 11-lamp-install/
├── 12-app-crud/
├── 13-scanner-rede/
├── 14-firewall-ufw/
└── 15-monitor-uptime/
```