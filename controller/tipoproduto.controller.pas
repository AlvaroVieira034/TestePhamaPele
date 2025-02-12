unit tipoproduto.controller;

interface

uses tipoproduto.model, iinterface.repository, tipoproduto.service, iinterface.service, system.SysUtils,
     Vcl.Forms, FireDAC.Comp.Client, Data.DB;

type
  TTipoProdutoController = class

  private
    FTipoProduto: TTipoProduto;
    FTipoProdutoService: TTipoProdutoService;
    FDataSource: TDataSource;

  public
    constructor Create(ATipoProdutoService: IInterfaceService<TTipoProduto>);
    destructor Destroy; override;
    procedure PreencherComboTipoProdutos(TblTipoProdutos: TFDQuery);
    function GetDataSource: TDataSource;

  end;

implementation

{ TTipoProdutoController }

constructor TTipoProdutoController.Create(ATipoProdutoService: IInterfaceService<TTipoProduto>);
begin
  FTipoProduto := TTipoProduto.Create();
  FTipoProdutoService := TTipoProdutoService.Create;
end;

destructor TTipoProdutoController.Destroy;
begin
  FTipoProduto.Free;
  inherited;
end;

procedure TTipoProdutoController.PreencherComboTipoProdutos(TblTipoProdutos: TFDQuery);
begin
  FTipoProdutoService.PreencherComboBox(TblTipoProdutos);
end;

function TTipoProdutoController.GetDataSource: TDataSource;
begin
  Result := FTipoProdutoService.GetDataSource;
end;

end.
