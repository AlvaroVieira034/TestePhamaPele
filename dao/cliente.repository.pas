unit cliente.repository;

interface

uses iinterface.repository, cliente.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TClienteRepository = class(TInterfacedObject, IInterfaceRepository<TCliente>)

  private
    QryClientes: TFDQuery;
    QryTemp: TFDQuery;
    Transacao: TFDTransaction;

  public
    constructor Create;
    destructor Destroy; override;
    function Inserir(AEntity: TCliente; out sErro: string): Boolean;
    function Alterar(AEntity: TCliente; ACodigo: Integer; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro: string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;

  end;

implementation

{ TProdutoRepository }

constructor TClienteRepository.Create;
begin
  inherited Create;
  Transacao := TConexao.GetInstance.Connection.CriarTransaction;
  QryClientes := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
  QryClientes.Transaction := Transacao;
end;

destructor TClienteRepository.Destroy;
begin
  QryClientes.Free;
  inherited;
end;

function TClienteRepository.Inserir(AEntity: TCliente; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryClientes, AEntity do
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into cliente(');
        SQL.Add('nome, ');
        SQL.Add('endereco, ');
        SQL.Add('bairro, ');
        SQL.Add('cidade, ');
        SQL.Add('estado, ');
        SQL.Add('cep, ');
        SQL.Add('telefone, ');
        SQL.Add('email) ');
        SQL.Add('values (:nome, ');
        SQL.Add(':endereco, ');
        SQL.Add(':bairro, ');
        SQL.Add(':cidade, ');
        SQL.Add(':estado, ');
        SQL.Add(':cep, ');
        SQL.Add(':telefone, ');
        SQL.Add(':email) ');

        ParamByName('NOME').AsString := Nome;
        ParamByName('ENDERECO').AsString := Endereco;
        ParamByName('BAIRRO').AsString := Bairro;
        ParamByName('CIDADE').AsString := Cidade;
        ParamByName('estado').AsString := estado;
        ParamByName('CEP').AsString := Cep;
        ParamByName('TELEFONE').AsString := Telefone;
        ParamByName('EMAIL').AsString := Email;

        ExecSQL;
      end;
    end, sErro);
end;

function TClienteRepository.Alterar(AEntity: TCliente; ACodigo: Integer; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryClientes, AEntity do
      begin
        Close;
        SQL.Clear;
        SQL.Add('update cliente set ');
        SQL.Add('nome = :nome, ');
        SQL.Add('endereco = :endereco, ');
        SQL.Add('bairro = :bairro, ');
        SQL.Add('cidade = :cidade, ');
        SQL.Add('estado = :estado, ');
        SQL.Add('cep = :cep, ');
        SQL.Add('telefone = :telefone, ');
        SQL.Add('email = :email ');
        SQL.Add('where id_cliente = :id_cliente');

        ParamByName('NOME').AsString := Nome;
        ParamByName('ENDERECO').AsString := Endereco;
        ParamByName('BAIRRO').AsString := Bairro;
        ParamByName('CIDADE').AsString := Cidade;
        ParamByName('ESTADO').AsString := estado;
        ParamByName('CEP').AsString := Cep;
        ParamByName('TELEFONE').AsString := Telefone;
        ParamByName('EMAIL').AsString := Email;
        ParamByName('ID_CLIENTE').AsInteger := ACodigo;

        ExecSQL;
      end;
    end, sErro);
end;

function TClienteRepository.Excluir(ACodigo: Integer; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryClientes do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'delete from cliente where id_cliente = :id_cliente';
        ParamByName('ID_CLIENTE').AsInteger := ACodigo;

        ExecSQL;
      end;
    end, sErro);
end;

function TClienteRepository.ExecutarTransacao(AOperacao: TProc;  var sErro: string): Boolean;
begin
  Result := False;
  if not Transacao.Connection.Connected then
    Transacao.Connection.Open();
  try
    Transacao.StartTransaction;
    try
      AOperacao;
      Transacao.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Transacao.Rollback;
        sErro := 'Ocorreu um erro ao excluir o cliente!' + sLineBreak + E.Message;
        raise;
      end;
    end;
  except
    on E: Exception do
    begin
      sErro := 'Erro na conexão com o banco de dados: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

end.
