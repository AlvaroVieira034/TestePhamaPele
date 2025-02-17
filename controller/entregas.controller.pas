unit entregas.controller;

interface

uses entregas.model, entregas.repository, ientregas.repository, entregas.service, ientregas.service, system.SysUtils,
     Vcl.Forms, FireDAC.Comp.Client, Data.DB;

type
  TEntregasController = class

  private
    FEntregas: TEntrega;
    FEntregasRepository: TEntregasRepository;
    FEntregasService: TEntregasService;
    FDataSource: TDataSource;

  public
    constructor Create(AEntregasRepository: IEntregasRepository; AEntregasService: IEntregasService);
    destructor Destroy; override;
    procedure PreencherGridPedidosPendentes;
    function Inserir(FEntregas: TEntrega; Transacao: TFDTransaction; var sErro: string): Boolean;
    function Alterar(FEntregas: TEntrega; ACodigo: Integer; sErro: string): Boolean;
    function Excluir(ACodigo: Integer; var sErro: string): Boolean;
    function GetDataSourcePedidos: TDataSource;
    function ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;

  end;

implementation

{ TEntregasController }


constructor TEntregasController.Create(AEntregasRepository: IEntregasRepository; AEntregasService: IEntregasService);
begin
  FEntregas := TEntrega.Create();
  FEntregasRepository := TEntregasRepository.Create();
  FEntregasService := TEntregasService.Create();
end;

destructor TEntregasController.Destroy;
begin
  FEntregas.Free;
  FEntregasRepository.Free;
  FEntregasService.Free;
  inherited;
end;

procedure TEntregasController.PreencherGridPedidosPendentes;
begin
  FEntregasService.PreencherGridPedidosPendentes();
end;

function TEntregasController.Inserir(FEntregas: TEntrega; Transacao: TFDTransaction; var sErro: string): Boolean;
begin
  Result := FEntregasRepository.Inserir(FEntregas, Transacao, sErro);
end;

function TEntregasController.Alterar(FEntregas: TEntrega; ACodigo: Integer; sErro: string): Boolean;
begin
  Result := FEntregasRepository.Alterar(FEntregas, ACodigo, sErro);
end;

function TEntregasController.Excluir(ACodigo: Integer; var sErro: string): Boolean;
begin
  Result := FEntregasRepository.Excluir(ACodigo, sErro);
end;

function TEntregasController.GetDataSourcePedidos: TDataSource;
begin
  Result := FEntregasService.GetDataSourcePedidos;
end;

function TEntregasController.ExecutarTransacao(AOperacao: TProc; var sErro: string): Boolean;
begin
  Result := FEntregasRepository.ExecutarTransacao(AOperacao, sErro);
end;



end.
