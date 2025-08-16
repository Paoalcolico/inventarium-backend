-- Dados iniciais para o sistema

-- Papéis do sistema
INSERT IGNORE INTO papel (id, nome, descricao, nivel) VALUES
(1, 'ADMIN', 'Administrador do sistema com acesso total', 1),
(2, 'GERENTE', 'Gerente com acesso a relatórios e configurações', 2),
(3, 'OPERADOR', 'Operador de estoque com acesso a transações', 3),
(4, 'VISUALIZADOR', 'Usuário com acesso apenas para visualização', 4);

-- Usuários iniciais (senha: admin123)
INSERT IGNORE INTO usuario (id, nome, username, senha_hash, papel_id) VALUES
(1, 'Administrador', 'admin', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 1),
(2, 'João Silva', 'joao.silva', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 2),
(3, 'Maria Santos', 'maria.santos', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 3),
(4, 'Pedro Oliveira', 'pedro.oliveira', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 3),
(5, 'Ana Costa', 'ana.costa', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 4);

-- Marcas
INSERT IGNORE INTO marca (id, nome) VALUES
(1, 'Samsung'), (2, 'Apple'), (3, 'LG'), (4, 'Sony'),
(5, 'Dell'), (6, 'HP'), (7, 'Lenovo'), (8, 'Asus'),
(9, 'Xiaomi'), (10, 'Motorola');

-- Produtos de exemplo
INSERT IGNORE INTO produto (id, nome, marca_id, codigo_fabricante, valor_unitario, quantidade, garantia, localizacao, descricao) VALUES
(1, 'Galaxy S24 Ultra', 1, 'SM-S928B', 4999.99, 25, '24 meses', 'Estoque A-01', 'Smartphone Samsung Galaxy S24 Ultra 512GB'),
(2, 'iPhone 15 Pro Max', 2, 'A3108', 7999.99, 15, '12 meses', 'Estoque A-02', 'iPhone 15 Pro Max 256GB Titânio Natural'),
(3, 'Smart TV 65" OLED', 3, '65C3PSA', 3499.99, 8, '24 meses', 'Estoque B-01', 'LG OLED65C3PSA Smart TV 65 4K'),
(4, 'PlayStation 5', 4, 'CFI-1216A', 2999.99, 12, '12 meses', 'Estoque C-01', 'Console PlayStation 5 825GB'),
(5, 'Notebook Inspiron 15', 5, 'I15-3511-A30P', 2199.99, 20, '12 meses', 'Estoque D-01', 'Dell Inspiron 15 3000 i5 8GB 256GB SSD'),
(6, 'Monitor Gamer 27"', 6, '27XQ25F', 899.99, 30, '36 meses', 'Estoque D-02', 'HP Pavilion Gaming 27 QHD 165Hz'),
(7, 'ThinkPad E14', 7, '21E3S03Q00', 3299.99, 10, '24 meses', 'Estoque D-03', 'Lenovo ThinkPad E14 i7 16GB 512GB'),
(8, 'ROG Strix G15', 8, 'G513QM-HN185', 4599.99, 6, '24 meses', 'Estoque D-04', 'Asus ROG Strix G15 Ryzen 7 RTX 3060'),
(9, 'Redmi Note 13', 9, 'RN13-256', 449.99, 50, '12 meses', 'Estoque A-03', 'Xiaomi Redmi Note 13 256GB'),
(10, 'Edge 40 Neo', 10, 'XT2315-1', 699.99, 35, '12 meses', 'Estoque A-04', 'Motorola Edge 40 Neo 256GB');

-- Transações de exemplo
INSERT IGNORE INTO transacao (id, tipo, valor_total, data_transacao, usuario_id, observacoes) VALUES
(1, 'ENTRADA', 124999.75, '2024-01-15 10:30:00', 2, 'Compra inicial de smartphones'),
(2, 'ENTRADA', 27999.92, '2024-01-16 14:20:00', 2, 'Reposição de TVs'),
(3, 'SAIDA', 14999.97, '2024-01-17 09:15:00', 3, 'Venda para cliente corporativo'),
(4, 'ENTRADA', 43999.92, '2024-01-18 11:45:00', 2, 'Compra de notebooks');

-- Itens das transações
INSERT IGNORE INTO transacao_item (id, transacao_id, produto_id, quantidade, valor_unitario) VALUES
(1, 1, 1, 25, 4999.99),
(2, 2, 3, 8, 3499.99),
(3, 3, 1, 3, 4999.99),
(4, 4, 5, 20, 2199.99);

-- Logs de auditoria
INSERT IGNORE INTO log_usuario (id, usuario_id, username, acao, tabela_afetada, registro_afetado, data_hora) VALUES
(1, 2, 'joao.silva', 'INSERT', 'transacao', 1, '2024-01-15 10:30:00'),
(2, 2, 'joao.silva', 'INSERT', 'transacao', 2, '2024-01-16 14:20:00'),
(3, 3, 'maria.santos', 'INSERT', 'transacao', 3, '2024-01-17 09:15:00'),
(4, 2, 'joao.silva', 'INSERT', 'transacao', 4, '2024-01-18 11:45:00'),
(5, 3, 'maria.santos', 'UPDATE', 'produto', 1, '2024-01-17 09:16:00'),
(6, 1, 'admin', 'CREATE', 'usuario', 2, '2024-01-10 08:00:00'),
(7, 1, 'admin', 'CREATE', 'usuario', 3, '2024-01-10 08:05:00');
