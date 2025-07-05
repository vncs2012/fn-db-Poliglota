-- Tabela de Clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    endereco TEXT,
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(10),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de Produtos
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    codigo_produto VARCHAR(50) UNIQUE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    categoria VARCHAR(100),
    preco DECIMAL(10,2) NOT NULL,
    estoque INTEGER DEFAULT 0,
    estoque_minimo INTEGER DEFAULT 5,
    ativo BOOLEAN DEFAULT TRUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id),
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'PENDENTE',
    valor_total DECIMAL(10,2) NOT NULL,
    endereco_entrega TEXT,
    observacoes TEXT
);

-- Tabela de Itens do Pedido
CREATE TABLE itens_pedido (
    id SERIAL PRIMARY KEY,
    pedido_id INTEGER REFERENCES pedidos(id),
    produto_id INTEGER REFERENCES produtos(id),
    quantidade INTEGER NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL
);

-- Tabela de Transações Financeiras
CREATE TABLE transacoes_financeiras (
    id SERIAL PRIMARY KEY,
    pedido_id INTEGER REFERENCES pedidos(id),
    tipo VARCHAR(50) NOT NULL, -- PAGAMENTO, ESTORNO, REEMBOLSO
    valor DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDENTE',
    metodo_pagamento VARCHAR(50),
    data_transacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    referencia_externa VARCHAR(255)
);

-- Índices para otimização
CREATE INDEX idx_clientes_email ON clientes(email);
CREATE INDEX idx_clientes_cpf ON clientes(cpf);
CREATE INDEX idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX idx_pedidos_data ON pedidos(data_pedido);
CREATE INDEX idx_itens_pedido ON itens_pedido(pedido_id);
CREATE INDEX idx_transacoes_pedido ON transacoes_financeiras(pedido_id);

-- Inserir clientes
INSERT INTO clientes (nome, email, cpf, telefone, endereco, cidade, estado, cep) VALUES
('João Silva', 'joao.silva@email.com', '123.456.789-00', '(11) 99999-1111', 'Rua A, 123', 'São Paulo', 'SP', '01234-567'),
('Maria Santos', 'maria.santos@email.com', '987.654.321-00', '(11) 99999-2222', 'Rua B, 456', 'São Paulo', 'SP', '01234-568'),
('Pedro Oliveira', 'pedro.oliveira@email.com', '456.789.123-00', '(21) 99999-3333', 'Rua C, 789', 'Rio de Janeiro', 'RJ', '20123-456'),
('Ana Costa', 'ana.costa@email.com', '789.123.456-00', '(31) 99999-4444', 'Rua D, 321', 'Belo Horizonte', 'MG', '30123-789'),
('Carlos Ferreira', 'carlos.ferreira@email.com', '321.654.987-00', '(41) 99999-5555', 'Rua E, 654', 'Curitiba', 'PR', '40123-321');

-- Inserir produtos
INSERT INTO produtos (codigo_produto, nome, categoria, preco, estoque, estoque_minimo) VALUES
('NOTEBOOK001', 'Notebook Gaming Pro', 'eletrônicos', 2500.00, 15, 5),
('SMARTPHONE001', 'Smartphone Ultra', 'eletrônicos', 1200.00, 25, 10),
('HEADSET001', 'Headset Gamer RGB', 'acessórios', 350.00, 50, 15),
('MOUSE001', 'Mouse Gamer Wireless', 'acessórios', 180.00, 30, 10),
('TECLADO001', 'Teclado Mecânico RGB', 'acessórios', 420.00, 20, 8),
('MONITOR001', 'Monitor 4K 27"', 'eletrônicos', 1800.00, 12, 5),
('CADEIRA001', 'Cadeira Gamer Pro', 'móveis', 890.00, 8, 3),
('WEBCAM001', 'Webcam Full HD', 'acessórios', 250.00, 35, 12);

-- Inserir pedidos
INSERT INTO pedidos (cliente_id, status, valor_total, endereco_entrega) VALUES
(1, 'FINALIZADO', 2680.00, 'Rua A, 123 - São Paulo/SP'),
(2, 'PROCESSANDO', 1550.00, 'Rua B, 456 - São Paulo/SP'),
(3, 'FINALIZADO', 970.00, 'Rua C, 789 - Rio de Janeiro/RJ'),
(1, 'FINALIZADO', 420.00, 'Rua A, 123 - São Paulo/SP'),
(4, 'ENVIADO', 2050.00, 'Rua D, 321 - Belo Horizonte/MG');

-- Inserir itens dos pedidos
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario, subtotal) VALUES
(1, 1, 1, 2500.00, 2500.00),
(1, 4, 1, 180.00, 180.00),
(2, 2, 1, 1200.00, 1200.00),
(2, 3, 1, 350.00, 350.00),
(3, 5, 1, 420.00, 420.00),
(3, 4, 1, 180.00, 180.00),
(3, 8, 1, 250.00, 250.00),
(3, 3, 1, 350.00, 350.00),
(4, 5, 1, 420.00, 420.00),
(5, 6, 1, 1800.00, 1800.00),
(5, 8, 1, 250.00, 250.00);

-- Inserir transações financeiras
INSERT INTO transacoes_financeiras (pedido_id, tipo, valor, status, metodo_pagamento) VALUES
(1, 'PAGAMENTO', 2680.00, 'APROVADO', 'CARTAO_CREDITO'),
(2, 'PAGAMENTO', 1550.00, 'PROCESSANDO', 'PIX'),
(3, 'PAGAMENTO', 970.00, 'APROVADO', 'BOLETO'),
(4, 'PAGAMENTO', 420.00, 'APROVADO', 'CARTAO_DEBITO'),
(5, 'PAGAMENTO', 2050.00, 'APROVADO', 'CARTAO_CREDITO');

-- Atualizar estoque após vendas
UPDATE produtos SET estoque = estoque - 1 WHERE id = 1; -- Notebook
UPDATE produtos SET estoque = estoque - 1 WHERE id = 2; -- Smartphone  
UPDATE produtos SET estoque = estoque - 2 WHERE id = 3; -- Headset (2 vendidos)
UPDATE produtos SET estoque = estoque - 2 WHERE id = 4; -- Mouse (2 vendidos)
UPDATE produtos SET estoque = estoque - 2 WHERE id = 5; -- Teclado (2 vendidos)
UPDATE produtos SET estoque = estoque - 1 WHERE id = 6; -- Monitor
UPDATE produtos SET estoque = estoque - 2 WHERE id = 8; -- Webcam (2 vendidas)