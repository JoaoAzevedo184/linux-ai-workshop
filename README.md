# 🐧 linux-ai-workshop

> 20 projetos práticos de **Linux/Ubuntu** integrados com **Claude Code** e a **API do Claude** — do básico de terminal a automação e IA. Estudos da Udemy aplicados em VM.

[![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?logo=ubuntu&logoColor=white)]()
[![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnubash&logoColor=white)]()
[![Python](https://img.shields.io/badge/Python-3.x-3776AB?logo=python&logoColor=white)]()
[![Claude](https://img.shields.io/badge/AI-Claude-D97757)]()
[![Ollama](https://img.shields.io/badge/LLM-Ollama-000000?logo=ollama&logoColor=white)]()

---

## 📖 Sobre

Este repositório reúne minha jornada de estudos práticos de **administração Linux** e **integração com IA**, aplicando na prática os conhecimentos de curso da Udemy. Cada projeto é executado em uma **VM Ubuntu** e construído/documentado com auxílio do **Claude Code**, usando também **Ollama** para inferência local.

A lista está organizada em **4 níveis de dificuldade crescente**, partindo de fundamentos de terminal até automação avançada com integração à API do Claude e a modelos locais via Ollama.

## 🎯 Objetivos

- Consolidar conhecimentos de terminal, permissões, usuários e pacotes.
- Praticar shell scripting (`bash`) e automação com `cron`.
- Montar e gerenciar um ambiente LAMP e configurações de rede/segurança.
- Integrar scripts com IA usando a API do Claude, Claude Code e Ollama (local).

## 🛠️ Stack

| Categoria | Ferramentas |
|-----------|-------------|
| SO | Ubuntu (VM) |
| Shell | Bash, Vim/Nano |
| Linguagens | Bash, Python 3 |
| Serviços | Apache, MySQL, PHP (LAMP) |
| Rede/Segurança | UFW, fail2ban, SSH, nmap |
| Agendamento | cron |
| IA | Claude Code, API do Claude, Ollama |

---

## 📂 Organização

Os projetos estão divididos em pastas por nível. Cada nível tem seu próprio `README.md` com a lista detalhada dos projetos.

| Pasta | Nível | Tema |
|-------|-------|------|
| [`Level1/`](./Level1) | Iniciante | Fundamentos de terminal + Claude Code |
| [`Level2/`](./Level2) | Intermediário | Gerenciamento de sistema (usuários, permissões, pacotes) |
| [`Level3/`](./Level3) | Avançado | Ambiente LAMP e redes |
| [`Level4/`](./Level4) | Expert | Automação + integração com IA |
| [`docs/`](./docs) | — | Anotações de estudo e material de apoio |

### Progresso geral

- **Level 1:** ⬜⬜⬜⬜⬜ (0/5)
- **Level 2:** ⬜⬜⬜⬜⬜ (0/5)
- **Level 3:** ⬜⬜⬜⬜⬜ (0/5)
- **Level 4:** ⬜⬜⬜⬜⬜ (0/5)

> Legenda: ⬜ a fazer · 🟨 em andamento · ✅ concluído

---

## 🚀 Como usar

```bash
# Clonar o repositório
git clone https://github.com/JoaoAzevedo184/linux-ai-workshop.git
cd linux-ai-workshop

# Entrar em um nível e depois em um projeto
cd Level1/01-setup-inicial

# Dar permissão e executar (exemplo)
chmod +x setup.sh
./setup.sh
```

> ⚠️ Os scripts foram feitos para fins de estudo e devem ser executados em uma **VM/ambiente de teste**, nunca em produção sem revisão.

## 📝 Notas de estudo

As anotações detalhadas de cada projeto (comandos, erros encontrados, soluções) ficam no `README.md` de cada nível e na pasta [`docs/`](./docs).

## 📌 Origem

Projetos baseados em estudos de Linux/Ubuntu da **Udemy**, com construção e documentação assistidas por **Claude Code** e modelos locais via **Ollama**.

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais detalhes.