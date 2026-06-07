<?php
// config.php - Dados de conexão com o banco.
// Mantenha as credenciais aqui, separadas da lógica.
// Em produção, use variáveis de ambiente em vez de deixar a senha no código.

define('DB_HOST', 'localhost');
define('DB_NAME', 'tarefas_db');
define('DB_USER', 'app_tarefas');
define('DB_PASS', '1234');   // troque pela senha definida no schema.sql

// Cria a conexão PDO (forma moderna e segura de acessar o banco em PHP).
function conectar(): PDO {
    $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
    $opcoes = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,   // lança exceção em erro
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,         // retorna arrays associativos
        PDO::ATTR_EMULATE_PREPARES   => false,                   // usa prepared statements reais
    ];
    return new PDO($dsn, DB_USER, DB_PASS, $opcoes);
}