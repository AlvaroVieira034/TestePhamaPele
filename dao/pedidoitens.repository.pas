unit pedidoitens.repository;

interface

uses pedidoitens.model, iPedidoitens.repository,  conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     System.Classes, System.Generics.Collections, Data.DB;

type
  TPedidoItensRepository = class(TInterfacedObject, IPedidoItensRepository)

  private
    QryPedidoItens: TFDQuery;
    TransacaoItens: TFDTransaction;

  public
    constructor Create;
    destructor Destroy; override;
    function CarregarItensPedido(ACodPedido: Integer): TList<TPedidoItens>;
    function Inserir(FPedidoItens: TPedidoItens; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro: string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
    procedure CriarTabelas;

  end;

implementation

{ TPedidosItensRepository }

constructor TPedidoItensRepository.Create;
begin
  CriarTabelas()
end;

destructor TPedidoItensRepository.Destroy;
begin
  TransacaoItens.Free;
  QryPedidoItens.Free;
  inherited;
end;

procedure TPedidoItensRepository.CriarTabelas;
begin
  TransacaoItens := TConexao.GetInstance.Connection.CriarTransaction;
  QryPedidoItens := TConexao.GetInstance.Connection.CriarQuery;
  QryPedidoItens.Transaction := TransacaoItens;
end;

function TPedidoItensRepository.CarregarItensPedido(ACodPedido: Integer): TList<TPedidoItens>;
var Item: TPedidoItens;
begin
  Result := TList<TPedidoItens>.Create;

  with QryPedidoItens do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select pdi.id_pedido_itens, ');
    SQL.Add('   pdi.id_pedido, ');
    SQL.Add('   pdi.id_produto, ');
    SQL.Add('   prd.nome as descricao, ');
    SQL.Add('   pdi.quantidade,');
    SQL.Add('   pdi.valor_unitario, ');
    SQL.Add('   pdi.valor_item, ');
    SQL.Add('   pdi.requer_prescricao, ');
    SQL.Add('   pdi.condicoes_armazenamento');
    SQL.Add('from pedido_itens pdi');
    SQL.Add('join produto prd on pdi.id_produto = prd.id_produto');
    SQL.Add('where pdi.id_pedido = :id_pedido');
    SQL.Add('order by pdi.id_pedido_itens');
    ParamByName('ID_PEDIDO').AsInteger := ACodPedido;
    Open;
  end;

  while not QryPedidoItens.Eof do
  begin
    Item := TPedidoItens.Create;
    Item.Id_Pedido_Itens := QryPedidoItens.FieldByName('ID_PEDIDO_ITENS').AsInteger;
    Item.Id_Pedido := QryPedidoItens.FieldByName('ID_PEDIDO').AsInteger;
    Item.Id_Produto := QryPedidoItens.FieldByName('ID_PRODUTO').AsInteger;
    Item.Descricao := QryPedidoItens.FieldByName('DESCRICAO').AsString;
    Item.Quantidade := QryPedidoItens.FieldByName('QUANTIDADE').AsInteger;
    Item.Valor_Unitario := QryPedidoItens.FieldByName('VALOR_UNITARIO').AsFloat;
    Item.Valor_Item := QryPedidoItens.FieldByName('VALOR_ITEM').AsFloat;
    Item.Requer_Prescricao := QryPedidoItens.FieldByName('REQUER_PRESCRICAO').AsString;
    Item.Condicoes_Armazenamento := QryPedidoItens.FieldByName('CONDICOES_ARMAZENAMENTO').AsString;
    Result.Add(Item);
    QryPedidoItens.Next;
  end;
  QryPedidoItens.Close;
end;

function TPedidoItensRepository.Inserir(FPedidoItens: TPedidoItens; out sErro: string): Boolean;
begin
  with QryPedidoItens, FPedidoItens do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into pedido_itens( ');
    SQL.Add('id_pedido, ');
    SQL.Add('id_produto, ');
    SQL.Add('quantidade, ');
    SQL.Add('valor_unitario, ');
    SQL.Add('valor_item, ');
    SQL.Add('requer_prescricao, ');
    SQL.Add('condicoes_armazenamento) ');
    SQL.Add('values (:id_pedido, ');
    SQL.Add(':id_produto, ');
    SQL.Add(':quantidade, ');
    SQL.Add(':valor_unitario, ');
    SQL.Add(':valor_item, ');
    SQL.Add(':requer_prescricao, ');
    SQL.Add(':condicoes_armazenamento) ');

    ParamByName('ID_PEDIDO').AsInteger := Id_Pedido;
    ParamByName('ID_PRODUTO').AsInteger := Id_Produto;
    ParamByName('QUANTIDADE').AsInteger := Quantidade;
    ParamByName('VALOR_UNITARIO').AsFloat := Valor_Unitario;
    ParamByName('VALOR_ITEM').AsFloat := Valor_Item;
    ParamByName('REQUER_PRESCRICAO').AsString := Requer_Prescricao;
    ParamByName('CONDICOES_ARMAZENAMENTO').AsString := Condicoes_Armazenamento;

    try
      Prepared := True;
      ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao inserir um item do pedido!' + sLineBreak + E.Message;
        Result := False;
        raise;
      end;
    end;
  end;
end;

function TPedidoItensRepository.Excluir(ACodigo: Integer; out sErro: string): Boolean;
begin
  with QryPedidoItens do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'delete from pedido_itens where id_pedido = :id_pedido';
    ParamByName('ID_PEDIDO').AsInteger := ACodigo;

    // Inicia Transação
    if not TransacaoItens.Connection.Connected then
      TransacaoItens.Connection.Open();

    try
      Prepared := True;
      TransacaoItens.StartTransaction;
      ExecSQL;
      TransacaoItens.Commit;
      Result := True;
    except on E: Exception do
      begin
        TransacaoItens.Rollback;
        sErro := 'Ocorreu um erro ao excluir os itens do pedido !' + sLineBreak + E.Message;
        Result := False;
        raise;
      end;
    end;
  end;
end;

function TPedidoItensRepository.ExecutarTransacao(AOperacao: TProc;  var sErro: string): Boolean;
begin
  Result := False;
  if not TransacaoItens.Connection.Connected then
    TransacaoItens.Connection.Open();

  try
    TransacaoItens.StartTransaction;
    try
      AOperacao;
      TransacaoItens.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        TransacaoItens.Rollback;
        sErro := 'Ocorreu um erro ao excluir o item do pedido !' + sLineBreak + E.Message;
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

  if TransacaoItens.Connection.Connected then
    TransacaoItens.Connection.Close();
end;


end.
