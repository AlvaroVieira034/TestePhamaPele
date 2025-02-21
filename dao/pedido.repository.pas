unit pedido.repository;

interface

uses pedido.model, iPedido.repository, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)

  private
    QryPedidos: TFDQuery;
    QryTemp: TFDQuery;
    Transacao: TFDTransaction;

  public
    constructor Create;
    destructor Destroy; override;
    function Inserir(FPedido: TPedido; Transacao: TFDTransaction; out sErro: string): Boolean;
    function Alterar(FPedido: TPedido; ACodigo: Integer; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro: string): Boolean;
    procedure AtulizarStatusEntrega(AStatus, APedido: Integer; out sErro: string);
    function ConcluirEntregaPedido(ADataEntrega: TDate; APedido: Integer; out sErro: string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
    procedure CriarTabelas;

  end;


implementation

{ TPedidoRepository }


constructor TPedidoRepository.Create;
begin
  CriarTabelas()
end;

destructor TPedidoRepository.Destroy;
begin
  QryPedidos.Free;
  QryTemp.Free;
  inherited;

end;

function TPedidoRepository.Inserir(FPedido: TPedido; Transacao: TFDTransaction; out sErro: string): Boolean;
begin
  QryPedidos.Transaction := Transacao;
  with QryPedidos, FPedido do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into pedido(');
    SQL.Add('id_cliente, ');
    SQL.Add('data_pedido, ');
    SQL.Add('valor_pedido, ');
    SQL.Add('status_entrega, ');
    SQL.Add('prioridade) ');
    SQL.Add('values (:id_cliente, ');
    SQL.Add(':data_pedido, ');
    SQL.Add(':valor_pedido, ');
    SQL.Add(':status_entrega, ');
    SQL.Add(':prioridade) ');

    ParamByName('ID_CLIENTE').AsInteger := Id_Cliente;
    ParamByName('DATA_PEDIDO').AsDateTime := Data_Pedido;
    ParamByName('VALOR_PEDIDO').AsFloat := Valor_Pedido;
    ParamByName('STATUS_ENTREGA').AsInteger := Status_Entrega;
    ParamByName('PRIORIDADE').AsInteger := Prioridade;

    try
      Prepared := True;
      ExecSQL;
      Result := True;

      QryPedidos.Close;
      QryPedidos.SQL.Text := 'SELECT MAX(ID_PEDIDO) AS ULTIMOID FROM PEDIDO ';
      QryPedidos.Open;
      FPedido.Id_Pedido := QryPedidos.FieldByName('ULTIMOID').AsInteger;

    except
      on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao inserir um novo pedido!' + sLineBreak + E.Message;
        raise;
      end;
    end;
  end;
end;

function TPedidoRepository.Alterar(FPedido: TPedido; ACodigo: Integer; out sErro: string): Boolean;
begin
  with QryPedidos, FPedido do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update pedido set ');
    SQL.Add('id_cliente = :id_cliente, ');
    SQL.Add('data_pedido = :data_pedido, ');
    SQL.Add('valor_pedido = :valor_pedido,');
    SQL.Add('status_entrega = :status_entrega,');
    SQL.Add('prioridade = :prioridade');
    SQL.Add('where id_pedido = :id_pedido');

    ParamByName('ID_CLIENTE').AsInteger := Id_Cliente;
    ParamByName('DATA_PEDIDO').AsDateTime := Data_Pedido;
    ParamByName('VALOR_PEDIDO').AsFloat := Valor_Pedido;
    ParamByName('STATUS_ENTREGA').AsInteger := Status_Entrega;
    ParamByName('PRIORIDADE').AsInteger := Prioridade;
    ParamByName('ID_PEDIDO').AsInteger := ACodigo;

    try
      ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
      sErro := 'Ocorreu um erro ao alterar um pedido!' + sLineBreak + E.Message;
      raise;
      end;
    end
  end;
end;

function TPedidoRepository.Excluir(ACodigo: Integer; out sErro: string): Boolean;
begin
  with QryPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'delete from pedido where id_pedido = :id_pedido';
    ParamByName('ID_PEDIDO').AsInteger := ACodigo;

    try
      ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
      sErro := 'Ocorreu um erro ao excluir um pedido!' + sLineBreak + E.Message;
      raise;
      end;
    end
  end;
end;

procedure TPedidoRepository.AtulizarStatusEntrega(AStatus, APedido: Integer; out sErro: string);
begin
  with QryPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'update pedido set status_entrega = :status_entrega where id_pedido = :id_pedido';
    ParamByName('STATUS_ENTREGA').AsInteger := AStatus;
    ParamByName('ID_PEDIDO').AsInteger := APedido;

    try
      ExecSQL;
    except
      on E: Exception do
      begin
      sErro := 'Ocorreu um erro ao alterar o status do pedido!' + sLineBreak + E.Message;
      raise;
      end;
    end
  end;
end;

function TPedidoRepository.ConcluirEntregaPedido(ADataEntrega: TDate;  APedido: Integer; out sErro: string): Boolean;
const STATUS_ENTREGA_PEDIDO = 2;
begin
  Result := False;
  with QryPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'update pedido set status_entrega = :status where id_pedido = :id_pedido';
    ParamByName('STATUS').AsInteger := STATUS_ENTREGA_PEDIDO;
    ParamByName('ID_PEDIDO').AsInteger := APedido;

    try
      ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
      sErro := 'Ocorreu um erro ao concluir a entrega do pedido!' + sLineBreak + E.Message;
      raise;
      end;
    end;

  end;

  with QryTemp do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'update entrega set data_entrega = :data_entrega where id_pedido = :id_pedido';

    ParamByName('DATA_ENTREGA').AsDateTime := ADataEntrega;
    ParamByName('ID_PEDIDO').AsInteger := APedido;

    try
      ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
      sErro := 'Ocorreu um erro ao concluir a entrega do pedido!' + sLineBreak + E.Message;
      raise;
      end;
    end;

  end;
end;

function TPedidoRepository.ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
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
        sErro := 'Ocorreu um erro ao persistir o pedido !' + sLineBreak + E.Message;
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

procedure TPedidoRepository.CriarTabelas;
begin
  Transacao := TConexao.GetInstance.Connection.CriarTransaction;
  QryPedidos := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
end;


end.
