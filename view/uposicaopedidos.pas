unit uposicaopedidos;

interface


{$REGION 'Uses'}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Controls, conexao, entregador.model, entregador.controller, entregador.service,
  entregador.repository, entregas.model, entregas.controller, entregas.repository, ientregas.repository,
  entregas.service, ientregas.service, pedido.controller, pedido.repository, pedido.service, untFormat,
  System.Generics.Collections;

{$ENDREGION}

type
  TFrmPosicaoPedido = class(TForm)
    PnlTopo: TPanel;
    BtnGravar: TSpeedButton;
    BtnSair: TSpeedButton;
    PnlDados: TPanel;
    GrbDados: TGroupBox;
    DbGridPedidos: TDBGrid;
    procedure BtnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DbGridPedidosDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    FEntregas: TEntrega;
    FPedidoController: TPedidoController;
    FPedidoRepository: TPedidoRepository;
    FEntregasController: TEntregasController;
    FEntregadorController: TEntregadorController;
    Transacao : TFDTransaction;

    procedure PreencherGridPedidos;
    function GravarDados: Boolean;
    procedure VerificaBotoes(AOperacao: TOperacao);
    function GetDataSource: TDataSource;

  public
    FOperacao: TOperacao;
    DsPedidos: TDataSource;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FrmPosicaoPedido: TFrmPosicaoPedido;

implementation

{$R *.dfm}

constructor TFrmPosicaoPedido.Create(AOwner: TComponent);
begin
  inherited;
  DsPedidos := TDataSource.Create(nil);
end;

destructor TFrmPosicaoPedido.Destroy;
begin
  DsPedidos.Free;

  inherited Destroy;
end;

procedure TFrmPosicaoPedido.FormCreate(Sender: TObject);
begin
  if TConexao.GetInstance.Connection.TestarConexao then
  begin
    FPedidoController := TPedidoController.Create(TPedidoRepository.Create, TPedidoService.Create);
    Transacao := TConexao.GetInstance.Connection.CriarTransaction;
    GetDataSource();
    FOperacao := opInicio;
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;
end;

procedure TFrmPosicaoPedido.FormShow(Sender: TObject);
begin
  PreencherGridPedidos();
  VerificaBotoes(FOperacao);
  DbGridPedidos.Columns[0].Width := 50;
  DbGridPedidos.Columns[1].Width := 80;
  DbGridPedidos.Columns[2].Width := 90;
  DbGridPedidos.Columns[3].Width := 100;
  DbGridPedidos.Columns[4].Width := 300;
  DbGridPedidos.Columns[5].Width := 300;
  DbGridPedidos.Columns[6].Width := 70;
  DbGridPedidos.Columns[7].Width := 700;
  DbGridPedidos.Columns[8].Width := 80;
  DbGridPedidos.Columns[9].Width := 300;
end;

procedure TFrmPosicaoPedido.PreencherGridPedidos;
begin
  FPedidoController.ExibirSituacaoPedidos;
end;

function TFrmPosicaoPedido.GetDataSource: TDataSource;
begin
  DbGridPedidos.DataSource := FPedidoController.GetDataSource();
end;

function TFrmPosicaoPedido.GravarDados: Boolean;
begin
//-
end;

procedure TFrmPosicaoPedido.VerificaBotoes(AOperacao: TOperacao);
begin
//-
end;

procedure TFrmPosicaoPedido.DbGridPedidosDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.FieldName = 'STATUS' then
  begin
    if Column.Field.AsString = 'Pendente'  then
      DbGridPedidos.Canvas.Font.Color := clRed;

    if Column.Field.AsString = 'Em Andamento'  then
      DbGridPedidos.Canvas.Font.Color := clYellow;

    if Column.Field.AsString = 'Entregue'  then
      DbGridPedidos.Canvas.Font.Color := clGreen;
  end;

  DbGridPedidos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmPosicaoPedido.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.
