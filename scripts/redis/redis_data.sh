#!/bin/bash
# Script para carregar dados de exemplo no Rdis

echo "Carregando dados no Redis..."

# Conectar ao Redis
redis-cli -a admin123 << 'EOF'

# SESSÕES DE USUÁRIO

# Simular sessões ativas
SET session:user_001 '{"user_id":1,"login_time":" 2025-06-28T10:00:00Z","ip":"192.168.1.100","device":"desktop"}' EX 1800
SET session:user_002 '{"user_id":2,"login_time":" 2025-06-28T10:15:00Z","ip":"192.168.1.101","device":"mobile"}' EX 1800
SET session:user_003 '{"user_id":3,"login_time":" 2025-06-28T10:30:00Z","ip":"192.168.1.102","device":"tablet"}' EX 1800

# CARRINHOS DE COMPRA

# Carrinho do usuário 1
HSET cart:user_001 NOTEBOOK001 1
HSET cart:user_001 MOUSE001 1
HSET cart:user_001 total_items 2
HSET cart:user_001 created_at " 2025-06-28T10:05:00Z"

# Carrinho do usuário 2  
HSET cart:user_002 SMARTPHONE001 1
HSET cart:user_002 HEADSET001 1
HSET cart:user_002 total_items 2
HSET cart:user_002 created_at " 2025-06-28T10:20:00Z"

# Carrinho do usuário 3
HSET cart:user_003 HEADSET001 2
HSET cart:user_003 total_items 2
HSET cart:user_003 created_at " 2025-06-28T10:35:00Z"

# CACHE DE PRODUTOS (mais acessados)

SET product:NOTEBOOK001 '{"id":"NOTEBOOK001","nome":"Notebook Gaming Pro","preco":2500.00,"estoque":14,"categoria":"eletrônicos"}' EX 3600
SET product:SMARTPHONE001 '{"id":"SMARTPHONE001","nome":"Smartphone Ultra","preco":1200.00,"estoque":24,"categoria":"eletrônicos"}' EX 3600
SET product:HEADSET001 '{"id":"HEADSET001","nome":"Headset Gamer RGB","preco":350.00,"estoque":48,"categoria":"acessórios"}' EX 3600
SET product:MOUSE001 '{"id":"MOUSE001","nome":"Mouse Gamer Wireless","preco":180.00,"estoque":28,"categoria":"acessórios"}' EX 3600

# RANKING DE PRODUTOS MAIS VISTOS

ZADD most_viewed 450 NOTEBOOK001
ZADD most_viewed 380 SMARTPHONE001  
ZADD most_viewed 320 HEADSET001
ZADD most_viewed 290 MOUSE001
ZADD most_viewed 250 MONITOR001
ZADD most_viewed 180 TECLADO001
ZADD most_viewed 150 WEBCAM001
ZADD most_viewed 120 CADEIRA001

# CONTADORES DE VISUALIZAÇÕES DIÁRIAS

# Visualizações de hoje
SET views:NOTEBOOK001: 2025-06-28 25
SET views:SMARTPHONE001: 2025-06-28 18
SET views:HEADSET001: 2025-06-28 15
SET views:MOUSE001: 2025-06-28 12

# Visualizações de ontem
SET views:NOTEBOOK001: 2025-06-27 30
SET views:SMARTPHONE001: 2025-06-27 22
SET views:HEADSET001: 2025-06-27 20
SET views:MOUSE001: 2025-06-27 16

# CACHE DE CONSULTAS FREQUENTES  

# Cache de resultados de busca
SET search:gaming '["NOTEBOOK001","HEADSET001","MOUSE001"]' EX 600
SET search:smartphone '["SMARTPHONE001"]' EX 600
SET search:notebook '["NOTEBOOK001"]' EX 600

# Cache de produtos por categoria
SET category:eletrônicos '["NOTEBOOK001","SMARTPHONE001","MONITOR001"]' EX 1800
SET category:acessórios '["HEADSET001","MOUSE001","TECLADO001","WEBCAM001"]' EX 1800

# DADOS DE PROMOÇÕES E OFERTAS

# Produtos em promoção
SET promo:flash_sale '["HEADSET001","MOUSE001"]' EX 7200
HSET promo:details:HEADSET001 original_price 350.00 promo_price 280.00 discount 20
HSET promo:details:MOUSE001 original_price 180.00 promo_price 150.00 discount 17

# CONFIGURAÇÕES DO SISTEMA

SET config:max_cart_items 10
SET config:session_timeout 1800
SET config:cache_ttl 3600

EOF

echo "Dados carregados no Redis com sucesso!"