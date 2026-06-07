<?php
// index.php - CRUD de tarefas (Create, Read, Update, Delete).
// Demonstra os 4 verbos do CRUD usando PDO com prepared statements.

require __DIR__ . '/config.php';

$pdo = conectar();
$erro = '';

// --- Tratamento das ações (POST) ---
// Usamos prepared statements (?) em TODAS as queries com entrada do usuário,
// para evitar SQL injection.
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $acao = $_POST['acao'] ?? '';

    try {
        if ($acao === 'criar') {
            // CREATE
            $titulo = trim($_POST['titulo'] ?? '');
            if ($titulo !== '') {
                $stmt = $pdo->prepare('INSERT INTO tarefas (titulo) VALUES (?)');
                $stmt->execute([$titulo]);
            }
        } elseif ($acao === 'alternar') {
            // UPDATE (marca/desmarca como concluída)
            $id = (int)($_POST['id'] ?? 0);
            $stmt = $pdo->prepare('UPDATE tarefas SET concluida = NOT concluida WHERE id = ?');
            $stmt->execute([$id]);
        } elseif ($acao === 'excluir') {
            // DELETE
            $id = (int)($_POST['id'] ?? 0);
            $stmt = $pdo->prepare('DELETE FROM tarefas WHERE id = ?');
            $stmt->execute([$id]);
        }
    } catch (PDOException $e) {
        $erro = 'Erro no banco: ' . $e->getMessage();
    }

    // Redireciona após POST (padrão PRG: evita reenvio ao dar F5)
    if ($erro === '') {
        header('Location: index.php');
        exit;
    }
}

// --- READ: busca todas as tarefas ---
$tarefas = $pdo->query('SELECT * FROM tarefas ORDER BY concluida, criada_em DESC')->fetchAll();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lista de Tarefas</title>
  <style>
    body { font-family: system-ui, sans-serif; max-width: 600px; margin: 3rem auto; padding: 0 1rem; background:#f4f4f5; color:#18181b; }
    h1 { font-size: 1.6rem; }
    form.nova { display: flex; gap: .5rem; margin-bottom: 1.5rem; }
    input[type=text] { flex: 1; padding: .6rem; border: 1px solid #d4d4d8; border-radius: 6px; font-size: 1rem; }
    button { padding: .6rem .9rem; border: none; border-radius: 6px; cursor: pointer; font-size: .95rem; }
    .add { background:#2563eb; color:#fff; }
    .erro { background:#fee2e2; color:#991b1b; padding:.6rem; border-radius:6px; margin-bottom:1rem; }
    ul { list-style: none; padding: 0; }
    li { display: flex; align-items: center; gap: .6rem; background:#fff; padding:.7rem .9rem; border-radius:8px; margin-bottom:.5rem; box-shadow:0 1px 2px rgba(0,0,0,.06); }
    li.feita span { text-decoration: line-through; color:#a1a1aa; }
    li span { flex: 1; }
    .toggle { background:#e4e4e7; }
    .del { background:#ef4444; color:#fff; }
    .vazio { color:#71717a; text-align:center; padding:2rem; }
  </style>
</head>
<body>
  <h1>📋 Lista de Tarefas</h1>

  <?php if ($erro): ?>
    <div class="erro"><?= htmlspecialchars($erro) ?></div>
  <?php endif; ?>

  <!-- Formulário para criar tarefa -->
  <form class="nova" method="post">
    <input type="hidden" name="acao" value="criar">
    <input type="text" name="titulo" placeholder="Nova tarefa..." required autofocus>
    <button class="add" type="submit">Adicionar</button>
  </form>

  <!-- Lista de tarefas -->
  <?php if (count($tarefas) === 0): ?>
    <p class="vazio">Nenhuma tarefa ainda. Adicione a primeira!</p>
  <?php else: ?>
    <ul>
      <?php foreach ($tarefas as $t): ?>
        <li class="<?= $t['concluida'] ? 'feita' : '' ?>">
          <!-- Marcar/desmarcar -->
          <form method="post" style="margin:0">
            <input type="hidden" name="acao" value="alternar">
            <input type="hidden" name="id" value="<?= (int)$t['id'] ?>">
            <button class="toggle" type="submit"><?= $t['concluida'] ? '↺' : '✓' ?></button>
          </form>
          <!-- htmlspecialchars evita XSS ao exibir texto do usuário -->
          <span><?= htmlspecialchars($t['titulo']) ?></span>
          <!-- Excluir -->
          <form method="post" style="margin:0" onsubmit="return confirm('Excluir esta tarefa?')">
            <input type="hidden" name="acao" value="excluir">
            <input type="hidden" name="id" value="<?= (int)$t['id'] ?>">
            <button class="del" type="submit">🗑</button>
          </form>
        </li>
      <?php endforeach; ?>
    </ul>
  <?php endif; ?>
</body>
</html>