
-- Tabela principal de eventos
CREATE TABLE IF NOT EXISTS eventos (
    user_id UInt64,
    session_id String,
    evento_tipo String,
    produto_id String,
    categoria String,
    preco Float64,
    quantidade UInt32 DEFAULT 1,
    valor_total Float64 DEFAULT 0,
    utm_source String DEFAULT '',
    utm_medium String DEFAULT '',
    utm_campaign String DEFAULT '',
    termo_busca String DEFAULT '',
    resultados_busca UInt32 DEFAULT 0,
    ip String,
    user_agent String,
    device_type String,
    browser String DEFAULT '',
    metadata String DEFAULT '{}',
    data Date
) ENGINE = MergeTree()
PARTITION BY toYYYYMM(data)
ORDER BY (user_id, evento_tipo)
SETTINGS index_granularity = 8192;

-- Tabela para funil de conversão (materializada)
CREATE TABLE IF NOT EXISTS funil_conversao (
    user_id UInt64,
    session_id String,
    produto_id String,
    data Date,
    visualizou UInt8 DEFAULT 0,
    adicionou_carrinho UInt8 DEFAULT 0, 
    comprou UInt8 DEFAULT 0,
    timestamp_view Nullable(DateTime),
    timestamp_cart Nullable(DateTime),
    timestamp_purchase Nullable(DateTime),
    valor_compra Float64 DEFAULT 0
) ENGINE = ReplacingMergeTree()
ORDER BY (user_id, session_id, produto_id, data);

-- Inserção de dados de exemplo na tabela de eventos
INSERT INTO eventos (user_id, session_id, evento_tipo, produto_id, categoria, preco, quantidade, valor_total, utm_source, utm_medium, utm_campaign, termo_busca, resultados_busca, ip, user_agent, device_type, browser, metadata, data) VALUES
(1, 'sess_001_20250628', 'view', 'NOTEBOOK001', 'eletrônicos', 2500.00, 1, 0, 'google', 'organic', '', '', 0, '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'desktop', 'Chrome', '{}', 2025-06-28),
(1, 'sess_001_20250628', 'click', 'NOTEBOOK001', 'eletrônicos', 2500.00, 1, 0, 'google', 'organic', '', '', 0, '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'desktop', 'Chrome', '{}', 2025-06-28),
(1, 'sess_001_20250628', 'view', 'MOUSE001', 'acessórios', 180.00, 1, 0, 'google', 'organic', '', '', 0, '192.168.1.100', 'Mozilla/5.0...', 'desktop', 'Chrome', '{}', 2025-06-28),
(1, 'sess_001_20250628', 'add_to_cart', 'MOUSE001', 'acessórios', 180.00, 1, 180.00, 'google', 'organic', '', '', 0, '192.168.1.100', 'Mozilla/5.0...', 'desktop', 'Chrome', '{}', 2025-06-28),
(1, 'sess_001_20250628', 'purchase', 'NOTEBOOK001', 'eletrônicos', 2500.00, 1, 2680.00, 'google', 'organic', '', '', 0, '192.168.1.100', 'Mozilla/5.0...', 'desktop', 'Chrome', '{"pedido_id": 1}', 2025-06-28),
(2, 'sess_002_20250628', 'search', '', '', 0, 0, 0, 'facebook', 'cpc', 'summer_sale', 'smartphone', 5, '192.168.1.101', 'Mobile Safari...', 'mobile', 'Safari', '{}', 2025-06-28),
(2, 'sess_002_20250628', 'view', 'SMARTPHONE001', 'eletrônicos', 1200.00, 1, 0, 'facebook', 'cpc', 'summer_sale', '', 0, '192.168.1.101', 'Mobile Safari...', 'mobile', 'Safari', '{}', 2025-06-28),
(2, 'sess_002_20250628', 'view', 'HEADSET001', 'acessórios', 350.00, 1, 0, 'facebook', 'cpc', 'summer_sale', '', 0, '192.168.1.101', 'Mobile Safari...', 'mobile', 'Safari', '{}', 2025-06-28),
(2, 'sess_002_20250628', 'add_to_cart', 'SMARTPHONE001', 'eletrônicos', 1200.00, 1, 1200.00, 'facebook', 'cpc', 'summer_sale', '', 0, '192.168.1.101', 'Mobile Safari...', 'mobile', 'Safari', '{}', 2025-06-28),
(3, 'sess_003_20250627', 'view', 'HEADSET001', 'acessórios', 350.00, 1, 0, 'instagram', 'social', 'gaming_week', '', 0, '192.168.1.102', 'Chrome Mobile...', 'tablet', 'Chrome', '{}', 2025-06-27),
(3, 'sess_003_20250627', 'view', 'MOUSE001', 'acessórios', 180.00, 1, 0, 'instagram', 'social', 'gaming_week', '', 0, '192.168.1.102', 'Chrome Mobile...', 'tablet', 'Chrome', '{}', 2025-06-27),
(3, 'sess_003_20250627', 'add_to_cart', 'HEADSET001', 'acessórios', 350.00, 2, 700.00, 'instagram', 'social', 'gaming_week', '', 0, '192.168.1.102', 'Chrome Mobile...', 'tablet', 'Chrome', '{}', 2025-06-27),
(4, 'sess_004_20250626', 'search', '', '', 0, 0, 0, 'direct', '', '', 'monitor 4k', 3, '192.168.1.103', 'Firefox...', 'desktop', 'Firefox', '{}', 2025-06-26),
(4, 'sess_004_20250626', 'view', 'MONITOR001', 'eletrônicos', 1800.00, 1, 0, 'direct', '', '', '', 0, '192.168.1.103', 'Firefox...', 'desktop', 'Firefox', '{}', 2025-06-26),
(4, 'sess_004_20250626', 'click', 'MONITOR001', 'eletrônicos', 1800.00, 1, 0, 'direct', '', '', '', 0, '192.168.1.103', 'Firefox...', 'desktop', 'Firefox', '{}', 2025-06-26),
(5, 'sess_005_20250625', 'view', 'TECLADO001', 'acessórios', 420.00, 1, 0, 'google', 'cpc', 'tech_ads', '', 0, '192.168.1.104', 'Edge...', 'desktop', 'Edge', '{}', 2025-06-25),
(5, 'sess_005_20250625', 'add_to_cart', 'TECLADO001', 'acessórios', 420.00, 1, 420.00, 'google', 'cpc', 'tech_ads', '', 0, '192.168.1.104', 'Edge...', 'desktop', 'Edge', '{}', 2025-06-25),
(5, 'sess_005_20250625', 'purchase', 'TECLADO001', 'acessórios', 420.00, 1, 420.00, 'google', 'cpc', 'tech_ads', '', 0, '192.168.1.104', 'Edge...', 'desktop', 'Edge', '{"pedido_id": 4}', 2025-06-25),
(6, 'sess_006_20250624', 'view', 'WEBCAM001', 'acessórios', 250.00, 1, 0, 'email', 'newsletter', 'weekly_deals', '', 0, '192.168.1.105', 'Safari...', 'mobile', 'Safari', '{}', 2025-06-24),
(6, 'sess_006_20250624', 'click', 'WEBCAM001', 'acessórios', 250.00, 1, 0, 'email', 'newsletter', 'weekly_deals', '', 0, '192.168.1.105', 'Safari...', 'mobile', 'Safari', '{}', 2025-06-24),
(7, 'sess_007_20250623', 'search', '', '', 0, 0, 0, 'bing', 'organic', '', 'cadeira gamer', 4, '192.168.1.106', 'Chrome...', 'desktop', 'Chrome', '{}', 2025-06-23),
(7, 'sess_007_20250623', 'view', 'CADEIRA001', 'móveis', 890.00, 1, 0, 'bing', 'organic', '', '', 0, '192.168.1.106', 'Chrome...', 'desktop', 'Chrome', '{}', 2025-06-23),
(8, 'sess_008_20250622', 'view', 'NOTEBOOK001', 'eletrônicos', 2500.00, 1, 0, 'youtube', 'video', 'tech_review', '', 0, '192.168.1.107', 'Chrome...', 'mobile', 'Chrome', '{}', 2025-06-22),
(8, 'sess_008_20250622', 'add_to_cart', 'NOTEBOOK001', 'eletrônicos', 2500.00, 1, 2500.00, 'youtube', 'video', 'tech_review', '', 0, '192.168.1.107', 'Chrome...', 'mobile', 'Chrome', '{}', 2025-06-22),
(8, 'sess_008_20250622', 'purchase', 'NOTEBOOK001', 'eletrônicos', 2500.00, 1, 2500.00, 'youtube', 'video', 'tech_review', '', 0, '192.168.1.107', 'Chrome...', 'mobile', 'Chrome', '{"pedido_id": 5}', 2025-06-22);

-- Inserção de dados de exemplo na tabela de funil de conversão
INSERT INTO funil_conversao (user_id, session_id, produto_id, data, visualizou, adicionou_carrinho, comprou, timestamp_view, timestamp_cart, timestamp_purchase, valor_compra) VALUES
(1, 'sess_001_20250628', 'NOTEBOOK001', 2025-06-28, 1, 1, 1, '2025-06-28 10:00:00', '2025-06-28 10:07:00', '2025-06-28 10:20:00', 2680.00),
(1, 'sess_001_20250628', 'MOUSE001', 2025-06-28, 1, 1, 1, '2025-06-28 10:10:00', '2025-06-28 10:12:00', '2025-06-28 10:20:00', 2680.00),
(2, 'sess_002_20250628', 'SMARTPHONE001', 2025-06-28, 1, 1, 0, '2025-06-28 10:16:00', '2025-06-28 10:22:00', NULL, 0),
(2, 'sess_002_20250628', 'HEADSET001', 2025-06-28, 1, 0, 0, '2025-06-28 10:20:00', NULL, NULL, 0),
(3, 'sess_003_20250627', 'HEADSET001', 2025-06-27, 1, 1, 0, '2025-06-27 20:00:00', '2025-06-27 20:10:00', NULL, 0),
(3, 'sess_003_20250627', 'MOUSE001', 2025-06-27, 1, 0, 0, '2025-06-27 20:05:00', NULL, NULL, 0),
(4, 'sess_004_20250626', 'MONITOR001', 2025-06-26, 1, 0, 0, '2025-06-26 14:31:00', NULL, NULL, 0),
(5, 'sess_005_20250625', 'TECLADO001', 2025-06-25, 1, 1, 1, '2025-06-25 16:20:00', '2025-06-25 16:25:00', '2025-06-25 16:30:00', 420.00),
(6, 'sess_006_20250624', 'WEBCAM001', 2025-06-24, 1, 0, 0, '2025-06-24 12:00:00', NULL, NULL, 0),
(7, 'sess_007_20250623', 'CADEIRA001', 2025-06-23, 1, 0, 0, '2025-06-23 09:16:00', NULL, NULL, 0),
(8, 'sess_008_20250622', 'NOTEBOOK001', 2025-06-22, 1, 1, 1, '2025-06-22 18:45:00', '2025-06-22 18:50:00', '2025-06-22 19:00:00', 2500.00);