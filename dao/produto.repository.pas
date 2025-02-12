unit produto.repository;

interface

uses iinterface.repository, produto.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TProdutoRepository = class(TInterfacedObject, IInterfaceRepository<TProduto>)

  private
    QryProdutos: TFDQuery;
    Transacao: TFDTransaction;

  public
    constructor Create;
    destructor Destroy; override;
    function Inserir(AEntity: TProduto; out sErro: string): Boolean;
    function Alterar(AEntity: TProduto; iCodigo: Integer; out sErro: string): Boolean;
    function Excluir(iCodigo: Integer; out sErro : string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;

  end;

implementation

{ TProdutoRepository }

constructor TProdutoRepository.Create;
begin
  inherited Create;
  Transacao := TConexao.GetInstance.Connection.CriarTransaction;
  QryProdutos := TConexao.GetInstance.Connection.CriarQuery;
  QryProdutos.Transaction := Transacao;
end;

destructor TProdutoRepository.Destroy;
begin
  QryProdutos.Free;
  inherited Destroy;
end;

function TProdutoRepository.Inserir(AEntity: TProduto; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryProdutos, AEntity do
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into produto(');
        SQL.Add('nome, ');
        SQL.Add('codigo, ');
        SQL.Add('quantidade, ');
        SQL.Add('data_validade, ');
        SQL.Add('id_tipo_produto, ');
        SQL.Add('condicoes_armazenamento, ');
        SQL.Add('requer_prescricao, ');
        SQL.Add('valor) ');
        SQL.Add('values (:nome, ');
        SQL.Add(':codigo, ');
        SQL.Add(':quantidade, ');
        SQL.Add(':data_validade, ');
        SQL.Add(':id_tipo_produto, ');
        SQL.Add(':condicoes_armazenamento, ');
        SQL.Add(':requer_prescricao, ');
        SQL.Add(':valor) ');

        ParamByName('NOME').AsString := Nome;
        ParamByName('CODIGO').AsString := Codigo;
        ParamByName('QUANTIDADE').AsString := Quantidade;
        ParamByName('DATA_VALIDADE').AsDateTime := Data_Validade;
        ParamByName('ID_TIPO_PRODUTO').AsInteger := Id_Tipo_Produto;
        ParamByName('CONDICOES_ARMAZENAMENTO').AsString := Condicoes_Armazenamento;
        ParamByName('REQUER_PRESCRICAO').AsString := Requer_Prescricao;
        ParamByName('VALOR').AsFloat := Valor;

        ExecSQL;
      end;
    end, sErro);
end;

function TProdutoRepository.Alterar(AEntity: TProduto; iCodigo: Integer; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
  procedure
  begin
    with QryProdutos, AEntity do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update produto set ');
      SQL.Add('nome = :nome, ');
      SQL.Add('codigo = :codigo, ');
      SQL.Add('quantidade = :quantidade, ');
      SQL.Add('data_validade = :data_validade, ');
      SQL.Add('id_tipo_produto = :id_tipo_produto, ');
      SQL.Add('condicoes_armazenamento = :condicoes_armazenamento, ');
      SQL.Add('requer_prescricao = :requer_prescricao, ');
      SQL.Add('valor = :valor');
      SQL.Add('where id_produto = :id_produto');

      ParamByName('NOME').AsString := Nome;
      ParamByName('CODIGO').AsString := Codigo;
      ParamByName('QUANTIDADE').AsString := Quantidade;
      ParamByName('DATA_VALIDADE').AsDateTime := Data_Validade;
      ParamByName('ID_TIPO_PRODUTO').AsInteger := Id_Tipo_Produto;
      ParamByName('CONDICOES_ARMAZENAMENTO').AsString := Condicoes_Armazenamento;
      ParamByName('REQUER_PRESCRICAO').AsString := Requer_Prescricao;
      ParamByName('VALOR').AsFloat := Valor;
      ParamByName('ID_PRODUTO').AsInteger := iCodigo;

      ExecSQL;
    end;
  end, sErro);
end;

function TProdutoRepository.Excluir(iCodigo: Integer; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
  procedure
  begin
    with QryProdutos do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'delete from produto where id_produto = :id_produto';
      ParamByName('ID_PRODUTO').AsInteger := iCodigo;

      ExecSQL;
    end;
  end, sErro);
end;

function TProdutoRepository.ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
begin
  Result := False;
  if not Transacao.Connection.Connected then
    Transacao.Connection.Open();
  try
    Transacao.StartTransaction;
    try
      AOperacao;
      Transacao.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Transacao.Rollback;
        sErro := 'Ocorreu um erro ao excluir o produto !' + sLineBreak + E.Message;
        raise;
      end;
    end;
  except
    on E: Exception do
    begin
      sErro := 'Erro na conexão com o banco de dados: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

end.
