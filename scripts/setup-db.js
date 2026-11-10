/**
 * Setup do banco multiplataforma (macOS / Windows / Linux).
 *
 * Usa o driver `pg` e as credenciais do .env — NAO depende do psql/createdb
 * estarem no PATH. Cria o banco e aplica schema.sql, seed.sql e pgvector.sql.
 *
 *   node scripts/setup-db.js
 */
const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
require('dotenv').config();

const cfg = {
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432', 10),
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || '',
};
const dbName = process.env.DB_NAME || 'bdnc';
const dir = path.join(__dirname, '..', 'src', 'database');

async function run() {
  // 1. cria o banco (conectado ao banco administrativo "postgres")
  const admin = new Client({ ...cfg, database: 'postgres' });
  await admin.connect();
  try {
    await admin.query(`CREATE DATABASE ${dbName}`);
    console.log(`banco "${dbName}" criado`);
  } catch (e) {
    if (e.code === '42P04') console.log(`banco "${dbName}" ja existe (ok)`);
    else throw e;
  }
  await admin.end();

  // 2. aplica os arquivos SQL em ordem
  const db = new Client({ ...cfg, database: dbName });
  await db.connect();
  for (const arquivo of ['schema.sql', 'seed.sql', 'pgvector.sql']) {
    const sql = fs.readFileSync(path.join(dir, arquivo), 'utf8');
    await db.query(sql);
    console.log(`aplicado: ${arquivo}`);
  }
  await db.end();

  console.log('\nSetup concluido. Suba a API com: npm run dev');
  console.log('Depois gere os vetores: POST /api/v1/produto/vetorizar-todos');
}

run().catch((e) => {
  console.error('\nERRO no setup:', e.message);
  if (e.code === 'ECONNREFUSED') console.error('> O PostgreSQL esta rodando? Confira host/porta no .env.');
  if (e.code === '28P01' || e.code === '28000') console.error('> Usuario/senha do .env (DB_USER/DB_PASSWORD) estao corretos?');
  if (e.message && e.message.includes('vector')) console.error('> A extensao pgvector esta instalada no servidor? Veja o README (passo 2).');
  process.exit(1);
});
