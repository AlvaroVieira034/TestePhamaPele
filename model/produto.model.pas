unit produto.model;

interface

uses System.SysUtils, FireDAC.Comp.Client, FireDAC.DApt;

type
  TProduto = class

  private
    FId_Produto: Integer;
    FNome: string;
    FCodigo: string;
    FQuantidade: string;
    FData_Validade: TDateTime;
    FId_Tipo_Produto: Integer;
    FRequer_Prescricao: string;
    FCondicoes_Armazenamento: string;
    FValor: Double;
    procedure SetNome(const Value: string);

  public
    property Id_Produto: Integer read FId_Produto write FId_Produto;
    property Nome: string read FNome write SetNome;
    property Codigo: string read FCodigo write FCodigo;
    property Quantidade: string read FQuantidade write FQuantidade;
    property Data_Validade: TDateTime read FData_Validade write FData_Validade;
    property Id_Tipo_Produto: Integer read FId_Tipo_Produto write FId_Tipo_Produto;
    property Requer_Prescricao: string read FRequer_Prescricao write FRequer_Prescricao;
    property Condicoes_Armazenamento: string read FCondicoes_Armazenamento write FCondicoes_Armazenamento;
    property Valor: Double read FValor write FValor;

  end;

implementation

{ TProduto }

procedure TProduto.SetNome(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('O campo ''Nome do produto'' precisa ser preenchido !');

  FNome := Value;
end;

end.


