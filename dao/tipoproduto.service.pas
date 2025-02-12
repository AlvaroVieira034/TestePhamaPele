unit tipoproduto.service;

interface

uses iinterface.service, conexao, tipoproduto.model, FireDAC.Comp.Client, FireDAC.Stan.Param, System.SysUtils,
     Data.DB;

type
  TTipoProdutoService = class(TInterfacedObject, IInterfaceService<TTipoProduto>)

  private
    TblTipoProdutos: TFDQuery;
    DsTipoProdutos: TDataSource;

  public
    constructor Create;
    destructor Destroy; override;
    procedure PreencherComboBox(TblTipoProdutos: TFDQuery);
    procedure PreencherGridForm(APesquisa, ACampo: string);
    procedure PreencherCamposForm(FTipoProduto: TTipoProduto; iCodigo: Integer);
    function GetDataSource: TDataSource;
    procedure CriarTabelas;

  end;

implementation

{ TProdutoService }

constructor TTipoProdutoService.Create;
begin
  CriarTabelas();
end;

destructor TTipoProdutoService.Destroy;
begin
  TblTipoProdutos.Free;
  DsTipoProdutos.Free;
  inherited Destroy;
end;

procedure TTipoProdutoService.CriarTabelas;
begin
  TblTipoProdutos := TConexao.GetInstance.Connection.CriarQuery;
  DsTipoProdutos := TConexao.GetInstance.Connection.CriarDataSource;
  DsTipoProdutos.DataSet := TblTipoProdutos;
end;

procedure TTipoProdutoService.PreencherComboBox(TblTipoProdutos: TFDQuery);
begin
  with TblTipoProdutos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from tipo_produto tpp order by tpp.descricao ');
    Open();
  end;
end;

procedure TTipoProdutoService.PreencherGridForm(APesquisa, ACampo: string);
begin

end;

procedure TTipoProdutoService.PreencherCamposForm(FTipoProduto: TTipoProduto; iCodigo: Integer);
begin

end;

function TTipoProdutoService.GetDataSource: TDataSource;
begin
  Result := DsTipoProdutos;
end;

end.
