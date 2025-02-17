unit ientregas.repository;

interface

uses entregas.model, Data.DB, FireDAC.Comp.Client, System.SysUtils;

type
  IEntregasRepository = interface
    ['{FD5CD3F4-955A-4E16-B82E-F1599D24CF73}']
    function Inserir(FEntregas: TEntrega; Transacao: TFDTransaction; out sErro: string): Boolean;
    function Alterar(FEntregas: TEntrega; ACodigo: Integer; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro : string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
    procedure CriarTabelas;

  end;

implementation

end.
