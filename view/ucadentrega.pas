unit ucadentrega;

interface

{$REGION 'Uses'}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Controls, conexao, entregador.model, entregador.controller, entregador.service,
  entregador.repository, entregas.model, entregas.controller, entregas.repository, ientregas.repository,
  entregas.service, ientregas.service, pedido.controller, pedido.repository, pedido.service, untFormat,
  System.Generics.Collections;

{$ENDREGION}

type
  TOperacao = (opInicio, opNovo, opEditar, opNavegar);
  TFrmCadEntrega = class(TForm)
    PnlTopo: TPanel;
    BtnInserir: TSpeedButton;
    BtnGravar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnSair: TSpeedButton;
    PnlDados: TPanel;
    GrbDados: TGroupBox;
    Label7: TLabel;
    LCbxNomeEntregador: TDBLookupComboBox;
    DbGridPedidos: TDBGrid;
    BtnAddItemGrid: TButton;
    PnlGrid: TPanel;
    LblTotRegistros: TLabel;
    GrbGrid: TGroupBox;
    BtnDelItemGrid: TButton;
    DbGridEntregas: TDBGrid;
    MTblEntregas: TFDMemTable;
    MTblEntregasID_PEDIDO: TIntegerField;
    MTblEntregasDATA_PEDIDO: TDateField;
    MTblEntregasVALOR_PEDIDO: TFloatField;
    MTblEntregasID_CLIENTE: TIntegerField;
    MTblEntregasCLIENTE: TStringField;
    MTblEntregasENDERECO: TStringField;
    MTblEntregasREQUER_PRESCRICAO: TStringField;
    MTblEntregasOBSERVACOES: TStringField;
    MTblEntregasPRIORIDADE: TIntegerField;
    DsEntregas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnAddItemGridClick(Sender: TObject);
    procedure BtnDelItemGridClick(Sender: TObject);
    procedure DbGridPedidosDblClick(Sender: TObject);

  private
    FEntregas: TEntrega;
    FPedidoController: TPedidoController;
    FPedidoRepository: TPedidoRepository;
    FEntregasController: TEntregasController;
    FEntregadorController: TEntregadorController;
    TblEntregadores: TFDQuery;
    DsEntregadores: TDataSource;
    Transacao : TFDTransaction;

    procedure PreencheCdsEntregas;
    procedure PreencherGridPedidosPendentes;
    function GravarDados: Boolean;
    procedure AtualizarBotaoDelItem;
    procedure VerificaBotoes(AOperacao: TOperacao);
    procedure AtulizarStatusEntrega;


  public
    FOperacao: TOperacao;
    DsPedidos: TDataSource;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FrmCadEntrega: TFrmCadEntrega;
  sErro: string;

implementation

{$R *.dfm}

{ TFrmCadEntrega }

constructor TFrmCadEntrega.Create(AOwner: TComponent);
begin
  inherited;
  DsPedidos := TDataSource.Create(nil);
  TblEntregadores := TFDQuery.Create(nil);
  DsEntregadores := TDataSource.Create(nil);
  Transacao := TFDTransaction.Create(nil);
end;

destructor TFrmCadEntrega.Destroy;
begin
  FEntregas.Free;
  FPedidoController.Free;
  FEntregasController.Free;
  FEntregadorController.Free;
  DsPedidos.Free;
  TblEntregadores.Free;
  DsEntregadores.Free;
  Transacao.Free;

  inherited Destroy;
end;

procedure TFrmCadEntrega.FormCreate(Sender: TObject);
begin
  if TConexao.GetInstance.Connection.TestarConexao then
  begin
    FEntregas := TEntrega.Create;
    FPedidoController := TPedidoController.Create(TPedidoRepository.Create, TPedidoService.Create);
    FEntregasController := TEntregasController.Create(TEntregasRepository.Create, TEntregasService.Create);
    FEntregadorController := TEntregadorController.Create(TEntregadorRepository.Create, TEntregadorService.Create);
    DBGridPedidos.DataSource := FEntregasController.GetDataSourcePedidos();
    DsPedidos.DataSet := FEntregasController.GetDataSourcePedidos.DataSet;
    Transacao := TConexao.GetInstance.Connection.CriarTransaction;

    // ComboBox Entregadores
    TblEntregadores := TConexao.GetInstance.Connection.CriarQuery;
    DsEntregadores := TConexao.GetInstance.Connection.CriarDataSource;
    DsEntregadores.DataSet := TblEntregadores;
    FEntregadorController := TEntregadorController.Create(TEntregadorRepository.Create, TEntregadorService.Create);
    LCbxNomeEntregador.KeyField := 'id_entregador';
    LCbxNomeEntregador.ListField := 'nome';
    LCbxNomeEntregador.ListSource := DsEntregadores;

    FOperacao := opInicio;
    AtualizarBotaoDelItem();
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;
end;

procedure TFrmCadEntrega.FormShow(Sender: TObject);
begin
  FEntregadorController.PreencherComboEntregadores(TblEntregadores);
  PreencherGridPedidosPendentes();
  VerificaBotoes(FOperacao);
  DbGridPedidos.Columns[0].Width := 50;
  DbGridPedidos.Columns[1].Width := 80;
  DbGridPedidos.Columns[2].Width := 90;
  DbGridPedidos.Columns[3].Width := 280;
  DbGridPedidos.Columns[4].Width := 300;
  DbGridPedidos.Columns[5].Width := 70;
  DbGridPedidos.Columns[6].Width := 700;
  DbGridPedidos.Columns[7].Width := 70;
  DbGridPedidos.Columns[8].Width := 70;

  DbGridEntregas.Columns[0].Width := 50;
  DbGridEntregas.Columns[1].Width := 80;
  DbGridEntregas.Columns[2].Width := 90;
  DbGridEntregas.Columns[3].Width := 280;
  DbGridEntregas.Columns[4].Width := 300;
  DbGridEntregas.Columns[5].Width := 70;
  DbGridEntregas.Columns[6].Width := 700;
  DbGridEntregas.Columns[7].Width := 70;
  DbGridEntregas.Columns[8].Width := 70;
end;

procedure TFrmCadEntrega.PreencherGridPedidosPendentes;
begin
  FEntregasController.PreencherGridPedidosPendentes;
end;

procedure TFrmCadEntrega.PreencheCdsEntregas;
var PedidoSelecionado: Variant;
begin
  if (LCbxNomeEntregador.KeyValue = 0) or (LCbxNomeEntregador.KeyValue = Null) then
  begin
     MessageDlg('O entregador do pedido deve ser informado!', mtWarning, [mbOk], 0);
     LCbxNomeEntregador.SetFocus;
     Exit;
  end;

  if not MTblEntregas.Active then
    MTblEntregas.Open;

  if not DsPedidos.DataSet.IsEmpty then
  begin
    PedidoSelecionado := DsPedidos.DataSet.FieldValues['ID_PEDIDO'];
    if not MTblEntregas.Locate('ID_PEDIDO', PedidoSelecionado, []) then
    begin
      // Adiciona o pedido à MTblEntregas
      MTblEntregas.Append;
      MTblEntregas.FieldByName('ID_PEDIDO').AsInteger := DsPedidos.DataSet.FieldByName('ID_PEDIDO').AsInteger;
      MTblEntregas.FieldByName('DATA_PEDIDO').AsDateTime := DsPedidos.DataSet.FieldByName('DATA_PEDIDO').AsDateTime;
      MTblEntregas.FieldByName('VALOR_PEDIDO').AsFloat := DsPedidos.DataSet.FieldByName('VALOR_PEDIDO').AsFloat;
      MTblEntregas.FieldByName('ID_CLIENTE').AsInteger := DsPedidos.DataSet.FieldByName('ID_CLIENTE').AsInteger;
      MTblEntregas.FieldByName('CLIENTE').AsString := DsPedidos.DataSet.FieldByName('CLIENTE').AsString;
      MTblEntregas.FieldByName('ENDERECO').AsString := DsPedidos.DataSet.FieldByName('ENDERECO').AsString;
      MTblEntregas.FieldByName('REQUER_PRESCRICAO').AsString := DsPedidos.DataSet.FieldByName('REQUER_PRESCRICAO').AsString;
      MTblEntregas.FieldByName('OBSERVACOES').AsString := DsPedidos.DataSet.FieldByName('OBSERVACOES').AsString;
      MTblEntregas.FieldByName('PRIORIDADE').AsInteger := DsPedidos.DataSet.FieldByName('PRIORIDADE').AsInteger;
      MTblEntregas.Post;
      AtualizarBotaoDelItem();
    end
    else
    begin
      MessageDlg('Este pedido já foi adicionado à lista de entregas!', mtError, [mbOk], 0);
    end;
  end;
end;

function TFrmCadEntrega.GravarDados: Boolean;
begin
  Result := False;
  if MTblEntregas.RecordCount = 0 then
  begin
    MessageDlg('Não existe itens cadastrados para entrega!', mtWarning, [mbOK],0);
    Exit;
  end;

  with FEntregas do
  begin
    Id_Pedido := MTblEntregasID_PEDIDO.AsInteger;
    Id_Cliente := MTblEntregasID_CLIENTE.AsInteger;
    Id_Entregador := LCbxNomeEntregador.KeyValue;
    Data_Pedido := MTblEntregasDATA_PEDIDO.AsDateTime;
    Valor_Pedido := MTblEntregasVALOR_PEDIDO.AsFloat;
    Observacoes := MTblEntregasOBSERVACOES.AsString;
    Prioridade := MTblEntregasPRIORIDADE.AsInteger;
  end;

  if not Transacao.Connection.Connected then
    Transacao.Connection.Open();

  Transacao.StartTransaction;
  try
    FEntregasController.Inserir(FEntregas, Transacao, sErro);
    Transacao.Commit;
    FPedidoController.AtulizarStatusEntrega(1, MTblEntregasID_PEDIDO.AsInteger, sErro);
    MessageDlg('Entrega inserida com sucesso!', mtInformation, [mbOK],0);
    PreencherGridPedidosPendentes();
    if MTblEntregas.Active then
      MTblEntregas.Close;

    Result := True;
  except
    on E: Exception do
    begin
      Transacao.Rollback;
      MTblEntregas.Close;
      VerificaBotoes(FOperacao);
      raise Exception.Create(sErro + #13 + E.Message);
    end;
  end;
end;

procedure TFrmCadEntrega.VerificaBotoes(AOperacao: TOperacao);
begin
  BtnInserir.Enabled := AOperacao in [opInicio, opNavegar];
  BtnSair.Enabled := AOperacao in [opInicio, opNavegar];

  BtnGravar.Enabled := AOperacao in [opNovo, opEditar];
  BtnCancelar.Enabled := AOperacao in [opNovo, opEditar];

  GrbDados.Enabled := AOperacao in [opNovo, opEditar];
  GrbGrid.Enabled := AOperacao in [opNovo, opEditar];
end;

procedure TFrmCadEntrega.AtualizarBotaoDelItem;
begin
  if (DsEntregas <> nil) and (DsEntregas.DataSet <> nil) then
    BtnDelItemGrid.Enabled := not DsEntregas.DataSet.IsEmpty
  else
    BtnDelItemGrid.Enabled := False;
end;

procedure TFrmCadEntrega.BtnInserirClick(Sender: TObject);
begin
  MTblEntregas.Active := False;
  GrbDados.Enabled := True;
  GrbGrid.Enabled := True;
  FOperacao := opNovo;
  VerificaBotoes(opNovo);
  LCbxNomeEntregador.SetFocus;
end;

procedure TFrmCadEntrega.BtnGravarClick(Sender: TObject);
begin
  if GravarDados() then
  begin
    FOperacao := opNavegar;
    VerificaBotoes(FOperacao);
    GrbDados.Enabled := False;
    GrbGrid.Enabled:= False;
  end;
end;

procedure TFrmCadEntrega.BtnCancelarClick(Sender: TObject);
begin
  if FOperacao = opNovo then
  begin
    FOperacao := opInicio;
    GrbDados.Enabled := True;
    GrbGrid.Enabled := True;
    VerificaBotoes(opInicio);
    if MTblEntregas.Active then
      MTblEntregas.Close;
  end;

  VerificaBotoes(FOperacao);
end;

procedure TFrmCadEntrega.BtnAddItemGridClick(Sender: TObject);
begin
  PreencheCdsEntregas();
  LCbxNomeEntregador.SetFocus;
end;

procedure TFrmCadEntrega.BtnDelItemGridClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro selecionado?', mtConfirmation, [mbYes, mbNo], mrNo) = mrNo then
    Exit
  else
  begin
    MTblEntregas.Locate('ID_PEDIDO', MTblEntregasID_PEDIDO.AsInteger, []);
    MTblEntregas.Delete;
    MTblEntregas.ApplyUpdates(0);
    AtualizarBotaoDelItem();
  end;
end;

procedure TFrmCadEntrega.DbGridPedidosDblClick(Sender: TObject);
begin
  PreencheCdsEntregas();
  LCbxNomeEntregador.SetFocus;
end;

procedure TFrmCadEntrega.AtulizarStatusEntrega;
begin

end;

procedure TFrmCadEntrega.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.
