// Inicialização do MongoDB - DataDriven Store

// Criar coleção de produtos
db.produtos.insertMany([
  {
    _id: "NOTEBOOK001",
    nome: "Notebook Gaming Pro",
    categoria: "eletrônicos",
    marca: "TechGamer",
    preco: 2500.00,
    descricao: "Notebook para jogos com alta performance",
    atributos: {
      processador: "Intel i7-12700H",
      memoria: "16GB DDR4",
      armazenamento: "512GB SSD NVMe",
      placa_video: "RTX 3060 6GB",
      tela: "15.6 Full HD 144Hz",
      peso: "2.3kg"
    },
    avaliacoes: [
      {
        usuario_id: "user_001",
        nota: 5,
        comentario: "Excelente notebook para jogos!",
        data: new Date("2024-06-01")
      },
      {
        usuario_id: "user_002", 
        nota: 4,
        comentario: "Boa qualidade, mas esquenta um pouco",
        data: new Date("2024-06-15")
      }
    ],
    tags: ["gaming", "notebook", "alta-performance"],
    data_cadastro: new Date("2024-01-15")
  },
  {
    _id: "SMARTPHONE001",
    nome: "Smartphone Ultra",
    categoria: "eletrônicos",
    marca: "MobileTech",
    preco: 1200.00,
    descricao: "Smartphone com câmera profissional",
    atributos: {
      processador: "Snapdragon 8 Gen 2",
      memoria: "8GB",
      armazenamento: "256GB",
      camera_principal: "108MP",
      camera_frontal: "32MP",
      bateria: "5000mAh",
      tela: "6.7 AMOLED"
    },
    avaliacoes: [
      {
        usuario_id: "user_003",
        nota: 5,
        comentario: "Câmera incrível!",
        data: new Date("2024-05-20")
      }
    ],
    tags: ["smartphone", "camera", "android"],
    data_cadastro: new Date("2024-02-01")
  },
  {
    _id: "HEADSET001",
    nome: "Headset Gamer RGB",
    categoria: "acessórios",
    marca: "AudioGamer",
    preco: 350.00,
    descricao: "Headset gamer com iluminação RGB",
    atributos: {
      tipo: "Over-ear",
      conectividade: "USB/P2",
      microfone: "Removível",
      drivers: "50mm",
      iluminacao: "RGB",
      cancelamento_ruido: true
    },
    avaliacoes: [
      {
        usuario_id: "user_001",
        nota: 4,
        comentario: "Som muito bom, RGB bonito",
        data: new Date("2024-06-10")
      }
    ],
    tags: ["headset", "gaming", "rgb", "audio"],
    data_cadastro: new Date("2024-01-20")
  },
  {
    _id: "MOUSE001",
    nome: "Mouse Gamer Wireless",
    categoria: "acessórios", 
    marca: "GamePro",
    preco: 180.00,
    descricao: "Mouse gamer sem fio de alta precisão",
    atributos: {
      tipo: "Wireless",
      dpi: "16000",
      botoes: 8,
      bateria: "70h",
      peso: "85g",
      sensor: "PixArt 3370"
    },
    avaliacoes: [],
    tags: ["mouse", "gaming", "wireless"],
    data_cadastro: new Date("2024-03-01")
  },
  {
    _id: "MONITOR001",
    nome: "Monitor 4K 27\"",
    categoria: "eletrônicos",
    marca: "DisplayTech",
    preco: 1800.00,
    descricao: "Monitor profissional 4K",
    atributos: {
      tamanho: "27 polegadas",
      resolucao: "3840x2160",
      taxa_atualizacao: "60Hz",
      painel: "IPS",
      conectividade: ["HDMI", "DisplayPort", "USB-C"],
      cores: "99% sRGB"
    },
    avaliacoes: [
      {
        usuario_id: "user_004",
        nota: 5,
        comentario: "Cores perfeitas para design",
        data: new Date("2024-05-30")
      }
    ],
    tags: ["monitor", "4k", "profissional"],
    data_cadastro: new Date("2024-02-15")
  }
]);

// Criar coleção de perfis estendidos de usuários
db.perfis_usuarios.insertMany([
  {
    _id: "user_001",
    cliente_id: 1,
    preferencias: ["gaming", "tecnologia", "eletrônicos"],
    dados_demograficos: {
      idade: 28,
      genero: "M",
      profissao: "Desenvolvedor",
      renda_faixa: "5000-8000"
    },
    historico_navegacao: [
      {
        produto_id: "NOTEBOOK001",
        timestamp: new Date("2024-06-20T10:30:00Z"),
        tempo_visualizacao: 120
      },
      {
        produto_id: "HEADSET001", 
        timestamp: new Date("2024-06-20T11:00:00Z"),
        tempo_visualizacao: 60
      }
    ],
    produtos_favoritos: ["NOTEBOOK001", "MOUSE001"],
    ultima_atualizacao: new Date("2024-06-20")
  },
  {
    _id: "user_002",
    cliente_id: 2,
    preferencias: ["smartphone", "fotografia", "tecnologia"],
    dados_demograficos: {
      idade: 35,
      genero: "F", 
      profissao: "Designer",
      renda_faixa: "3000-5000"
    },
    historico_navegacao: [
      {
        produto_id: "SMARTPHONE001",
        timestamp: new Date("2024-06-19T14:20:00Z"),
        tempo_visualizacao: 180
      },
      {
        produto_id: "MONITOR001",
        timestamp: new Date("2024-06-19T15:00:00Z"), 
        tempo_visualizacao: 90
      }
    ],
    produtos_favoritos: ["SMARTPHONE001"],
    ultima_atualizacao: new Date("2024-06-19")
  },
  {
    _id: "user_003",
    cliente_id: 3,
    preferencias: ["gaming", "streaming", "acessórios"],
    dados_demograficos: {
      idade: 22,
      genero: "M",
      profissao: "Estudante",
      renda_faixa: "1000-3000"
    },
    historico_navegacao: [
      {
        produto_id: "HEADSET001",
        timestamp: new Date("2024-06-18T20:15:00Z"),
        tempo_visualizacao: 200
      }
    ],
    produtos_favoritos: ["HEADSET001", "MOUSE001"],
    ultima_atualizacao: new Date("2024-06-18")
  }
]);

// Criar índices para otimização
db.produtos.createIndex({ "categoria": 1 });
db.produtos.createIndex({ "marca": 1 });
db.produtos.createIndex({ "preco": 1 });
db.produtos.createIndex({ "tags": 1 });
db.produtos.createIndex({ "atributos.processador": 1 });

db.perfis_usuarios.createIndex({ "cliente_id": 1 });
db.perfis_usuarios.createIndex({ "preferencias": 1 });
db.perfis_usuarios.createIndex({ "produtos_favoritos": 1 });

print("MongoDB inicializado com sucesso!");