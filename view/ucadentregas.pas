unit ucadentregas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ucadastropadrao, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TFrmCadEntregas = class(TFrmCadastroPadrao)
    Label7: TLabel;
    LCbxNomeEntregador: TDBLookupComboBox;
    DbGridPedidos: TDBGrid;
    DBGrid1: TDBGrid;
    BtnDelItemGrid: TButton;
    BtnAddItemGrid: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadEntregas: TFrmCadEntregas;

implementation

{$R *.dfm}

end.
