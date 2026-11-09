import dotenv from 'dotenv';

dotenv.config();

/**
 * Configuracao central da aplicacao.
 * Le as variaveis do .env (com fallback para o ambiente local).
 */
export const config = {
  database: {
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '5432'),
    user: process.env.DB_USER || 'i589591',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'bdnc',
  },
  server: {
    port: parseInt(process.env.PORT || '3333'),
  },
};
