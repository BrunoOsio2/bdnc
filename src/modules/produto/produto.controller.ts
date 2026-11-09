import { Request, Response, NextFunction } from 'express';
import { Database } from '../../database/Database';
import { ProdutoService } from './produto.service';

/**
 * ProdutoController - roteia operacoes via ?operacao=
 */
export class ProdutoController {
  async handle(req: Request, res: Response, _next: NextFunction): Promise<void> {
    const banco = new Database();
    const produtoService = new ProdutoService(banco);

    try {
      const operacao = (req.query.operacao as string) || 'Nao informado [Erro]';

      switch (operacao) {
        case 'getProdutos':
          await produtoService.getProdutos();
          break;

        case 'getProduto': {
          const id_produto = parseInt(req.query.id_produto as string);
          if (!id_produto) throw new Error('id_produto nao informado');
          await produtoService.getProduto(id_produto);
          break;
        }

        case 'createProduto': {
          const dados = {
            nome: req.body.nome,
            descricao: req.body.descricao || null,
            id_classe: parseInt(req.body.id_classe),
            preco: parseFloat(req.body.preco),
          };
          if (!dados.nome) throw new Error('campo nome nao fornecido');
          if (!dados.id_classe) throw new Error('campo id_classe nao fornecido');
          if (isNaN(dados.preco)) throw new Error('campo preco nao fornecido');
          await produtoService.createProduto(dados);
          break;
        }

        default:
          banco.setMensagem(1, 'Operacao nao tratada. Operacao=' + operacao);
          break;
      }

      res.json(banco.getRetorno(operacao));
    } catch (error: any) {
      banco.setMensagem(1, error.message || 'Erro desconhecido');
      res.json(banco.getRetorno((req.query.operacao as string) || 'erro'));
    }
  }
}
