unit iinterface.service;

interface

uses Data.DB, FireDAC.Comp.Client;

type
  IInterfaceService<T> = interface
    ['{768F33E8-4061-4C96-AB10-509B6E149ABD}']
    procedure PreencherGridForm(APesquisa, ACampo: string);
    procedure PreencherComboBox(TblComboClientes: TFDQuery);
    procedure PreencherCamposForm(AEntity: T; ACodigo: Integer);
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation

end.
