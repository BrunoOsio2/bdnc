/**
 * Vetorizacao de produtos.
 *
 * Dois modos (via .env EMBEDDING_MODE):
 *   - "model"       -> modelo de embedding REAL, local e gratuito (Transformers.js).
 *                      NAO e um LLM: apenas transforma texto em vetor (384 dims).
 *   - "placeholder" -> hashing de palavras, sem IA (deterministico), para comparar.
 *
 * O schema usa vector(384); o modelo abaixo tambem gera 384 dims, entao a troca
 * nao exige mudanca no banco.
 */

const DIMENSOES = 384;
const MODELO_HF = 'Xenova/paraphrase-multilingual-MiniLM-L12-v2';
const MODO = (process.env.EMBEDDING_MODE || 'model').toLowerCase();

export const EMBEDDING_DIM = DIMENSOES;
export const EMBEDDING_MODELO = MODO === 'placeholder' ? 'placeholder-hash-v1' : MODELO_HF;

/** Formata o array como literal de vetor do pgvector: [v1,v2,...] */
export function toVectorLiteral(v: number[]): string {
  return '[' + v.join(',') + ']';
}

// ---------------------------------------------------------------------------
// Modo 1: modelo de embedding real (Transformers.js)
// ---------------------------------------------------------------------------

// Carrega o modulo ESM transformers.js mesmo neste projeto CommonJS.
const importDynamic = new Function('m', 'return import(m)') as (m: string) => Promise<any>;

let extractorPromise: Promise<any> | null = null;

async function getExtractor(): Promise<any> {
  if (!extractorPromise) {
    extractorPromise = (async () => {
      const { pipeline } = await importDynamic('@huggingface/transformers');
      console.log(`[embedding] carregando modelo ${MODELO_HF} (1a vez pode baixar ~100MB)...`);
      const extractor = await pipeline('feature-extraction', MODELO_HF);
      console.log('[embedding] modelo pronto');
      return extractor;
    })();
  }
  return extractorPromise;
}

async function gerarComModelo(texto: string): Promise<number[]> {
  const extractor = await getExtractor();
  const saida = await extractor(texto, { pooling: 'mean', normalize: true });
  return Array.from(saida.data as Float32Array);
}

// ---------------------------------------------------------------------------
// Modo 2: placeholder sem IA (hashing trick)
// ---------------------------------------------------------------------------

function hashToken(token: string): number {
  let h = 2166136261;
  for (let i = 0; i < token.length; i++) {
    h ^= token.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return h >>> 0;
}

const STOPWORDS = new Set([
  'a', 'o', 'as', 'os', 'um', 'uma', 'uns', 'umas', 'de', 'da', 'do', 'das', 'dos',
  'e', 'ou', 'em', 'no', 'na', 'nos', 'nas', 'por', 'para', 'pra', 'com', 'sem',
  'que', 'se', 'ao', 'aos', 'sobre', 'entre', 'ate', 'the', 'of', 'to',
  'seu', 'sua', 'seus', 'suas', 'ja', 'mais', 'menos', 'muito', 'toda', 'todo',
  'todos', 'todas', 'este', 'esta', 'esse', 'essa', 'isso', 'como', 'tambem',
]);

/**
 * Quebra um texto em termos normalizados (minusculo, sem acento, sem stopwords)
 * para uso na parte LEXICA da busca hibrida.
 */
export function tokenizar(texto: string): string[] {
  const tokens = (texto || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/[^a-z0-9\s]/g, ' ')
    .split(/\s+/)
    .filter((t) => t.length >= 2 && !STOPWORDS.has(t));
  return Array.from(new Set(tokens));
}

function gerarPlaceholder(texto: string): number[] {
  const vet = new Array<number>(DIMENSOES).fill(0);
  const tokens = (texto || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/[^a-z0-9\s]/g, ' ')
    .split(/\s+/)
    .filter((t) => t.length >= 3 && !STOPWORDS.has(t));

  for (const tk of tokens) {
    vet[hashToken(tk) % DIMENSOES] += 1;
  }

  const norma = Math.sqrt(vet.reduce((s, v) => s + v * v, 0));
  if (norma > 0) {
    for (let i = 0; i < DIMENSOES; i++) vet[i] /= norma;
  }
  return vet;
}

// ---------------------------------------------------------------------------

/** Gera o embedding de um texto conforme o modo configurado. */
export async function gerarEmbedding(texto: string): Promise<number[]> {
  if (MODO === 'placeholder') return gerarPlaceholder(texto);
  return gerarComModelo(texto);
}
