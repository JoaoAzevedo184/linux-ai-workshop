# 🟡 Level 2 — Intermediário

> Gerenciamento de sistema (usuários, permissões, pacotes)

Administração da VM: criação de usuários e grupos, auditoria de permissões, monitoramento de recursos e gerência de pacotes. Scripts mais robustos com lógica de menu e logs.

## 📋 Projetos

| # | Projeto | Descrição | Conceitos | Status |
|---|---------|-----------|-----------|:------:|
| 06 | **Criação de usuários em lote** | A partir de um CSV, criar usuários, grupos e definir permissões. | CSV, `useradd`/`groupadd`/`chmod` | ✅ |
| 07 | **Auditor de permissões** | Varre um diretório e reporta arquivos com permissões inseguras (ex: `777`). | `find` + `stat` | ✅ |
| 08 | **Dashboard de monitoramento no terminal** | Mostra CPU, RAM, disco e usuários logados, formatado. | `top`, `df`, `free`, `who` | ✅ |
| 09 | **Gerenciador de pacotes interativo** | Menu em shell para instalar/remover/atualizar grupos de pacotes. | menu shell, `apt` | ✅ |
| 10 | **Logger de atividades do sistema** | Registra logins, uso de disco e processos pesados em log diário, com rotação. | logs diários, rotação | ✅ |

> Legenda: ⬜ a fazer · 🟨 em andamento · ✅ concluído

## 🎯 O que vou aprender

- Gerenciar usuários, grupos e permissões em lote.
- Auditar segurança de arquivos com `find` e `stat`.
- Coletar métricas do sistema (`top`, `df`, `free`, `who`).
- Construir menus interativos em Bash.
- Implementar logging e rotação de logs.

## 🗂️ Estrutura

```
Level2/
├── 06-usuarios-lote/
├── 07-auditor-permissoes/
├── 08-dashboard-terminal/
├── 09-gerenciador-pacotes/
└── 10-logger-sistema/
```