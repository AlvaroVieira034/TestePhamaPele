unit umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmMain = class(TForm)
    PanelBotoesMenu: TPanel;
    BtnSair: TSpeedButton;
    BtnVendas: TSpeedButton;
    BtnProdutos: TSpeedButton;
    BtnClientes: TSpeedButton;
    procedure BtnClientesClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses ucadcliente;

procedure TFrmMain.BtnClientesClick(Sender: TObject);
begin
  if not Assigned(FrmCadCliente) then
    FrmCadCliente := TFrmCadCliente.Create(Self);

  FrmCadCliente.ShowModal;
  FrmCadCliente.Free;
  FrmCadCliente := nil;
end;

procedure TFrmMain.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.
