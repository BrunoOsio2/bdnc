import express, { Application, Request, Response } from 'express';
import cors from 'cors';
import path from 'path';
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
    // Frontend estatico (public/index.html -> "/")
    this.app.use(express.static(path.join(__dirname, '..', 'public')));
  }

  private routes(): void {
    // Info da API (JSON)
    this.app.get('/api', (_req: Request, res: Response) => {
      res.json({
        message: 'Projeto BDNC - Problema A (comercio eletronico)',
        version: '1.0.0',
        endpoints: [
          'GET  /health',
          'GET  /api/v1/produto',
          'GET  /api/v1/produto/buscar?q=...&limite=10',
          'GET  /api/v1/produto/:id',
          'POST /api/v1/produto',
          'POST /api/v1/produto/vetorizar-todos',
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
