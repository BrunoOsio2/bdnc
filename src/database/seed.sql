-- ============================================================
-- Dados ficticios minimos para validar a conexao e as queries.
-- Baseado no exemplo do documento de arquitetura.
-- ============================================================

-- Clientes
INSERT INTO cliente (nome, email) VALUES
  ('Ana Souza',    'ana@exemplo.com'),
  ('Bruno Lima',   'bruno@exemplo.com'),
  ('Carla Dias',   'carla@exemplo.com');

-- Classes de produto
INSERT INTO classe_produto (id_classe, codigo, descricao) OVERRIDING SYSTEM VALUE VALUES
  (1, 'NOTEBOOK', 'Computadores portateis'),
  (2, 'ROUPA',    'Vestuario'),
  (3, 'ALIMENTO', 'Produtos alimenticios');

-- Caracteristicas
INSERT INTO caracteristica (id_caracteristica, codigo, tipo_dado) OVERRIDING SYSTEM VALUE VALUES
  (1, 'TAMANHO',     'TEXTO'),
  (2, 'PROCESSADOR', 'TEXTO'),
  (3, 'MEMORIA_RAM', 'NUMERO'),
  (4, 'TECIDO',      'TEXTO'),
  (5, 'VALIDADE',    'DATA'),
  (6, 'COR',         'TEXTO');

-- Relacao classe x caracteristica
INSERT INTO classe_caracteristica (id_classe, id_caracteristica, obrigatoria) VALUES
  (1, 1, true), (1, 2, true), (1, 3, true),
  (2, 1, true), (2, 4, true), (2, 6, false),
  (3, 5, true);

-- Produtos
INSERT INTO produto (id_produto, nome, descricao, id_classe, preco) OVERRIDING SYSTEM VALUE VALUES
  (101, 'Notebook Pro',    'Notebook para uso profissional, leve e potente', 1, 4500.00),
  (102, 'Notebook Basico', 'Notebook de entrada para tarefas do dia a dia',  1, 2800.00),
  (201, 'Camiseta Azul',   'Camiseta de algodao confortavel',                2, 79.90),
  (301, 'Suco de Uva',     'Suco integral de uva, 1 litro',                  3, 12.50);

-- Valores das caracteristicas
INSERT INTO valor_caracteristica (id_produto, id_caracteristica, valor) VALUES
  (101, 1, '15,6 polegadas'), (101, 2, 'Intel Core i7'), (101, 3, '16'),
  (102, 1, '14 polegadas'),   (102, 2, 'Intel Core i5'), (102, 3, '8'),
  (201, 1, 'M'), (201, 4, 'Algodao'), (201, 6, 'Azul'),
  (301, 5, '2027-01-15');

-- Estoque
INSERT INTO estoque (id_produto, qtd_disponivel) VALUES
  (101, 10), (102, 25), (201, 100), (301, 1);

-- Ajusta as sequencias apos inserts com id explicito
SELECT setval('classe_produto_id_classe_seq', (SELECT MAX(id_classe) FROM classe_produto));
SELECT setval('caracteristica_id_caracteristica_seq', (SELECT MAX(id_caracteristica) FROM caracteristica));
SELECT setval('produto_id_produto_seq', (SELECT MAX(id_produto) FROM produto));
