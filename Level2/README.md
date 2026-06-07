# 🐧 linux-ai-workshop

> 20 projetos práticos de **Linux/Ubuntu** integrados com **Claude Code** e a **API do Claude** — do básico de terminal a automação e IA. Estudos da Udemy aplicados em VM.

[![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?logo=ubuntu&logoColor=white)]()
[![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnubash&logoColor=white)]()
[![Python](https://img.shields.io/badge/Python-3.x-3776AB?logo=python&logoColor=white)]()
[![Claude](https://img.shields.io/badge/AI-Claude-D97757)]()

---

## 📖 Sobre

Este repositório reúne minha jornada de estudos práticos de **administração Linux** e **integração com IA**, aplicando na prática os conhecimentos de curso da Udemy. Cada projeto é executado em uma **VM Ubuntu** e construído/documentado com auxílio do **Claude Code**.

A lista está organizada em **4 níveis de dificuldade crescente**, partindo de fundamentos de terminal até automação avançada com integração à API do Claude.

## 🎯 Objetivos

- Consolidar conhecimentos de terminal, permissões, usuários e pacotes.
- Praticar shell scripting (`bash`) e automação com `cron`.
- Montar e gerenciar um ambiente LAMP e configurações de rede/segurança.
- Integrar scripts com IA usando a API do Claude e Claude Code.

## 🛠️ Stack

| Categoria | Ferramentas |
|-----------|-------------|
| SO | Ubuntu (VM) |
| Shell | Bash, Vim/Nano |
| Linguagens | Bash, Python 3 |
| Serviços | Apache, MySQL, PHP (LAMP) |
| Rede/Segurança | UFW, fail2ban, SSH, nmap |
| Agendamento | cron |
| IA | Claude Code, API do Claude |

---

## 📂 Projetos

### Nível 1 — Iniciante (fundamentos de terminal + Claude Code)

| # | Projeto | Conceitos | Status |
|---|---------|-----------|:------:|
| 01 | Setup inicial automatizado | `setup.sh`, `apt`, `chmod +x` | ⬜ |
| 02 | Gerador de aliases inteligente | `.bashrc`, edição Vim/Nano | ⬜ |
| 03 | Organizador de diretórios | permissões, `ls -la` | ⬜ |
| 04 | Backup simples com cron | `tar`/`rsync`, `crontab -e` | ⬜ |
| 05 | Cheat sheet pessoal | HTML, `python3 -m http.server` | ⬜ |

### Nível 2 — Gerenciamento de sistema (usuários, permissões, pacotes)

| # | Projeto | Conceitos | Status |
|---|---------|-----------|:------:|
| 06 | Criação de usuários em lote | CSV, `useradd`/`groupadd`/`chmod` | ⬜ |
| 07 | Auditor de permissões | `find` + `stat`, permissões inseguras | ⬜ |
| 08 | Dashboard de monitoramento no terminal | `top`, `df`, `free`, `who` | ⬜ |
| 09 | Gerenciador de pacotes interativo | menu shell, `apt` | ⬜ |
| 10 | Logger de atividades do sistema | logs diários, rotação | ⬜ |

### Nível 3 — Ambiente LAMP e redes

| # | Projeto | Conceitos | Status |
|---|---------|-----------|:------:|
| 11 | Instalação automatizada do LAMP | script idempotente, Apache/MySQL/PHP | ⬜ |
| 12 | App PHP+MySQL (CRUD) | virtual hosts, CRUD | ⬜ |
| 13 | Scanner de rede local | `ip`, `ping`, `nmap` | ⬜ |
| 14 | Configurador de firewall (UFW) | perfis de regras | ⬜ |
| 15 | Monitor de uptime de serviços | checagem + alerta, cron | ⬜ |

### Nível 4 — Avançado (automação + integração com IA)

| # | Projeto | Conceitos | Status |
|---|---------|-----------|:------:|
| 16 | Assistente de manutenção da VM | limpeza, update, relatório | ⬜ |
| 17 | Hardening básico de servidor | SSH por chave, fail2ban, no-root | ⬜ |
| 18 | Pipeline de deploy local | git pull, testes, restart | ⬜ |
| 19 | Gerador de documentação de infraestrutura | coleta de config → README | ⬜ |
| 20 | CLI próprio com IA integrada | shell + API do Claude | ⬜ |

> Legenda: ⬜ a fazer · 🟨 em andamento · ✅ concluído

---

## 🗂️ Estrutura sugerida

```
linux-claude-lab/
├── README.md
├── 01-setup-inicial/
│   ├── setup.sh
│   └── README.md
├── 02-aliases/
├── 03-organizador-diretorios/
├── ...
└── 20-cli-ia/
```

Cada pasta de projeto contém o código, um `README.md` próprio com o objetivo, os comandos usados e o que foi aprendido.

## 🚀 Como usar

```bash
# Clonar o repositório
git clone https://github.com/JoaoAzevedo184/linux-claude-lab.git
cd linux-claude-lab

# Entrar em um projeto
cd 01-setup-inicial

# Dar permissão e executar (exemplo)
chmod +x setup.sh
./setup.sh
```

> ⚠️ Os scripts foram feitos para fins de estudo e devem ser executados em uma **VM/ambiente de teste**, nunca em produção sem revisão.

## 📝 Notas de estudo

As anotações detalhadas de cada projeto (comandos, erros encontrados, soluções) ficam no `README.md` de cada pasta.

## 📌 Origem

Projetos baseados em estudos de Linux/Ubuntu da **Udemy**, com construção e documentação assistidas por **Claude Code**.

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais detalhes.