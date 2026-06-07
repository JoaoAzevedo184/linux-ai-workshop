# 12 — App PHP + MySQL (CRUD)

Lista de tarefas funcional rodando no LAMP do projeto 11, com virtual host próprio no Apache. Demonstra os 4 verbos do CRUD (Create, Read, Update, Delete).

## Arquivos

```
12-app-crud/
├── schema.sql        # cria banco, tabela, usuário e dados de exemplo
├── tarefas.conf      # virtual host do Apache
└── app/
    ├── config.php    # conexão PDO (credenciais)
    └── index.php     # o CRUD completo
```

## Passo a passo

**1. Pré-requisito:** ter feito o projeto 11 (LAMP instalado).

**2. Criar o banco:**

```bash
sudo mariadb < schema.sql
```

> Antes, abra `schema.sql` e troque `senha_app` por uma senha forte. Use a mesma em `app/config.php`.

**3. Copiar o app para o servidor:**

```bash
sudo mkdir -p /var/www/tarefas
sudo cp app/* /var/www/tarefas/
sudo chown -R www-data:www-data /var/www/tarefas
```

**4. Ativar o virtual host:**

```bash
sudo cp tarefas.conf /etc/apache2/sites-available/
sudo a2ensite tarefas.conf
sudo systemctl reload apache2
```

**5. Apontar o domínio local** (adicione ao `/etc/hosts`):

```bash
echo "127.0.0.1   tarefas.local" | sudo tee -a /etc/hosts
```

**6. Acessar:** <http://tarefas.local>

## Conceitos praticados

- **Virtual hosts** no Apache (`a2ensite`, `sites-available`).
- **CRUD** com PDO + prepared statements.
- **Segurança**: prepared statements (anti SQL injection), `htmlspecialchars` (anti XSS), usuário de banco com permissões mínimas (não usa root).
- Padrão **PRG** (Post-Redirect-Get) para evitar reenvio de formulário.

## Por que um usuário de banco dedicado?

O app usa `app_tarefas`, que só pode SELECT/INSERT/UPDATE/DELETE na base `tarefas_db`. Se o app for comprometido, o estrago fica limitado — diferente de usar o `root` do MySQL.

## Limpar depois

```bash
sudo a2dissite tarefas.conf && sudo systemctl reload apache2
sudo rm -rf /var/www/tarefas
sudo mariadb -e "DROP DATABASE tarefas_db; DROP USER 'app_tarefas'@'localhost';"
```