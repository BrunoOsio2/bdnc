-- ========== CLIENTES (base de tudo) ==========
CREATE TABLE cliente (
  id_cliente BIGSERIAL PRIMARY KEY,
  nome       TEXT NOT NULL,
  email      TEXT UNIQUE NOT NULL,
  criado_em  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ========== CATÁLOGO — EAV estilo SAP MM (dono: gab) ==========
CREATE TABLE classe_produto (
  id_classe BIGSERIAL PRIMARY KEY,
  codigo    TEXT UNIQUE NOT NULL,
  descricao TEXT
);

CREATE TABLE caracteristica (
  id_caracteristica BIGSERIAL PRIMARY KEY,
  codigo            TEXT UNIQUE NOT NULL,
  tipo_dado         TEXT NOT NULL CHECK (tipo_dado IN ('TEXTO','NUMERO','DATA','BOOLEANO'))
);

CREATE TABLE classe_caracteristica (
  id_classe         BIGINT NOT NULL REFERENCES classe_produto(id_classe),
  id_caracteristica BIGINT NOT NULL REFERENCES caracteristica(id_caracteristica),
  obrigatoria       BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (id_classe, id_caracteristica)
);

CREATE TABLE produto (
  id_produto    BIGSERIAL PRIMARY KEY,
  nome          TEXT NOT NULL,
  descricao     TEXT,
  id_classe     BIGINT NOT NULL REFERENCES classe_produto(id_classe),
  preco         NUMERIC(12,2) NOT NULL CHECK (preco >= 0),
  ativo         BOOLEAN NOT NULL DEFAULT true,
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE valor_caracteristica (
  id_produto        BIGINT NOT NULL REFERENCES produto(id_produto) ON DELETE CASCADE,
  id_caracteristica BIGINT NOT NULL REFERENCES caracteristica(id_caracteristica),
  valor             TEXT NOT NULL,
  PRIMARY KEY (id_produto, id_caracteristica)
);

-- ========== ESTOQUE (dono: bruno) ==========
CREATE TABLE estoque (
  id_produto     BIGINT PRIMARY KEY REFERENCES produto(id_produto),
  qtd_disponivel INT NOT NULL DEFAULT 0 CHECK (qtd_disponivel >= 0),
  qtd_reservada  INT NOT NULL DEFAULT 0 CHECK (qtd_reservada >= 0)
);

-- ========== CARRINHO (dono: stefani) ==========
CREATE TABLE carrinho (
  id_carrinho   BIGSERIAL PRIMARY KEY,
  id_cliente    BIGINT NOT NULL REFERENCES cliente(id_cliente),
  status        TEXT NOT NULL DEFAULT 'ABERTO' CHECK (status IN ('ABERTO','CONVERTIDO','ABANDONADO')),
  criado_em     TIMESTAMPTZ NOT NULL DEFAULT now(),
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE item_carrinho (
  id_carrinho BIGINT NOT NULL REFERENCES carrinho(id_carrinho) ON DELETE CASCADE,
  id_produto  BIGINT NOT NULL REFERENCES produto(id_produto),
  quantidade  INT NOT NULL CHECK (quantidade > 0),
  PRIMARY KEY (id_carrinho, id_produto)
);

-- ========== PEDIDOS (dono: bruno) ==========
CREATE TABLE pedido (
  id_pedido          BIGSERIAL PRIMARY KEY,
  id_cliente         BIGINT NOT NULL REFERENCES cliente(id_cliente),
  status             TEXT NOT NULL DEFAULT 'CRIADO'
                     CHECK (status IN ('CRIADO','PAGO','SEPARACAO','ENVIADO','ENTREGUE','CANCELADO')),
  valor_total        NUMERIC(12,2) NOT NULL CHECK (valor_total >= 0),
  chave_idempotencia TEXT UNIQUE NOT NULL,   -- impede pedido duplicado (situação 4)
  criado_em          TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE item_pedido (
  id_pedido      BIGINT NOT NULL REFERENCES pedido(id_pedido) ON DELETE CASCADE,
  id_produto     BIGINT NOT NULL REFERENCES produto(id_produto),
  quantidade     INT NOT NULL CHECK (quantidade > 0),
  preco_unitario NUMERIC(12,2) NOT NULL,
  PRIMARY KEY (id_pedido, id_produto)
);

-- ========== EVENTOS DE NAVEGAÇÃO — persistidos do Redis em batch (dono: stefani) ==========
CREATE TABLE evento_navegacao (
  id_evento   BIGSERIAL PRIMARY KEY,
  id_cliente  BIGINT REFERENCES cliente(id_cliente),
  id_produto  BIGINT REFERENCES produto(id_produto),
  tipo_evento TEXT NOT NULL CHECK (tipo_evento IN ('VIEW','CLICK','SEARCH','ADD_CART')),
  criado_em   TIMESTAMPTZ NOT NULL DEFAULT now()
  -- Em produção: particionar por RANGE (criado_em). Na PoC fica tabela simples.
);

-- ========== RECOMENDAÇÃO / EXPLICABILIDADE — situação 5 (dono: gab) ==========
CREATE TABLE recomendacao (
  id_recomendacao BIGSERIAL PRIMARY KEY,
  id_cliente      BIGINT NOT NULL REFERENCES cliente(id_cliente),
  id_produto      BIGINT NOT NULL REFERENCES produto(id_produto),
  motivo          TEXT NOT NULL,
  criado_em       TIMESTAMPTZ NOT NULL DEFAULT now()
);