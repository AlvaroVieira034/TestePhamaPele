unit ucadproduto;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.DatS,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.DApt,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, conexao, produto.model,
  tipoproduto.model, produto.controller, tipoproduto.controller, produto.repository, produto.service,
  tipoproduto.service, Vcl.DBCtrls;

{$ENDREGION}

type
  TOperacao = (opInicio, opNovo, opEditar, opNavegar);
  TFrmCadProduto = class(TFrmCadastroPadrao)

{$REGION 'Componentes'}
    PnlPesquisar: TPanel;
    Label4: TLabel;
    BtnPesquisar: TSpeedButton;
    EdtPesquisar: TEdit;
    CbxFiltro: TComboBox;
    DBGridProdutos: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    EdtPrecoUnitario: TEdit;
    EdtCodigo: TEdit;
    EdtDescricao: TEdit;
    Label3: TLabel;
    EdtQuantidade: TEdit;
    Label5: TLabel;
    EdtDataValidade: TEdit;
    Label7: TLabel;
    LCbxTipoProduto: TDBLookupComboBox;
    Label8: TLabel;
    EdtCondicoesArmazenamento: TEdit;
    Label9: TLabel;
    EdtIdProduto: TEdit;
    ChkPrescricao: TCheckBox;

{$ENDREGION}

    procedure BtnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridProdutosDblClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure EdtPrecoUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDataValidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtPrecoUnitarioExit(Sender: TObject);
    procedure DBGridProdutosCellClick(Column: TColumn);
    procedure DBGridProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisarChange(Sender: TObject);

  private
    ValoresOriginais: array of string;
    TblTipoProdutos: TFDQuery;
    FProduto: TProduto;
    FProdutoController: TProdutoController;
    FTipoProduto: TTipoProduto;
    FTipoProdutoController: TTipoProdutoController;

    procedure PreencherGridProdutos;
    procedure PreencherCamposForm;
    procedure LimpaCamposForm(Form: TForm);
    function GravarDados: Boolean;
    function ValidarDados: Boolean;
    procedure MostrarMensagemErro(AErro: TCampoInvalido);
    procedure VerificaBotoes(AOperacao: TOperacao);
    function GetDataSource: TDataSource;

  public
    FOperacao: TOperacao;
    DsProdutos: TDataSource;
    DsTipoProdutos: TDataSource;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

var
  FrmCadProduto: TFrmCadProduto;
  sErro: string;

implementation

{$R *.dfm}

uses untFormat;

{ TFrmCadProduto }

constructor TFrmCadProduto.Create(AOwner: TComponent);
begin
  inherited;
  DsProdutos := TDataSource.Create(nil);
end;

destructor TFrmCadProduto.Destroy;
begin
  TblTipoProdutos.Free;
  DsTipoProdutos.Free;
  DsProdutos.Free;
  inherited Destroy;
end;

procedure TFrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  if TConexao.GetInstance.Connection.TestarConexao then
  begin
    FProduto := TProduto.Create;
    FProdutoController := TProdutoController.Create(TProdutoRepository.Create, TProdutoService.Create);


    TblTipoProdutos := TConexao.GetInstance.Connection.CriarQuery;
    DsTipoProdutos := TConexao.GetInstance.Connection.CriarDataSource;
    DsTipoProdutos.DataSet := TblTipoProdutos;
    FTipoProdutoController := TTipoProdutoController.Create(TTipoProdutoService.Create);

    LCbxTipoProduto.KeyField := 'id_tipo_produto';
    LCbxTipoProduto.ListField := 'descricao';
    LCbxTipoProduto.ListSource := DsTipoProdutos;

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

procedure TFrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
  FTipoProdutoController.PreencherComboTipoProdutos(TblTipoProdutos);
  PreencherGridProdutos();
  DsProdutos := FProdutoController.GetDataSource();
  DbGridProdutos.Columns[0].Width := 40;
  DbGridProdutos.Columns[1].Width := 245;
  DbGridProdutos.Columns[2].Width := 65;
  DbGridProdutos.Columns[3].Width := 110;
  DbGridProdutos.Columns[4].Width := 90;
  DbGridProdutos.Columns[5].Width := 110;
  DbGridProdutos.Columns[6].Width := 90;
  DbGridProdutos.Columns[7].Width := 60;
  DbGridProdutos.Columns[8].Width := 450;
  VerificaBotoes(FOperacao);
  if EdtPesquisar.CanFocus then
    EdtPesquisar.SetFocus;
end;

procedure TFrmCadProduto.PreencherGridProdutos;
begin
  FProdutoController.PreencherGridProdutos(Trim(EdtPesquisar.Text) + '%', CbxFiltro.Text);
  LblTotRegistros.Caption := 'Produtos: ' + InttoStr(DBGridProdutos.DataSource.DataSet.RecordCount);
end;

procedure TFrmCadProduto.PreencherCamposForm;
begin
  DsProdutos := FProdutoController.GetDataSource();
  FProdutoController.PreencherCamposForm(FProduto, DsProdutos.DataSet.FieldByName('ID_PRODUTO').AsInteger);
  with FProduto do
  begin
    EdtIdProduto.Text := IntToStr(Id_Produto);
    EdtDescricao.Text := Nome;
    EdtCodigo.Text := Codigo;
    EdtQuantidade.Text := Quantidade;
    EdtDataValidade.Text := DateToStr(Data_Validade);
    LcbxTipoProduto.KeyValue := Id_Tipo_Produto;
    EdtPrecoUnitario.Text := FormatFloat('######0.00', Valor);
    EdtCondicoesArmazenamento.Text := Condicoes_Armazenamento;
    ChkPrescricao.Checked := Requer_Prescricao = 'S';
  end;

  ValoresOriginais[0] := EdtIdProduto.Text;
  ValoresOriginais[1] := EdtDescricao.Text;
  ValoresOriginais[2] := EdtCodigo.Text;
  ValoresOriginais[3] := EdtQuantidade.Text;
  ValoresOriginais[4] := EdtDataValidade.Text;
  ValoresOriginais[5] := IntToStr(LCbxTipoProduto.KeyValue);
  ValoresOriginais[6] := EdtPrecoUnitario.Text;
  ValoresOriginais[7] := EdtCondicoesArmazenamento.Text;
  ValoresOriginais[8] := IfThen(ChkPrescricao.Checked, 'S', 'N');
  BtnPesquisar.Click;
end;

procedure TFrmCadProduto.LimpaCamposForm(Form: TForm);
var i: Integer;
begin
  for i := 0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TEdit then
    begin
      TEdit(Form.Components[i]).Text := '';
    end;
  end;
  ChkPrescricao.Checked := False;
  EdtPrecoUnitario.Text := '0.00';
  LCbxTipoProduto.KeyValue := 0;
  GrbDados.Enabled := FOperacao in [opNovo, opEditar];
  DBGridProdutos.Enabled := FOperacao in [opInicio, opNavegar];
end;

function TFrmCadProduto.GravarDados: Boolean;
begin
  Result := False;
  if not ValidarDados then
    Exit;

  with FProduto do
  begin
    Nome := EdtDescricao.Text;
    Codigo := EdtCodigo.Text;
    Quantidade := EdtQuantidade.Text;
    Data_Validade := StrToDate(EdtDataValidade.Text);
    Id_Tipo_Produto := LCbxTipoProduto.KeyValue;
    Valor := StrToFloat(StringReplace(StringReplace(EdtPrecoUnitario.Text, '.', '', [rfReplaceAll]), ',',
                        FormatSettings.DecimalSeparator, [rfReplaceAll]));
    Condicoes_Armazenamento := EdtCondicoesArmazenamento.Text;
    Requer_Prescricao := IfThen(ChkPrescricao.Checked, 'S', 'N');
  end;

  case FOperacao of
    opNovo:
    begin
      if FProdutoController.ExecutarTransacao(
        procedure
        begin
          FProdutoController.Inserir(FProduto, sErro);
        end, sErro) then
        MessageDlg('Produto incluído com sucesso!', mtInformation, [mbOk], 0)
      else
        raise Exception.Create(sErro);
    end;

    opEditar:
    begin
      if FProdutoController.ExecutarTransacao(
        procedure
        begin
          FProdutoController.Alterar(FProduto, StrToInt(EdtIdProduto.Text), sErro);
        end, sErro) then
        MessageDlg('Produto alterado com sucesso!', mtInformation, [mbOk], 0)
      else
        raise Exception.Create(sErro);
    end;
  end;

  Result := True;
  DsProdutos.DataSet.Refresh;
  FOperacao := opNavegar;
end;

function TFrmCadProduto.ValidarDados: Boolean;
var LErro: TCampoInvalido;
begin
  Result := FProdutoController.ValidarDados(EdtDescricao.Text, EdtCodigo.Text, EdtQuantidade.Text, EdtDataValidade.Text, EdtPrecoUnitario.Text, LErro);
  if not Result then
  begin
    MostrarMensagemErro(LErro);
    Exit(False);
  end;

  Result := True;
end;

procedure TFrmCadProduto.MostrarMensagemErro(AErro: TCampoInvalido);
begin
  case AErro of
    ciNome:
    begin
      MessageDlg('A descrição do produto deve ser informada!', mtInformation, [mbOK], 0);
      EdtDescricao.SetFocus;
    end;

    ciCodigo:
    begin
      MessageDlg('O código do produto deve ser informado!', mtInformation, [mbOK], 0);
      EdtCodigo.SetFocus;
    end;

    ciQuantidade:
    begin
      MessageDlg('A quantidade do produto deve ser informada!', mtInformation, [mbOK], 0);
      EdtQuantidade.SetFocus;
    end;

    ciDataValidade:
    begin
      MessageDlg('A data de validade do produto deve ser informada!', mtInformation, [mbOK], 0);
      EdtDataValidade.SetFocus;
    end;

    ciValor:
    begin
      MessageDlg('O preço unitário do produto ser informado!', mtInformation, [mbOK], 0);
      EdtPrecoUnitario.SetFocus;
    end;

    ciValorZero:
    begin
      MessageDlg('O preço unitário do produto não poder ser igual a ''0''!', mtInformation, [mbOK], 0);
      EdtPrecoUnitario.SetFocus;
    end;
  end;
end;

procedure TFrmCadProduto.VerificaBotoes(AOperacao: TOperacao);
begin
  BtnInserir.Enabled := AOperacao in [opInicio, opNavegar];
  BtnAlterar.Enabled := AOperacao = opNavegar;
  BtnExcluir.Enabled := AOperacao = opNavegar;
  BtnSair.Enabled := AOperacao in [opInicio, opNavegar];
  BtnGravar.Enabled := AOperacao in [opNovo, opEditar];
  BtnCancelar.Enabled := AOperacao in [opNovo, opEditar];
  GrbDados.Enabled := AOperacao in [opNovo, opEditar];
  DBGridProdutos.Enabled := AOperacao in [opInicio, opNavegar];
  PnlPesquisar.Enabled := AOperacao in [opInicio, opNavegar];
end;

function TFrmCadProduto.GetDataSource: TDataSource;
begin
  DBGridProdutos.DataSource := FProdutoController.GetDataSource();
end;

procedure TFrmCadProduto.DBGridProdutosCellClick(Column: TColumn);
begin
  inherited;
  FOperacao := opNavegar;
  VerificaBotoes(FOperacao);
end;

procedure TFrmCadProduto.DBGridProdutosDblClick(Sender: TObject);
begin
  inherited;
  FOperacao := opNavegar;
  PreencherCamposForm;
  VerificaBotoes(FOperacao);
end;

procedure TFrmCadProduto.DBGridProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    PreencherCamposForm();
    VerificaBotoes(FOperacao);
    FOperacao := opEditar;
    BtnAlterar.Click;
    EdtDescricao.SetFocus;
    Key := 0;
  end;
end;

procedure TFrmCadProduto.BtnInserirClick(Sender: TObject);
begin
  inherited;
  GrbDados.Enabled := True;
  FOperacao := opNovo;
  VerificaBotoes(opNovo);
  EdtDescricao.SetFocus;
end;

procedure TFrmCadProduto.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  FOperacao := opEditar;
  VerificaBotoes(FOperacao);
  EdtDescricao.SetFocus;
end;

procedure TFrmCadProduto.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja realmente excluir o produto selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
  begin
    if FProdutoController.ExecutarTransacao(
      procedure
      begin
        FProdutoController.Excluir(DsProdutos.DataSet.FieldByName('ID_PRODUTO').AsInteger, sErro);
      end, sErro) then
      MessageDlg('Produto excluído com sucesso!', mtInformation, [mbOk], 0)
    else
      raise Exception.Create(sErro);

    DsProdutos.DataSet.Refresh;
  end;
end;

procedure TFrmCadProduto.BtnGravarClick(Sender: TObject);
begin
  inherited;
  if GravarDados() then
  begin
    FOperacao := opNavegar;
    VerificaBotoes(FOperacao);
    LimpaCamposForm(Self);
  end;
end;

procedure TFrmCadProduto.BtnCancelarClick(Sender: TObject);
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
    EdtIdProduto.Text := ValoresOriginais[0];
    EdtDescricao.Text := ValoresOriginais[1];
    EdtCodigo.Text := ValoresOriginais[2];
    EdtDataValidade.Text := ValoresOriginais[3];
    EdtQuantidade.Text := ValoresOriginais[4];
    LCbxTipoProduto.KeyValue := StrToInt(ValoresOriginais[5]);
    EdtPrecoUnitario.Text := ValoresOriginais[6];
    EdtCondicoesArmazenamento.Text := ValoresOriginais[7];
    ChkPrescricao.Checked := ValoresOriginais[8] = 'S';
  end;

  VerificaBotoes(FOperacao);
  EdtPesquisar.SetFocus;
end;

procedure TFrmCadProduto.EdtPesquisarChange(Sender: TObject);
begin
  inherited;
  PreencherGridProdutos();
end;

procedure TFrmCadProduto.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  PreencherGridProdutos();
end;

procedure TFrmCadProduto.EdtPrecoUnitarioExit(Sender: TObject);
var LValor: Double;
begin
  inherited;
  if TryStrToFloat(EdtPrecoUnitario.Text, LValor) then
    EdtPrecoUnitario.Text := FormatFloat('######0.00', LValor)
end;

procedure TFrmCadProduto.EdtDataValidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not( key in['0'..'9','/', #08] ) then
    key:=#0;
end;

procedure TFrmCadProduto.EdtPrecoUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', ',', #08]) then
    key := #0;
end;

procedure TFrmCadProduto.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0)
end;

procedure TFrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmCadProduto.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
