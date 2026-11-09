import express, { Application, Request, Response } from 'express';
import cors from 'cors';
import { pool } from './config/database';
import produtoRoutes from './modules/produto/produto.routes';

/**
 * Configuracao do Express App.
 */
export class App {
  public app: Application;

  constructor() {
    this.app = express();
    this.middlewares();
    this.routes();
  }

  private middlewares(): void {
    this.app.use(cors());
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
  }

  private routes(): void {
    // Raiz
    this.app.get('/', (_req: Request, res: Response) => {
      res.json({
        message: 'Projeto BDNC - Problema A (comercio eletronico)',
        version: '1.0.0',
        endpoints: [
          'GET  /health',
          'GET  /api/v1/produto',
          'GET  /api/v1/produto/:id',
          'POST /api/v1/produto',
          'GET  /api/v1/produto/ProdutoController?operacao=getProdutos',
        ],
      });
    });

    // Health check - prova que a conexao com o banco esta viva
    this.app.get('/health', async (_req: Request, res: Response) => {
      try {
        const result = await pool.query('SELECT now() AS agora, current_database() AS banco');
        res.json({
          status: 'ok',
          banco: result.rows[0].banco,
          hora_banco: result.rows[0].agora,
        });
      } catch (error: any) {
        res.status(500).json({ status: 'erro', mensagem: error.message });
      }
    });

    // Modulos
    this.app.use('/api/v1/produto', produtoRoutes);

    // 404
    this.app.use((req: Request, res: Response) => {
      res.status(404).json({ error: 'Rota nao encontrada', path: req.path });
    });
  }
}
