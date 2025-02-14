unit ipedido.repository;

interface

uses pedido.model, Data.DB, FireDAC.Comp.Client, System.SysUtils;

type
  IPedidoRepository = interface
    ['{473481D2-41FB-4743-9697-E83D7144AAEF}']
    function Inserir(FPedido: TPedido; Transacao: TFDTransaction; out sErro: string): Boolean;
    function Alterar(FPedido: TPedido; ACodigo: Integer; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro : string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
    procedure CriarTabelas;

  end;

implementation


end.
