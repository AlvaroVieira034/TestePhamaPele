unit ipedidoitens.repository;

interface

uses pedidoitens.model, Data.DB, FireDAC.Comp.Client, System.SysUtils, System.Classes,
     System.Generics.Collections;

type
  IPedidoItensRepository = interface
    ['{E75EADFA-3EFD-4C22-B4D8-5162EE4B154C}']
    function CarregarItensPedido(ACodPedido: Integer): TList<TPedidoItens>;
    function Inserir(FPedidoItens: TPedidoItens; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro: string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
    procedure CriarTabelas;
  end;

implementation

end.
