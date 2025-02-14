unit entregador.repository;

interface

uses iinterface.repository, entregador.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TEntregadorRepository = class(TInterfacedObject, IInterfaceRepository<TEntregador>)

  private
    QryEntregadores: TFDQuery;
    QryTemp: TFDQuery;
    Transacao: TFDTransaction;

  public
    constructor Create;
    destructor Destroy; override;
    function Inserir(AEntity: TEntregador; out sErro: string): Boolean;
    function Alterar(AEntity: TEntregador; ACodigo: Integer; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro: string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;

  end;

implementation

{ TEntregadorRepository }

constructor TEntregadorRepository.Create;
begin
  Transacao := TConexao.GetInstance.Connection.CriarTransaction;
  QryEntregadores := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
  QryEntregadores.Transaction := Transacao;
end;

destructor TEntregadorRepository.Destroy;
begin
  QryEntregadores.Free;
  inherited;
end;

function TEntregadorRepository.Inserir(AEntity: TEntregador; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryEntregadores, AEntity do
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into entregador(');
        SQL.Add('nome, ');
        SQL.Add('veiculo, ');
        SQL.Add('placa, ');
        SQL.Add('telefone) ');
        SQL.Add('values (:nome, ');
        SQL.Add(':veiculo, ');
        SQL.Add(':placa, ');
        SQL.Add(':telefone) ');

        ParamByName('NOME').AsString := Nome;
        ParamByName('VEICULO').AsString := Veiculo;
        ParamByName('PLACA').AsString := Placa;
        ParamByName('TELEFONE').AsString := Telefone;

        ExecSQL;
      end;
    end, sErro);
end;

function TEntregadorRepository.Alterar(AEntity: TEntregador; ACodigo: Integer; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryEntregadores, AEntity do
      begin
        Close;
        SQL.Clear;
        SQL.Add('update entregador set ');
        SQL.Add('nome = :nome, ');
        SQL.Add('veiculo = :veiculo, ');
        SQL.Add('placa = :placa, ');
        SQL.Add('telefone = :telefone ');
        SQL.Add('where id_entregador = :id_entregador');

        ParamByName('NOME').AsString := Nome;
        ParamByName('VEICULO').AsString := Veiculo;
        ParamByName('PLACA').AsString := Placa;
        ParamByName('TELEFONE').AsString := Telefone;
        ParamByName('ID_ENTREGADOR').AsInteger := ACodigo;

        ExecSQL;
      end;
    end, sErro);
end;

function TEntregadorRepository.Excluir(ACodigo: Integer; out sErro: string): Boolean;
begin
  Result := ExecutarTransacao(
    procedure
    begin
      with QryEntregadores do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'delete from entregador where id_entregador = :id_entregador';
        ParamByName('ID_ENTREGADOR').AsInteger := ACodigo;

        ExecSQL;
      end;
    end, sErro);
end;

function TEntregadorRepository.ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
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
        sErro := 'Ocorreu um erro ao excluir o entregador!' + sLineBreak + E.Message;
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
