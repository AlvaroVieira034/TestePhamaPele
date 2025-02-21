unit pedido.service;

interface

uses ipedido.service, pedido.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TOperacao = (opInicio, opNovo, opEditar, opNavegar);
  TPedidoService = class(TInterfacedObject, IPedidoService)

  private
    TblPedidos: TFDQuery;
    QryTemp: TFDQuery;
    DsPedidos: TDataSource;

  public
    constructor Create;
    destructor Destroy; override;
    function RetornaPrioridadeProduto(ACodigo: Integer): Integer;
    procedure PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
    procedure PreencherCamposForm(FPedido: TPedido; ACodigo: Integer);
    procedure ExibirSituacaoPedidos;
    function GetDataSource: TDataSource;
    procedure CriarTabelas;
    procedure CriarCamposTabelas;

  end;

implementation

{ TPedidoService }

constructor TPedidoService.Create;
begin
  CriarTabelas();
  CriarCamposTabelas();
end;

destructor TPedidoService.Destroy;
begin
  TblPedidos.Free;
  QryTemp.Free;
  DsPedidos.Free;
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

function TPedidoService.RetornaPrioridadeProduto(ACodigo: Integer): Integer;
var LIdTipoProduto: Integer;
begin
  with QryTemp do
  begin
    SQL.Clear;
    SQL.Add('select id_tipo_produto from produto where id_produto = :id_produto');
    ParamByName('ID_PRODUTO').AsInteger := ACodigo;
    Open();

    if not IsEmpty then
    begin
      LIdTipoProduto := FieldByName('ID_TIPO_PRODUTO').AsInteger;

      // Define a prioridade com base no id_tipo_produto
      case LIdTipoProduto of
        3: Result := 0; // Prioridade máxima
        2: Result := 1; // Prioridade alta
        5: Result := 2; // Prioridade média
      else
        Result := 3; // Prioridade normal (qualquer outro valor)
      end;
    end;
  end;
end;

procedure TPedidoService.PreencherCamposForm(FPedido: TPedido; ACodigo: Integer);
begin
  with QryTemp do
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

    with FPedido, QryTemp do
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

procedure TPedidoService.ExibirSituacaoPedidos;
begin
  with TblPedidos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select');
    SQL.Add('ped.id_pedido, ');
    SQL.Add('ped.data_pedido, ');
    SQL.Add('ped.valor_pedido, ');
    SQL.Add('ped.id_cliente, ');
    SQL.Add('cli.nome as cliente, ');
    SQL.Add('cli.endereco as endereco, ');
    SQL.Add('ped.status_entrega, ');
    SQL.Add('CASE ');
    SQL.Add('   WHEN ped.status_entrega = 0 THEN ''Pendente'' ');
    SQL.Add('   WHEN ped.status_entrega = 1 THEN ''Em Andamento'' ');
    SQL.Add('   WHEN ped.status_entrega = 2 THEN ''Entregue'' ');
    SQL.Add('END as status,');
    SQL.Add('ped.prioridade, ');
    SQL.Add('CASE ');
    SQL.Add('   WHEN exists ( ');
    SQL.Add('       select 1');
    SQL.Add('       from pedido_itens pit');
    SQL.Add('       join produto prd ON pit.id_produto = prd.id_produto');
    SQL.Add('       where pit.id_pedido = ped.id_pedido');
    SQL.Add('       and prd.requer_prescricao = ''S''');
    SQL.Add('   ) THEN ''S'' ELSE ''N''');
    SQL.Add('END as requer_prescricao,');
    SQL.Add('CAST((');
    SQL.Add('    select list(distinct prd.condicoes_armazenamento, '' | '')');
    SQL.Add('    from pedido_itens pit');
    SQL.Add('    join produto prd on pit.id_produto = prd.id_produto');
    SQL.Add('    where pit.id_pedido = ped.id_pedido');
    SQL.Add('    and prd.condicoes_armazenamento IS NOT NULL');
    SQL.Add(') as varchar(500)) as observacoes,');
    SQL.Add('CASE ');
    SQL.Add('   WHEN ped.status_entrega = 2 THEN ent.data_entrega ');
    SQL.Add('   ELSE NULL ');
    SQL.Add('END as data_entrega,');
    SQL.Add('CASE ');
    SQL.Add('    WHEN ped.status_entrega IN (1, 2) THEN entg.nome ');
    SQL.Add('    ELSE NULL ');
    SQL.Add('END as entregador');
    SQL.Add('from pedido ped ');
    SQL.Add('join cliente cli on ped.id_cliente = cli.id_cliente ');
    SQL.Add('left join entrega ent on ped.id_pedido = ent.id_pedido ');
    SQL.Add('left join entregador entg ON ent.id_entregador = entg.id_entregador ');
    SQL.Add('order by ped.prioridade, ped.data_pedido ');
    Prepared := True;
    Open();
  end;
end;

function TPedidoService.GetDataSource: TDataSource;
begin
  Result := DsPedidos;
end;

procedure TPedidoService.CriarTabelas;
begin
  TblPedidos := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
  DsPedidos := TConexao.GetInstance.Connection.CriarDataSource;
  DsPedidos.DataSet := TblPedidos;
end;

procedure TPedidoService.CriarCamposTabelas;
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

  // Criando o campo STATUS_ENTREGA
  IntegerField:= TIntegerField.Create(TblPedidos);
  IntegerField.FieldName := 'STATUS_ENTREGA';
  IntegerField.DataSet := TblPedidos;
  IntegerField.Name := 'TblPedidoSTATUS_ENTREGA';

  // Criando o campo STATUS
  StringField := TStringField.Create(TblPedidos);
  StringField.FieldName := 'STATUS';
  StringField.Size := 30;
  StringField.DataSet := TblPedidos;
  StringField.Name := 'TblPedidoSTATUS';

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

  // Criando o campo DATA_ENTREGA
  DateField := TDateField.Create(TblPedidos);
  DateField.FieldName := 'DATA_ENTREGA';
  DateField.DataSet := TblPedidos;
  DateField.Name := 'TblProdutosDATA_ENTREGA';

  // Criando o campo ENTREGADOR
  StringField := TStringField.Create(TblPedidos);
  StringField.FieldName := 'ENTREGADOR';
  StringField.Size := 100;
  StringField.DataSet := TblPedidos;
  StringField.Name := 'TblPedidosENTREGADOR';

end;

end.
