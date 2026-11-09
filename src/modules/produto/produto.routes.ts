import { Router } from 'express';
import { ProdutoController } from './produto.controller';

const router = Router();
const produtoController = new ProdutoController();

// Rota estilo ?operacao= (compativel com o padrao do grupo)
router.all('/ProdutoController', (req, res, next) => {
  produtoController.handle(req, res, next);
});

// Rotas REST
// GET /api/v1/produto - lista produtos
router.get('/', (req, res, next) => {
  req.query.operacao = 'getProdutos';
  produtoController.handle(req, res, next);
});

// POST /api/v1/produto - cria produto
router.post('/', (req, res, next) => {
  req.query.operacao = 'createProduto';
  produtoController.handle(req, res, next);
});

// GET /api/v1/produto/:id - busca produto por id
router.get('/:id', (req, res, next) => {
  req.query.operacao = 'getProduto';
  req.query.id_produto = req.params.id;
  produtoController.handle(req, res, next);
});

export default router;
