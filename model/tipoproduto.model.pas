unit tipoproduto.model;

interface

uses System.SysUtils, FireDAC.Comp.Client, FireDAC.DApt;

type
  TTipoProduto = class

  private
    FId_Tipo_Produto: Integer;
    FDescricao: string;
    procedure SetDescricao(const Value: string);

  public
    property Id_Tipo_Produto: Integer read FId_Tipo_Produto write FId_Tipo_Produto;
    property Descricao: string read FDescricao write SetDescricao;

  end;

implementation

{ TTipoProduto }

procedure TTipoProduto.SetDescricao(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('O campo ''Descrição'' precisa ser preenchido !');

  FDescricao := Value;
end;

end.
