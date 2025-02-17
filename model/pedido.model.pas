unit pedido.model;

interface

uses umain, System.SysUtils, FireDAC.Comp.Client;

Type
  TPedido = class
  private
    FId_Pedido: Integer;
    FData_Pedido: TDateTime;
    FId_Cliente: Integer;
    FDes_Cliente: string;
    FValor_Pedido: Double;
    FStatus_Entrega: Integer;
    FPrioridade: Integer;
    procedure SetId_Cliente(const Value: Integer);

  public
    property Id_Pedido: Integer read FId_Pedido write FId_Pedido;
    property Data_Pedido: TDateTime read FData_Pedido write FData_Pedido;
    property Id_Cliente: Integer read FId_Cliente write SetId_Cliente;
    property Des_Cliente: string read FDes_Cliente write FDes_Cliente;
    property Valor_Pedido: Double read FValor_Pedido write FValor_Pedido;
    property Status_Entrega: Integer read FStatus_Entrega write FStatus_Entrega;
    property Prioridade: Integer read FPrioridade write FPrioridade;

  end;

implementation

{ TPedido }

procedure TPedido.SetId_Cliente(const Value: Integer);
begin
  if Value = 0 then
    raise EArgumentException.Create('O campo ''Código do Cliente'' precisa ser preenchido!');

  FId_Cliente := Value;
end;

end.
