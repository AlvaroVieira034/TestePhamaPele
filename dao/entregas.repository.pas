unit entregas.repository;

interface

uses ientregas.repository, entregas.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TEntregasRepository = class(TInterfacedObject, IEntregasRepository)

  private
    QryEntregas: TFDQuery;
    QryTemp: TFDQuery;
    Transacao: TFDTransaction;

  public
    constructor Create;
    destructor Destroy; override;
    function Inserir(FEntregas: TEntrega; Transacao: TFDTransaction; out sErro: string): Boolean;
    function Alterar(FEntregas: TEntrega; ACodigo: Integer; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro: string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
    procedure CriarTabelas;

  end;

implementation

{ TEntregaRepository }

constructor TEntregasRepository.Create;
begin
  CriarTabelas();
end;

procedure TEntregasRepository.CriarTabelas;
begin
  Transacao := TConexao.GetInstance.Connection.CriarTransaction;
  QryEntregas := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
  QryEntregas.Transaction := Transacao;
end;

destructor TEntregasRepository.Destroy;
begin
  QryEntregas.Free;
  QryTemp.Free;
  //Transacao.Free;

  inherited Destroy;
end;

function TEntregasRepository.Inserir(FEntregas: TEntrega; Transacao: TFDTransaction; out sErro: string): Boolean;
begin
    Result := ExecutarTransacao(
    procedure
    begin
      with QryEntregas, FEntregas do
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into entrega(');
        SQL.Add('id_pedido, ');
        SQL.Add('id_cliente, ');
        SQL.Add('id_entregador, ');
        SQL.Add('data_pedido, ');
        SQL.Add('data_entrega, ');
        SQL.Add('valor_pedido, ');
        SQL.Add('prioridade, ');
        SQL.Add('observacoes) ');
        SQL.Add('values (:id_pedido, ');
        SQL.Add(':id_cliente, ');
        SQL.Add(':id_entregador, ');
        SQL.Add(':data_pedido, ');
        SQL.Add(':data_entrega, ');
        SQL.Add(':valor_pedido, ');
        SQL.Add(':prioridade, ');
        SQL.Add(':observacoes) ');

        ParamByName('ID_PEDIDO').AsInteger := Id_Pedido;
        ParamByName('ID_CLIENTE').AsInteger := Id_Cliente;
        ParamByName('ID_ENTREGADOR').AsInteger := Id_Entregador;
        ParamByName('DATA_PEDIDO').AsDateTime := Data_Pedido;
        ParamByName('DATA_ENTREGA').AsDateTime := Data_Entrega;
        ParamByName('VALOR_PEDIDO').AsFloat := Valor_Pedido;
        ParamByName('PRIORIDADE').AsInteger := Prioridade;
        ParamByName('OBSERVACOES').AsString := Observacoes;

        ExecSQL;
      end;
    end, sErro);
end;

function TEntregasRepository.Alterar(FEntregas: TEntrega; ACodigo: Integer; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
  procedure
  begin
    with QryEntregas, FEntregas do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update entrega set ');
      SQL.Add('id_pedido = :id_pedido, ');
      SQL.Add('id_cliente = :id_cliente, ');
      SQL.Add('id_entregador = :id_entregador, ');
      SQL.Add('data_pedido = :id_pedido, ');
      SQL.Add('data_entrega = :data_entrega, ');
      SQL.Add('valor_pedido = :valor_pedido, ');
      SQL.Add('prioridade = :prioridade');
      SQL.Add('where id_entrega = :id_entrega');

      ParamByName('ID_PEDIDO').AsInteger := Id_Pedido;
      ParamByName('ID_CLIENTE').AsInteger := Id_Cliente;
      ParamByName('ID_ENTREGADOR').AsInteger := Id_Entregador;
      ParamByName('DATA_PEDIDO').AsDateTime := Data_Pedido;
      ParamByName('DATA_ENTREGA').AsDateTime := Data_Entrega;
      ParamByName('VALOR_PEDIDO').AsFloat := Valor_Pedido;
      ParamByName('PRIORIDADE').AsInteger := Prioridade;
      ParamByName('ID_ENTREGA').AsInteger := ACodigo;

      ExecSQL;
    end;
  end, sErro);
end;

function TEntregasRepository.Excluir(ACodigo: Integer; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
  procedure
  begin
    with QryEntregas do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'delete from entrega where id_entrega = :id_entrega';
      ParamByName('ID_ENTREGA').AsInteger := ACodigo;

      ExecSQL;
    end;
  end, sErro);
end;

function TEntregasRepository.ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
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
        sErro := 'Ocorreu um erro ao persistir a entrega !' + sLineBreak + E.Message;
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
