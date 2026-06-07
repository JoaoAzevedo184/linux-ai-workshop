-- schema.sql - Cria o banco e a tabela da lista de tarefas.
--
-- Rodar com:
--   sudo mariadb < schema.sql
-- ou:
--   sudo mysql < schema.sql

-- Cria o banco se ainda não existir
CREATE DATABASE IF NOT EXISTS tarefas_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE tarefas_db;

-- Tabela de tarefas
CREATE TABLE IF NOT EXISTS tarefas (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  titulo      VARCHAR(200) NOT NULL,
  concluida   BOOLEAN NOT NULL DEFAULT FALSE,
  criada_em   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Usuário dedicado para a aplicação (não usar o root no app!)
-- Troque 'senha_app' por uma senha forte.
CREATE USER IF NOT EXISTS 'app_tarefas'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT, INSERT, UPDATE, DELETE ON tarefas_db.* TO 'app_tarefas'@'localhost';
FLUSH PRIVILEGES;

-- Alguns dados de exemplo
INSERT INTO tarefas (titulo, concluida) VALUES
  ('Estudar comandos Linux', FALSE),
  ('Configurar a stack LAMP', TRUE),
  ('Construir o CRUD de tarefas', FALSE);