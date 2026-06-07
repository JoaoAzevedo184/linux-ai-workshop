Aqui estão 20 projetos que combinam Linux/Ubuntu (VM) com Claude/Claude Code, organizados do mais simples ao mais avançado:

**Nível 1 — Iniciante (fundamentos de terminal + Claude Code)**

1. **Setup inicial automatizado**: peça ao Claude Code para gerar um script `setup.sh` que configura sua VM recém-instalada (timezone, locale, pacotes essenciais via apt), e use-o para praticar `chmod +x` e execução.

2. **Gerador de aliases inteligente**: use o Claude Code para criar um conjunto de aliases úteis no `.bashrc`, com comentários explicando cada um. Pratique edição com Vim/Nano.

3. **Organizador de diretórios**: script que organiza arquivos por extensão em pastas. O Claude gera o código, você ajusta permissões e testa com `ls -la`.

4. **Backup simples com cron**: peça ao Claude um script de backup (`tar`/`rsync`) de uma pasta e configure um agendamento com `crontab -e`.

5. **Cheat sheet pessoal**: use a extensão Claude/chat para gerar uma página HTML com seus comandos Linux favoritos, sirva-a localmente com `python3 -m http.server`.

**Nível 2 — Gerenciamento de sistema (usuários, permissões, pacotes)**

6. **Script de criação de usuários em lote**: a partir de um arquivo CSV, criar usuários, grupos e definir permissões. Claude gera a lógica de `useradd`/`groupadd`/`chmod`.

7. **Auditor de permissões**: script que varre um diretório e reporta arquivos com permissões inseguras (ex: `777`). Bom exercício de `find` + `stat`.

8. **Dashboard de monitoramento no terminal**: um script que mostra CPU, RAM, disco e usuários logados, formatado bonito. Claude Code ajuda com `top`, `df`, `free`, `who`.

9. **Gerenciador de pacotes interativo**: menu em shell para instalar/remover/atualizar grupos de pacotes (dev, multimídia, etc.) via apt.

10. **Logger de atividades do sistema**: script que registra logins, uso de disco e processos pesados em um log diário, com rotação.

**Nível 3 — Ambiente LAMP e redes**

11. **Instalação automatizada do LAMP**: script idempotente que instala e configura Apache, MySQL e PHP, valida cada serviço e cria uma página de teste.

12. **App PHP+MySQL simples (CRUD)**: peça ao Claude Code para gerar um pequeno sistema CRUD (lista de tarefas) rodando no seu LAMP, e pratique configuração de virtual hosts no Apache.

13. **Scanner de rede local**: script que descobre dispositivos na rede e portas abertas usando `ip`, `ping` e `nmap`. Claude explica o output.

14. **Configurador de firewall (UFW)**: script interativo que define regras de firewall para diferentes perfis (servidor web, dev, fechado).

15. **Monitor de uptime de serviços**: verifica se Apache/MySQL estão de pé e envia alerta (log ou notificação) se caírem, agendado via cron.

**Nível 4 — Avançado (automação + integração com IA)**

16. **Assistente de manutenção da VM**: um script master que combina limpeza de pacotes, atualização, verificação de segurança e relatório — documentado com ajuda do Claude Code no VSCode.

17. **Hardening básico de servidor**: script guiado de segurança (SSH com chave, desabilitar root login, fail2ban, atualizações automáticas), com Claude explicando cada decisão.

18. **Pipeline de deploy local**: do código ao Apache automaticamente — git pull, testes, restart de serviço. Use Claude Code para construir e documentar o fluxo.

19. **Gerador de documentação de infraestrutura**: script que coleta toda a config da VM (pacotes, serviços, rede, usuários) e o Claude gera um README/documentação técnica em Markdown automaticamente.

20. **CLI próprio com IA integrada**: crie uma ferramenta de linha de comando que recebe perguntas sobre o sistema e usa a API do Claude para responder (ex: "qual processo está consumindo mais RAM?"), juntando shell scripting, redes e integração com IA.