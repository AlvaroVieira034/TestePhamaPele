unit umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList;

type
  TFrmMain = class(TForm)
    PanelBotoesMenu: TPanel;
    BtnSair: TSpeedButton;
    BtnPedidos: TSpeedButton;
    BtnProdutos: TSpeedButton;
    BtnClientes: TSpeedButton;
    ImageList: TImageList;
    Timer1: TTimer;
    BtnCriarEntregas: TSpeedButton;
    BtnVerEntregas: TSpeedButton;
    BtnEntregadores: TSpeedButton;
    procedure BtnClientesClick(Sender: TObject);
    procedure BtnProdutosClick(Sender: TObject);
    procedure BtnPedidosClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnEntregadoresClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses ucadcliente, ucadproduto, ucadentregador, ucadpedido;

procedure TFrmMain.BtnClientesClick(Sender: TObject);
begin
  if not Assigned(FrmCadCliente) then
    FrmCadCliente := TFrmCadCliente.Create(Self);

  FrmCadCliente.ShowModal;
  FrmCadCliente.Free;
  FrmCadCliente := nil;
end;

procedure TFrmMain.BtnProdutosClick(Sender: TObject);
begin
  if not Assigned(FrmCadProduto) then
    FrmCadProduto := TFrmCadProduto.Create(Self);

  FrmCadProduto.ShowModal;
  FrmCadProduto.Free;
  FrmCadProduto := nil;
end;

procedure TFrmMain.BtnEntregadoresClick(Sender: TObject);
begin
  if not Assigned(FrmCadEntregador) then
    FrmCadEntregador := TFrmCadEntregador.Create(Self);

  FrmCadEntregador.ShowModal;
  FrmCadEntregador.Free;
  FrmCadEntregador := nil;
end;

procedure TFrmMain.BtnPedidosClick(Sender: TObject);
begin
  if not Assigned(FrmCadPedido) then
    FrmCadPedido := TFrmCadPedido.Create(Self);

  FrmCadPedido.ShowModal;
  FrmCadPedido.Free;
  FrmCadPedido := nil;
end;

procedure TFrmMain.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.
