// Criação do grafo de recomendações - DataDriven Store

// CRIAR CONSTRAINTS E ÍNDICES

CREATE CONSTRAINT cliente_id IF NOT EXISTS FOR (c:Cliente) REQUIRE c.id IS UNIQUE;
CREATE CONSTRAINT produto_id IF NOT EXISTS FOR (p:Produto) REQUIRE p.id IS UNIQUE;
CREATE CONSTRAINT marca_nome IF NOT EXISTS FOR (m:Marca) REQUIRE m.nome IS UNIQUE;
CREATE CONSTRAINT categoria_nome IF NOT EXISTS FOR (cat:Categoria) REQUIRE cat.nome IS UNIQUE;

CREATE INDEX cliente_nome IF NOT EXISTS FOR (c:Cliente) ON (c.nome);
CREATE INDEX produto_nome IF NOT EXISTS FOR (p:Produto) ON (p.nome);
CREATE INDEX produto_preco IF NOT EXISTS FOR (p:Producto) ON (p.preco);

// CRIAR NÓS - CLIENTES

MERGE (c1:Cliente {id: 1})
SET c1.nome = "João Silva",
    c1.email = "joao.silva@email.com",
    c1.idade = 28,
    c1.genero = "M",
    c1.cidade = "São Paulo",
    c1.data_cadastro = date("2024-01-15");

MERGE (c2:Cliente {id: 2})
SET c2.nome = "Maria Santos",
    c2.email = "maria.santos@email.com",
    c2.idade = 35,
    c2.genero = "F",
    c2.cidade = "São Paulo",
    c2.data_cadastro = date("2024-02-20");

MERGE (c3:Cliente {id: 3})
SET c3.nome = "Pedro Oliveira",
    c3.email = "pedro.oliveira@email.com",
    c3.idade = 22,
    c3.genero = "M",
    c3.cidade = "Rio de Janeiro",
    c3.data_cadastro = date("2024-03-10");

MERGE (c4:Cliente {id: 4})
SET c4.nome = "Ana Costa",
    c4.email = "ana.costa@email.com",
    c4.idade = 42,
    c4.genero = "F",
    c4.cidade = "Belo Horizonte",
    c4.data_cadastro = date("2024-01-25");

MERGE (c5:Cliente {id: 5})
SET c5.nome = "Carlos Ferreira",
    c5.email = "carlos.ferreira@email.com",
    c5.idade = 31,
    c5.genero = "M",
    c5.cidade = "Curitiba",
    c5.data_cadastro = date("2024-04-05");

// CRIAR NÓS - MARCAS

MERGE (m1:Marca {nome: "TechGamer"})
SET m1.categoria_principal = "eletrônicos",
    m1.reputacao = 4.5;

MERGE (m2:Marca {nome: "MobileTech"})
SET m2.categoria_principal = "eletrônicos",
    m2.reputacao = 4.3;

MERGE (m3:Marca {nome: "AudioGamer"})
SET m3.categoria_principal = "acessórios",
    m3.reputacao = 4.2;

MERGE (m4:Marca {nome: "GamePro"})
SET m4.categoria_principal = "acessórios",
    m4.reputacao = 4.4;

MERGE (m5:Marca {nome: "DisplayTech"})
SET m5.categoria_principal = "eletrônicos",
    m5.reputacao = 4.6;

MERGE (m6:Marca {nome: "ErgoOffice"})
SET m6.categoria_principal = "móveis",
    m6.reputacao = 4.1;

// CRIAR NÓS - CATEGORIAS

MERGE (cat1:Categoria {nome: "eletrônicos"})
SET cat1.descricao = "Produtos eletrônicos e tecnologia";

MERGE (cat2:Categoria {nome: "acessórios"})
SET cat2.descricao = "Acessórios para gaming e informática";

MERGE (cat3:Categoria {nome: "móveis"})
SET cat3.descricao = "Móveis para escritório e gaming";

// Subcategorias
MERGE (subcat1:Categoria {nome: "notebooks"})
SET subcat1.descricao = "Notebooks e laptops",
    subcat1.categoria_pai = "eletrônicos";

MERGE (subcat2:Categoria {nome: "smartphones"})
SET subcat2.descricao = "Telefones celulares",
    subcat2.categoria_pai = "eletrônicos";

MERGE (subcat3:Categoria {nome: "periféricos"})
SET subcat3.descricao = "Mouse, teclado, headset",
    subcat3.categoria_pai = "acessórios";

MERGE (subcat4:Categoria {nome: "monitores"})
SET subcat4.descricao = "Monitores e displays",
    subcat4.categoria_pai = "eletrônicos";

// CRIAR NÓS - PRODUTOS

MERGE (p1:Produto {id: "NOTEBOOK001"})
SET p1.nome = "Notebook Gaming Pro",
    p1.preco = 2500.00,
    p1.categoria = "eletrônicos",
    p1.subcategoria = "notebooks",
    p1.rating = 4.5,
    p1.num_avaliacoes = 127,
    p1.estoque = 14,
    p1.descricao = "Notebook para jogos com alta performance",
    p1.tags = ["gaming", "i7", "rtx3060", "alta-performance"];

MERGE (p2:Produto {id: "SMARTPHONE001"})
SET p2.nome = "Smartphone Ultra",
    p2.preco = 1200.00,
    p2.categoria = "eletrônicos",
    p2.subcategoria = "smartphones",
    p2.rating = 4.3,
    p2.num_avaliacoes = 89,
    p2.estoque = 24,
    p2.descricao = "Smartphone com câmera profissional",
    p2.tags = ["smartphone", "108mp", "android", "5g"];

MERGE (p3:Produto {id: "HEADSET001"})
SET p3.nome = "Headset Gamer RGB",
    p3.preco = 350.00,
    p3.categoria = "acessórios",
    p3.subcategoria = "periféricos",
    p3.rating = 4.2,
    p3.num_avaliacoes = 203,
    p3.estoque = 48,
    p3.descricao = "Headset gamer com iluminação RGB",
    p3.tags = ["headset", "gaming", "rgb", "microfone"];

MERGE (p4:Produto {id: "MOUSE001"})
SET p4.nome = "Mouse Gamer Wireless",
    p4.preco = 180.00,
    p4.categoria = "acessórios",
    p4.subcategoria = "periféricos",
    p4.rating = 4.4,
    p4.num_avaliacoes = 156,
    p4.estoque = 28,
    p4.descricao = "Mouse gamer sem fio de alta precisão",
    p4.tags = ["mouse", "gaming", "wireless", "16000dpi"];

MERGE (p5:Produto {id: "TECLADO001"})
SET p5.nome = "Teclado Mecânico RGB",
    p5.preco = 420.00,
    p5.categoria = "acessórios",
    p5.subcategoria = "periféricos",
    p5.rating = 4.3,
    p5.num_avaliacoes = 174,
    p5.estoque = 18,
    p5.descricao = "Teclado mecânico com switches blue",
    p5.tags = ["teclado", "mecânico", "rgb", "switches-blue"];

MERGE (p6:Produto {id: "MONITOR001"})
SET p6.nome = "Monitor 4K 27\"",
    p6.preco = 1800.00,
    p6.categoria = "eletrônicos",
    p6.subcategoria = "monitores",
    p6.rating = 4.6,
    p6.num_avaliacoes = 95,
    p6.estoque = 11,
    p6.descricao = "Monitor profissional 4K",
    p6.tags = ["monitor", "4k", "27", "ips", "profissional"];

MERGE (p7:Produto {id: "CADEIRA001"})
SET p7.nome = "Cadeira Gamer Pro",
    p7.preco = 890.00,
    p7.categoria = "móveis",
    p7.subcategoria = "cadeiras",
    p7.rating = 4.1,
    p7.num_avaliacoes = 67,
    p7.estoque = 5,
    p7.descricao = "Cadeira ergonômica para gamers",
    p7.tags = ["cadeira", "gaming", "ergonômica", "couro"];

MERGE (p8:Produto {id: "WEBCAM001"})
SET p8.nome = "Webcam Full HD",
    p8.preco = 250.00,
    p8.categoria = "acessórios",
    p8.subcategoria = "periféricos",
    p8.rating = 4.0,
    p8.num_avaliacoes = 88,
    p8.estoque = 33,
    p8.descricao = "Webcam para streaming e videoconferências",
    p8.tags = ["webcam", "fullhd", "streaming", "usb"];

// CRIAR RELACIONAMENTOS - PRODUTOS E CATEGORIAS

MATCH (p:Produto), (cat:Categoria)
WHERE p.categoria = cat.nome
MERGE (p)-[:PERTENCE_A]->(cat);

// Relacionamentos com subcategorias
MATCH (p1:Produto {id: "NOTEBOOK001"}), (sub:Categoria {nome: "notebooks"})
MERGE (p1)-[:PERTENCE_A]->(sub);

MATCH (p2:Produto {id: "SMARTPHONE001"}), (sub:Categoria {nome: "smartphones"})
MERGE (p2)-[:PERTENCE_A]->(sub);

MATCH (p3:Produto {id: "HEADSET001"}), (p4:Produto {id: "MOUSE001"}), (p5:Produto {id: "TECLADO001"}), (p8:Produto {id: "WEBCAM001"}), (sub:Categoria {nome: "periféricos"})
MERGE (p3)-[:PERTENCE_A]->(sub)
MERGE (p4)-[:PERTENCE_A]->(sub)
MERGE (p5)-[:PERTENCE_A]->(sub)
MERGE (p8)-[:PERTENCE_A]->(sub);

MATCH (p6:Produto {id: "MONITOR001"}), (sub:Categoria {nome: "monitores"})
MERGE (p6)-[:PERTENCE_A]->(sub);

// CRIAR RELACIONAMENTOS - PRODUTOS E MARCAS

MATCH (p1:Produto {id: "NOTEBOOK001"}), (m1:Marca {nome: "TechGamer"})
MERGE (p1)-[:DA_MARCA]->(m1);

MATCH (p2:Produto {id: "SMARTPHONE001"}), (m2:Marca {nome: "MobileTech"})
MERGE (p2)-[:DA_MARCA]->(m2);

MATCH (p3:Produto {id: "HEADSET001"}), (m3:Marca {nome: "AudioGamer"})
MERGE (p3)-[:DA_MARCA]->(m3);

MATCH (p4:Produto {id: "MOUSE001"}), (p5:Produto {id: "TECLADO001"}), (m4:Marca {nome: "GamePro"})
MERGE (p4)-[:DA_MARCA]->(m4)
MERGE (p5)-[:DA_MARCA]->(m4);

MATCH (p6:Produto {id: "MONITOR001"}), (m5:Marca {nome: "DisplayTech"})
MERGE (p6)-[:DA_MARCA]->(m5);

MATCH (p7:Produto {id: "CADEIRA001"}), (m6:Marca {nome: "ErgoOffice"})
MERGE (p7)-[:DA_MARCA]->(m6);

MATCH (p8:Produto {id: "WEBCAM001"}), (m5:Marca {nome: "DisplayTech"})
MERGE (p8)-[:DA_MARCA]->(m5);

// CRIAR RELACIONAMENTOS - CLIENTES E PRODUTOS

MATCH (c1:Cliente {id: 1}), (p1:Produto {id: "NOTEBOOK001"})
MERGE (c1)-[:COMPROU {data: date("2024-06-28"), valor: 2680.00, pedido_id: 1, avaliacao: 5, comentario: "Excelente notebook!"}]->(p1);

MATCH (c1:Cliente {id: 1}), (p4:Produto {id: "MOUSE001"})
MERGE (c1)-[:COMPROU {data: date("2024-06-28"), valor: 2680.00, pedido_id: 1}]->(p4);

MATCH (c1:Cliente {id: 1}), (p5:Produto {id: "TECLADO001"})
MERGE (c1)-[:COMPROU {data: date("2024-06-25"), valor: 420.00, pedido_id: 4, avaliacao: 4, comentario: "Bom teclado, mas um pouco barulhento"}]->(p5);

MATCH (c1:Cliente {id: 1}), (p3:Produto {id: "HEADSET001"})
MERGE (c1)-[:VISUALIZOU {timestamp: datetime("2024-06-28T10:15:00Z"), tempo_sessao: 120}]->(p3);

MATCH (c1:Cliente {id: 1}), (p6:Produto {id: "MONITOR001"})
MERGE (c1)-[:VISUALIZOU {timestamp: datetime("2024-06-27T14:30:00Z"), tempo_sessao: 180}]->(p6);

MATCH (c2:Cliente {id: 2}), (p2:Produto {id: "SMARTPHONE001"})
MERGE (c2)-[:VISUALIZOU {timestamp: datetime("2024-06-28T10:16:00Z"), tempo_sessao: 200}]->(p2);

MATCH (c2:Cliente {id: 2}), (p3:Produto {id: "HEADSET001"})
MERGE (c2)-[:VISUALIZOU {timestamp: datetime("2024-06-28T10:20:00Z"), tempo_sessao: 90}]->(p3);

MATCH (c2:Cliente {id: 2}), (p6:Produto {id: "MONITOR001"})
MERGE (c2)-[:COMPROU {data: date("2024-05-15"), valor: 2050.00, pedido_id: 5, avaliacao: 5, comentario: "Perfeito para design!"}]->(p6);

MATCH (c3:Cliente {id: 3}), (p3:Produto {id: "HEADSET001"})
MERGE (c3)-[:COMPROU {data: date("2024-06-20"), valor: 970.00, pedido_id: 3, avaliacao: 4}]->(p3);

MATCH (c3:Cliente {id: 3}), (p4:Produto {id: "MOUSE001"})
MERGE (c3)-[:COMPROU {data: date("2024-06-20"), valor: 970.00, pedido_id: 3}]->(p4);

MATCH (c3:Cliente {id: 3}), (p1:Produto {id: "NOTEBOOK001"})
MERGE (c3)-[:VISUALIZOU {timestamp: datetime("2024-06-25T20:00:00Z"), tempo_sessao: 300}]->(p1);

MATCH (c4:Cliente {id: 4}), (p6:Produto {id: "MONITOR001"})
MERGE (c4)-[:VISUALIZOU {timestamp: datetime("2024-06-26T14:31:00Z"), tempo_sessao: 240}]->(p6);

MATCH (c4:Cliente {id: 4}), (p8:Produto {id: "WEBCAM001"})
MERGE (c4)-[:COMPROU {data: date("2024-05-10"), valor: 250.00, pedido_id: 6, avaliacao: 4}]->(p8);

MATCH (c5:Cliente {id: 5}), (p5:Produto {id: "TECLADO001"})
MERGE (c5)-[:VISUALIZOU {timestamp: datetime("2024-06-25T16:20:00Z"), tempo_sessao: 150}]->(p5);

MATCH (c5:Cliente {id: 5}), (p7:Produto {id: "CADEIRA001"})
MERGE (c5)-[:COMPROU {data: date("2024-04-20"), valor: 890.00, pedido_id: 7, avaliacao: 4}]->(p7);

// CRIAR RELACIONAMENTOS DE SIMILARIDADE

MATCH (c1:Cliente {id: 1}), (c3:Cliente {id: 3})
MERGE (c1)-[:SIMILAR_A {score: 0.75, motivo: "Ambos compraram produtos gaming"}]->(c3);

MATCH (c1:Cliente {id: 1}), (c5:Cliente {id: 5})
MERGE (c1)-[:SIMILAR_A {score: 0.65, motivo: "Interesse em setup gaming/profissional"}]->(c5);

MATCH (c2:Cliente {id: 2}), (c4:Cliente {id: 4})
MERGE (c2)-[:SIMILAR_A {score: 0.70, motivo: "Interesse em produtos para design e uso profissional"}]->(c4);