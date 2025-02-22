unit pedido.controller;

interface

uses umain, Pedido.model, Pedido.service, iPedido.service, Pedido.repository, iPedido.repository,
     system.SysUtils, Vcl.Forms, FireDAC.Comp.Client, Data.DB;

type
  TPedidoController = class

  private
    FPedido: TPedido;
    FPedidoRepository : TPedidoRepository;
    FPedidoService : TPedidoService;

  public
    constructor Create(APedidoRepository: IPedidoRepository; APedidoService: IPedidoService);
    destructor Destroy; override;
    procedure PreencherGrid(TblPedidos: TFDQuery; APesquisa, ACampo: string);
    function CarregarCampos(FPedido: TPedido; ACodigo: Integer): Boolean;
    function Inserir(FPedido: TPedido; Transacao: TFDTransaction; var sErro: string): Boolean;
    function Alterar(FPedido: TPedido; ACodigo: Integer; sErro: string): Boolean;
    function Excluir(ACodigo: Integer; var sErro: string): Boolean;
    procedure AtulizarStatusEntrega(AStatus, APedido: Integer; var sErro: string);
    function ConcluirEntregaPedido(ADataEntrega: TDate; APedido: Integer; out sErro: string): Boolean;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
    function RetornaPrioridadeProduto(ACodigo: Integer): Integer;
    procedure ExibirSituacaoPedidos;
    function GetDataSource: TDataSource;

  end;

implementation

{ TPedidoController }

constructor TPedidoController.Create(APedidoRepository: IPedidoRepository; APedidoService: IPedidoService);
begin
  FPedido := TPedido.Create();
  FPedidoRepository := TPedidoRepository.Create();
  FPedidoService := TPedidoService.Create();
end;

destructor TPedidoController.Destroy;
begin
  FPedido.Free;
  FPedidoRepository.Free;
  FPedidoService.Free;
  inherited;
end;

procedure TPedidoController.PreencherGrid(TblPedidos: TFDQuery; APesquisa, ACampo: string);
var LCampo, sErro: string;
begin
  try
    if ACampo = 'Data' then
      LCampo := 'ped.data_pedido';

    if ACampo = 'Cliente' then
      LCampo := 'cli.nome';

    if ACampo = '' then
      LCampo := 'ped.data_pedido';

    FPedidoService.PreencherGridPedidos(TblPedidos, APesquisa, LCampo);
  except on E: Exception do
    begin
      sErro := 'Ocorreu um erro ao pesquisar o pedido!' + sLineBreak + E.Message;
      raise;
    end;
  end;
end;

function TPedidoController.CarregarCampos(FPedido: TPedido; ACodigo: Integer): Boolean;
var sErro: string;
begin
  try
    FPedidoService.PreencherCamposForm(FPedido, ACodigo);
    Result := True;
  except on E: Exception do
    begin
      sErro := 'Ocorreu um erro ao carregar o pedido!' + sLineBreak + E.Message;
      Result := False;
      raise;
    end;
  end;
end;

function TPedidoController.Inserir(FPedido: TPedido; Transacao: TFDTransaction; var sErro: string): Boolean;
begin
  Result := FPedidoRepository.Inserir(FPedido, Transacao, sErro);
end;

function TPedidoController.Alterar(FPedido: TPedido; ACodigo: Integer; sErro: string): Boolean;
begin
  Result := FPedidoRepository.Alterar(FPedido, ACodigo, sErro);
end;

function TPedidoController.Excluir(ACodigo: Integer; var sErro: string): Boolean;
begin
  Result := FPedidoRepository.Excluir(ACodigo, sErro);
end;

procedure TPedidoController.AtulizarStatusEntrega(AStatus, APedido: Integer; var sErro: string);
begin
  FPedidoRepository.AtulizarStatusEntrega(AStatus, APedido, sErro);
end;

function TPedidoController.ConcluirEntregaPedido(ADataEntrega: TDate; APedido: Integer; out sErro: string): Boolean;
begin
  Result := FPedidoRepository.ConcluirEntregaPedido(ADataEntrega, APedido, sErro)
end;

function TPedidoController.ExecutarTransacao(AOperacao: TProc;  var sErro: string): Boolean;
begin
  Result := FPedidoRepository.ExecutarTransacao(AOperacao, sErro);
end;

function TPedidoController.RetornaPrioridadeProduto(ACodigo: Integer): Integer;
begin
  Result := FPedidoService.RetornaPrioridadeProduto(ACodigo);
end;

procedure TPedidoController.ExibirSituacaoPedidos;
begin
  FPedidoService.ExibirSituacaoPedidos;
end;

function TPedidoController.GetDataSource: TDataSource;
begin
  Result := FPedidoService.GetDataSource;
end;

end.
