import { App } from './app';
import { config } from './config/environment';

/**
 * Inicializa o servidor.
 */
const app = new App().app;
const PORT = config.server.port;

app.listen(PORT, () => {
  console.log('=================================');
  console.log(`Servidor rodando na porta ${PORT}`);
  console.log(`http://localhost:${PORT}`);
  console.log('=================================');
  console.log('Teste rapido:');
  console.log(`  GET http://localhost:${PORT}/health`);
  console.log(`  GET http://localhost:${PORT}/api/v1/produto`);
  console.log('=================================');
});
