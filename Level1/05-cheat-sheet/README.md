# 05 — Cheat sheet pessoal

Página HTML com seus comandos Linux favoritos, organizada por categorias, servida localmente com o servidor HTTP embutido do Python. Estética de terminal (verde sobre fundo escuro).

## Como servir localmente

```bash
cd 05-cheat-sheet
python3 -m http.server 8000
```

Depois abra no navegador: <http://localhost:8000>

(O `index.html` é carregado automaticamente.)

Para parar o servidor: `Ctrl + C`.

## O que tem na página

8 cartões com comandos por tema: Navegação, Arquivos, Permissões, Processos, Sistema, Pacotes (apt), Rede e Git.

## Conceitos praticados

- `python3 -m http.server` para subir um servidor estático sem instalar nada.
- HTML + CSS (variáveis CSS, grid responsivo, animações simples).
- Estrutura de um `index.html`.

## Personalizar

Edite o `index.html` e adicione/remova comandos nos blocos `<li>`. Cada item segue o padrão:

```html
<li><code>comando</code><span class="desc">o que faz</span></li>
```

Para criar um novo cartão de categoria, copie um bloco `<div class="card">...</div>` inteiro.