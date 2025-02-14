unit entregador.model;

interface

uses umain, System.SysUtils, FireDAC.Comp.Client, FireDAC.DApt;

type
  TEntregador = class

  private
    FId_Entregador: Integer;
    FNome: string;
    FVeiculo: string;
    FPlaca: string;
    FTelefone: string;
    procedure Set_Nome(const Value: string);

  public
    property Id_Entregador: Integer read FId_Entregador write FId_Entregador;
    property Nome: string read FNome write Set_Nome;
    property Veiculo: string read FVeiculo write FVeiculo;
    property Placa: string read FPlaca write FPlaca;
    property Telefone: string read FTelefone write FTelefone;

  end;

implementation

{ TEntregador }

procedure TEntregador.Set_Nome(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('O campo ''Nome do Entregador'' precisa ser preenchido !');

  FNome := Value;
end;

end.
