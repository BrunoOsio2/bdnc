// Tipos compartilhados da aplicacao

export interface ApiResponse<T = any> {
  operacao: string;
  NumMens: number;
  Mensagem: string;
  registros: number;
  dados: T;
}

export interface Produto {
  id_produto: number;
  nome: string;
  descricao: string | null;
  id_classe: number;
  preco: number;
  ativo: boolean;
  atualizado_em: string;
}
