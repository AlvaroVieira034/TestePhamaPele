unit entregador.service;

interface

uses iinterface.service, entregador.model, conexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
     Data.DB;

type
  TEntregadorService = class(TInterfacedObject, IInterfaceService<TEntregador>)

  private
    TblEntregadores: TFDQuery;
    QryTemp: TFDQuery;
    DsEntregadores: TDataSource;

  public
    constructor Create;
    destructor Destroy; override;
    procedure PreencherGridForm(APesquisa, ACampo: string);
    procedure PreencherComboBox(TblEntregadores: TFDQuery);
    procedure PreencherCamposForm(FEntregador: TEntregador; ACodigo: Integer);
    procedure CriarTabelas;
    function GetDataSource: TDataSource;

  end;

implementation

{ TEntregadorService }

constructor TEntregadorService.Create;
begin
  CriarTabelas();
end;

destructor TEntregadorService.Destroy;
begin
  TblEntregadores.Free;
  QryTemp.Free;
  DsEntregadores.Free;
  inherited;
end;

procedure TEntregadorService.PreencherGridForm(APesquisa, ACampo: string);
begin
  with TblEntregadores do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ent.id_entregador,  ');
    SQL.Add('ent.nome, ');
    SQL.Add('ent.veiculo, ');
    SQL.Add('ent.placa, ');
    SQL.Add('ent.telefone ');
    SQL.Add('from entregador ent');
    SQL.Add('where ' + ACampo + ' like :PNAME');
    SQL.Add('order by ' + ACampo);
    ParamByName('PNAME').AsString := APesquisa;
    Open();
  end;
end;

procedure TEntregadorService.PreencherComboBox(TblEntregadores: TFDQuery);
begin
  with TblEntregadores do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from entregador order by nome ');
    Open();
  end;
end;

procedure TEntregadorService.PreencherCamposForm(FEntregador: TEntregador; ACodigo: Integer);
begin
  with QryTemp do
  begin
    SQL.Clear;
    SQL.Add('select ent.id_entregador,  ');
    SQL.Add('ent.nome, ');
    SQL.Add('ent.veiculo, ');
    SQL.Add('ent.placa, ');
    SQL.Add('ent.telefone ');
    SQL.Add('from entregador ent');
    SQL.Add('where id_entregador = :id_entregador');
    ParamByName('ID_ENTREGADOR').AsInteger := ACodigo;
    Open;

    FEntregador.Id_Entregador := FieldByName('ID_ENTREGADOR').AsInteger;
    FEntregador.Nome := FieldByName('NOME').AsString;
    FEntregador.Veiculo := FieldByName('VEICULO').AsString;
    FEntregador.Placa := FieldByName('PLACA').AsString;
    FEntregador.Telefone := FieldByName('TELEFONE').AsString;
  end;
end;

procedure TEntregadorService.CriarTabelas;
begin
  TblEntregadores := TConexao.GetInstance.Connection.CriarQuery;
  QryTemp := TConexao.GetInstance.Connection.CriarQuery;
  DsEntregadores := TConexao.GetInstance.Connection.CriarDataSource;
  DsEntregadores.DataSet := TblEntregadores;
end;

function TEntregadorService.GetDataSource: TDataSource;
begin
  Result := DsEntregadores;
end;


end.
