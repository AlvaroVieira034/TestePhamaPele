unit entregas.service;

interface

uses ientregas.service, conexao, pedido.model, entregas.model, FireDAC.Comp.Client, FireDAC.Stan.Param, System.SysUtils,
     Data.DB;

type
  TEntregasService = class(TInterfacedObject, IEntregasService)

  private
    TblEntregas: TFDQuery;
    TblPedidos: TFDQuery;
    QryTemp: TFDQuery;
    DsEntregas: TDataSource;
    DsPedidos: TDataSource;
    function GetDataSource: TDataSource;

  public
    constructor Create;
    destructor Destroy; override;
    procedure PreencherGridPedidosPendentes;
    function GetDataSourcePedidos: TDataSource;
    function GetDataSourceEntregas: TDataSource;
    procedure CriarTabelas;
    procedure CriarCamposTabelas;

  end;

implementation

{ TEntregasService }

constructor TEntregasService.Create;
begin
  CriarTabelas();
  CriarCamposTabelas();
end;

destructor TEntregasService.Destroy;
begin
  TblEntregas.Free;
  QryTemp.Free;
  DsEntregas.Free;

  inherited Destroy;
end;

function TEntregasService.GetDataSource: TDataSource;
begin

end;

procedure TEntregasService.PreencherGridPedidosPendentes;
begin
  with TblPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ped.id_pedido, ');
    SQL.Add('ped.data_pedido, ');
    SQL.Add('ped.valor_pedido, ');
    SQL.Add('ped.id_cliente, ');
    SQL.Add('cli.nome as cliente, ');
    SQL.Add('cli.endereco as endereco, ');
    SQL.Add('ped.status_entrega, ');
    SQL.Add('ped.prioridade, ');
    SQL.Add('case when exists (');
    SQL.Add('select 1 from pedido_itens pit ');
    SQL.Add('join produto prd on pit.id_produto = prd.id_produto ');
    SQL.Add('where pit.id_pedido = ped.id_pedido ');
    SQL.Add('and prd.requer_prescricao = ''S'') ');
    SQL.Add('then ''S'' else ''N'' ');
    SQL.Add('end as requer_prescricao, ');
    SQL.Add('cast(');
    SQL.Add('(select list(distinct prd.condicoes_armazenamento, '' | '')');
    SQL.Add('from pedido_itens pit ');
    SQL.Add('join produto prd on pit.id_produto = prd.id_produto ');
    SQL.Add('where pit.id_pedido = ped.id_pedido ');
    SQL.Add('and prd.condicoes_armazenamento is not null) as varchar(500)) as observacoes');
    SQL.Add('from pedido ped ');
    SQL.Add('join cliente cli on ped.id_cliente = cli.id_cliente ');
    SQL.Add('where ped.status_entrega = 0 ');
    SQL.Add('order by ped.prioridade, ped.data_pedido ');
    Open();
  end;
end;

procedure TEntregasService.CriarTabelas;
begin
  TblEntregas := TConexao.GetInstance.Connection.CriarQuery;
  TblPedidos := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
  DsEntregas := TConexao.GetInstance.Connection.CriarDataSource;
  DsPedidos := TConexao.GetInstance.Connection.CriarDataSource;
  DsEntregas.DataSet := TblEntregas;
  DsPedidos.DataSet := TblPedidos;

  // Configurar o TblPedidos para mapear os campos automaticamente
  TblPedidos.FieldOptions.AutoCreateMode := acCombineComputed; // ou acCombineAlways
end;

function TEntregasService.GetDataSourcePedidos: TDataSource;
begin
  Result := DsPedidos;
end;

function TEntregasService.GetDataSourceEntregas: TDataSource;
begin
  Result := DsEntregas;
end;

procedure TEntregasService.CriarCamposTabelas;
var
  SingleField: TSingleField;
  FloatField: TFloatField;
  StringField: TStringField;
  MemoField: TMemoField;
  DateField: TDateField;
  IntegerField: TIntegerField;
begin
  // Tabela TblPedidos
  // Criando o campo ID_PEDIDO
  IntegerField := TIntegerField.Create(TblPedidos);
  IntegerField.FieldName := 'ID_PEDIDO';
  IntegerField.DataSet := TblPedidos;
  IntegerField.Name := 'TblPedidosID_PEDIDO';

  // Criando o campo DATA_PEDIDO
  DateField := TDateField.Create(TblPedidos);
  DateField.FieldName := 'DATA_PEDIDO';
  DateField.DataSet := TblPedidos;
  DateField.Name := 'TblProdutosDATA_PEDIDO';

   // Criando o campo VALOR_PEDIDO
  SingleField := TSingleField.Create(TblPedidos);
  SingleField.FieldName := 'VALOR_PEDIDO';
  SingleField.DataSet := TblPedidos;
  SingleField.Name := 'TblPedidosVALOR_PEDIDO';
  SingleField.DisplayFormat := '#,###,##0.00';

  // Criando o campo ID_CLIENTE
  IntegerField := TIntegerField.Create(TblPedidos);
  IntegerField.FieldName := 'ID_CLIENTE';
  IntegerField.DataSet := TblPedidos;
  IntegerField.Name := 'TblPedidosID_CLIENTE';

  // Criando o campo CLIENTE
  StringField := TStringField.Create(TblPedidos);
  StringField.FieldName := 'CLIENTE';
  StringField.Size := 100;
  StringField.DataSet := TblPedidos;
  StringField.Name := 'TblPedidosCLIENTE';

  // Criando o campo ENDERECO
  StringField := TStringField.Create(TblPedidos);
  StringField.FieldName := 'ENDERECO';
  StringField.Size := 100;
  StringField.DataSet := TblPedidos;
  StringField.Name := 'TblPedidosENDERECO';

  // Criando o campo PRIORIDADE
  IntegerField := TIntegerField.Create(TblPedidos);
  IntegerField.FieldName := 'PRIORIDADE';
  IntegerField.DataSet := TblPedidos;
  IntegerField.Name := 'TblPedidosPRIORIDADE';

  // Criando o campo REQUER_PRESCRICAO
  StringField := TStringField.Create(TblPedidos);
  StringField.FieldName := 'REQUER_PRESCRICAO';
  StringField.Size := 1;
  StringField.DataSet := TblPedidos;
  StringField.Name := 'TblPedidosREQUER_PRESCRICAO';

  // Criando o campo OBSERVACOES
  StringField := TStringField.Create(TblPedidos);
  StringField.FieldName := 'OBSERVACOES';
  StringField.Size := 500;
  StringField.DataSet := TblPedidos;
  StringField.Name := 'TblPedidosOBSERVACOES';
end;


end.
