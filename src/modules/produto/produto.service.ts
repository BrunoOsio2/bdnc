import { BaseService } from '../../database/BaseService';
import { Database } from '../../database/Database';

/**
 * ProdutoService - acesso ao catalogo (EAV).
 */
export class ProdutoService extends BaseService {
  constructor(banco: Database) {
    super(banco);
  }

  /** Lista todos os produtos */
  async getProdutos(): Promise<void> {
    const sql = `
      SELECT p.id_produto, p.nome, p.descricao, p.preco, p.ativo,
             c.codigo AS classe
      FROM produto p
      JOIN classe_produto c ON c.id_classe = p.id_classe
      ORDER BY p.id_produto
    `;
    const result = await this.conexao.query(sql);
    this.banco.setDados(result.rows.length, result.rows);
  }

  /** Busca um produto com suas caracteristicas (EAV montado) */
  async getProduto(id_produto: number): Promise<void> {
    const sqlProduto = `
      SELECT p.id_produto, p.nome, p.descricao, p.preco, p.ativo,
             c.codigo AS classe
      FROM produto p
      JOIN classe_produto c ON c.id_classe = p.id_classe
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

    const produto = { ...prod.rows[0], caracteristicas: carac.rows };
    this.banco.setDados(1, produto);
  }

  /** Cria um produto simples (sem caracteristicas) */
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
    this.banco.setDados(1, {
      id_produto: result.rows[0].id_produto,
      Mensagem: 'Produto criado com sucesso',
    });
  }
}
