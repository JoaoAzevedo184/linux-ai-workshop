# 06 — Criação de usuários em lote

Lê um arquivo CSV e cria usuários + grupos + permissões de uma vez. Útil para provisionar várias contas (ex: turma, equipe) sem repetir comandos.

## Arquivos

- `usuarios.csv` — exemplo de entrada (4 usuários).
- `criar_usuarios.sh` — o script.

## Formato do CSV

```csv
usuario,grupo,shell,comentario
ana.silva,dev,/bin/bash,Ana Silva - Backend
```

A primeira linha é o cabeçalho (é ignorada pelo script).

## Como rodar

```bash
chmod +x criar_usuarios.sh
sudo ./criar_usuarios.sh usuarios.csv
```

## O que o script faz por linha

1. Cria o grupo, se não existir (`groupadd`).
2. Pula o usuário se ele já existir (`id`).
3. Cria o usuário com home e shell (`useradd -m -s -g -c`).
4. Define uma senha temporária (`chpasswd`).
5. Força a troca no primeiro login (`passwd --expire`).
6. Restringe a home com `chmod 700`.

## Conceitos praticados

- Leitura de CSV em Bash (`tail -n +2` + `IFS=',' read`).
- `groupadd`, `useradd`, `chpasswd`, `passwd --expire`.
- `getent` para checar se grupo/usuário existe.
- `chmod` em diretório home.

## Testar com segurança

⚠️ Cria contas reais no sistema. Use uma VM de teste. Para remover depois:

```bash
sudo userdel -r ana.silva      # -r remove também a home
sudo groupdel dev              # se nenhum usuário usar mais o grupo
```

Conferir o que foi criado:

```bash
getent passwd | tail -n 10
getent group dev
```