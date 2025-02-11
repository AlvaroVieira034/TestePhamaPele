unit cliente.model;

interface

uses umain, System.SysUtils, FireDAC.Comp.Client, FireDAC.DApt;

type
  TCliente = class

  private
    FId_Cliente: Integer;
    FNome: string;
    FEndereco: string;
    FBairro: string;
    FCidade: string;
    FEstado: string;
    FCep: string;
    FTelefone: string;
    FEmail: string;
    procedure Set_Nome(const Value: string);

  public
    property Id_Cliente: Integer read FId_Cliente write FId_Cliente;
    property Nome: string read FNome write Set_Nome;
    property Endereco: string read FEndereco write FEndereco;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
    property Cep: string read FCep write FCep;
    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;


  end;

implementation

{ TCliente }

procedure TCliente.Set_Nome(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('O campo ''Nome do Cliente'' precisa ser preenchido !');

  FNome := Value;
end;

end.
