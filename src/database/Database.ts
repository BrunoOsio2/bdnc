import { Pool, QueryResult } from 'pg';
import { pool } from '../config/database';
import { ApiResponse } from '../types';

/**
 * Classe Database - gerencia conexao e formatacao de respostas.
 */
export class Database {
  private pool: Pool;
  private numMensagem: number;
  private mensagem: string;
  private dados: any;
  private numRegistros: number;

  constructor() {
    this.pool = pool;
    this.numMensagem = 0;
    this.mensagem = '';
    this.dados = null;
    this.numRegistros = 0;
  }

  /** Retorna o pool de conexoes */
  getConexao(): Pool {
    return this.pool;
  }

  /** Define mensagem de retorno */
  setMensagem(numMensagem: number, mensagem: string): void {
    this.numMensagem = numMensagem;
    this.mensagem = mensagem;
  }

  /** Define dados de retorno */
  setDados(numRegistros: number, dados: any): void {
    this.dados = dados;
    this.numRegistros = numRegistros;
  }

  /** Retorna resposta formatada */
  getRetorno(operacao: string): ApiResponse {
    return {
      operacao: operacao,
      NumMens: this.numMensagem,
      Mensagem: this.mensagem,
      registros: this.numRegistros,
      dados: this.dados,
    };
  }

  /** Executa uma query no banco */
  async query(text: string, params?: any[]): Promise<QueryResult> {
    return this.pool.query(text, params);
  }
}
