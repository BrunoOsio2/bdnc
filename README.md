# Projeto BDNC — Problema A (comércio eletrônico)

Base Node.js + TypeScript + PostgreSQL para o Trabalho Integrador de Bancos de Dados
Não Convencionais. Mesmo padrão do `node-backend` do grupo: Express + `pg` (Pool),
classes `Database`/`BaseService` e módulos (`service` + `controller` + `routes`).

## Pré-requisitos
- Node.js 18+
- PostgreSQL rodando localmente (porta 5432)

## 1. Configurar credenciais
Edite o arquivo `.env` se necessário (padrão abaixo):

```
DB_HOST=localhost
DB_PORT=5432
DB_USER=i589591
DB_PASSWORD=
DB_NAME=bdnc
PORT=3333
```

## 2. Instalar dependências
```bash
npm install
```

## 3. Criar o banco + schema + dados fictícios
```bash
npm run db:setup
```
Isso executa, em sequência:
- `db:create` → cria o banco `bdnc`
- `db:schema` → aplica `src/database/schema.sql`
- `db:seed`   → carrega `src/database/seed.sql`

> Rode os passos avulsos com `npm run db:schema` / `npm run db:seed` se preferir.

## 4. Subir a API
```bash
npm run dev
```

## 5. Testar a conexão
```bash
curl http://localhost:3333/health
curl http://localhost:3333/api/v1/produto
curl http://localhost:3333/api/v1/produto/101
```

## Estrutura
```
src/
  config/        environment.ts (lê .env) + database.ts (Pool pg)
  database/      Database.ts, BaseService.ts, schema.sql, seed.sql
  modules/
    produto/     exemplo de módulo (service + controller + routes)
  types/         tipos compartilhados
  app.ts         rotas + health check
  server.ts      bootstrap
```

## Como adicionar um módulo
Copie `src/modules/produto/` para um novo nome (ex.: `carrinho`), ajuste as queries no
`service`, as operações no `controller` e registre em `src/app.ts`:
```ts
this.app.use('/api/v1/carrinho', carrinhoRoutes);
```

O `schema.sql` é a **fonte única** do banco relacional — todos rodam o mesmo arquivo.
