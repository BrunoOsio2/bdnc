-- ============================================================
-- Dados ficticios para demonstrar catalogo e busca por similaridade.
-- Descricoes ricas (mais termos) para melhorar a vetorizacao.
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
  (3, 'ALIMENTO', 'Produtos alimenticios'),
  (4, 'CAMPING',  'Equipamentos de camping e acampamento');

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

-- Produtos (descricoes ricas, com sinonimos e casos de uso)
INSERT INTO produto (id_produto, nome, descricao, id_classe, preco) OVERRIDING SYSTEM VALUE VALUES
  (101, 'Notebook Pro',
        'Notebook profissional de alto desempenho com processador Intel Core i7, 16 GB de memoria RAM e SSD rapido. Tela de 15,6 polegadas, leve e portatil, ideal para trabalho, programacao, edicao de video, design grafico e uso profissional intenso.',
        1, 4500.00),
  (102, 'Notebook Basico',
        'Notebook de entrada com processador Intel Core i5 e 8 GB de memoria RAM. Leve, economico e silencioso, indicado para estudos, navegacao na internet, tarefas do dia a dia, home office e uso domestico.',
        1, 2800.00),
  (201, 'Camiseta Azul',
        'Camiseta masculina de algodao na cor azul, tamanho M, tecido leve, macio e respiravel. Roupa casual e confortavel para o dia a dia, passeios e clima quente.',
        2, 79.90),
  (301, 'Suco de Uva',
        'Suco integral de uva natural, garrafa de 1 litro, sem adicao de acucar. Bebida saudavel e refrescante, rica em antioxidantes, otima para o cafe da manha, lanches e para toda a familia.',
        3, 12.50),
  (302, 'Barraca Camping 4 pessoas',
        'Barraca de camping para 4 pessoas, impermeavel e resistente a chuva e vento. Espacosa e facil de montar, ideal para acampamento em familia, trilhas, viagens, pescaria e atividades ao ar livre na natureza.',
        4, 349.90),
  (303, 'Barraca Iglu 2 pessoas',
        'Barraca iglu compacta para 2 pessoas, leve e impermeavel, com montagem rapida. Perfeita para camping, trilha, mochilao, aventura e acampamentos ao ar livre em qualquer estacao.',
        4, 289.90),
  (304, 'Saco de Dormir Termico',
        'Saco de dormir termico e compacto para temperaturas baixas, com forro macio e resistente ao frio. Ideal para camping, trilha, acampamento na montanha e aventuras ao ar livre.',
        4, 159.90),
  (305, 'Lanterna de Cabeca LED',
        'Lanterna de cabeca com LED de alto brilho, a prova d agua e com bateria recarregavel. Pratica para camping, trilha noturna, pescaria, acampamento e atividades ao ar livre.',
        4, 89.90);

-- Valores das caracteristicas (apenas dos produtos com classe EAV definida)
INSERT INTO valor_caracteristica (id_produto, id_caracteristica, valor) VALUES
  (101, 1, '15,6 polegadas'), (101, 2, 'Intel Core i7'), (101, 3, '16'),
  (102, 1, '14 polegadas'),   (102, 2, 'Intel Core i5'), (102, 3, '8'),
  (201, 1, 'M'), (201, 4, 'Algodao'), (201, 6, 'Azul'),
  (301, 5, '2027-01-15');

-- Estoque
INSERT INTO estoque (id_produto, qtd_disponivel) VALUES
  (101, 10), (102, 25), (201, 100), (301, 1), (302, 15), (303, 20), (304, 30), (305, 40);

-- Ajusta as sequencias apos inserts com id explicito
SELECT setval('classe_produto_id_classe_seq', (SELECT MAX(id_classe) FROM classe_produto));
SELECT setval('caracteristica_id_caracteristica_seq', (SELECT MAX(id_caracteristica) FROM caracteristica));
SELECT setval('produto_id_produto_seq', (SELECT MAX(id_produto) FROM produto));
