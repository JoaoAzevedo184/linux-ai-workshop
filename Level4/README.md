# 🔴 Level 4 — Expert

> Automação + integração com IA

Junção de tudo: scripts master de manutenção, hardening de segurança, pipeline de deploy, geração automática de documentação e uma CLI própria que integra IA (API do Claude e/ou Ollama local).

## 📋 Projetos

| # | Projeto | Descrição | Conceitos | Status |
|---|---------|-----------|-----------|:------:|
| 16 | **Assistente de manutenção da VM** | Script master: limpeza de pacotes, atualização, verificação de segurança e relatório. | automação, relatório | ⬜ |
| 17 | **Hardening básico de servidor** | Script guiado de segurança: SSH com chave, desabilitar root login, fail2ban, updates automáticos. | SSH por chave, fail2ban, hardening | ⬜ |
| 18 | **Pipeline de deploy local** | Do código ao Apache: git pull, testes, restart de serviço. | git pull, testes, restart | ⬜ |
| 19 | **Gerador de documentação de infraestrutura** | Coleta toda a config da VM e a IA gera um README técnico em Markdown. | coleta de config → Markdown | ⬜ |
| 20 | **CLI própria com IA integrada** | Ferramenta de linha de comando que responde perguntas sobre o sistema usando a API do Claude / Ollama. | shell + API do Claude / Ollama | ⬜ |

> Legenda: ⬜ a fazer · 🟨 em andamento · ✅ concluído

## 🎯 O que vou aprender

- Orquestrar múltiplos scripts num fluxo de manutenção.
- Aplicar boas práticas de hardening de servidor.
- Construir um pipeline de deploy local automatizado.
- Gerar documentação técnica a partir do estado real da VM.
- Integrar shell scripting com IA (API do Claude e Ollama local).

## 🤖 Nota sobre IA local (Ollama)

Os projetos 19 e 20 podem usar **Ollama** para inferência local, evitando dependência de API externa. Exemplo de chamada:

```bash
ollama run llama3 "Qual processo está consumindo mais RAM neste output? $(ps aux --sort=-%mem | head)"
```

## 🗂️ Estrutura

```
Level4/
├── 16-assistente-manutencao/
├── 17-hardening-servidor/
├── 18-pipeline-deploy/
├── 19-gerador-docs/
└── 20-cli-ia/
```