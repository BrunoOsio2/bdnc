-- ============================================================
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
  (12, 'PET', 'Produtos para animais de estimacao');

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

-- Produtos (originais + adicionados pelo usuario + 100 gerados)
INSERT INTO produto (id_produto, nome, descricao, id_classe, preco) OVERRIDING SYSTEM VALUE VALUES
  (101, 'Notebook Pro', 'Notebook profissional de alto desempenho com processador Intel Core i7, 16 GB de memoria RAM e SSD rapido. Tela de 15,6 polegadas, leve e portatil, ideal para trabalho, programacao, edicao de video, design grafico e uso profissional intenso.', 1, 4500.00),
  (102, 'Notebook Basico', 'Notebook de entrada com processador Intel Core i5 e 8 GB de memoria RAM. Leve, economico e silencioso, indicado para estudos, navegacao na internet, tarefas do dia a dia, home office e uso domestico.', 1, 2800.00),
  (201, 'Camiseta Azul', 'Camiseta masculina de algodao na cor azul, tamanho M, tecido leve, macio e respiravel. Roupa casual e confortavel para o dia a dia, passeios e clima quente.', 2, 79.90),
  (301, 'Suco de Uva', 'Suco integral de uva natural, garrafa de 1 litro, sem adicao de acucar. Bebida saudavel e refrescante, rica em antioxidantes, otima para o cafe da manha, lanches e para toda a familia.', 3, 12.50),
  (302, 'Barraca Camping 4 pessoas', 'Barraca de camping para 4 pessoas, impermeavel e resistente a chuva e vento. Espacosa e facil de montar, ideal para acampamento em familia, trilhas, viagens, pescaria e atividades ao ar livre na natureza.', 4, 349.90),
  (303, 'Barraca Iglu 2 pessoas', 'Barraca iglu compacta para 2 pessoas, leve e impermeavel, com montagem rapida. Perfeita para camping, trilha, mochilao, aventura e acampamentos ao ar livre em qualquer estacao.', 4, 289.90),
  (304, 'Saco de Dormir Termico', 'Saco de dormir termico e compacto para temperaturas baixas, com forro macio e resistente ao frio. Ideal para camping, trilha, acampamento na montanha e aventuras ao ar livre.', 4, 159.90),
  (305, 'Lanterna de Cabeca LED', 'Lanterna de cabeca com LED de alto brilho, a prova d agua e com bateria recarregavel. Pratica para camping, trilha noturna, pescaria, acampamento e atividades ao ar livre.', 4, 89.90),
(306, 'Mochila de Trilha 40L', 'Mochila impermeavel de 40 litros para trilha, camping e viagens ao ar livre', 4, 259.90),
  (307, 'Chevrolet Opala Diplomata/diplom. SLE 4.1/2.5 1990', 'Opala 4.1 Diplomata se 6cc 1990
Manual
Completo 
Ar Gelando 
Vidros elétricos
Trava elétrica 
Placa preta 
Pneus novos 
Todo Revisado 
comando 250s cabeçote trabalhado, todos os dutos polidos.
Diferencial Dana 30 blocado 
Interna original, lataria original.
Lanternas e faróis Cibie', 3, 69000.00),
  (308, 'Chevrolet Opala L/sl/ss/ 2.5/4.1 1970', 'Trabalhamos com veículos selecionados, com procedência garantida e padrão premium de qualidade.
Todos os carros passam por avaliação criteriosa, oferecendo segurança, transparência e excelente custo-benefício.

Na Autocar Premium você encontra seminovos e 0 km com atendimento especializado e suporte completo em todas as etapas da compra.

Consulte disponibilidade e condições. 

 Demais opcionais: 

Completo


 Publicado pelo Autos 360, o integrador oficial do Grupo OLX. Referência: 4649413', 3, 100000.00),
  (309, 'Fiat Palio Attractive 1.0 EVO Fire Flex 8V 5P 2015', 'FIAT PALIO ATTRACTIVE 2015 ? COMPLETO

Uma excelente opção para quem procura um carro econômico, confiável, completo e com baixo custo de manutenção.

O Palio Attractive é conhecido pela mecânica simples e confiável, facilidade de manutenção e excelente disponibilidade de peças. Um carro ideal para o dia a dia, primeiro veículo ou para quem quer economizar sem abrir mão do conforto.

Principais diferenciais:

* Motor 1.0 Flex econômico;
* Câmbio manual;
* Ar-condicionado;
* Direção hidráulica;
* Vidros e travas elétricas;
* Som/central multimídia;
* Rodas de liga leve;
* Excelente espaço interno para a categoria;
* Mecânica Fiat de manutenção acessível;
* Ótima aceitação e facilidade de revenda.

FESTIVAL DE OFERTAS SAMAMBAIA

Neste final de semana, a Auto Fé Multimarcas é loja participante do Festival de Ofertas Samambaia, em parceria com Santander e Webmotors.

Condições especiais para você aproveitar:

Taxas especiais de financiamento
Primeira parcela para 60 dias
Revisão grátis
Tanque cheio na entrega

Uma oportunidade para comprar seu carro com condições diferenciadas e ainda sair da loja com tudo pronto para rodar.

ONIX LTZ TURBO 2022 - MANUAL

BLACK NOVEMBER AUTO FÉ MULTIMARCAS

Veículo extremamente diferenciado e conservado, não há detalhe.
Segurança e procedência acima da média. 
Motor 1.0 Turbo econômico e forte, excelente consumo, muito confortável no dia a dia, tecnologia e conectividade, um dos hatchs mais procurados do Brasil
Turbo que anda muito e bebe pouco.

Mais tranquilidade na compra, egurança mecânica, revisões feitas corretamente, histórico comprovado em concessionária. 
Comprar um carro com garantia até 2032 faz toda diferença.

Tecnologia e conforto
Multimídia moderna, interior sofisticado, excelente dirigibilidade, muito confortável para cidade e estrada com direção elétrica e ar gelando bem. 
Carro moderno e muito acima dos populares básicos.

Economia no dia a dia
Excelente consumo, baixo custo de manutenção troca de óleo R$ 600,00 na concessionária para manter garanti, Ideal para quem roda muito
Mais economia e menos preocupação.

Garantia até 2032 é raridade
Primeiro que ver pessoalmente entende a diferença, veículo acima da média de conservação. 

CHEGOU A BLACK NOVEMBER AUTO FÉ!

Na Auto Fé Multimarcas você encontra veículos ABAIXO DO VALOR DE MERCADO, com qualidade, procedência e a confiança de uma empresa nota máxima nas avaliações dos clientes no Google!

E TEM MAIS VANTAGENS:

* Veículos com preços imperdíveis;
* Taxas especiais a partir de 1,39% ao mês;
* Crédito facilitado;
* TANQUE CHEIO GRÁTIS!
* TROCA DE ÓLEO GRÁTIS!

FACILIDADE PARA SUA CONQUISTA

* Trabalhamos com 12 instituições financeiras;
* Financiamento em até 60x;
* Aceitamos carro ou moto na troca;
* Entrada parcelada em até 21x no cartão de crédito, conforme condições.

Taxas e aprovação sujeitas à análise de crédito e às condições das instituições financeiras.

NÃO PERCA ESSA OPORTUNIDADE!

(61)... ver número
(61)... ver número

AUTO FÉ MULTIMARCAS
QI 616, Conjunto D, Lote 5 - Samambaia Norte/DF
Próximo ao Hospital Regional de Samambaia (HRSAM).

BLACK NOVEMBER AUTO FÉ ? seu próximo carro com preço especial, qualidade e confiança!', 3, 39000.00),
  (1001, 'Notebook Ultrafino 14', 'Notebook leve e fino de 14 polegadas, processador eficiente e SSD, ideal para trabalho e estudos com longa duracao de bateria.', 1, 3299.00),
  (1002, 'Notebook Gamer 15', 'Notebook gamer com placa de video dedicada, tela de 144Hz e refrigeracao reforcada para jogos pesados e edicao.', 1, 6999.00),
  (1003, 'Notebook Empresarial 13', 'Notebook corporativo robusto, leve e seguro, com teclado confortavel para uso profissional no dia a dia.', 1, 4199.00),
  (1004, 'Notebook 2 em 1 Conversivel', 'Notebook conversivel com tela sensivel ao toque que vira tablet, otimo para anotacoes e apresentacoes.', 1, 4899.00),
  (1005, 'Chromebook Estudante 11', 'Chromebook economico de 11 polegadas, rapido e simples, ideal para estudos, pesquisa e aulas online.', 1, 1899.00),
  (1006, 'Workstation Movel 16', 'Notebook workstation de alto desempenho para engenharia, 3D e renderizacao com muita memoria RAM.', 1, 11999.00),
  (1007, 'Camiseta Basica Branca', 'Camiseta de algodao branca, leve e respiravel, confortavel para o dia a dia e facil de combinar.', 2, 49.90),
  (1008, 'Calca Jeans Masculina', 'Calca jeans masculina de corte reto, tecido resistente e confortavel para uso casual.', 2, 159.90),
  (1009, 'Moletom com Capuz', 'Moletom unissex com capuz e bolso canguru, quentinho para dias frios e passeios.', 2, 139.90),
  (1010, 'Jaqueta Corta-Vento', 'Jaqueta corta-vento leve e impermeavel, ideal para corrida, trilha e dias de vento.', 2, 219.90),
  (1011, 'Vestido Floral Verao', 'Vestido floral leve e fresco, perfeito para o verao, praia e ocasioes casuais.', 2, 179.90),
  (1012, 'Bermuda Esportiva', 'Bermuda esportiva com tecido que seca rapido, confortavel para academia e corrida.', 2, 89.90),
  (1013, 'Camisa Social Slim', 'Camisa social slim de algodao, elegante para trabalho, reunioes e eventos formais.', 2, 129.90),
  (1014, 'Blusa de Trico Feminina', 'Blusa de trico macia e quentinha, estilosa para o inverno e climas frios.', 2, 149.90),
  (1015, 'Pijama de Algodao', 'Pijama de algodao macio e confortavel para uma noite de sono tranquila.', 2, 99.90),
  (1016, 'Meia Esportiva Kit 5', 'Kit com 5 pares de meias esportivas respiraveis, confortaveis para o dia a dia e exercicios.', 2, 59.90),
  (1017, 'Cafe Torrado em Graos 1kg', 'Cafe torrado em graos selecionados, aroma intenso e sabor encorpado para a cafeteira.', 3, 54.90),
  (1018, 'Azeite Extra Virgem 500ml', 'Azeite de oliva extra virgem, acidez baixa, ideal para saladas e finalizacao de pratos.', 3, 39.90),
  (1019, 'Chocolate Amargo 70%', 'Barra de chocolate amargo 70 por cento cacau, intenso e com menos acucar.', 3, 18.90),
  (1020, 'Mel Puro 500g', 'Mel puro natural, doce e aromatico, otimo para o cafe da manha e receitas.', 3, 32.90),
  (1021, 'Macarrao Integral 500g', 'Macarrao integral rico em fibras, pratico e saudavel para o almoco e jantar.', 3, 12.90),
  (1022, 'Castanha de Caju 200g', 'Castanha de caju torrada e crocante, lanche saudavel rico em nutrientes.', 3, 29.90),
  (1023, 'Suco de Laranja Natural 1L', 'Suco de laranja natural, refrescante e rico em vitamina C, sem adicao de acucar.', 3, 14.90),
  (1024, 'Arroz Integral 1kg', 'Arroz integral soltinho e nutritivo, fonte de fibras para refeicoes saudaveis.', 3, 11.90),
  (1025, 'Granola Tradicional 1kg', 'Granola crocante com cereais, frutas e castanhas, otima para o cafe da manha.', 3, 27.90),
  (1026, 'Cha Verde Caixa 25 Saches', 'Cha verde natural em saches, refrescante e antioxidante para o dia a dia.', 3, 16.90),
  (1027, 'Barraca Ultraleve 1 Pessoa', 'Barraca ultraleve para 1 pessoa, impermeavel e compacta, ideal para mochilao e trilha longa.', 4, 219.90),
  (1028, 'Rede de Dormir Camping', 'Rede de dormir resistente para camping, leve e facil de montar entre arvores.', 4, 119.90),
  (1029, 'Fogareiro Portatil a Gas', 'Fogareiro portatil a gas compacto para cozinhar em acampamentos e trilhas.', 4, 99.90),
  (1030, 'Isolante Termico Dobravel', 'Isolante termico dobravel que protege do frio do chao em acampamentos.', 4, 69.90),
  (1031, 'Cantil Termico 1L', 'Cantil termico de 1 litro que mantem a agua gelada por horas na trilha.', 4, 79.90),
  (1032, 'Kit Panelas Camping', 'Kit de panelas leves e antiaderentes para cozinhar ao ar livre com praticidade.', 4, 139.90),
  (1033, 'Canivete Multifuncao', 'Canivete multifuncao com varias ferramentas, util para camping, pesca e aventura.', 4, 89.90),
  (1034, 'Corda de Escalada 10m', 'Corda resistente de 10 metros para escalada, trilha e uso em acampamentos.', 4, 109.90),
  (1035, 'Fone de Ouvido Bluetooth', 'Fone de ouvido sem fio com cancelamento de ruido, bateria longa e som potente.', 5, 299.90),
  (1036, 'Smartwatch Fitness', 'Relogio inteligente com monitor de batimentos, passos e sono, resistente a agua.', 5, 399.90),
  (1037, 'Caixa de Som Portatil', 'Caixa de som bluetooth portatil e a prova d agua, grave reforcado para festas.', 5, 259.90),
  (1038, 'Mouse Sem Fio Ergonomico', 'Mouse sem fio ergonomico e silencioso, preciso para trabalho e estudos.', 5, 89.90),
  (1039, 'Teclado Mecanico RGB', 'Teclado mecanico com iluminacao RGB, resposta rapida para jogos e digitacao.', 5, 349.90),
  (1040, 'Webcam Full HD', 'Webcam Full HD com microfone para videochamadas, reunioes e transmissoes.', 5, 199.90),
  (1041, 'Carregador Rapido USB-C', 'Carregador rapido USB-C compacto, carrega o celular em pouco tempo.', 5, 79.90),
  (1042, 'Power Bank 20000mAh', 'Bateria portatil de 20000mAh para carregar celular e tablet varias vezes.', 5, 159.90),
  (1043, 'Smart TV 50 4K', 'Smart TV de 50 polegadas com resolucao 4K, aplicativos de streaming e controle por voz.', 5, 2499.00),
  (1044, 'Roteador Wi-Fi 6', 'Roteador Wi-Fi 6 de alta velocidade e cobertura ampla para toda a casa.', 5, 429.90),
  (1045, 'Tablet 10 Polegadas', 'Tablet de 10 polegadas leve, otimo para leitura, videos e navegacao.', 5, 1399.00),
  (1046, 'Microfone USB Podcast', 'Microfone USB com qualidade de estudio para podcast, gravacao e lives.', 5, 329.90),
  (1047, 'Livro Ficcao Cientifica', 'Romance de ficcao cientifica envolvente sobre viagens espaciais e futuro da humanidade.', 6, 49.90),
  (1048, 'Livro de Receitas Saudaveis', 'Livro com receitas saudaveis e praticas para o dia a dia, com fotos e dicas.', 6, 59.90),
  (1049, 'Guia de Programacao Python', 'Guia pratico de programacao em Python para iniciantes, com exercicios e projetos.', 6, 89.90),
  (1050, 'Biografia Inspiradora', 'Biografia inspiradora de um grande empreendedor, cheia de licoes de vida.', 6, 44.90),
  (1051, 'Livro Infantil Ilustrado', 'Livro infantil ilustrado com historias divertidas para criancas lerem antes de dormir.', 6, 34.90),
  (1052, 'Classico da Literatura', 'Classico da literatura mundial em edicao especial de capa dura.', 6, 69.90),
  (1053, 'Livro de Autoajuda', 'Livro de autoajuda sobre produtividade, habitos e desenvolvimento pessoal.', 6, 39.90),
  (1054, 'Atlas Geografico Ilustrado', 'Atlas geografico ilustrado com mapas detalhados do mundo e curiosidades.', 6, 79.90),
  (1055, 'Tenis de Corrida', 'Tenis de corrida leve com amortecimento, confortavel para treinos e maratonas.', 7, 299.90),
  (1056, 'Bota de Trilha Impermeavel', 'Bota de trilha impermeavel e resistente, com boa aderencia para terrenos dificeis.', 7, 349.90),
  (1057, 'Sapato Social Couro', 'Sapato social de couro legitimo, elegante para trabalho e eventos formais.', 7, 259.90),
  (1058, 'Sandalia Feminina Verao', 'Sandalia feminina confortavel e estilosa, perfeita para o verao e passeios.', 7, 119.90),
  (1059, 'Chinelo de Dedo', 'Chinelo de dedo leve e duravel, ideal para praia, piscina e uso casual.', 7, 49.90),
  (1060, 'Tenis Casual Urbano', 'Tenis casual urbano versatil que combina com varios looks do dia a dia.', 7, 229.90),
  (1061, 'Chuteira Society', 'Chuteira society com travas para gramado sintetico, firme e confortavel.', 7, 199.90),
  (1062, 'Sapatilha Feminina', 'Sapatilha feminina macia e leve, confortavel para o trabalho e passeios.', 7, 99.90),
  (1063, 'Cadeira de Escritorio Ergonomica', 'Cadeira de escritorio ergonomica com ajuste de altura e apoio lombar para longas horas.', 8, 799.90),
  (1064, 'Mesa de Escritorio Compacta', 'Mesa de escritorio compacta e resistente, ideal para home office em espacos pequenos.', 8, 499.90),
  (1065, 'Estante de Livros', 'Estante de livros com varias prateleiras, organizadora e decorativa para a sala.', 8, 399.90),
  (1066, 'Sofa 2 Lugares', 'Sofa de 2 lugares confortavel e moderno, revestimento macio para a sala de estar.', 8, 1599.00),
  (1067, 'Luminaria de Mesa LED', 'Luminaria de mesa LED com ajuste de intensidade, ideal para leitura e estudo.', 8, 129.90),
  (1068, 'Guarda-Roupa 3 Portas', 'Guarda-roupa de 3 portas espacoso com espelho e varios compartimentos.', 8, 1199.00),
  (1069, 'Cama Box Casal', 'Cama box casal confortavel com colchao de molas para um sono reparador.', 8, 1899.00),
  (1070, 'Prateleira Decorativa', 'Prateleira decorativa de parede, pratica para organizar livros e enfeites.', 8, 89.90),
  (1071, 'Bola de Futebol Oficial', 'Bola de futebol oficial costurada, resistente para jogos em campo e quadra.', 9, 139.90),
  (1072, 'Kit Halteres 20kg', 'Kit de halteres ajustaveis de 20kg para treino de forca em casa.', 9, 349.90),
  (1073, 'Tapete de Yoga', 'Tapete de yoga antiderrapante e confortavel para exercicios, pilates e alongamento.', 9, 119.90),
  (1074, 'Bicicleta Aro 29', 'Bicicleta aro 29 com cambio de varias marchas, ideal para trilha e cidade.', 9, 2199.00),
  (1075, 'Corda de Pular Profissional', 'Corda de pular profissional ajustavel para treino cardio e crossfit.', 9, 49.90),
  (1076, 'Luva de Boxe', 'Par de luvas de boxe acolchoadas para treino e sparring com protecao.', 9, 179.90),
  (1077, 'Prancha de Stand Up', 'Prancha de stand up paddle inflavel e estavel para lagos, rios e mar.', 9, 1899.00),
  (1078, 'Mochila Hidratacao 2L', 'Mochila de hidratacao de 2 litros para ciclismo, corrida e trilha.', 9, 159.90),
  (1079, 'Perfume Masculino Amadeirado', 'Perfume masculino amadeirado marcante e duradouro para ocasioes especiais.', 10, 249.90),
  (1080, 'Kit Shampoo e Condicionador', 'Kit shampoo e condicionador hidratante para cabelos secos e danificados.', 10, 79.90),
  (1081, 'Creme Hidratante Facial', 'Creme hidratante facial com protecao, deixa a pele macia e saudavel.', 10, 89.90),
  (1082, 'Secador de Cabelo Profissional', 'Secador de cabelo profissional potente com controle de temperatura.', 10, 229.90),
  (1083, 'Barbeador Eletrico', 'Barbeador eletrico recarregavel para barba rente e suave sem irritacao.', 10, 199.90),
  (1084, 'Batom Matte Longa Duracao', 'Batom matte de longa duracao, cor intensa e confortavel nos labios.', 10, 39.90),
  (1085, 'Kit Maquiagem Completo', 'Kit de maquiagem completo com sombras, base e pinceis para um visual perfeito.', 10, 159.90),
  (1086, 'Protetor Solar FPS 50', 'Protetor solar FPS 50 resistente a agua, protege a pele do sol no dia a dia.', 10, 59.90),
  (1087, 'Furadeira de Impacto', 'Furadeira de impacto potente com velocidade ajustavel para madeira, metal e concreto.', 11, 349.90),
  (1088, 'Jogo de Chaves de Fenda', 'Jogo de chaves de fenda e philips com varias pontas para reparos em geral.', 11, 59.90),
  (1089, 'Trena Metrica 5m', 'Trena metrica de 5 metros resistente, trava automatica para medicoes precisas.', 11, 29.90),
  (1090, 'Parafusadeira sem Fio', 'Parafusadeira sem fio recarregavel, leve e pratica para montagens e reparos.', 11, 259.90),
  (1091, 'Serra Circular', 'Serra circular potente para cortes precisos em madeira e materiais de construcao.', 11, 499.90),
  (1092, 'Kit Ferramentas 100 Pecas', 'Kit de ferramentas com 100 pecas em maleta organizadora para casa e oficina.', 11, 299.90),
  (1093, 'Nivel a Laser', 'Nivel a laser preciso para alinhamento em obras, quadros e instalacoes.', 11, 189.90),
  (1094, 'Racao Premium Caes 15kg', 'Racao premium para caes adultos, rica em nutrientes para saude e energia.', 12, 179.90),
  (1095, 'Arranhador para Gatos', 'Arranhador para gatos com plataformas, diverte e protege os moveis.', 12, 139.90),
  (1096, 'Cama Pet Confortavel', 'Cama pet macia e confortavel, lavavel, para caes e gatos descansarem.', 12, 99.90),
  (1097, 'Coleira Ajustavel', 'Coleira ajustavel resistente com guia para passeios seguros com o pet.', 12, 49.90),
  (1098, 'Brinquedo Mordedor', 'Brinquedo mordedor resistente que diverte o cachorro e ajuda na higiene bucal.', 12, 29.90),
  (1099, 'Comedouro Automatico', 'Comedouro automatico com temporizador para alimentar o pet na hora certa.', 12, 199.90),
  (1100, 'Shampoo para Pets', 'Shampoo suave para pets, limpa e perfuma sem irritar a pele do animal.', 12, 39.90);

-- Valores das caracteristicas (apenas dos produtos originais com EAV)
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
