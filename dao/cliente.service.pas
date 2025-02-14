unit cliente.service;

interface

uses iinterface.service, cliente.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TClienteService = class(TInterfacedObject, IInterfaceService<TCliente>)

  private
    TblClientes: TFDQuery;
    QryTemp: TFDQuery;
    DsClientes: TDataSource;

  public
    constructor Create;
    destructor Destroy; override;
    procedure PreencherGridForm(APesquisa, ACampo: string);
    procedure PreencherComboBox(TblClientes: TFDQuery);
    procedure PreencherCamposForm(FCliente: TCliente; ACodigo: Integer);
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation

{ TClienteService }

constructor TClienteService.Create;
begin
  CriarTabelas();
end;

destructor TClienteService.Destroy;
begin
  TblClientes.Free;
  QryTemp.Free;
  DsClientes.Free;
  inherited;
end;

procedure TClienteService.CriarTabelas;
begin
  TblClientes := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
  DsClientes := TConexao.GetInstance.Connection.CriarDataSource;
  DsClientes.DataSet := TblClientes;
end;

function TClienteService.GetDataSource: TDataSource;
begin
  Result := DsClientes;
end;

procedure TClienteService.PreencherGridForm(APesquisa, ACampo: string);
begin
  with TblClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select cli.id_cliente,  ');
    SQL.Add('cli.nome, ');
    SQL.Add('cli.endereco, ');
    SQL.Add('cli.bairro, ');
    SQL.Add('cli.cidade, ');
    SQL.Add('cli.estado, ');
    SQL.Add('cli.cep, ');
    SQL.Add('cli.telefone, ');
    SQL.Add('cli.email ');
    SQL.Add('from cliente cli');
    SQL.Add('where ' + ACampo + ' like :PNAME');
    SQL.Add('order by ' + ACampo);
    ParamByName('PNAME').AsString := APesquisa;
    Open();
  end;
end;

procedure TClienteService.PreencherComboBox(TblClientes: TFDQuery);
begin
  with TblClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from cliente order by nome ');
    Open();
  end;
end;

procedure TClienteService.PreencherCamposForm(FCliente: TCliente; ACodigo: Integer);
begin
  with QryTemp do
  begin
    SQL.Clear;
    SQL.Add('select cli.id_cliente,  ');
    SQL.Add('cli.nome, ');
    SQL.Add('cli.endereco, ');
    SQL.Add('cli.bairro, ');
    SQL.Add('cli.cidade, ');
    SQL.Add('cli.estado, ');
    SQL.Add('cli.cep, ');
    SQL.Add('cli.telefone, ');
    SQL.Add('cli.email ');
    SQL.Add('from cliente cli');
    SQL.Add('where id_cliente = :id_cliente');
    ParamByName('ID_CLIENTE').AsInteger := ACodigo;
    Open;

    FCliente.Id_Cliente := FieldByName('ID_CLIENTE').AsInteger;
    FCliente.Nome := FieldByName('NOME').AsString;
    FCliente.Endereco := FieldByName('ENDERECO').AsString;
    FCliente.Bairro := FieldByName('BAIRRO').AsString;
    FCliente.Cidade := FieldByName('CIDADE').AsString;
    FCliente.Estado := FieldByName('ESTADO').AsString;
    FCliente.Cep := FieldByName('CEP').AsString;
    FCliente.Telefone := FieldByName('TELEFONE').AsString;
    FCliente.Email := FieldByName('EMAIL').AsString;
  end;
end;

end.
