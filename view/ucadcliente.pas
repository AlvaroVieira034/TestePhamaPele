unit ucadcliente;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ucadastropadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cep.service,
  conexao, cliente.model, cliente.controller, cliente.repository, cliente.service, System.UITypes, untFormat;

{$ENDREGION}

type
  TOperacao = (opInicio, opNovo, opEditar, opNavegar);
  TFrmCadCliente = class(TFrmCadastroPadrao)

{$REGION 'Componentes'}
    PnlPesquisar: TPanel;
    BtnPesquisar: TSpeedButton;
    Label12: TLabel;
    EdtPesquisar: TEdit;
    CbxFiltro: TComboBox;
    DbGridClientes: TDBGrid;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    BtnPesquisarCep: TSpeedButton;
    Label3: TLabel;
    EdtCep: TEdit;
    EdtEndereco: TEdit;
    EdtEstado: TEdit;
    EdtCodigoCliente: TEdit;
    EdtNome: TEdit;
    Label1: TLabel;
    EdtBairro: TEdit;
    Label2: TLabel;
    EdtCidade: TEdit;
    Label4: TLabel;
    EdtTelefone: TEdit;
    Label5: TLabel;
    EdtEmail: TEdit;

{$ENDREGION}

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnPesquisarCepClick(Sender: TObject);
    procedure EdtCepKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure CbxFiltroChange(Sender: TObject);
    procedure DbGridClientesDblClick(Sender: TObject);
    procedure DbGridClientesCellClick(Column: TColumn);
    procedure DbGridClientesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPesquisarChange(Sender: TObject);
    procedure EdtCepChange(Sender: TObject);

  private
    ValoresOriginais: array of string;
    FCliente: TCliente;
    FClienteController: TClienteController;

    procedure PreencherGridClientes;
    procedure PreencherCamposForm;
    procedure LimpaCamposForm(Form: TForm);
    function GravarDados: Boolean;
    function ValidarDados: Boolean;
    procedure MostrarMensagemErro(AErro: TCampoInvalido);
    procedure VerificaBotoes(AOperacao: TOperacao);
    function GetDataSource: TDataSource;

  public
    FOperacao: TOperacao;
    DsClientes: TDataSource;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FrmCadCliente: TFrmCadCliente;
  sErro : string;

implementation

{$R *.dfm}

uses System.SysUtils, System.JSON;

{ TFrmCadCliente }

constructor TFrmCadCliente.Create(AOwner: TComponent);
begin
  inherited;
  DsClientes := TDataSource.Create(nil);
end;

destructor TFrmCadCliente.Destroy;
begin
if Assigned(DsClientes) then
    DsClientes.Free;

  inherited Destroy;
end;

procedure TFrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  if TConexao.GetInstance.Connection.TestarConexao then
  begin
    FCliente := TCliente.Create;
    FClienteController := TClienteController.Create(TClienteRepository.Create, TClienteService.Create);
    GetDataSource();
    FOperacao := opInicio;
    SetLength(ValoresOriginais, 10);
  end
  else
  begin
    ShowMessage('Não foi possível conectar ao banco de dados!');
    Close;
  end;
end;

procedure TFrmCadCliente.FormShow(Sender: TObject);
begin
  inherited;
  PreencherGridClientes();
  DsClientes := FClienteController.GetDataSource();
  DbGridClientes.Columns[0].Width := 50;
  DbGridClientes.Columns[1].Width := 270;
  DbGridClientes.Columns[2].Width := 70;
  DbGridClientes.Columns[3].Width := 270;
  DbGridClientes.Columns[4].Width := 130;
  DbGridClientes.Columns[5].Width := 160;
  DbGridClientes.Columns[6].Width := 45;
  DbGridClientes.Columns[7].Width := 100;
  DbGridClientes.Columns[8].Width := 200;
  VerificaBotoes(FOperacao);
  if EdtPesquisar.CanFocus then
    EdtPesquisar.SetFocus;
end;

procedure TFrmCadCliente.PreencherGridClientes;
begin
  FClienteController.PreencherGridClientes(Trim(EdtPesquisar.Text) + '%', CbxFiltro.Text);
  LblTotRegistros.Caption := 'Clientes: ' + InttoStr(DbGridClientes.DataSource.DataSet.RecordCount);
end;

procedure TFrmCadCliente.PreencherCamposForm;
begin
  FClienteController.PreencherCamposForm(FCliente, DsClientes.DataSet.FieldByName('ID_CLIENTE').AsInteger);
  with FCliente do
  begin
    EdtCodigoCliente.Text := IntToStr(Id_Cliente);
    EdtNome.Text := Nome;
    EdtCep.Text := Cep;
    EdtEndereco.Text := Endereco;
    EdtBairro.Text := Bairro;
    EdtCidade.Text := Cidade;
    EdtEstado.Text := Estado;
    EdtTelefone.Text := Telefone;
    EdtEmail.Text := Email;
  end;

  ValoresOriginais[0] := EdtCodigoCliente.Text;
  ValoresOriginais[1] := EdtNome.Text;
  ValoresOriginais[2] := EdtCep.Text;
  ValoresOriginais[3] := EdtEndereco.Text;
  ValoresOriginais[4] := EdtBairro.Text;
  ValoresOriginais[5] := EdtCidade.Text;
  ValoresOriginais[6] := EdtEstado.Text;
  ValoresOriginais[7] := EdtTelefone.Text;
  ValoresOriginais[8] := EdtEmail.Text;
end;

procedure TFrmCadCliente.LimpaCamposForm(Form: TForm);
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
  DBGridClientes.Enabled := FOperacao in [opInicio, opNavegar];

end;

function TFrmCadCliente.GravarDados: Boolean;
begin
  Result := False;
  if not ValidarDados then
    Exit;

  with FCliente do
  begin
    Nome := EdtNome.Text;
    Cep := EdtCep.Text;
    Endereco := EdtEndereco.Text;
    Bairro := EdtBairro.Text;
    Cidade := EdtCidade.Text;
    Estado := EdtEstado.Text;
    Telefone := EdtTelefone.Text;
    Email := EdtEmail.Text;
  end;

  case FOperacao of
    opNovo:
    begin
      if FClienteController.ExecutarTransacao(
        procedure
        begin
          FClienteController.Inserir(FCliente, sErro);
        end, sErro) then
        MessageDlg('Cliente incluído com sucesso!', mtInformation, [mbOk], 0)
      else
        raise Exception.Create(sErro);
    end;

    opEditar:
    begin
      if FClienteController.ExecutarTransacao(
        procedure
        begin
          FClienteController.Alterar(FCliente, StrToInt(EdtCodigoCliente.Text), sErro);
        end, sErro) then
        MessageDlg('Cliente alterado com sucesso!', mtInformation, [mbOk], 0)
      else
        raise Exception.Create(sErro);
    end;
  end;

  Result := True;
  PreencherGridClientes();
  FOperacao := opNavegar;
end;

function TFrmCadCliente.ValidarDados: Boolean;
var LErro: TCampoInvalido;
begin
  Result := FClienteController.ValidarDados(EdtNome.Text, EdtCep.Text, EdtEndereco.Text, EdtBairro.Text, EdtCidade.Text, LErro);
  if not Result then
  begin
    MostrarMensagemErro(LErro);
    Exit(False);
  end;

  Result := True;
end;

procedure TFrmCadCliente.MostrarMensagemErro(AErro: TCampoInvalido);
begin
  case AErro of
    ciNome:
    begin
      MessageDlg('O nome do cliente deve ser informado!', mtInformation, [mbOK], 0);
      EdtNome.SetFocus;
    end;

    ciCep:
    begin
      MessageDlg('O CEP do cliente deve ser informado!', mtInformation, [mbOK], 0);
      EdtNome.SetFocus;
    end;

    ciEndereco:
    begin
      MessageDlg('O endereço do cliente deve ser informado!', mtInformation, [mbOK], 0);
      EdtNome.SetFocus;
    end;

    ciBairro:
    begin
      MessageDlg('O bairro do cliente deve ser informado!', mtInformation, [mbOK], 0);
      EdtNome.SetFocus;
    end;

    ciCidade:
    begin
      MessageDlg('A cidade do cliente deve ser informada!', mtInformation, [mbOK], 0);
      EdtCidade.SetFocus;
    end;
  end;
end;

procedure TFrmCadCliente.VerificaBotoes(AOperacao: TOperacao);
begin
  BtnInserir.Enabled := AOperacao in [opInicio, opNavegar];
  BtnAlterar.Enabled := AOperacao = opNavegar;
  BtnExcluir.Enabled := AOperacao = opNavegar;
  BtnSair.Enabled := AOperacao in [opInicio, opNavegar];
  BtnGravar.Enabled := AOperacao in [opNovo, opEditar];
  BtnCancelar.Enabled := AOperacao in [opNovo, opEditar];
  GrbDados.Enabled := AOperacao in [opNovo, opEditar];
  DbGridClientes.Enabled := AOperacao in [opInicio, opNavegar];
  PnlPesquisar.Enabled := AOperacao in [opInicio, opNavegar];
end;

procedure TFrmCadCliente.BtnInserirClick(Sender: TObject);
begin
  inherited;
  FOperacao := opNovo;
  VerificaBotoes(FOperacao);
  LimpaCamposForm(Self);
  EdtNome.SetFocus;
end;

procedure TFrmCadCliente.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  FOperacao := opEditar;
  PreencherCamposForm();
  VerificaBotoes(FOperacao);
end;

procedure TFrmCadCliente.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja realmente excluir o cliente selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
  begin
    if FClienteController.ExecutarTransacao(
      procedure
      begin
        FClienteController.Excluir(DsClientes.DataSet.FieldByName('ID_CLIENTE').AsInteger, sErro);
      end, sErro) then
      MessageDlg('Cliente excluído com sucesso!', mtInformation, [mbOk], 0)
    else
      raise Exception.Create(sErro);

    BtnPesquisar.Click;
  end;
end;

procedure TFrmCadCliente.BtnGravarClick(Sender: TObject);
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

procedure TFrmCadCliente.BtnCancelarClick(Sender: TObject);
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
    EdtCodigoCliente.Text := ValoresOriginais[0];
    EdtNome.Text := ValoresOriginais[1];
    EdtCep.Text := ValoresOriginais[2];
    EdtEndereco.Text := ValoresOriginais[3];
    EdtBairro.Text := ValoresOriginais[4];
    EdtCidade.Text := ValoresOriginais[5];
    EdtEstado.Text := ValoresOriginais[6];
    EdtTelefone.Text := ValoresOriginais[7];
    EdtEmail.Text := ValoresOriginais[8];
  end;

  VerificaBotoes(FOperacao);
  EdtPesquisar.SetFocus;
end;

procedure TFrmCadCliente.BtnPesquisarCepClick(Sender: TObject);
var FCepService: TCEPService;
    JSONValue: TJSONValue;
    JSONObject: TJSONObject;
    Response,  NCep: string;
begin
  inherited;
  FCepService := TCEPService.Create;
  try
    if EdtCep.Text = EmptyStr then
    begin
      MessageDlg('O CEP a pesquisar deve ser preenchido!', mtInformation, [mbOK], 0);
      Exit;
    end;

    NCep := StringReplace(StringReplace(EdtCep.Text, '-', '', [rfReplaceAll]), '.', '', [rfReplaceAll]);

    Response := FCepService.ConsultaCep(NCep, True);
    JSONValue := TJSONObject.ParseJSONValue(Response);
    if Assigned(JSONValue) and (JSONValue is TJSONObject) then
    begin
      JSONObject := JSONValue as TJSONObject;
      if JSONObject.GetValue('erro') <> nil then
      begin
        ShowMessage('CEP não encontrado!');
        Exit;
      end;

      Formatar(EdtCep, TFormato.CEP);
      EdtEndereco.Text := JSONObject.GetValue<string>('logradouro', '');
      EdtBairro.Text := JSONObject.GetValue<string>('bairro', '');
      EdtCidade.Text := JSONObject.GetValue<string>('localidade', '');
      EdtEstado.Text := JSONObject.GetValue<string>('uf', '');
      VerificaBotoes(FOperacao);
    end
    else
      ShowMessage('Erro ao processar a resposta do serviço de pesquisa do CEP');

  finally
    FreeAndNil(FCepService);
  end;
end;

procedure TFrmCadCliente.CbxFiltroChange(Sender: TObject);
begin
  inherited;
  PreencherGridClientes();
end;

procedure TFrmCadCliente.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  PreencherGridClientes();
end;

function TFrmCadCliente.GetDataSource: TDataSource;
begin
  DbGridClientes.DataSource := FClienteController.GetDataSource();
end;

procedure TFrmCadCliente.DbGridClientesCellClick(Column: TColumn);
begin
  inherited;
  FOperacao := opNavegar;
  VerificaBotoes(FOperacao);
end;

procedure TFrmCadCliente.DbGridClientesDblClick(Sender: TObject);
begin
  inherited;
  FOperacao := opNavegar;
  PreencherCamposForm;
  VerificaBotoes(FOperacao);
end;

procedure TFrmCadCliente.DbGridClientesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    PreencherCamposForm();
    VerificaBotoes(FOperacao);
    FOperacao := opEditar;
    BtnAlterarClick(Sender);
    Key := 0;
  end;
end;

procedure TFrmCadCliente.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0)
end;

procedure TFrmCadCliente.EdtCepChange(Sender: TObject);
begin
  inherited;
  Formatar(EdtCep, TFormato.CEP);
end;

procedure TFrmCadCliente.EdtCepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', #08]) then
    key := #0;
end;

procedure TFrmCadCliente.EdtPesquisarChange(Sender: TObject);
begin
  inherited;
  PreencherGridClientes();
end;

procedure TFrmCadCliente.EdtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    PreencherCamposForm();
    BtnAlterarClick(Sender);
    Key := #0;
  end;
end;

procedure TFrmCadCliente.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
