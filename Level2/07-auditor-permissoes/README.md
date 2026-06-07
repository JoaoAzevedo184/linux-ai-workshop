# 07 — Auditor de permissões

Varre um diretório e reporta permissões inseguras. Só lê e reporta — **não altera nada**.

## Como rodar

```bash
chmod +x auditor.sh
./auditor.sh /caminho/para/auditar     # padrão: diretório atual
sudo ./auditor.sh /etc                 # com sudo enxerga mais arquivos
```

## O que ele detecta

1. **World-writable** — arquivos/pastas que qualquer usuário pode escrever (ex: `777`, `666`). Risco clássico de segurança.
2. **SUID/SGID** — executáveis que rodam com o privilégio do dono/grupo. Úteis, mas vetor comum de escalonamento de privilégio.
3. **Órfãos** — arquivos sem usuário ou grupo válido (sobra de contas removidas).

## Conceitos praticados

- `find -perm` com máscaras octais (`-0002`, `-4000`, `-2000`).
- `find -nouser` / `-nogroup`.
- `stat -c '%a'` (octal) e `'%A'` (simbólico).
- Ignorar erros de permissão com `2>/dev/null`.

## Testar

```bash
mkdir -p /tmp/audit && cd /tmp/audit
touch normal.txt inseguro.sh
chmod 777 inseguro.sh
~/Level2/07-auditor-permissoes/auditor.sh /tmp/audit
# inseguro.sh deve aparecer na seção [1]
```

## Próximo passo (ideia)

Adicionar uma flag `--fix` que sugere (ou aplica) `chmod 644`/`755` nos arquivos world-writable. Cuidado: corrigir permissões em massa pode quebrar serviços, então faça sempre em modo "dry-run" primeiro.