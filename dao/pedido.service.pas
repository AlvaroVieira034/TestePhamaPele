unit pedido.service;

interface

uses ipedido.service, pedido.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)

  private
    TblPedidos: TFDQuery;
    DsPedidos: TDataSource;

  public
    constructor Create;
    destructor Destroy; override;
    procedure PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
    procedure PreencherCamposForm(FPedido: TPedido; ACodigo: Integer);

  end;

implementation

{ TPedidoService }

constructor TPedidoService.Create;
begin
  TblPedidos := TConexao.GetInstance.Connection.CriarQuery;
end;

destructor TPedidoService.Destroy;
begin
  TblPedidos.Free;

  inherited;
end;

procedure TPedidoService.PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
begin
  with TblPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ped.id_pedido, ');
    SQL.Add('ped.id_cliente, ');
    SQL.Add('cli.nome as nomecliente, ');
    SQL.Add('ped.data_pedido, ');
    SQL.Add('cast(ped.valor_pedido as DOUBLE PRECISION) as valor_pedido, ');
    SQL.Add('ped.status_entrega');
    SQL.Add('from pedido ped');
    SQL.Add('join cliente cli on ped.id_cliente = cli.id_cliente ');
    SQL.Add('where ' + ACampo + ' like :PNAME');
    SQL.Add('order by ' + ACampo + ' desc');
    ParamByName('PNAME').AsString := APesquisa;
    Prepared := True;
    Open();
  end;
end;

procedure TPedidoService.PreencherCamposForm(FPedido: TPedido; ACodigo: Integer);
begin
  with TblPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ped.id_pedido, ');
    SQL.Add('ped.id_cliente, ');
    SQL.Add('cli.nome as des_cliente, ');
    SQL.Add('ped.data_pedido, ');
    SQL.Add('cast(ped.valor_pedido as DOUBLE PRECISION) as valor_pedido, ');
    SQL.Add('ped.status_entrega');
    SQL.Add('from pedido ped');
    SQL.Add('join cliente cli on ped.id_cliente = cli.id_cliente ');
    SQL.Add('where ped.id_pedido = :id_pedido');
    ParamByName('ID_PEDIDO').AsInteger := ACodigo;
    Open();

    with FPedido, TblPedidos do
    begin
      Id_Pedido := FieldByName('ID_PEDIDO').AsInteger;
      Id_Cliente := FieldByName('ID_CLIENTE').AsInteger;
      Des_Cliente := FieldByName('DES_CLIENTE').AsString;
      Data_Pedido := FieldByName('DATA_PEDIDO').AsDateTime;
      Valor_Pedido := FieldByName('VALOR_PEDIDO').AsFloat;
      Status_Entrega := FieldByName('STATUS_ENTREGA').AsInteger;
    end;
  end;
end;

end.
