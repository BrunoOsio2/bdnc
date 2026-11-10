-- ============================================================
-- Add-on pgvector: armazenamento dos embeddings (dados DERIVADOS)
-- Rodar DEPOIS do schema.sql. Requer a extensao pgvector instalada.
--   npm run db:vector
-- ============================================================

CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS unaccent;

-- Dimensao 384: compativel com modelos como all-MiniLM-L6-v2 / e5-small,
-- para trocar o placeholder por um modelo real depois sem mexer no schema.
CREATE TABLE IF NOT EXISTS produto_embedding (
  id_produto    BIGINT PRIMARY KEY REFERENCES produto(id_produto) ON DELETE CASCADE,
  embedding     vector(384) NOT NULL,
  modelo        TEXT NOT NULL DEFAULT 'placeholder-hash-v1',
  atualizado_em TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Indice de similaridade por cosseno (HNSW). Para poucos registros o seqscan ja
-- resolve; deixamos o indice pronto para volume maior.
CREATE INDEX IF NOT EXISTS idx_produto_embedding_hnsw
  ON produto_embedding USING hnsw (embedding vector_cosine_ops);
