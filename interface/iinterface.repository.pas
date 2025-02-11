unit iinterface.repository;

interface

uses cliente.model, produto.model, Data.DB, System.SysUtils;

type
  IInterfaceRepository<T> = interface
    ['{4DEDD214-181D-4FCD-89D0-AEE846C957FF}']
    function Inserir(AEntity: T; out sErro: string): Boolean;
    function Alterar(AEntity: T; ACodigo: Integer; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro : string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;

  end;

implementation

end.
