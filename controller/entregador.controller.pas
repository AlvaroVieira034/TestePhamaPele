unit entregador.controller;

interface

uses entregador.model, entregador.repository, iinterface.repository, entregador.service, iinterface.service, conexao,
     System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type
  TCampoInvalido = (ciNome, ciVeiculo, ciTelefone);
  TEntregadorController = class

  private
    FEntregador: TEntregador;
    FEntregadorRepository : TEntregadorRepository;
    FEntregadorService : TEntregadorService;

  public
    constructor Create(AEntregadorRepository: IInterfaceRepository<TEntregador>; AEntregadorService: IInterfaceService<TEntregador>);
    destructor Destroy; override;
    procedure PreencherGridEntregadores(APesquisa, ACampo: string);
    procedure PreencherCamposForm(FEntregador: TEntregador; ACodigo: Integer);
    procedure PreencherComboEntregadores(TblComboEntregadores: TFDQuery);
    function Inserir(FEntregador: TEntregador; out sErro: string): Boolean;
    function Alterar(FEntregador: TEntregador; ACodigo: Integer; out sErro: string): Boolean;
    function Excluir(ACodigo: Integer; out sErro : string): Boolean;
    function ValidarDados(const ANome, AVeiculo, ATelefone: string; out AErro: TCampoInvalido): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
    function GetDataSource: TDataSource;

  end;

implementation

{ TEntregadorController }

constructor TEntregadorController.Create(AEntregadorRepository: IInterfaceRepository<TEntregador>; AEntregadorService: IInterfaceService<TEntregador>);
begin
  FEntregador := TEntregador.Create();
  FEntregadorRepository := TEntregadorRepository.Create;
  FEntregadorService := TEntregadorService.Create;
end;

destructor TEntregadorController.Destroy;
begin
  FEntregador.Free;
  FEntregadorRepository.Free;
  FEntregadorService.Free;
  inherited Destroy;;
end;

procedure TEntregadorController.PreencherGridEntregadores(APesquisa, ACampo: string);
var LCampo, SErro: string;
begin
  try
    if ACampo = 'Código' then
      LCampo := 'ent.id_entregador';

    if ACampo = 'Nome' then
      LCampo := 'ent.nome';

    if ACampo = 'Veículo' then
      LCampo := 'ent.veiculo';

    if ACampo = '' then
      LCampo := 'ent.nome';

    FEntregadorService.PreencherGridForm(APesquisa, LCampo);
  except on E: Exception do
    begin
      SErro := 'Ocorreu um erro ao pesquisar o entregador!' + sLineBreak + E.Message;
      raise;
    end;
  end;
end;

procedure TEntregadorController.PreencherCamposForm(FEntregador: TEntregador; ACodigo: Integer);
var sErro: string;
begin
  try
    FEntregadorService.PreencherCamposForm(FEntregador, ACodigo);
  except on E: Exception do
    begin
      sErro := 'Ocorreu um erro ao carregar o entregador!' + sLineBreak + E.Message;
      raise;
    end;
  end;
end;

procedure TEntregadorController.PreencherComboEntregadores(TblComboEntregadores: TFDQuery);
begin
  FEntregadorService.PreencherComboBox(TblComboEntregadores);
end;

function TEntregadorController.Inserir(FEntregador: TEntregador; out sErro: string): Boolean;
begin
  Result := FEntregadorRepository.Inserir(FEntregador, sErro);
end;

function TEntregadorController.Alterar(FEntregador: TEntregador; ACodigo: Integer; out sErro: string): Boolean;
begin
  Result := FEntregadorRepository.Alterar(FEntregador, ACodigo, sErro);
end;

function TEntregadorController.Excluir(ACodigo: Integer; out sErro: string): Boolean;
begin
  Result := FEntregadorRepository.Excluir(ACodigo, sErro);
end;

function TEntregadorController.ValidarDados(const ANome, AVeiculo, ATelefone: string; out AErro: TCampoInvalido): Boolean;
begin
  if ANome = EmptyStr then
  begin
    AErro := ciNome;
    Exit;
  end;

  if AVeiculo = EmptyStr then
  begin
    AErro := ciVeiculo;
    Exit;
  end;

  if ATelefone = EmptyStr then
  begin
    AErro := ciTelefone;
    Exit;
  end;

  Result := True;
end;

function TEntregadorController.ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
begin
  Result := FEntregadorRepository.ExecutarTransacao(AOperacao, sErro);
end;

function TEntregadorController.GetDataSource: TDataSource;
begin
  Result := FEntregadorService.GetDataSource;
end;

end.
