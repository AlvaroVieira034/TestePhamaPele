unit pedidoitens.model;

interface

uses System.SysUtils, FireDAC.Comp.Client, System.Classes, System.Generics.Collections;

Type
  TPedidoItens = class
  private
    FId_Pedido_Itens: Integer;
    FId_Pedido: Integer;
    FId_Produto: Integer;
    FDescricao: string;
    FQuantidade: Integer;
    FValor_Unitario: Double;
    FValor_Item: Double;
    FRequer_Prescricao: string;
    FCondicoes_Armazenamento: string;
    procedure SetId_Produto(const Value: Integer);

  public
    property Id_Pedido_Itens: Integer read FId_Pedido_Itens write FId_Pedido_Itens;
    property Id_Pedido: Integer read FId_Pedido write FId_Pedido;
    property Id_Produto: Integer read FId_Produto write SetId_Produto;
    property Descricao: string read FDescricao write FDescricao;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property Valor_Unitario: Double read FValor_Unitario write FValor_Unitario;
    property Valor_Item: Double read FValor_Item write FValor_Item;
    property Requer_Prescricao: string read FRequer_Prescricao write FRequer_Prescricao;
    property Condicoes_Armazenamento: string read FCondicoes_Armazenamento write FCondicoes_Armazenamento;

  end;

implementation

{ TPedidoItens }

procedure TPedidoItens.SetId_Produto(const Value: Integer);
begin
  if Value = 0 then
    raise EArgumentException.Create('O campo ''Código do Produto'' precisa ser preenchido !');

  FId_Produto := Value;
end;

end.
