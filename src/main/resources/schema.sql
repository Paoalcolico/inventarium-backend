-- Dropa as tabelas na ordem correta para evitar erros de chave estrangeira
DROP TABLE IF EXISTS historico_preco;
DROP TABLE IF EXISTS log_usuario;
DROP TABLE IF EXISTS transacao_item;
DROP TABLE IF EXISTS transacao;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS marca;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS papel;

-- =======================================
-- TABELA PAPEL (perfis de usuário)
-- =======================================
CREATE TABLE papel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(255),
    nivel INT NOT NULL UNIQUE,
    status ENUM('ativo', 'inativo') DEFAULT 'ativo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    edited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT chk_nivel_positivo CHECK (nivel > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =======================================
-- TABELA USUARIO
-- =======================================
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    parent_id INT NULL,
    nome VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    senha_hash CHAR(60) NOT NULL,
    papel_id INT NOT NULL,
    status ENUM('ativo', 'inativo', 'bloqueado') DEFAULT 'ativo',
    ultimo_login TIMESTAMP NULL,
    tentativas_login INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    edited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_usuario_papel FOREIGN KEY (papel_id) REFERENCES papel(id),
    CONSTRAINT fk_usuario_parent FOREIGN KEY (parent_id) REFERENCES usuario(id),
    CONSTRAINT chk_tentativas_positivas CHECK (tentativas_login >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =======================================
-- TABELA CATEGORIA
-- =======================================
CREATE TABLE categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255),
    status ENUM('ativa', 'inativa') DEFAULT 'ativa',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    edited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =======================================
-- TABELA MARCA
-- =======================================
CREATE TABLE marca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255),
    status ENUM('ativa', 'inativa') DEFAULT 'ativa',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    edited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =======================================
-- TABELA PRODUTO
-- =======================================
CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    marca_id INT NOT NULL,
    categoria_id INT NULL,
    codigo_fabricante VARCHAR(100) UNIQUE,
    codigo_barras VARCHAR(50) UNIQUE,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_custo DECIMAL(10,2),
    quantidade INT NOT NULL DEFAULT 0,
    estoque_minimo INT DEFAULT 0,
    estoque_maximo INT DEFAULT NULL,
    garantia VARCHAR(50),
    localizacao VARCHAR(100),
    descricao TEXT,
    status ENUM('ativo', 'inativo', 'descontinuado') DEFAULT 'ativo',
    deleted_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    edited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_produto_marca FOREIGN KEY (marca_id) REFERENCES marca(id),
    CONSTRAINT fk_produto_categoria FOREIGN KEY (categoria_id) REFERENCES categoria(id),
    CONSTRAINT chk_valor_unitario_positivo CHECK (valor_unitario > 0),
    CONSTRAINT chk_valor_custo_positivo CHECK (valor_custo IS NULL OR valor_custo >= 0),
    CONSTRAINT chk_quantidade_positiva CHECK (quantidade >= 0),
    CONSTRAINT chk_estoque_minimo_positivo CHECK (estoque_minimo >= 0),
    CONSTRAINT chk_estoque_maximo_valido CHECK (estoque_maximo IS NULL OR estoque_maximo >= estoque_minimo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =======================================
-- TABELA TRANSACAO
-- =======================================
CREATE TABLE transacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('entrada', 'saida') NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,
    observacoes TEXT,
    data_transacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuario_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_transacao_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    CONSTRAINT chk_valor_total_positivo CHECK (valor_total > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =======================================
-- TABELA TRANSACAO_ITEM
-- =======================================
CREATE TABLE transacao_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transacao_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(10,2) GENERATED ALWAYS AS (quantidade * valor_unitario) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_item_transacao FOREIGN KEY (transacao_id) REFERENCES transacao(id) ON DELETE CASCADE,
    CONSTRAINT fk_item_produto FOREIGN KEY (produto_id) REFERENCES produto(id),
    CONSTRAINT chk_quantidade_item_positiva CHECK (quantidade > 0),
    CONSTRAINT chk_valor_unitario_item_positivo CHECK (valor_unitario > 0),
    
    UNIQUE KEY uk_transacao_produto (transacao_id, produto_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =======================================
-- TABELA LOG_USUARIO
-- =======================================
CREATE TABLE log_usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    acao VARCHAR(50) NOT NULL,
    tabela_afetada VARCHAR(50),
    registro_afetado INT,
    valores_anteriores JSON,
    valores_novos JSON,
    ip VARCHAR(45),
    user_agent VARCHAR(255),
    status ENUM('sucesso', 'erro', 'tentativa') DEFAULT 'sucesso',
    detalhes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_log_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =======================================
-- TABELA HISTORICO_PRECO
-- =======================================
CREATE TABLE historico_preco (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT NOT NULL,
    valor_anterior DECIMAL(10,2) NOT NULL,
    valor_novo DECIMAL(10,2) NOT NULL,
    usuario_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_historico_produto FOREIGN KEY (produto_id) REFERENCES produto(id),
    CONSTRAINT fk_historico_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =======================================
-- ÍNDICES PARA PERFORMANCE
-- =======================================

-- Índices para produto
CREATE INDEX idx_produto_nome ON produto(nome);
CREATE INDEX idx_produto_codigo ON produto(codigo_fabricante);
CREATE INDEX idx_produto_barras ON produto(codigo_barras);
CREATE INDEX idx_produto_status_categoria ON produto(status, categoria_id);
CREATE INDEX idx_produto_marca_status ON produto(marca_id, status);
CREATE INDEX idx_produto_estoque_baixo ON produto(quantidade, estoque_minimo);

-- Índices para transação
CREATE INDEX idx_transacao_data ON transacao(data_transacao);
CREATE INDEX idx_transacao_usuario_data ON transacao(usuario_id, data_transacao);
CREATE INDEX idx_transacao_tipo_data ON transacao(tipo, data_transacao);

-- Índices para transacao_item
CREATE INDEX idx_item_transacao_produto ON transacao_item(transacao_id, produto_id);
CREATE INDEX idx_item_produto_data ON transacao_item(produto_id, created_at);

-- Índices para log
CREATE INDEX idx_log_usuario_data ON log_usuario(created_at);
CREATE INDEX idx_log_usuario_acao ON log_usuario(usuario_id, acao);
CREATE INDEX idx_log_tabela_registro ON log_usuario(tabela_afetada, registro_afetado);

-- Índices para usuario
CREATE INDEX idx_usuario_status ON usuario(status);
CREATE INDEX idx_usuario_ultimo_login ON usuario(ultimo_login);
