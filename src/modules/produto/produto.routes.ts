import { Router } from 'express';
import { ProdutoController } from './produto.controller';

const router = Router();
const produtoController = new ProdutoController();

// Rota estilo ?operacao= (compativel com o padrao do grupo)
router.all('/ProdutoController', (req, res, next) => {
  produtoController.handle(req, res, next);
});

// --- Rotas REST ---

// GET /api/v1/produto - lista produtos
router.get('/', (req, res, next) => {
  req.query.operacao = 'getProdutos';
  produtoController.handle(req, res, next);
});

// GET /api/v1/produto/buscar?q=...&limite=... - busca por similaridade (ANTES de /:id)
router.get('/buscar', (req, res, next) => {
  req.query.operacao = 'buscarSimilares';
  produtoController.handle(req, res, next);
});

// GET /api/v1/produto/classes - lista as classes (ANTES de /:id)
router.get('/classes', (req, res, next) => {
  req.query.operacao = 'getClasses';
  produtoController.handle(req, res, next);
});

// POST /api/v1/produto - cria produto (+ vetoriza)
router.post('/', (req, res, next) => {
  req.query.operacao = 'createProduto';
  produtoController.handle(req, res, next);
});

// POST /api/v1/produto/vetorizar-todos - vetoriza todos os produtos existentes
router.post('/vetorizar-todos', (req, res, next) => {
  req.query.operacao = 'vetorizarTodos';
  produtoController.handle(req, res, next);
});

// POST /api/v1/produto/:id/vetorizar - (re)vetoriza um produto
router.post('/:id/vetorizar', (req, res, next) => {
  req.query.operacao = 'vetorizarProduto';
  req.query.id_produto = req.params.id;
  produtoController.handle(req, res, next);
});

// GET /api/v1/produto/:id - busca produto por id
router.get('/:id', (req, res, next) => {
  req.query.operacao = 'getProduto';
  req.query.id_produto = req.params.id;
  produtoController.handle(req, res, next);
});

export default router;
