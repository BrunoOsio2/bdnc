import { BaseService } from '../../database/BaseService';
import { Database } from '../../database/Database';
import { gerarEmbedding, toVectorLiteral, tokenizar, EMBEDDING_MODELO, EMBEDDING_DIM } from '../../utils/embedding';

/**
 * ProdutoService - catalogo (EAV) + vetorizacao (pgvector).
 */
export class ProdutoService extends BaseService {
  constructor(banco: Database) {
    super(banco);
  }

  /** Lista as classes de produto (para o formulario de cadastro) */
  async getClasses(): Promise<void> {
    const r = await this.conexao.query(
      'SELECT id_classe, codigo, descricao FROM classe_produto ORDER BY id_classe'
    );
    this.banco.setDados(r.rows.length, r.rows);
  }

  /** Lista todos os produtos (indica se ja possuem embedding) */
  async getProdutos(): Promise<void> {
    const sql = `
      SELECT p.id_produto, p.nome, p.descricao, p.preco, p.ativo,
             c.codigo AS classe,
             (e.id_produto IS NOT NULL) AS vetorizado
      FROM produto p
      JOIN classe_produto c ON c.id_classe = p.id_classe
      LEFT JOIN produto_embedding e ON e.id_produto = p.id_produto
      ORDER BY p.id_produto
    `;
    const result = await this.conexao.query(sql);
    this.banco.setDados(result.rows.length, result.rows);
  }

  /** Busca um produto com caracteristicas (EAV) + status do embedding */
  async getProduto(id_produto: number): Promise<void> {
    const sqlProduto = `
      SELECT p.id_produto, p.nome, p.descricao, p.preco, p.ativo,
             c.codigo AS classe,
             e.modelo AS embedding_modelo, e.atualizado_em AS embedding_em
      FROM produto p
      JOIN classe_produto c ON c.id_classe = p.id_classe
      LEFT JOIN produto_embedding e ON e.id_produto = p.id_produto
      WHERE p.id_produto = $1
    `;
    const prod = await this.conexao.query(sqlProduto, [id_produto]);

    if (prod.rows.length === 0) {
      this.banco.setMensagem(1, 'Produto nao encontrado');
      this.banco.setDados(0, []);
      return;
    }

    const sqlCarac = `
      SELECT ca.codigo, ca.tipo_dado, vc.valor
      FROM valor_caracteristica vc
      JOIN caracteristica ca ON ca.id_caracteristica = vc.id_caracteristica
      WHERE vc.id_produto = $1
      ORDER BY ca.codigo
    `;
    const carac = await this.conexao.query(sqlCarac, [id_produto]);

    const row = prod.rows[0];
    const produto = {
      id_produto: row.id_produto,
      nome: row.nome,
      descricao: row.descricao,
      preco: row.preco,
      ativo: row.ativo,
      classe: row.classe,
      caracteristicas: carac.rows,
      vetorizacao: row.embedding_modelo
        ? { modelo: row.embedding_modelo, dimensoes: EMBEDDING_DIM, atualizado_em: row.embedding_em }
        : null,
    };
    this.banco.setDados(1, produto);
  }

  /**
   * Cria um produto e PROPAGA para o banco vetorial (operacao 1).
   * A vetorizacao e feita a partir dos dados oficiais (nome + descricao).
   */
  async createProduto(dados: {
    nome: string;
    descricao?: string | null;
    id_classe: number;
    preco: number;
  }): Promise<void> {
    const sql = `
      INSERT INTO produto (nome, descricao, id_classe, preco)
      VALUES ($1, $2, $3, $4)
      RETURNING id_produto
    `;
    const result = await this.conexao.query(sql, [
      dados.nome,
      dados.descricao || null,
      dados.id_classe,
      dados.preco,
    ]);
    const id_produto = result.rows[0].id_produto;

    // Propagacao -> banco vetorial
    await this.vetorizarProduto(id_produto);

    this.banco.setDados(1, {
      id_produto,
      Mensagem: 'Produto criado e vetorizado com sucesso',
      vetorizacao: { modelo: EMBEDDING_MODELO, dimensoes: EMBEDDING_DIM },
    });
  }

  /**
   * (Re)vetoriza um produto: le os dados oficiais, gera o embedding e faz
   * upsert em produto_embedding. Usado no cadastro e quando o produto muda.
   */
  async vetorizarProduto(id_produto: number): Promise<void> {
    const r = await this.conexao.query(
      `SELECT nome, coalesce(descricao,'') AS descricao FROM produto WHERE id_produto = $1`,
      [id_produto]
    );
    if (r.rows.length === 0) throw new Error('Produto nao encontrado para vetorizar');

    const texto = `${r.rows[0].nome} ${r.rows[0].descricao}`;
    const embedding = await gerarEmbedding(texto);

    await this.conexao.query(
      `
      INSERT INTO produto_embedding (id_produto, embedding, modelo, atualizado_em)
      VALUES ($1, $2::vector, $3, now())
      ON CONFLICT (id_produto)
      DO UPDATE SET embedding = EXCLUDED.embedding,
                    modelo = EXCLUDED.modelo,
                    atualizado_em = now()
      `,
      [id_produto, toVectorLiteral(embedding), EMBEDDING_MODELO]
    );
  }

  /** Vetoriza todos os produtos que ainda nao possuem embedding (ou todos) */
  async vetorizarTodos(): Promise<void> {
    const r = await this.conexao.query(`SELECT id_produto FROM produto ORDER BY id_produto`);
    for (const row of r.rows) {
      await this.vetorizarProduto(row.id_produto);
    }
    this.banco.setDados(r.rows.length, {
      Mensagem: `${r.rows.length} produto(s) vetorizado(s)`,
      modelo: EMBEDDING_MODELO,
      dimensoes: EMBEDDING_DIM,
    });
  }

  /**
   * Busca HIBRIDA: combina score semantico (pgvector) com score lexico
   * (match de substring dos termos no nome/descricao, com peso maior no nome).
   *   score = 0.6 * semantico + 0.4 * lexico
   *   lexico = 0.7 * (termos no nome) + 0.3 * (termos no nome+descricao)
   */
  async buscarSimilares(texto: string, limite: number): Promise<void> {
    const embedding = await gerarEmbedding(texto);
    const literal = toVectorLiteral(embedding);
    const termos = tokenizar(texto); // minusculo, sem acento, sem stopwords

    const sql = `
      SELECT q.id_produto, q.nome, q.descricao, q.preco, q.classe,
             round(q.semantica::numeric, 4) AS semantica,
             round(q.lexico::numeric, 4)    AS lexico,
             round((0.6 * q.semantica + 0.4 * q.lexico)::numeric, 4) AS score
      FROM (
        SELECT p.id_produto, p.nome, p.descricao, p.preco, c.codigo AS classe,
               (1 - (e.embedding <=> $1::vector)) AS semantica,
               COALESCE(
                 0.7 * (SELECT count(*) FROM unnest($2::text[]) AS t(termo)
                          WHERE unaccent(lower(p.nome)) LIKE '%' || t.termo || '%')::float
                       / NULLIF(array_length($2::text[], 1), 0)
               + 0.3 * (SELECT count(*) FROM unnest($2::text[]) AS t(termo)
                          WHERE unaccent(lower(p.nome || ' ' || coalesce(p.descricao, ''))) LIKE '%' || t.termo || '%')::float
                       / NULLIF(array_length($2::text[], 1), 0)
               , 0) AS lexico
        FROM produto_embedding e
        JOIN produto p        ON p.id_produto = e.id_produto
        JOIN classe_produto c ON c.id_classe = p.id_classe
      ) q
      ORDER BY score DESC
      LIMIT $3
    `;
    const result = await this.conexao.query(sql, [literal, termos, limite]);
    this.banco.setDados(result.rows.length, result.rows);
  }
}
