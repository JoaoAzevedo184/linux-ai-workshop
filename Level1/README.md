# 🟢 Level 1 — Iniciante

> Fundamentos de terminal + Claude Code

Primeiros passos com a VM Ubuntu: criação e execução de scripts, edição de arquivos de configuração, permissões e agendamento. O Claude Code ajuda a gerar e explicar cada script.

## 📋 Projetos

| # | Projeto | Descrição | Conceitos | Status |
|---|---------|-----------|-----------|:------:|
| 01 | **Setup inicial automatizado** | Script `setup.sh` que configura a VM recém-instalada (timezone, locale, pacotes essenciais via `apt`). | `setup.sh`, `apt`, `chmod +x`, execução | ✅ |
| 02 | **Gerador de aliases inteligente** | Conjunto de aliases úteis no `.bashrc`, com comentários explicando cada um. | `.bashrc`, edição Vim/Nano | ✅ |
| 03 | **Organizador de diretórios** | Script que organiza arquivos por extensão em pastas. | permissões, `ls -la` | ✅ |
| 04 | **Backup simples com cron** | Script de backup (`tar`/`rsync`) de uma pasta, agendado via crontab. | `tar`/`rsync`, `crontab -e` | ✅ |
| 05 | **Cheat sheet pessoal** | Página HTML com comandos Linux favoritos, servida localmente. | HTML, `python3 -m http.server` | ✅ |

> Legenda: ⬜ a fazer · 🟨 em andamento · ✅ concluído

## 🎯 O que vou aprender

- Tornar scripts executáveis e rodá-los (`chmod +x`, `./script.sh`).
- Editar arquivos de configuração no terminal (Vim/Nano).
- Instalar pacotes com `apt`.
- Agendar tarefas com `cron`.
- Subir um servidor HTTP simples com Python.

## 🗂️ Estrutura

```
Level1/
├── 01-setup-inicial/
├── 02-aliases/
├── 03-organizador-diretorios/
├── 04-backup-cron/
└── 05-cheat-sheet/
```