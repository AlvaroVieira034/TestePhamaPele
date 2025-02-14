unit produto.service;

interface

uses iinterface.service, conexao, produto.model, FireDAC.Comp.Client, FireDAC.Stan.Param, System.SysUtils,
     Data.DB;

type
  TProdutoInfo = record
    ValorUnitario: Double;
    RequerPrescricao: Char;
    CondicoesArmazenamento: string;
  end;

  TProdutoService = class(TInterfacedObject, IInterfaceService<TProduto>)

  private
    TblProdutos: TFDQuery;
    QryTemp: TFDQuery;
    DsProdutos: TDataSource;

  public
    constructor Create;
    destructor Destroy; override;
    procedure PreencherGridForm(APesquisa, ACampo: string);
    procedure PreencherComboBox(TblProdutos: TFDQuery);
    procedure PreencherCamposForm(FProduto: TProduto; iCodigo: Integer);
    function GetProdutoInfo(ACodigo: Integer): TProdutoInfo;
    function GetDataSource: TDataSource;
    procedure CriarTabelas;
    procedure CriarCamposTabelas;

  end;

implementation

{ TProdutoService }

constructor TProdutoService.Create;
begin
  CriarTabelas();
  CriarCamposTabelas();
end;

destructor TProdutoService.Destroy;
begin
  TblProdutos.Free;
  QryTemp.Free;
  DsProdutos.Free;
  inherited Destroy;
end;

procedure TProdutoService.CriarTabelas;
begin
  TblProdutos := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
  DsProdutos := TConexao.GetInstance.Connection.CriarDataSource;
  DsProdutos.DataSet := TblProdutos;
end;

procedure TProdutoService.CriarCamposTabelas;
var
  FloatField: TFloatField;
  StringField: TStringField;
  DateField: TDateField;
  IntegerField: TIntegerField;
begin
  // Criando o campo COD_PRODUTO
  IntegerField := TIntegerField.Create(TblProdutos);
  IntegerField.FieldName := 'ID_PRODUTO';
  IntegerField.DataSet := TblProdutos;
  IntegerField.Name := 'TblProdutosID_PRODUTO';

  // Criando o campo NOME_PRODUTO
  StringField := TStringField.Create(TblProdutos);
  StringField.FieldName := 'NOME';
  StringField.Size := 100;
  StringField.DataSet := TblProdutos;
  StringField.Name := 'TblProdutosNOME';

  // Criando o campo CODIGO
  StringField := TStringField.Create(TblProdutos);
  StringField.FieldName := 'CODIGO';
  StringField.Size := 20;
  StringField.DataSet := TblProdutos;
  StringField.Name := 'TblProdutosCODIGO';

  // Criando o campo QUANTIDADE
  StringField := TStringField.Create(TblProdutos);
  StringField.FieldName := 'QUANTIDADE';
  StringField.Size := 50;
  StringField.DataSet := TblProdutos;
  StringField.Name := 'TblProdutosQUANTIDADE';

  // Criando o campo DATA_VALIDADE
  DateField := TDateField.Create(TblProdutos);
  DateField.FieldName := 'DATA_VALIDADE';
  DateField.DataSet := TblProdutos;
  DateField.Name := 'TblProdutosDATA_VALIDADE';

  // Criando o campo ID_TIPO_PRODUTO
  IntegerField := TIntegerField.Create(TblProdutos);
  IntegerField.FieldName := 'ID_TIPO_PRODUTO';
  IntegerField.DataSet := TblProdutos;
  IntegerField.Name := 'TblProdutosID_TIPO_PRODUTO';

  // Criando o campo CONDICOES_ARMAZENAMENTO
  StringField := TStringField.Create(TblProdutos);
  StringField.FieldName := 'CONDICOES_ARMAZENAMENTO';
  StringField.Size := 200;
  StringField.DataSet := TblProdutos;
  StringField.Name := 'TblProdutosCONDICOES_ARMAZENAMENTO';

  // Criando o campo REQUER_PRESCRICAO
  StringField := TStringField.Create(TblProdutos);
  StringField.FieldName := 'REQUER_PRESCRICAO';
  StringField.Size := 1;
  StringField.DataSet := TblProdutos;
  StringField.Name := 'TblProdutosREQUER_PRESCRICAOO';

  // Criando o campo VALOR
  FloatField := TFloatField.Create(TblProdutos);
  FloatField.FieldName := 'VALOR';
  FloatField.DataSet := TblProdutos;
  FloatField.Name := 'TblProdutosVALOR';
  FloatField.DisplayFormat := '#,###,##0.00';
end;

procedure TProdutoService.PreencherGridForm(APesquisa, ACampo: string);
begin
  with TblProdutos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select prd.id_produto, ');
    SQL.Add('   prd.nome, ');
    SQL.Add('   prd.codigo, ');
    SQL.Add('   prd.quantidade, ');
    SQL.Add('   prd.data_validade, ');
    SQL.Add('   prd.id_tipo_produto, ');
    SQL.Add('   tpp.descricao, ');
    SQL.Add('   prd.condicoes_armazenamento, ');
    SQL.Add('   prd.requer_prescricao, ');
    SQL.Add('   cast(prd.valor as DOUBLE PRECISION) as valor ');
    SQL.Add(' from produto prd');
    SQL.Add('    join  tipo_produto tpp on prd.id_tipo_produto = tpp.id_tipo_produto');
    SQL.Add('where ' + ACampo + ' like :PNAME');
    SQL.Add('order by ' + ACampo);
    ParamByName('PNAME').AsString := APesquisa;
    Open();
  end;
end;

procedure TProdutoService.PreencherComboBox(TblProdutos: TFDQuery);
begin
  with TblProdutos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from produto prd order by prd.nome ');
    Open();
  end;
end;

procedure TProdutoService.PreencherCamposForm(FProduto: TProduto; iCodigo: Integer);
begin
  with QryTemp do
  begin
    SQL.Clear;
    SQL.Add('select prd.id_produto, ');
    SQL.Add('   prd.nome, ');
    SQL.Add('   prd.codigo, ');
    SQL.Add('   prd.quantidade, ');
    SQL.Add('   prd.data_validade, ');
    SQL.Add('   prd.id_tipo_produto, ');
    SQL.Add('   tpp.descricao, ');
    SQL.Add('   prd.condicoes_armazenamento, ');
    SQL.Add('   prd.requer_prescricao, ');
    SQL.Add('   prd.valor ');
    SQL.Add('from  produto prd');
    SQL.Add('join  tipo_produto tpp on prd.id_tipo_produto = tpp.id_tipo_produto');
    SQL.Add('where prd.id_produto = :id_produto');

    ParamByName('ID_PRODUTO').AsInteger := iCodigo;

    Open();

    FProduto.Id_Produto := FieldByName('ID_PRODUTO').AsInteger;
    FProduto.Nome := FieldByName('NOME').AsString;
    FProduto.Codigo := FieldByName('CODIGO').AsString;
    FProduto.Quantidade := FieldByName('QUANTIDADE').AsString;
    FProduto.Data_Validade := FieldByName('DATA_VALIDADE').AsDateTime;
    FProduto.Id_Tipo_Produto := FieldByName('ID_TIPO_PRODUTO').AsInteger;
    FProduto.Condicoes_Armazenamento := FieldByName('CONDICOES_ARMAZENAMENTO').AsString;
    FProduto.Requer_Prescricao := FieldByName('REQUER_PRESCRICAO').AsString;
    FProduto.Valor := FieldByName('VALOR').AsFloat;
  end;
end;

function TProdutoService.GetProdutoInfo(ACodigo: Integer): TProdutoInfo;
begin
  Result.ValorUnitario := 1;
  Result.RequerPrescricao := 'N';
  Result.CondicoesArmazenamento := '';

  with QryTemp do
  begin
    SQL.Clear;
    SQL.Add('select valor, requer_prescricao, condicoes_armazenamento ');
    SQL.Add('from produto ');
    SQL.Add('where id_produto = :id_produto');
    ParamByName('ID_PRODUTO').AsInteger := ACodigo;
    Open;

    if not IsEmpty then
    begin
      Result.ValorUnitario := FieldByName('VALOR').AsFloat;
      Result.RequerPrescricao := FieldByName('REQUER_PRESCRICAO').AsString[1];
      Result.CondicoesArmazenamento := FieldByName('CONDICOES_ARMAZENAMENTO').AsString;
    end;
  end;
end;

function TProdutoService.GetDataSource: TDataSource;
begin
  Result := DsProdutos;
end;

end.
