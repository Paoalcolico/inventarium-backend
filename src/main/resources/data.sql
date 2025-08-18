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
-- Seeder de produtos fictícios para o novo modelo
INSERT IGNORE INTO produto (id, nome, marca_id, categoria_id, codigo_fabricante, codigo_barras, valor_unitario, valor_custo, quantidade, estoque_minimo, estoque_maximo, garantia, localizacao, descricao, status)
VALUES
(1, 'Smartphone Orion X', 1, NULL, 'ORX-1001', '7891000000011', 1899.90, 1299.90, 12, 2, 30, '12 meses', 'Estoque A-01', 'Celular topo de linha com IA embarcada', 'ativo'),
(2, 'Notebook Nebula Pro', 5, NULL, 'NBP-2002', '7891000000012', 3499.00, 2499.00, 8, 1, 20, '24 meses', 'Estoque D-01', 'Notebook ultrafino com tela OLED', 'ativo'),
(3, 'Fone de Ouvido SonicWave', 2, NULL, 'SW-3003', '7891000000013', 299.90, 199.90, 0, 1, 10, '6 meses', 'Estoque B-02', 'Fone bluetooth com cancelamento de ruído', 'ativo'),
(4, 'Smart TV Cosmos 55"', 3, NULL, 'COS-5504', '7891000000014', 2599.00, 1999.00, 3, 1, 10, '18 meses', 'Estoque B-01', 'Smart TV 4K com HDR10+', 'ativo'),
(5, 'Tablet Luna Tab 10', 1, NULL, 'LT10-5005', '7891000000015', 1299.00, 899.00, 5, 1, 15, '12 meses', 'Estoque A-02', 'Tablet 10" com stylus', 'ativo'),
(6, 'Console GameBox Z', 4, NULL, 'GBZ-6006', '7891000000016', 2299.00, 1799.00, 2, 1, 10, '12 meses', 'Estoque C-01', 'Console de última geração', 'ativo'),
(7, 'Monitor Vision 27"', 6, NULL, 'VSN-2707', '7891000000017', 899.00, 699.00, 10, 2, 20, '24 meses', 'Estoque D-02', 'Monitor gamer 165Hz', 'ativo'),
(8, 'Câmera ActionCam 4K', 2, NULL, 'AC4K-8008', '7891000000018', 799.00, 599.00, 1, 1, 10, '12 meses', 'Estoque B-03', 'Câmera esportiva à prova d’água', 'ativo'),
(9, 'Caixa de Som Thunder', 9, NULL, 'THD-9009', '7891000000019', 399.00, 249.00, 0, 1, 10, '12 meses', 'Estoque B-04', 'Caixa de som bluetooth potente', 'ativo'),
(10, 'Smartwatch Pulse', 10, NULL, 'PLS-1010', '7891000000020', 499.00, 299.00, 7, 1, 15, '12 meses', 'Estoque A-03', 'Relógio inteligente com GPS', 'ativo'),
(11, 'Headset Vulcan', 7, NULL, 'VLC-1111', '7891000000021', 349.00, 199.00, 2, 1, 10, '12 meses', 'Estoque D-03', 'Headset gamer com microfone', 'ativo'),
(12, 'Roteador HyperNet', 8, NULL, 'HNT-1212', '7891000000022', 259.00, 159.00, 4, 1, 10, '12 meses', 'Estoque D-04', 'Roteador Wi-Fi 6', 'ativo'),
(13, 'Impressora PrintEasy', 6, NULL, 'PE-1313', '7891000000023', 599.00, 399.00, 1, 1, 10, '12 meses', 'Estoque D-05', 'Impressora multifuncional', 'ativo'),
(14, 'Teclado Lumina', 5, NULL, 'LUM-1414', '7891000000024', 199.00, 99.00, 0, 1, 10, '12 meses', 'Estoque D-06', 'Teclado mecânico RGB', 'ativo'),
(15, 'Mouse Speedster', 5, NULL, 'SPD-1515', '7891000000025', 129.00, 69.00, 3, 1, 10, '12 meses', 'Estoque D-07', 'Mouse gamer 12000dpi', 'ativo'),
(16, 'Projetor Aurora', 3, NULL, 'AUR-1616', '7891000000026', 1599.00, 1099.00, 2, 1, 10, '12 meses', 'Estoque B-05', 'Projetor portátil Full HD', 'ativo'),
(17, 'HD Externo Titan 2TB', 1, NULL, 'TIT-1717', '7891000000027', 499.00, 299.00, 0, 1, 10, '12 meses', 'Estoque A-05', 'HD externo USB 3.1', 'ativo'),
(18, 'SSD Flash 1TB', 5, NULL, 'FLS-1818', '7891000000028', 699.00, 399.00, 6, 1, 10, '12 meses', 'Estoque D-08', 'SSD NVMe 1TB', 'ativo'),
(19, 'Pen Drive Nano 64GB', 9, NULL, 'NANO-1919', '7891000000029', 59.00, 29.00, 10, 1, 20, '12 meses', 'Estoque A-06', 'Pen drive USB 3.0', 'ativo'),
(20, 'Carregador TurboCharge', 1, NULL, 'TBC-2020', '7891000000030', 89.00, 39.00, 8, 1, 20, '12 meses', 'Estoque A-07', 'Carregador rápido 30W', 'ativo'),
(21, 'Webcam Crystal', 2, NULL, 'CRY-2121', '7891000000031', 199.00, 99.00, 0, 1, 10, '12 meses', 'Estoque B-06', 'Webcam Full HD', 'ativo'),
(22, 'Microfone StudioMic', 4, NULL, 'STM-2222', '7891000000032', 299.00, 149.00, 2, 1, 10, '12 meses', 'Estoque C-02', 'Microfone condensador', 'ativo'),
(23, 'Cabo USB-C Flex', 8, NULL, 'FLEX-2323', '7891000000033', 29.00, 9.00, 15, 1, 50, '12 meses', 'Estoque D-09', 'Cabo USB-C reforçado', 'ativo'),
(24, 'Hub USB 4 portas', 6, NULL, 'HUB-2424', '7891000000034', 69.00, 29.00, 5, 1, 20, '12 meses', 'Estoque D-10', 'Hub USB 3.0', 'ativo'),
(25, 'Leitor Cartão SD', 7, NULL, 'SD-2525', '7891000000035', 49.00, 19.00, 3, 1, 10, '12 meses', 'Estoque D-11', 'Leitor de cartão SD', 'ativo'),
(26, 'Estabilizador PowerSafe', 10, NULL, 'PWS-2626', '7891000000036', 199.00, 99.00, 2, 1, 10, '12 meses', 'Estoque A-08', 'Estabilizador 600VA', 'ativo'),
(27, 'Nobreak Energy', 9, NULL, 'ENB-2727', '7891000000037', 499.00, 299.00, 1, 1, 10, '12 meses', 'Estoque A-09', 'Nobreak 1200VA', 'ativo'),
(28, 'Switch NetLink 8p', 8, NULL, 'NL8-2828', '7891000000038', 159.00, 99.00, 0, 1, 10, '12 meses', 'Estoque D-12', 'Switch 8 portas gigabit', 'ativo'),
(29, 'Placa de Vídeo Vega', 5, NULL, 'VEGA-2929', '7891000000039', 1999.00, 1499.00, 2, 1, 10, '12 meses', 'Estoque D-13', 'Placa de vídeo 8GB', 'ativo'),
(30, 'Memória RAM 16GB', 6, NULL, 'RAM-3030', '7891000000040', 399.00, 199.00, 4, 1, 20, '12 meses', 'Estoque D-14', 'Memória DDR4 16GB', 'ativo'),
-- ... (continue até pelo menos 110 produtos, variando nomes, marcas, valores, quantidades, localizações e descrições fictícias)
-- Continuação da seeder de produtos fictícios
(31, 'Câmera Zoomster Pro', 2, NULL, 'ZMP-3131', '7891000000041', 1299.00, 899.00, 2, 1, 10, '12 meses', 'Estoque B-07', 'Câmera digital com zoom óptico 40x', 'ativo'),
(32, 'Smart Speaker EchoBox', 9, NULL, 'ECB-3232', '7891000000042', 399.00, 249.00, 5, 1, 10, '12 meses', 'Estoque A-10', 'Caixa de som inteligente com assistente virtual', 'ativo'),
(33, 'Drone SkyFlyer', 4, NULL, 'SKF-3333', '7891000000043', 1599.00, 1099.00, 1, 1, 10, '12 meses', 'Estoque C-03', 'Drone com câmera 4K e GPS', 'ativo'),
(34, 'Smartband FitLife', 10, NULL, 'FLF-3434', '7891000000044', 199.00, 99.00, 8, 1, 20, '12 meses', 'Estoque A-11', 'Pulseira fitness com monitor cardíaco', 'ativo'),
(35, 'Notebook PixelBook', 5, NULL, 'PXB-3535', '7891000000045', 2999.00, 1999.00, 3, 1, 10, '24 meses', 'Estoque D-15', 'Notebook com tela sensível ao toque', 'ativo'),
(36, 'Tablet KidsFun', 1, NULL, 'KDF-3636', '7891000000046', 699.00, 399.00, 6, 1, 15, '12 meses', 'Estoque A-12', 'Tablet infantil resistente a quedas', 'ativo'),
(37, 'Console RetroPlay', 4, NULL, 'RTP-3737', '7891000000047', 499.00, 299.00, 2, 1, 10, '12 meses', 'Estoque C-04', 'Console retrô com 200 jogos clássicos', 'ativo'),
(38, 'Monitor UltraWide 34"', 6, NULL, 'UW34-3838', '7891000000048', 1999.00, 1499.00, 1, 1, 10, '24 meses', 'Estoque D-16', 'Monitor 34 polegadas ultrawide', 'ativo'),
(39, 'Fone Bluetooth AirBeats', 2, NULL, 'ABT-3939', '7891000000049', 349.00, 199.00, 0, 1, 10, '6 meses', 'Estoque B-08', 'Fone bluetooth com estojo carregador', 'ativo'),
(40, 'Smart TV Nova 50"', 3, NULL, 'NOVA-4040', '7891000000050', 2199.00, 1699.00, 4, 1, 10, '18 meses', 'Estoque B-09', 'Smart TV 4K com Dolby Vision', 'ativo'),
(41, 'Pen Drive Ultra 128GB', 9, NULL, 'ULTRA-4141', '7891000000051', 99.00, 49.00, 10, 1, 20, '12 meses', 'Estoque A-13', 'Pen drive USB 3.1', 'ativo'),
(42, 'Carregador SolarCharge', 1, NULL, 'SOL-4242', '7891000000052', 149.00, 79.00, 3, 1, 10, '12 meses', 'Estoque A-14', 'Carregador solar portátil', 'ativo'),
(43, 'Webcam NightVision', 2, NULL, 'NV-4343', '7891000000053', 249.00, 149.00, 2, 1, 10, '12 meses', 'Estoque B-10', 'Webcam com visão noturna', 'ativo'),
(44, 'Microfone PodcastMic', 4, NULL, 'PCM-4444', '7891000000054', 399.00, 199.00, 1, 1, 10, '12 meses', 'Estoque C-05', 'Microfone USB para podcast', 'ativo'),
(45, 'Cabo Lightning Fast', 8, NULL, 'LTF-4545', '7891000000055', 59.00, 19.00, 12, 1, 50, '12 meses', 'Estoque D-17', 'Cabo lightning reforçado', 'ativo'),
(46, 'Hub USB-C Pro', 6, NULL, 'HUBC-4646', '7891000000056', 129.00, 59.00, 7, 1, 20, '12 meses', 'Estoque D-18', 'Hub USB-C com HDMI', 'ativo'),
(47, 'Leitor Biométrico TouchID', 7, NULL, 'TID-4747', '7891000000057', 299.00, 149.00, 2, 1, 10, '12 meses', 'Estoque D-19', 'Leitor biométrico USB', 'ativo'),
(48, 'Estabilizador MaxSafe', 10, NULL, 'MXS-4848', '7891000000058', 249.00, 129.00, 1, 1, 10, '12 meses', 'Estoque A-15', 'Estabilizador 1000VA', 'ativo'),
(49, 'Nobreak PowerGuard', 9, NULL, 'PWG-4949', '7891000000059', 699.00, 399.00, 0, 1, 10, '12 meses', 'Estoque A-16', 'Nobreak bivolt', 'ativo'),
(50, 'Switch NetLink 16p', 8, NULL, 'NL16-5050', '7891000000060', 299.00, 199.00, 3, 1, 10, '12 meses', 'Estoque D-20', 'Switch 16 portas gigabit', 'ativo'),
(51, 'Placa de Vídeo NovaX', 5, NULL, 'NVX-5151', '7891000000061', 2499.00, 1999.00, 2, 1, 10, '12 meses', 'Estoque D-21', 'Placa de vídeo 12GB', 'ativo'),
(52, 'Memória RAM 32GB', 6, NULL, 'RAM-5252', '7891000000062', 699.00, 399.00, 4, 1, 20, '12 meses', 'Estoque D-22', 'Memória DDR4 32GB', 'ativo'),
(53, 'Smartphone Vega S', 1, NULL, 'VGS-5353', '7891000000063', 2099.00, 1599.00, 6, 2, 30, '12 meses', 'Estoque A-17', 'Smartphone intermediário com 5G', 'ativo'),
(54, 'Notebook CloudBook', 5, NULL, 'CLB-5454', '7891000000064', 2599.00, 1799.00, 7, 1, 20, '24 meses', 'Estoque D-23', 'Notebook leve para trabalho remoto', 'ativo'),
(55, 'Fone de Ouvido BassPro', 2, NULL, 'BSP-5555', '7891000000065', 199.00, 99.00, 0, 1, 10, '6 meses', 'Estoque B-11', 'Fone bluetooth com graves potentes', 'ativo'),
(56, 'Smart TV Vision 43"', 3, NULL, 'VS43-5656', '7891000000066', 1799.00, 1299.00, 2, 1, 10, '18 meses', 'Estoque B-12', 'Smart TV Full HD', 'ativo'),
(57, 'Tablet ProTab 8', 1, NULL, 'PT8-5757', '7891000000067', 899.00, 599.00, 5, 1, 15, '12 meses', 'Estoque A-18', 'Tablet 8" com 4G', 'ativo'),
(58, 'Console GameBox Mini', 4, NULL, 'GBM-5858', '7891000000068', 1299.00, 999.00, 2, 1, 10, '12 meses', 'Estoque C-06', 'Console portátil com 100 jogos', 'ativo'),
(59, 'Monitor Vision 24"', 6, NULL, 'VSN-5959', '7891000000069', 699.00, 499.00, 10, 2, 20, '24 meses', 'Estoque D-24', 'Monitor 24 polegadas IPS', 'ativo'),
(60, 'Câmera ActionCam Mini', 2, NULL, 'ACM-6060', '7891000000070', 499.00, 299.00, 1, 1, 10, '12 meses', 'Estoque B-13', 'Câmera esportiva compacta', 'ativo'),
(61, 'Caixa de Som BassBox', 9, NULL, 'BSB-6161', '7891000000071', 299.00, 149.00, 0, 1, 10, '12 meses', 'Estoque B-14', 'Caixa de som bluetooth portátil', 'ativo'),
(62, 'Smartwatch Runner', 10, NULL, 'RUN-6262', '7891000000072', 599.00, 399.00, 7, 1, 15, '12 meses', 'Estoque A-19', 'Relógio inteligente para corrida', 'ativo'),
(63, 'Headset Thunder', 7, NULL, 'THD-6363', '7891000000073', 399.00, 249.00, 2, 1, 10, '12 meses', 'Estoque D-25', 'Headset com som surround', 'ativo'),
(64, 'Roteador SpeedNet', 8, NULL, 'SPN-6464', '7891000000074', 199.00, 99.00, 4, 1, 10, '12 meses', 'Estoque D-26', 'Roteador Wi-Fi Mesh', 'ativo'),
(65, 'Impressora PrintMax', 6, NULL, 'PMX-6565', '7891000000075', 799.00, 599.00, 1, 1, 10, '12 meses', 'Estoque D-27', 'Impressora laser colorida', 'ativo'),
(66, 'Teclado Gamer RGB', 5, NULL, 'TGR-6666', '7891000000076', 299.00, 149.00, 0, 1, 10, '12 meses', 'Estoque D-28', 'Teclado mecânico com RGB', 'ativo'),
(67, 'Mouse Precision', 5, NULL, 'PRC-6767', '7891000000077', 149.00, 79.00, 3, 1, 10, '12 meses', 'Estoque D-29', 'Mouse óptico de alta precisão', 'ativo'),
(68, 'Projetor MiniBeam', 3, NULL, 'MBM-6868', '7891000000078', 999.00, 599.00, 2, 1, 10, '12 meses', 'Estoque B-15', 'Projetor portátil LED', 'ativo'),
(69, 'HD Externo Pocket 1TB', 1, NULL, 'PKT-6969', '7891000000079', 399.00, 249.00, 0, 1, 10, '12 meses', 'Estoque A-20', 'HD externo compacto', 'ativo'),
(70, 'SSD Flash 512GB', 5, NULL, 'FLS-7070', '7891000000080', 499.00, 299.00, 6, 1, 10, '12 meses', 'Estoque D-30', 'SSD NVMe 512GB', 'ativo'),
(71, 'Pen Drive Nano 32GB', 9, NULL, 'NANO-7171', '7891000000081', 39.00, 19.00, 10, 1, 20, '12 meses', 'Estoque A-21', 'Pen drive USB 2.0', 'ativo'),
(72, 'Carregador UltraCharge', 1, NULL, 'ULC-7272', '7891000000082', 119.00, 59.00, 8, 1, 20, '12 meses', 'Estoque A-22', 'Carregador rápido 65W', 'ativo'),
(73, 'Webcam ProVision', 2, NULL, 'PRV-7373', '7891000000083', 299.00, 149.00, 0, 1, 10, '12 meses', 'Estoque B-15', 'Webcam 2K com microfone', 'ativo'),
(74, 'Microfone VoiceCast', 4, NULL, 'VCT-7474', '7891000000084', 349.00, 199.00, 2, 1, 10, '12 meses', 'Estoque C-07', 'Microfone USB para streaming', 'ativo'),
(75, 'Cabo USB-C Turbo', 8, NULL, 'TUR-7575', '7891000000085', 39.00, 9.00, 15, 1, 50, '12 meses', 'Estoque D-31', 'Cabo USB-C de alta velocidade', 'ativo'),
(76, 'Hub USB 7 portas', 6, NULL, 'HUB-7676', '7891000000086', 99.00, 29.00, 5, 1, 20, '12 meses', 'Estoque D-32', 'Hub USB 2.0', 'ativo'),
(77, 'Leitor Cartão MicroSD', 7, NULL, 'MSD-7777', '7891000000087', 59.00, 19.00, 3, 1, 10, '12 meses', 'Estoque D-33', 'Leitor de cartão microSD', 'ativo'),
(78, 'Estabilizador SafePower', 10, NULL, 'SFP-7878', '7891000000088', 179.00, 99.00, 2, 1, 10, '12 meses', 'Estoque A-23', 'Estabilizador 800VA', 'ativo'),
(79, 'Nobreak UltraGuard', 9, NULL, 'UGD-7979', '7891000000089', 599.00, 399.00, 1, 1, 10, '12 meses', 'Estoque A-24', 'Nobreak com autonomia estendida', 'ativo'),
(80, 'Switch NetLink 24p', 8, NULL, 'NL24-8080', '7891000000090', 399.00, 299.00, 3, 1, 10, '12 meses', 'Estoque D-34', 'Switch 24 portas gigabit', 'ativo'),
(81, 'Placa de Vídeo TitanX', 5, NULL, 'TTX-8181', '7891000000091', 2999.00, 2499.00, 2, 1, 10, '12 meses', 'Estoque D-35', 'Placa de vídeo 16GB', 'ativo'),
(82, 'Memória RAM 8GB', 6, NULL, 'RAM-8282', '7891000000092', 199.00, 99.00, 4, 1, 20, '12 meses', 'Estoque D-36', 'Memória DDR4 8GB', 'ativo'),
(83, 'Smartphone Nova M', 1, NULL, 'NVM-8383', '7891000000093', 1599.00, 1099.00, 6, 2, 30, '12 meses', 'Estoque A-25', 'Smartphone básico com Android', 'ativo'),
(84, 'Notebook WorkBook', 5, NULL, 'WKB-8484', '7891000000094', 1999.00, 1499.00, 7, 1, 20, '24 meses', 'Estoque D-37', 'Notebook para escritório', 'ativo'),
(85, 'Fone de Ouvido Studio', 2, NULL, 'STD-8585', '7891000000095', 249.00, 99.00, 0, 1, 10, '6 meses', 'Estoque B-16', 'Fone de ouvido profissional', 'ativo'),
(86, 'Smart TV Max 65"', 3, NULL, 'MAX-8686', '7891000000096', 2999.00, 2499.00, 2, 1, 10, '18 meses', 'Estoque B-17', 'Smart TV 8K', 'ativo'),
(87, 'Tablet SchoolTab', 1, NULL, 'SCT-8787', '7891000000097', 599.00, 399.00, 5, 1, 15, '12 meses', 'Estoque A-26', 'Tablet para estudantes', 'ativo'),
(88, 'Console GameBox Classic', 4, NULL, 'GBC-8888', '7891000000098', 999.00, 799.00, 2, 1, 10, '12 meses', 'Estoque C-08', 'Console clássico com 50 jogos', 'ativo'),
(89, 'Monitor Vision 32"', 6, NULL, 'VSN-8989', '7891000000099', 1299.00, 999.00, 10, 2, 20, '24 meses', 'Estoque D-38', 'Monitor 32 polegadas QHD', 'ativo'),
(90, 'Câmera ActionCam Pro', 2, NULL, 'ACP-9090', '7891000000100', 899.00, 599.00, 1, 1, 10, '12 meses', 'Estoque B-18', 'Câmera esportiva profissional', 'ativo'),
(91, 'Caixa de Som PartyBox', 9, NULL, 'PTY-9191', '7891000000101', 499.00, 249.00, 0, 1, 10, '12 meses', 'Estoque B-19', 'Caixa de som para festas', 'ativo'),
(92, 'Smartwatch FitPro', 10, NULL, 'FTP-9292', '7891000000102', 399.00, 199.00, 7, 1, 15, '12 meses', 'Estoque A-27', 'Relógio inteligente esportivo', 'ativo'),
(93, 'Headset Studio', 7, NULL, 'STD-9393', '7891000000103', 299.00, 149.00, 2, 1, 10, '12 meses', 'Estoque D-39', 'Headset para estúdio', 'ativo'),
(94, 'Roteador MeshPro', 8, NULL, 'MSP-9494', '7891000000104', 299.00, 149.00, 4, 1, 10, '12 meses', 'Estoque D-40', 'Roteador mesh para grandes áreas', 'ativo'),
(95, 'Impressora PrintJet', 6, NULL, 'PJT-9595', '7891000000105', 999.00, 699.00, 1, 1, 10, '12 meses', 'Estoque D-41', 'Impressora jato de tinta', 'ativo'),
(96, 'Teclado Slim', 5, NULL, 'SLM-9696', '7891000000106', 149.00, 79.00, 0, 1, 10, '12 meses', 'Estoque D-42', 'Teclado slim silencioso', 'ativo'),
(97, 'Mouse Wireless', 5, NULL, 'WLS-9797', '7891000000107', 99.00, 49.00, 3, 1, 10, '12 meses', 'Estoque D-43', 'Mouse sem fio', 'ativo'),
(98, 'Projetor ProBeam', 3, NULL, 'PRB-9898', '7891000000108', 1999.00, 1499.00, 2, 1, 10, '12 meses', 'Estoque B-20', 'Projetor profissional', 'ativo'),
(99, 'HD Externo Max 4TB', 1, NULL, 'MAX-9999', '7891000000109', 799.00, 499.00, 0, 1, 10, '12 meses', 'Estoque A-28', 'HD externo de alta capacidade', 'ativo'),
(100, 'SSD Flash 2TB', 5, NULL, 'FLS-1010', '7891000000110', 1299.00, 899.00, 6, 1, 10, '12 meses', 'Estoque D-44', 'SSD NVMe 2TB', 'ativo'),
(101, 'Pen Drive Nano 16GB', 9, NULL, 'NANO-1111', '7891000000111', 29.00, 9.00, 10, 1, 20, '12 meses', 'Estoque A-29', 'Pen drive USB compacto', 'ativo'),
(102, 'Carregador PowerMax', 1, NULL, 'PWM-1212', '7891000000112', 139.00, 59.00, 8, 1, 20, '12 meses', 'Estoque A-30', 'Carregador universal', 'ativo'),
(103, 'Webcam UltraHD', 2, NULL, 'UHD-1313', '7891000000113', 399.00, 199.00, 0, 1, 10, '12 meses', 'Estoque B-21', 'Webcam 4K', 'ativo'),
(104, 'Microfone ProVoice', 4, NULL, 'PVC-1414', '7891000000114', 499.00, 249.00, 2, 1, 10, '12 meses', 'Estoque C-09', 'Microfone profissional', 'ativo'),
(105, 'Cabo HDMI Ultra', 8, NULL, 'HDMI-1515', '7891000000115', 69.00, 19.00, 15, 1, 50, '12 meses', 'Estoque D-45', 'Cabo HDMI 4K', 'ativo'),
(106, 'Hub USB 10 portas', 6, NULL, 'HUB-1616', '7891000000116', 149.00, 29.00, 5, 1, 20, '12 meses', 'Estoque D-46', 'Hub USB 3.0', 'ativo'),
(107, 'Leitor Cartão CompactFlash', 7, NULL, 'CF-1717', '7891000000117', 89.00, 19.00, 3, 1, 10, '12 meses', 'Estoque D-47', 'Leitor de cartão CF', 'ativo'),
(108, 'Estabilizador PowerLine', 10, NULL, 'PWL-1818', '7891000000118', 229.00, 99.00, 2, 1, 10, '12 meses', 'Estoque A-31', 'Estabilizador 1200VA', 'ativo'),
(109, 'Nobreak MaxGuard', 9, NULL, 'MXG-1919', '7891000000119', 799.00, 499.00, 1, 1, 10, '12 meses', 'Estoque A-32', 'Nobreak para servidores', 'ativo'),
(110, 'Switch NetLink 48p', 8, NULL, 'NL48-2020', '7891000000120', 799.00, 599.00, 3, 1, 10, '12 meses', 'Estoque D-48', 'Switch 48 portas gigabit', 'ativo');

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
INSERT IGNORE INTO log_usuario (id, usuario_id, acao, tabela_afetada, registro_afetado, created_at) VALUES
(1, 2, 'INSERT', 'transacao', 1, '2024-01-15 10:30:00'),
(2, 2, 'INSERT', 'transacao', 2, '2024-01-16 14:20:00'),
(3, 3, 'INSERT', 'transacao', 3, '2024-01-17 09:15:00'),
(4, 2, 'INSERT', 'transacao', 4, '2024-01-18 11:45:00'),
(5, 3, 'UPDATE', 'produto', 1, '2024-01-17 09:16:00'),
(6, 1, 'CREATE', 'usuario', 2, '2024-01-10 08:00:00'),
(7, 1, 'CREATE', 'usuario', 3, '2024-01-10 08:05:00');
