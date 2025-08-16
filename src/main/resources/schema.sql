-- Schema do banco de dados Inventarium
-- Criação das tabelas conforme especificação

-- Tabela de papéis/roles
CREATE TABLE IF NOT EXISTS papel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(255),
    nivel INT NOT NULL
);

-- Tabela de usuários (com hierarquia)
CREATE TABLE IF NOT EXISTS usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    parent_id INT,
    nome VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    papel_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES usuario(id) ON DELETE SET NULL,
    FOREIGN KEY (papel_id) REFERENCES papel(id) ON DELETE RESTRICT
);

-- Tabela de marcas
CREATE TABLE IF NOT EXISTS marca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de produtos
CREATE TABLE IF NOT EXISTS produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    marca_id INT NOT NULL,
    codigo_fabricante VARCHAR(100) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    quantidade INT NOT NULL DEFAULT 0,
    garantia VARCHAR(50),
    localizacao VARCHAR(100),
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (marca_id) REFERENCES marca(id) ON DELETE RESTRICT,
    INDEX idx_codigo_fabricante (codigo_fabricante),
    INDEX idx_marca_id (marca_id)
);

-- Tabela de transações (cabeçalho)
CREATE TABLE IF NOT EXISTS transacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('ENTRADA', 'SAIDA')),
    valor_total DECIMAL(12,2) NOT NULL,
    data_transacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    usuario_id INT NOT NULL,
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE RESTRICT,
    INDEX idx_data_transacao (data_transacao),
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_tipo (tipo)
);

-- Tabela de itens da transação (detalhes)
CREATE TABLE IF NOT EXISTS transacao_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transacao_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(12,2) GENERATED ALWAYS AS (quantidade * valor_unitario) STORED,
    FOREIGN KEY (transacao_id) REFERENCES transacao(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE RESTRICT,
    INDEX idx_transacao_id (transacao_id),
    INDEX idx_produto_id (produto_id)
);

-- Tabela de log de auditoria
CREATE TABLE IF NOT EXISTS log_usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    username VARCHAR(50) NOT NULL,
    acao VARCHAR(20) NOT NULL,
    tabela_afetada VARCHAR(50) NOT NULL,
    registro_afetado INT,
    dados_anteriores JSON,
    dados_novos JSON,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE RESTRICT,
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_data_hora (data_hora),
    INDEX idx_tabela_afetada (tabela_afetada)
);

-- Inserção de dados iniciais
INSERT IGNORE INTO papel (nome, descricao, nivel) VALUES
('ADMIN', 'Administrador do sistema com acesso total', 1),
('GERENTE', 'Gerente com acesso a relatórios e aprovações', 2),
('OPERADOR', 'Operador com acesso básico ao sistema', 3),
('VISUALIZADOR', 'Apenas visualização de dados', 4);

INSERT IGNORE INTO marca (nome) VALUES
('Samsung'),
('Apple'),
('Xiaomi'),
('LG'),
('Sony'),
('Dell'),
('HP'),
('Lenovo');

-- Usuário administrador padrão (senha: admin123)
INSERT IGNORE INTO usuario (nome, username, senha_hash, papel_id) VALUES
('Administrador', 'admin', '$2a$10$N9qo8uLOickgx2ZMRZoMye', 1);
