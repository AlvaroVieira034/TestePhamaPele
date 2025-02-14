unit ipedido.service;

interface

uses pedido.model, Data.DB, FireDAC.Comp.Client;

type
  IPedidoService = interface
    ['{40039F27-F56D-4C71-AA2A-961BFD73B664}']
    procedure PreencherGridPedidos(TblPedidos: TFDQuery; APesquisa, ACampo: string);
    procedure PreencherCamposForm(FPedido: TPedido; ACodigo: Integer);

  end;

implementation

end.
