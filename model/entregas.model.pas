unit entregas.model;

interface

uses umain, System.SysUtils, FireDAC.Comp.Client;

Type
  TEntrega = class
  private
    FId_Entrega: Integer;
    FId_Pedido: Integer;
    FId_Cliente: Integer;
    FCliente: string;
    FId_Entregador: Integer;
    FData_Pedido: TDateTime;
    FData_Entrega: TDateTime;
    FValor_Pedido: Double;
    FObservacoes: string;
    FPrioridade: Integer;

  public
    property Id_Entrega: Integer read FId_Entrega write FId_Entrega;
    property Id_Pedido: Integer read FId_Pedido write FId_Pedido;
    property Id_Cliente: Integer read FId_Cliente write FId_Cliente;
    property Cliente: string read FCliente write FCliente;
    property Id_Entregador: Integer read FId_Entregador write FId_Entregador;
    property Data_Pedido: TDateTime read FData_Pedido write FData_Pedido;
    property Data_Entrega: TDateTime read FData_Entrega write FData_Entrega;
    property Valor_Pedido: Double read FValor_Pedido write FValor_Pedido;
    property Prioridade: Integer read FPrioridade write FPrioridade;
    property Observacoes: string read FObservacoes write FObservacoes;

  end;

implementation

{ TEntrega }


end.
