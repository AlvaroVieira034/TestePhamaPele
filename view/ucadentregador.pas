unit ucadentregador;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ucadastropadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cep.service,
  conexao, entregador.model, entregador.controller, entregador.repository, entregador.service,
  System.UITypes, System.SysUtils;

{$ENDREGION}

type
  TOperacao = (opInicio, opNovo, opEditar, opNavegar);
  TFrmCadEntregador = class(TFrmCadastroPadrao)

{$REGION 'Componentes'}
    PnlPesquisar: TPanel;
    BtnPesquisar: TSpeedButton;
    Label12: TLabel;
    DbGridEntregadores: TDBGrid;
    EdtPesquisar: TEdit;
    CbxFiltro: TComboBox;
    Label8: TLabel;
    EdtCodigoEntregador: TEdit;
    EdtNome: TEdit;
    Label3: TLabel;
    EdtTelefone: TEdit;
    EdtVeiculo: TEdit;
    Label4: TLabel;
    EdtPlaca: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;

{$ENDREGION}

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure CbxFiltroChange(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure DbGridEntregadoresDblClick(Sender: TObject);
    procedure DbGridEntregadoresCellClick(Column: TColumn);
    procedure DbGridEntregadoresKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    ValoresOriginais: array of string;
    FEntregador: TEntregador;
    FEntregadorController: TEntregadorController;

    procedure PreencherGridEntregadores;
    procedure PreencherCamposForm;
    procedure LimpaCamposForm(Form: TForm);
    function GravarDados: Boolean;
    function ValidarDados: Boolean;
    procedure MostrarMensagemErro(AErro: TCampoInvalido);
    procedure VerificaBotoes(AOperacao: TOperacao);
    function GetDataSource: TDataSource;

  public
    FOperacao: TOperacao;
    DsEntregadores: TDataSource;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FrmCadEntregador: TFrmCadEntregador;
  sErro : string;

implementation

{$R *.dfm}

{ TFrmCadEntregador }

constructor TFrmCadEntregador.Create(AOwner: TComponent);
begin
  inherited;
  DsEntregadores := TDataSource.Create(nil);
end;

destructor TFrmCadEntregador.Destroy;
begin
  if Assigned(DsEntregadores) then
    DsEntregadores.Free;

  inherited Destroy;
end;

procedure TFrmCadEntregador.FormCreate(Sender: TObject);
begin
  inherited;
  if TConexao.GetInstance.Connection.TestarConexao then
  begin
    FEntregador := TEntregador.Create;
    FEntregadorController := TEntregadorController.Create(TEntregadorRepository.Create, TEntregadorService.Create);
    GetDataSource();
    FOperacao := opInicio;
    SetLength(ValoresOriginais, 6);
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;
end;

procedure TFrmCadEntregador.FormShow(Sender: TObject);
begin
  inherited;
  PreencherGridEntregadores();
  DsEntregadores := FEntregadorController.GetDataSource();
  DbGridEntregadores.Columns[0].Width := 50;
  DbGridEntregadores.Columns[1].Width := 250;
  DbGridEntregadores.Columns[2].Width := 170;
  DbGridEntregadores.Columns[3].Width := 80;
  DbGridEntregadores.Columns[4].Width := 100;
  VerificaBotoes(FOperacao);
  if EdtPesquisar.CanFocus then
    EdtPesquisar.SetFocus;
end;

procedure TFrmCadEntregador.PreencherGridEntregadores;
begin
  FEntregadorController.PreencherGridEntregadores(Trim(EdtPesquisar.Text) + '%', CbxFiltro.Text);
  LblTotRegistros.Caption := 'Entregadores: ' + InttoStr(DbGridEntregadores.DataSource.DataSet.RecordCount);
end;

procedure TFrmCadEntregador.PreencherCamposForm;
begin
  FEntregadorController.PreencherCamposForm(FEntregador, DsEntregadores.DataSet.FieldByName('ID_ENTREGADOR').AsInteger);
  with FEntregador do
  begin
    EdtCodigoEntregador.Text := IntToStr(Id_Entregador);
    EdtNome.Text := Nome;
    EdtVeiculo.Text := Veiculo;
    EdtPlaca.Text := Placa;
    EdtTelefone.Text := Telefone;
  end;

  ValoresOriginais[0] := EdtCodigoEntregador.Text;
  ValoresOriginais[1] := EdtNome.Text;
  ValoresOriginais[2] := EdtVeiculo.Text;
  ValoresOriginais[3] := EdtPlaca.Text;
  ValoresOriginais[4] := EdtTelefone.Text;
end;

procedure TFrmCadEntregador.LimpaCamposForm(Form: TForm);
var i: Integer;
begin
  for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TEdit then
    begin
      TEdit(Form.Components[i]).Text := '';
    end;
  end;
  GrbDados.Enabled := FOperacao in [opNovo, opEditar];
  DBGridEntregadores.Enabled := FOperacao in [opInicio, opNavegar];
end;

function TFrmCadEntregador.GravarDados: Boolean;
begin
  Result := False;
  if not ValidarDados then
    Exit;

  with FEntregador do
  begin
    Nome := EdtNome.Text;
    Veiculo := EdtVeiculo.Text;
    Placa := EdtPlaca.Text;
    Telefone := EdtTelefone.Text;
  end;

  case FOperacao of
    opNovo:
    begin
      if FEntregadorController.ExecutarTransacao(
        procedure
        begin
          FEntregadorController.Inserir(FEntregador, sErro);
        end, sErro) then
        MessageDlg('Entregador incluído com sucesso!', mtInformation, [mbOk], 0)
      else
        raise Exception.Create(sErro);
    end;

    opEditar:
    begin
      if FEntregadorController.ExecutarTransacao(
        procedure
        begin
          FEntregadorController.Alterar(FEntregador, StrToInt(EdtCodigoEntregador.Text), sErro);
        end, sErro) then
        MessageDlg('Entregador alterado com sucesso!', mtInformation, [mbOk], 0)
      else
        raise Exception.Create(sErro);
    end;
  end;

  Result := True;
  PreencherGridEntregadores();
  FOperacao := opNavegar;
end;

function TFrmCadEntregador.ValidarDados: Boolean;
var LErro: TCampoInvalido;
begin
  Result := FEntregadorController.ValidarDados(EdtNome.Text, EdtVeiculo.Text, EdtTelefone.Text, LErro);
  if not Result then
  begin
    MostrarMensagemErro(LErro);
    Exit(False);
  end;

  Result := True;
end;

procedure TFrmCadEntregador.MostrarMensagemErro(AErro: TCampoInvalido);
begin
  case AErro of
    ciNome:
    begin
      MessageDlg('O nome do entregador deve ser informado!', mtInformation, [mbOK], 0);
      EdtNome.SetFocus;
    end;

    ciVeiculo:
    begin
      MessageDlg('O veículo do entregador deve ser informado!', mtInformation, [mbOK], 0);
      EdtNome.SetFocus;
    end;

    ciTelefone:
    begin
      MessageDlg('O telefone do entregador deve ser informado!', mtInformation, [mbOK], 0);
      EdtNome.SetFocus;
    end;
  end;
end;

procedure TFrmCadEntregador.VerificaBotoes(AOperacao: TOperacao);
begin
  BtnInserir.Enabled := AOperacao in [opInicio, opNavegar];
  BtnAlterar.Enabled := AOperacao = opNavegar;
  BtnExcluir.Enabled := AOperacao = opNavegar;
  BtnSair.Enabled := AOperacao in [opInicio, opNavegar];
  BtnGravar.Enabled := AOperacao in [opNovo, opEditar];
  BtnCancelar.Enabled := AOperacao in [opNovo, opEditar];
  GrbDados.Enabled := AOperacao in [opNovo, opEditar];
  DbGridEntregadores.Enabled := AOperacao in [opInicio, opNavegar];
  PnlPesquisar.Enabled := AOperacao in [opInicio, opNavegar];
end;

function TFrmCadEntregador.GetDataSource: TDataSource;
begin
  DbGridEntregadores.DataSource := FEntregadorController.GetDataSource();
end;

procedure TFrmCadEntregador.BtnInserirClick(Sender: TObject);
begin
  inherited;
  FOperacao := opNovo;
  VerificaBotoes(FOperacao);
  LimpaCamposForm(Self);
  EdtNome.SetFocus;
end;

procedure TFrmCadEntregador.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  FOperacao := opEditar;
  PreencherCamposForm();
  VerificaBotoes(FOperacao);
end;

procedure TFrmCadEntregador.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja realmente excluir o entregador selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
  begin
    if FEntregadorController.ExecutarTransacao(
      procedure
      begin
        FEntregadorController.Excluir(DsEntregadores.DataSet.FieldByName('ID_Entregador').AsInteger, sErro);
      end, sErro) then
      MessageDlg('Entregador excluído com sucesso!', mtInformation, [mbOk], 0)
    else
      raise Exception.Create(sErro);

    BtnPesquisar.Click;
  end;
end;

procedure TFrmCadEntregador.BtnGravarClick(Sender: TObject);
begin
  inherited;
  if GravarDados() then
  begin
    FOperacao := opNavegar;
    VerificaBotoes(FOperacao);
    LimpaCamposForm(Self);
    BtnPesquisar.Click;
  end;
end;

procedure TFrmCadEntregador.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if FOperacao = opNovo then
  begin
    FOperacao := opInicio;
    LimpaCamposForm(Self);
    EdtPesquisar.Text := EmptyStr;
  end;

  if FOperacao = opEditar then
  begin
    FOperacao := opNavegar;
    EdtCodigoEntregador.Text := ValoresOriginais[0];
    EdtNome.Text := ValoresOriginais[1];
    EdtVeiculo.Text := ValoresOriginais[2];
    EdtPlaca.Text := ValoresOriginais[3];
    EdtTelefone.Text := ValoresOriginais[4];
  end;

  VerificaBotoes(FOperacao);
  EdtPesquisar.SetFocus;
end;

procedure TFrmCadEntregador.CbxFiltroChange(Sender: TObject);
begin
  inherited;
  BtnPesquisar.Click;
  EdtPesquisar.SetFocus;
end;

procedure TFrmCadEntregador.EdtPesquisarChange(Sender: TObject);
begin
  inherited;
  PreencherGridEntregadores();
end;

procedure TFrmCadEntregador.EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    PreencherCamposForm();
    BtnAlterarClick(Sender);
    Key := #0;
  end;
end;

procedure TFrmCadEntregador.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  PreencherGridEntregadores();
end;

procedure TFrmCadEntregador.DbGridEntregadoresCellClick(Column: TColumn);
begin
  inherited;
  FOperacao := opNavegar;
  VerificaBotoes(FOperacao);
end;

procedure TFrmCadEntregador.DbGridEntregadoresDblClick(Sender: TObject);
begin
  inherited;
  FOperacao := opNavegar;
  PreencherCamposForm;
  VerificaBotoes(FOperacao);
end;

procedure TFrmCadEntregador.DbGridEntregadoresKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    PreencherCamposForm();
    VerificaBotoes(FOperacao);
    FOperacao := opEditar;
    BtnAlterarClick(Sender);
    EdtNome.SetFocus;
    Key := 0;
  end;

  if Key = VK_DELETE then
  begin
    BtnExcluirClick(Sender);
  end;
end;

procedure TFrmCadEntregador.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0)
end;

procedure TFrmCadEntregador.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
