# Projeto BDNC — Problema A (comércio eletrônico)

Base Node.js + TypeScript + PostgreSQL + pgvector para o Trabalho Integrador de
Bancos de Dados Não Convencionais. Implementa o **catálogo de produtos** (relacional,
modelo EAV) e a **busca por similaridade** (vetorial, com pgvector + um modelo de
embedding local).

> **Importante:** o "modelo" usado na busca é um **modelo de embedding** (texto → vetor),
> **não é um LLM**. Ele não gera texto; só transforma a descrição do produto em um vetor
> de 384 números para comparar significados. Roda **local e de graça**.

Funciona em **macOS, Windows e Linux**. Os passos comuns (3 em diante) são iguais nos
três; o que muda é só **como instalar o PostgreSQL + pgvector** (passos 1 e 2).

---

## 0. Pré-requisitos (todos os sistemas)

| Ferramenta | Para quê | Checar |
|---|---|---|
| Node.js 18+ | rodar a API | `node --version` |
| Git | clonar o projeto | `git --version` |
| PostgreSQL 15+ **com pgvector** | banco de dados | passos 1–2 |

Node: https://nodejs.org · Git: https://git-scm.com

---

## 1 + 2. Instalar PostgreSQL + pgvector

Escolha o seu sistema. **No fim deste passo você precisa ter:** um PostgreSQL rodando
em `localhost:5432` e a extensão `pgvector` disponível.

### 🐳 Opção Docker (recomendada no Windows, funciona em todos)

A imagem `pgvector/pgvector` já vem com o pgvector embutido — **nada pra compilar**.
Precisa só do Docker Desktop (https://www.docker.com/products/docker-desktop).

O projeto já tem um `docker-compose.yml` pronto. Dentro da pasta do projeto:

```bash
docker compose up -d
```

Isso sobe o PostgreSQL com pgvector em `localhost:5432`, já cria o banco `bdnc` e
guarda os dados num volume (não some ao reiniciar). No `.env` (passo 3) use:
`DB_USER=postgres` e `DB_PASSWORD=postgres`.

Comandos úteis:

```bash
docker compose stop     # para (mantem os dados)
docker compose start    # liga de novo
docker compose down     # remove o container (dados continuam no volume)
docker compose down -v  # remove tudo, inclusive os dados
docker compose logs -f  # ver o log do banco
```

> Alternativa sem compose (mesmo efeito, um comando):
> ```bash
> docker run --name bdnc-postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=bdnc -p 5432:5432 -d pgvector/pgvector:pg16
> ```

### 🍎 macOS (Homebrew, sem Docker)

```bash
brew install postgresql@15
brew services start postgresql@15
echo 'export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

No Homebrew o usuário do banco é o **seu usuário do macOS** (veja com `whoami`), **sem senha**.

Instalar o pgvector:

```bash
brew install pgvector
```

Se `CREATE EXTENSION vector` acusar "extension not available" (o pacote veio para outra
versão do Postgres), compile do fonte:

```bash
PGC=/opt/homebrew/opt/postgresql@15/bin/pg_config
git clone --depth 1 --branch v0.8.0 https://github.com/pgvector/pgvector.git /tmp/pgvector-build
cd /tmp/pgvector-build
make PG_CONFIG="$PGC" && make install PG_CONFIG="$PGC"
```

Se der erro `'stdio.h' file not found` / `no such sysroot` (toolchain desatualizado):

```bash
SDK=$(xcrun --show-sdk-path)
make clean PG_CONFIG="$PGC"
make         PG_CONFIG="$PGC" TARGET_ARCH="-isysroot $SDK" COPT="-isysroot $SDK"
make install PG_CONFIG="$PGC" TARGET_ARCH="-isysroot $SDK" COPT="-isysroot $SDK"
```

### 🪟 Windows

**No Windows, use Docker — é o jeito mais simples e confiável.** O pgvector existe para
Windows, mas instalar nativo exige compilar com o Visual Studio. Com Docker, não precisa
compilar nada.

**Passo a passo (Windows + Docker):**

1. Instale o **Docker Desktop**: https://www.docker.com/products/docker-desktop
   (na primeira vez ele pode pedir pra ativar o WSL 2 — siga o que a tela indicar e reinicie).
2. Abra o Docker Desktop e espere ficar "Running".
3. No terminal (PowerShell ou CMD), dentro da pasta do projeto:
   ```bash
   docker compose up -d
   ```
4. Confirme que subiu:
   ```bash
   docker ps
   ```
   Deve aparecer o container `bdnc-postgres`.
5. No `.env` (passo 3) use `DB_USER=postgres` e `DB_PASSWORD=postgres`.

Pronto — o banco com pgvector está rodando. Siga para o passo 3. Todo o resto
(`npm install`, `npm run db:setup:vector`, `npm run dev`) é igual ao dos outros sistemas.

<details>
<summary>Windows sem Docker (nativo, avançado — só se não puder usar Docker)</summary>

Exige o **Visual Studio Build Tools** (compilador C++).

1. Instale o PostgreSQL pelo instalador EDB: https://www.postgresql.org/download/windows/
   (defina e anote uma senha para o usuário `postgres`).
2. Adicione a pasta `bin` ao `PATH` (ex.: `C:\Program Files\PostgreSQL\16\bin`).
3. No **"x64 Native Tools Command Prompt for VS"**:
   ```cmd
   set "PGROOT=C:\Program Files\PostgreSQL\16"
   git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git
   cd pgvector
   nmake /F Makefile.win
   nmake /F Makefile.win install
   ```
   Guia oficial: https://github.com/pgvector/pgvector#windows
4. No `.env` use `DB_USER=postgres` e a senha que você definiu.
</details>

### 🐧 Linux (resumo)

```bash
sudo apt install postgresql postgresql-16-pgvector   # Debian/Ubuntu
```

---

## 3. Pegar o projeto e configurar o `.env`

```bash
cd caminho/para/bdnc/projeto_bdnc
cp .env.example .env     # Windows (cmd): copy .env.example .env
```

Edite o `.env` conforme o caminho que você escolheu:

```
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres         # Docker/Windows: postgres | macOS Homebrew: seu `whoami`
DB_PASSWORD=postgres     # Docker: postgres | macOS Homebrew: deixe vazio | Windows: sua senha
DB_NAME=bdnc
PORT=3333

# "model" = modelo de embedding real (local). "placeholder" = hashing sem IA.
EMBEDDING_MODE=model
```

---

## 4. Instalar as dependências

```bash
npm install
```

Baixa Express, driver do Postgres (`pg`) e a biblioteca do modelo de embedding
(`@huggingface/transformers`). **O modelo em si só baixa na primeira vetorização** (passo 6).

---

## 5. Criar o banco, tabelas e dados

```bash
npm run db:setup:vector
```

Esse comando é **multiplataforma** (roda via Node, usa o `.env`, não precisa do `psql` no
PATH). Ele cria o banco `bdnc` e aplica, em ordem:

- `src/database/schema.sql` — tabelas relacionais (fonte única)
- `src/database/seed.sql` — produtos fictícios
- `src/database/pgvector.sql` — extensão `vector` + tabela `produto_embedding`

---

## 6. Subir a API e gerar os embeddings

```bash
npm run dev
```

API em `http://localhost:3333`. Em **outro terminal**, gere os vetores:

```bash
curl -X POST http://localhost:3333/api/v1/produto/vetorizar-todos
```

> **Primeira vez:** baixa o modelo de embedding (~100 MB) — pode levar ~1 min. Depois
> fica em cache e é rápido. Tudo local, sem chave, sem custo.
> (No Windows sem `curl`, acesse o endpoint pelo navegador/Postman ou use `Invoke-RestMethod`.)

---

## 7. Testar

No navegador:
- **Busca por similaridade:** http://localhost:3333/
- **Lista de produtos:** http://localhost:3333/produtos.html

Buscar `presente para quem gosta de acampar` ou `computador para editar vídeo` — o modelo
entende o **significado**, então traz os produtos certos mesmo sem as palavras exatas.

Pela linha de comando:

```bash
curl http://localhost:3333/health
curl http://localhost:3333/api/v1/produto
curl "http://localhost:3333/api/v1/produto/buscar?q=barraca%20para%20trilha&limite=5"
```

---

## 8. Os dois modos de embedding (`.env` → `EMBEDDING_MODE`)

| Modo | O que usa | Quando usar |
|---|---|---|
| `model` | `Xenova/paraphrase-multilingual-MiniLM-L12-v2` (384 dims) | uso normal — entende significado |
| `placeholder` | hashing de palavras (sem IA, determinístico) | comparar / rodar sem baixar modelo |

Trocou o modo? Rode `vetorizar-todos` de novo. Ambos geram 384 dims → **o banco não muda**.

---

## 9. Estrutura do projeto

```
projeto_bdnc/
├── .env                      credenciais e configuração (não versionar)
├── package.json              dependências e scripts
├── scripts/setup-db.js       setup do banco multiplataforma
├── public/                   frontend estático (index.html, produtos.html)
└── src/
    ├── config/               environment.ts (.env) + database.ts (pool pg)
    ├── database/             Database.ts, BaseService.ts, schema.sql, seed.sql, pgvector.sql
    ├── modules/produto/      service + controller + routes
    ├── utils/embedding.ts    vetorização (modelo real ou placeholder)
    ├── app.ts                rotas + /health + estáticos
    └── server.ts             bootstrap (porta 3333)
```

---

## 10. Problemas comuns

| Sintoma | Causa / solução |
|---|---|
| `ECONNREFUSED` ao rodar o setup | PostgreSQL não está rodando (Docker parado? serviço parado?) |
| `password authentication failed` (28P01) | `DB_USER`/`DB_PASSWORD` do `.env` errados |
| `extension "vector" is not available` | pgvector não instalado para a sua versão → passo 2 (ou use Docker) |
| `'stdio.h' file not found` (macOS) | SDK → use `TARGET_ARCH`/`COPT` do passo 2 (macOS) |
| `EADDRINUSE :3333` | porta ocupada → feche o outro processo ou mude `PORT` no `.env` |
| busca retorna tudo igual / vazio | rode `vetorizar-todos` depois de popular/trocar o modo |

---

## 11. Resumo rápido (TL;DR)

**Com Docker (qualquer SO):**
```bash
docker run --name bdnc-postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d pgvector/pgvector:pg16
cd bdnc/projeto_bdnc
cp .env.example .env            # DB_USER=postgres  DB_PASSWORD=postgres
npm install
npm run db:setup:vector
npm run dev                     # http://localhost:3333
curl -X POST http://localhost:3333/api/v1/produto/vetorizar-todos
```

**macOS com Homebrew:**
```bash
brew install postgresql@15 && brew services start postgresql@15
brew install pgvector           # (ou compile — passo 2 macOS)
cd bdnc/projeto_bdnc
cp .env.example .env            # DB_USER=`whoami`  DB_PASSWORD vazio
npm install && npm run db:setup:vector && npm run dev
curl -X POST http://localhost:3333/api/v1/produto/vetorizar-todos
```
