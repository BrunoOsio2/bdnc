#!/usr/bin/env python3
# Gera o seed.sql completo: base + produtos originais + produtos do usuario + 100 novos.
import io

# ---- classes (1-4 existentes, 5-12 novas) ----
CLASSES = [
    (1, 'NOTEBOOK', 'Computadores portateis'),
    (2, 'ROUPA', 'Vestuario'),
    (3, 'ALIMENTO', 'Produtos alimenticios'),
    (4, 'CAMPING', 'Equipamentos de camping e acampamento'),
    (5, 'ELETRONICO', 'Eletronicos e acessorios'),
    (6, 'LIVRO', 'Livros e publicacoes'),
    (7, 'CALCADO', 'Calcados'),
    (8, 'MOVEL', 'Moveis e decoracao'),
    (9, 'ESPORTE', 'Artigos esportivos'),
    (10, 'BELEZA', 'Beleza e cuidados pessoais'),
    (11, 'FERRAMENTA', 'Ferramentas e construcao'),
    (12, 'PET', 'Produtos para animais de estimacao'),
]

# ---- catalogo: (classe, nome, descricao, preco) ----
P = []
def add(cls, nome, desc, preco):
    P.append((cls, nome, desc, preco))

# NOTEBOOK (6)
add(1,'Notebook Ultrafino 14','Notebook leve e fino de 14 polegadas, processador eficiente e SSD, ideal para trabalho e estudos com longa duracao de bateria.',3299.00)
add(1,'Notebook Gamer 15','Notebook gamer com placa de video dedicada, tela de 144Hz e refrigeracao reforcada para jogos pesados e edicao.',6999.00)
add(1,'Notebook Empresarial 13','Notebook corporativo robusto, leve e seguro, com teclado confortavel para uso profissional no dia a dia.',4199.00)
add(1,'Notebook 2 em 1 Conversivel','Notebook conversivel com tela sensivel ao toque que vira tablet, otimo para anotacoes e apresentacoes.',4899.00)
add(1,'Chromebook Estudante 11','Chromebook economico de 11 polegadas, rapido e simples, ideal para estudos, pesquisa e aulas online.',1899.00)
add(1,'Workstation Movel 16','Notebook workstation de alto desempenho para engenharia, 3D e renderizacao com muita memoria RAM.',11999.00)

# ROUPA (10)
add(2,'Camiseta Basica Branca','Camiseta de algodao branca, leve e respiravel, confortavel para o dia a dia e facil de combinar.',49.90)
add(2,'Calca Jeans Masculina','Calca jeans masculina de corte reto, tecido resistente e confortavel para uso casual.',159.90)
add(2,'Moletom com Capuz','Moletom unissex com capuz e bolso canguru, quentinho para dias frios e passeios.',139.90)
add(2,'Jaqueta Corta-Vento','Jaqueta corta-vento leve e impermeavel, ideal para corrida, trilha e dias de vento.',219.90)
add(2,'Vestido Floral Verao','Vestido floral leve e fresco, perfeito para o verao, praia e ocasioes casuais.',179.90)
add(2,'Bermuda Esportiva','Bermuda esportiva com tecido que seca rapido, confortavel para academia e corrida.',89.90)
add(2,'Camisa Social Slim','Camisa social slim de algodao, elegante para trabalho, reunioes e eventos formais.',129.90)
add(2,'Blusa de Trico Feminina','Blusa de trico macia e quentinha, estilosa para o inverno e climas frios.',149.90)
add(2,'Pijama de Algodao','Pijama de algodao macio e confortavel para uma noite de sono tranquila.',99.90)
add(2,'Meia Esportiva Kit 5','Kit com 5 pares de meias esportivas respiraveis, confortaveis para o dia a dia e exercicios.',59.90)

# ALIMENTO (10)
add(3,'Cafe Torrado em Graos 1kg','Cafe torrado em graos selecionados, aroma intenso e sabor encorpado para a cafeteira.',54.90)
add(3,'Azeite Extra Virgem 500ml','Azeite de oliva extra virgem, acidez baixa, ideal para saladas e finalizacao de pratos.',39.90)
add(3,'Chocolate Amargo 70%','Barra de chocolate amargo 70 por cento cacau, intenso e com menos acucar.',18.90)
add(3,'Mel Puro 500g','Mel puro natural, doce e aromatico, otimo para o cafe da manha e receitas.',32.90)
add(3,'Macarrao Integral 500g','Macarrao integral rico em fibras, pratico e saudavel para o almoco e jantar.',12.90)
add(3,'Castanha de Caju 200g','Castanha de caju torrada e crocante, lanche saudavel rico em nutrientes.',29.90)
add(3,'Suco de Laranja Natural 1L','Suco de laranja natural, refrescante e rico em vitamina C, sem adicao de acucar.',14.90)
add(3,'Arroz Integral 1kg','Arroz integral soltinho e nutritivo, fonte de fibras para refeicoes saudaveis.',11.90)
add(3,'Granola Tradicional 1kg','Granola crocante com cereais, frutas e castanhas, otima para o cafe da manha.',27.90)
add(3,'Cha Verde Caixa 25 Saches','Cha verde natural em saches, refrescante e antioxidante para o dia a dia.',16.90)

# CAMPING (8)
add(4,'Barraca Ultraleve 1 Pessoa','Barraca ultraleve para 1 pessoa, impermeavel e compacta, ideal para mochilao e trilha longa.',219.90)
add(4,'Rede de Dormir Camping','Rede de dormir resistente para camping, leve e facil de montar entre arvores.',119.90)
add(4,'Fogareiro Portatil a Gas','Fogareiro portatil a gas compacto para cozinhar em acampamentos e trilhas.',99.90)
add(4,'Isolante Termico Dobravel','Isolante termico dobravel que protege do frio do chao em acampamentos.',69.90)
add(4,'Cantil Termico 1L','Cantil termico de 1 litro que mantem a agua gelada por horas na trilha.',79.90)
add(4,'Kit Panelas Camping','Kit de panelas leves e antiaderentes para cozinhar ao ar livre com praticidade.',139.90)
add(4,'Canivete Multifuncao','Canivete multifuncao com varias ferramentas, util para camping, pesca e aventura.',89.90)
add(4,'Corda de Escalada 10m','Corda resistente de 10 metros para escalada, trilha e uso em acampamentos.',109.90)

# ELETRONICO (12)
add(5,'Fone de Ouvido Bluetooth','Fone de ouvido sem fio com cancelamento de ruido, bateria longa e som potente.',299.90)
add(5,'Smartwatch Fitness','Relogio inteligente com monitor de batimentos, passos e sono, resistente a agua.',399.90)
add(5,'Caixa de Som Portatil','Caixa de som bluetooth portatil e a prova d agua, grave reforcado para festas.',259.90)
add(5,'Mouse Sem Fio Ergonomico','Mouse sem fio ergonomico e silencioso, preciso para trabalho e estudos.',89.90)
add(5,'Teclado Mecanico RGB','Teclado mecanico com iluminacao RGB, resposta rapida para jogos e digitacao.',349.90)
add(5,'Webcam Full HD','Webcam Full HD com microfone para videochamadas, reunioes e transmissoes.',199.90)
add(5,'Carregador Rapido USB-C','Carregador rapido USB-C compacto, carrega o celular em pouco tempo.',79.90)
add(5,'Power Bank 20000mAh','Bateria portatil de 20000mAh para carregar celular e tablet varias vezes.',159.90)
add(5,'Smart TV 50 4K','Smart TV de 50 polegadas com resolucao 4K, aplicativos de streaming e controle por voz.',2499.00)
add(5,'Roteador Wi-Fi 6','Roteador Wi-Fi 6 de alta velocidade e cobertura ampla para toda a casa.',429.90)
add(5,'Tablet 10 Polegadas','Tablet de 10 polegadas leve, otimo para leitura, videos e navegacao.',1399.00)
add(5,'Microfone USB Podcast','Microfone USB com qualidade de estudio para podcast, gravacao e lives.',329.90)

# LIVRO (8)
add(6,'Livro Ficcao Cientifica','Romance de ficcao cientifica envolvente sobre viagens espaciais e futuro da humanidade.',49.90)
add(6,'Livro de Receitas Saudaveis','Livro com receitas saudaveis e praticas para o dia a dia, com fotos e dicas.',59.90)
add(6,'Guia de Programacao Python','Guia pratico de programacao em Python para iniciantes, com exercicios e projetos.',89.90)
add(6,'Biografia Inspiradora','Biografia inspiradora de um grande empreendedor, cheia de licoes de vida.',44.90)
add(6,'Livro Infantil Ilustrado','Livro infantil ilustrado com historias divertidas para criancas lerem antes de dormir.',34.90)
add(6,'Classico da Literatura','Classico da literatura mundial em edicao especial de capa dura.',69.90)
add(6,'Livro de Autoajuda','Livro de autoajuda sobre produtividade, habitos e desenvolvimento pessoal.',39.90)
add(6,'Atlas Geografico Ilustrado','Atlas geografico ilustrado com mapas detalhados do mundo e curiosidades.',79.90)

# CALCADO (8)
add(7,'Tenis de Corrida','Tenis de corrida leve com amortecimento, confortavel para treinos e maratonas.',299.90)
add(7,'Bota de Trilha Impermeavel','Bota de trilha impermeavel e resistente, com boa aderencia para terrenos dificeis.',349.90)
add(7,'Sapato Social Couro','Sapato social de couro legitimo, elegante para trabalho e eventos formais.',259.90)
add(7,'Sandalia Feminina Verao','Sandalia feminina confortavel e estilosa, perfeita para o verao e passeios.',119.90)
add(7,'Chinelo de Dedo','Chinelo de dedo leve e duravel, ideal para praia, piscina e uso casual.',49.90)
add(7,'Tenis Casual Urbano','Tenis casual urbano versatil que combina com varios looks do dia a dia.',229.90)
add(7,'Chuteira Society','Chuteira society com travas para gramado sintetico, firme e confortavel.',199.90)
add(7,'Sapatilha Feminina','Sapatilha feminina macia e leve, confortavel para o trabalho e passeios.',99.90)

# MOVEL (8)
add(8,'Cadeira de Escritorio Ergonomica','Cadeira de escritorio ergonomica com ajuste de altura e apoio lombar para longas horas.',799.90)
add(8,'Mesa de Escritorio Compacta','Mesa de escritorio compacta e resistente, ideal para home office em espacos pequenos.',499.90)
add(8,'Estante de Livros','Estante de livros com varias prateleiras, organizadora e decorativa para a sala.',399.90)
add(8,'Sofa 2 Lugares','Sofa de 2 lugares confortavel e moderno, revestimento macio para a sala de estar.',1599.00)
add(8,'Luminaria de Mesa LED','Luminaria de mesa LED com ajuste de intensidade, ideal para leitura e estudo.',129.90)
add(8,'Guarda-Roupa 3 Portas','Guarda-roupa de 3 portas espacoso com espelho e varios compartimentos.',1199.00)
add(8,'Cama Box Casal','Cama box casal confortavel com colchao de molas para um sono reparador.',1899.00)
add(8,'Prateleira Decorativa','Prateleira decorativa de parede, pratica para organizar livros e enfeites.',89.90)

# ESPORTE (8)
add(9,'Bola de Futebol Oficial','Bola de futebol oficial costurada, resistente para jogos em campo e quadra.',139.90)
add(9,'Kit Halteres 20kg','Kit de halteres ajustaveis de 20kg para treino de forca em casa.',349.90)
add(9,'Tapete de Yoga','Tapete de yoga antiderrapante e confortavel para exercicios, pilates e alongamento.',119.90)
add(9,'Bicicleta Aro 29','Bicicleta aro 29 com cambio de varias marchas, ideal para trilha e cidade.',2199.00)
add(9,'Corda de Pular Profissional','Corda de pular profissional ajustavel para treino cardio e crossfit.',49.90)
add(9,'Luva de Boxe','Par de luvas de boxe acolchoadas para treino e sparring com protecao.',179.90)
add(9,'Prancha de Stand Up','Prancha de stand up paddle inflavel e estavel para lagos, rios e mar.',1899.00)
add(9,'Mochila Hidratacao 2L','Mochila de hidratacao de 2 litros para ciclismo, corrida e trilha.',159.90)

# BELEZA (8)
add(10,'Perfume Masculino Amadeirado','Perfume masculino amadeirado marcante e duradouro para ocasioes especiais.',249.90)
add(10,'Kit Shampoo e Condicionador','Kit shampoo e condicionador hidratante para cabelos secos e danificados.',79.90)
add(10,'Creme Hidratante Facial','Creme hidratante facial com protecao, deixa a pele macia e saudavel.',89.90)
add(10,'Secador de Cabelo Profissional','Secador de cabelo profissional potente com controle de temperatura.',229.90)
add(10,'Barbeador Eletrico','Barbeador eletrico recarregavel para barba rente e suave sem irritacao.',199.90)
add(10,'Batom Matte Longa Duracao','Batom matte de longa duracao, cor intensa e confortavel nos labios.',39.90)
add(10,'Kit Maquiagem Completo','Kit de maquiagem completo com sombras, base e pinceis para um visual perfeito.',159.90)
add(10,'Protetor Solar FPS 50','Protetor solar FPS 50 resistente a agua, protege a pele do sol no dia a dia.',59.90)

# FERRAMENTA (7)
add(11,'Furadeira de Impacto','Furadeira de impacto potente com velocidade ajustavel para madeira, metal e concreto.',349.90)
add(11,'Jogo de Chaves de Fenda','Jogo de chaves de fenda e philips com varias pontas para reparos em geral.',59.90)
add(11,'Trena Metrica 5m','Trena metrica de 5 metros resistente, trava automatica para medicoes precisas.',29.90)
add(11,'Parafusadeira sem Fio','Parafusadeira sem fio recarregavel, leve e pratica para montagens e reparos.',259.90)
add(11,'Serra Circular','Serra circular potente para cortes precisos em madeira e materiais de construcao.',499.90)
add(11,'Kit Ferramentas 100 Pecas','Kit de ferramentas com 100 pecas em maleta organizadora para casa e oficina.',299.90)
add(11,'Nivel a Laser','Nivel a laser preciso para alinhamento em obras, quadros e instalacoes.',189.90)

# PET (7)
add(12,'Racao Premium Caes 15kg','Racao premium para caes adultos, rica em nutrientes para saude e energia.',179.90)
add(12,'Arranhador para Gatos','Arranhador para gatos com plataformas, diverte e protege os moveis.',139.90)
add(12,'Cama Pet Confortavel','Cama pet macia e confortavel, lavavel, para caes e gatos descansarem.',99.90)
add(12,'Coleira Ajustavel','Coleira ajustavel resistente com guia para passeios seguros com o pet.',49.90)
add(12,'Brinquedo Mordedor','Brinquedo mordedor resistente que diverte o cachorro e ajuda na higiene bucal.',29.90)
add(12,'Comedouro Automatico','Comedouro automatico com temporizador para alimentar o pet na hora certa.',199.90)
add(12,'Shampoo para Pets','Shampoo suave para pets, limpa e perfuma sem irritar a pele do animal.',39.90)

assert len(P) == 100, f"esperado 100, gerado {len(P)}"

out = io.StringIO()
w = out.write

w("""-- ============================================================
-- Seed com catalogo ampliado (100+ produtos). Descricoes ricas.
-- GERADO por scripts/gen_seed.py
-- ============================================================

-- Clientes
INSERT INTO cliente (nome, email) VALUES
  ('Ana Souza',    'ana@exemplo.com'),
  ('Bruno Lima',   'bruno@exemplo.com'),
  ('Carla Dias',   'carla@exemplo.com');

-- Classes de produto
INSERT INTO classe_produto (id_classe, codigo, descricao) OVERRIDING SYSTEM VALUE VALUES
""")
w(",\n".join(f"  ({c}, '{cod}', '{d}')" for c, cod, d in CLASSES) + ";\n\n")

w("""-- Caracteristicas
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

""")

# Produtos: originais + usuario + gerados
originais = [
    "  (101, 'Notebook Pro', 'Notebook profissional de alto desempenho com processador Intel Core i7, 16 GB de memoria RAM e SSD rapido. Tela de 15,6 polegadas, leve e portatil, ideal para trabalho, programacao, edicao de video, design grafico e uso profissional intenso.', 1, 4500.00),",
    "  (102, 'Notebook Basico', 'Notebook de entrada com processador Intel Core i5 e 8 GB de memoria RAM. Leve, economico e silencioso, indicado para estudos, navegacao na internet, tarefas do dia a dia, home office e uso domestico.', 1, 2800.00),",
    "  (201, 'Camiseta Azul', 'Camiseta masculina de algodao na cor azul, tamanho M, tecido leve, macio e respiravel. Roupa casual e confortavel para o dia a dia, passeios e clima quente.', 2, 79.90),",
    "  (301, 'Suco de Uva', 'Suco integral de uva natural, garrafa de 1 litro, sem adicao de acucar. Bebida saudavel e refrescante, rica em antioxidantes, otima para o cafe da manha, lanches e para toda a familia.', 3, 12.50),",
    "  (302, 'Barraca Camping 4 pessoas', 'Barraca de camping para 4 pessoas, impermeavel e resistente a chuva e vento. Espacosa e facil de montar, ideal para acampamento em familia, trilhas, viagens, pescaria e atividades ao ar livre na natureza.', 4, 349.90),",
    "  (303, 'Barraca Iglu 2 pessoas', 'Barraca iglu compacta para 2 pessoas, leve e impermeavel, com montagem rapida. Perfeita para camping, trilha, mochilao, aventura e acampamentos ao ar livre em qualquer estacao.', 4, 289.90),",
    "  (304, 'Saco de Dormir Termico', 'Saco de dormir termico e compacto para temperaturas baixas, com forro macio e resistente ao frio. Ideal para camping, trilha, acampamento na montanha e aventuras ao ar livre.', 4, 159.90),",
    "  (305, 'Lanterna de Cabeca LED', 'Lanterna de cabeca com LED de alto brilho, a prova d agua e com bateria recarregavel. Pratica para camping, trilha noturna, pescaria, acampamento e atividades ao ar livre.', 4, 89.90),",
]

with open('/tmp/user_products.sql', 'r', encoding='utf-8') as f:
    user_block = f.read().strip()

gerados = []
for i, (cls, nome, desc, preco) in enumerate(P):
    pid = 1001 + i
    gerados.append(f"  ({pid}, '{nome}', '{desc}', {cls}, {preco:.2f}),")

w("-- Produtos (originais + adicionados pelo usuario + 100 gerados)\n")
w("INSERT INTO produto (id_produto, nome, descricao, id_classe, preco) OVERRIDING SYSTEM VALUE VALUES\n")
corpo = "\n".join(originais) + "\n" + user_block + "\n" + "\n".join(gerados)
corpo = corpo.rstrip()
if corpo.endswith(','):
    corpo = corpo[:-1]
w(corpo + ";\n\n")

w("""-- Valores das caracteristicas (apenas dos produtos originais com EAV)
INSERT INTO valor_caracteristica (id_produto, id_caracteristica, valor) VALUES
  (101, 1, '15,6 polegadas'), (101, 2, 'Intel Core i7'), (101, 3, '16'),
  (102, 1, '14 polegadas'),   (102, 2, 'Intel Core i5'), (102, 3, '8'),
  (201, 1, 'M'), (201, 4, 'Algodao'), (201, 6, 'Azul'),
  (301, 5, '2027-01-15');

-- Estoque: originais + backfill para todos os demais produtos
INSERT INTO estoque (id_produto, qtd_disponivel) VALUES
  (101, 10), (102, 25), (201, 100), (301, 1), (302, 15), (303, 20), (304, 30), (305, 40);
INSERT INTO estoque (id_produto, qtd_disponivel)
  SELECT id_produto, 50 FROM produto
  WHERE id_produto NOT IN (SELECT id_produto FROM estoque);

-- Ajusta as sequencias apos inserts com id explicito
SELECT setval('classe_produto_id_classe_seq', (SELECT MAX(id_classe) FROM classe_produto));
SELECT setval('caracteristica_id_caracteristica_seq', (SELECT MAX(id_caracteristica) FROM caracteristica));
SELECT setval('produto_id_produto_seq', (SELECT MAX(id_produto) FROM produto));
""")

import sys
sys.stdout.write(out.getvalue())
