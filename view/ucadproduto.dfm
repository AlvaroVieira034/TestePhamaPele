inherited FrmCadProduto: TFrmCadProduto
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Produtos'
  ClientHeight = 576
  ClientWidth = 766
  KeyPreview = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 772
  ExplicitHeight = 605
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlTopo: TPanel
    Width = 766
    ExplicitWidth = 766
    inherited BtnInserir: TSpeedButton
      Left = 22
      OnClick = BtnInserirClick
      ExplicitLeft = 22
    end
    inherited BtnAlterar: TSpeedButton
      Left = 143
      OnClick = BtnAlterarClick
      ExplicitLeft = 143
    end
    inherited BtnExcluir: TSpeedButton
      Left = 264
      OnClick = BtnExcluirClick
      ExplicitLeft = 264
    end
    inherited BtnGravar: TSpeedButton
      Left = 385
      OnClick = BtnGravarClick
      ExplicitLeft = 385
    end
    inherited BtnCancelar: TSpeedButton
      Left = 506
      OnClick = BtnCancelarClick
      ExplicitLeft = 506
    end
    inherited BtnSair: TSpeedButton
      Left = 627
      OnClick = BtnSairClick
      ExplicitLeft = 627
    end
  end
  inherited PnlDados: TPanel
    Left = 0
    Top = 65
    Width = 766
    Height = 208
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 65
    ExplicitWidth = 766
    ExplicitHeight = 208
    inherited GrbDados: TGroupBox
      Left = 7
      Top = 6
      Width = 749
      Height = 195
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Dados do Produto '
      ExplicitLeft = 7
      ExplicitTop = 6
      ExplicitWidth = 749
      ExplicitHeight = 195
      object Label1: TLabel
        Left = 9
        Top = 21
        Width = 67
        Height = 13
        Caption = '&ID do Produto'
      end
      object Label2: TLabel
        Left = 9
        Top = 119
        Width = 73
        Height = 13
        Caption = '&Pre'#231'o Unit'#225'rio*'
      end
      object Label6: TLabel
        Left = 125
        Top = 21
        Width = 52
        Height = 13
        Caption = '&Descri'#231#227'o*'
      end
      object Label3: TLabel
        Left = 125
        Top = 70
        Width = 62
        Height = 13
        Caption = '&Quantidade*'
      end
      object Label5: TLabel
        Left = 9
        Top = 70
        Width = 87
        Height = 13
        Caption = 'Data de &Validade*'
      end
      object Label7: TLabel
        Left = 303
        Top = 70
        Width = 76
        Height = 13
        Caption = '&Tipo do Produto'
      end
      object Label8: TLabel
        Left = 124
        Top = 119
        Width = 145
        Height = 13
        Caption = 'Condi'#231#245'es de &Armazenamento'
      end
      object Label9: TLabel
        Left = 549
        Top = 21
        Width = 39
        Height = 13
        Caption = '&C'#243'digo*'
      end
      object EdtPrecoUnitario: TEdit
        Left = 9
        Top = 136
        Width = 83
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        MaxLength = 18
        TabOrder = 6
        Text = '0.00'
        OnExit = EdtPrecoUnitarioExit
        OnKeyPress = EdtPrecoUnitarioKeyPress
      end
      object EdtCodigo: TEdit
        Left = 549
        Top = 38
        Width = 168
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 2
      end
      object EdtDescricao: TEdit
        Left = 124
        Top = 38
        Width = 389
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 1
      end
      object EdtQuantidade: TEdit
        Left = 125
        Top = 87
        Width = 126
        Height = 21
        MaxLength = 50
        TabOrder = 4
      end
      object EdtDataValidade: TEdit
        Left = 9
        Top = 87
        Width = 83
        Height = 21
        MaxLength = 10
        TabOrder = 3
        OnKeyPress = EdtDataValidadeKeyPress
      end
      object LCbxTipoProduto: TDBLookupComboBox
        Left = 302
        Top = 87
        Width = 212
        Height = 21
        KeyField = 'ID_TIPO_PRODUTO'
        ListField = 'DESCRICAO'
        TabOrder = 5
      end
      object EdtCondicoesArmazenamento: TEdit
        Left = 124
        Top = 136
        Width = 593
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 200
        TabOrder = 7
      end
      object EdtIdProduto: TEdit
        Left = 9
        Top = 38
        Width = 83
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 0
      end
      object ChkPrescricao: TCheckBox
        Left = 9
        Top = 171
        Width = 178
        Height = 17
        Caption = ' Requer prescri'#231#227'o de receita?'
        TabOrder = 8
      end
    end
  end
  inherited PnlGrid: TPanel
    Left = 0
    Top = 273
    Width = 766
    Height = 266
    Align = alClient
    ExplicitLeft = 0
    ExplicitTop = 273
    ExplicitWidth = 766
    ExplicitHeight = 266
    inherited LblTotRegistros: TLabel
      Left = 666
      Top = 246
      Anchors = [akRight, akBottom]
      ExplicitLeft = 666
      ExplicitTop = 246
    end
    inherited GrbGrid: TGroupBox
      Left = 7
      Width = 749
      Height = 229
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Produtos Cadastrados '
      ExplicitLeft = 7
      ExplicitWidth = 749
      ExplicitHeight = 229
      object DBGridProdutos: TDBGrid
        Left = 9
        Top = 20
        Width = 732
        Height = 197
        Anchors = [akLeft, akTop, akRight]
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = DBGridProdutosCellClick
        OnDblClick = DBGridProdutosDblClick
        OnKeyDown = DBGridProdutosKeyDown
        Columns = <
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'id_produto'
            Title.Alignment = taCenter
            Title.Caption = 'ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Alignment = taCenter
            Title.Caption = 'Descri'#231#227'o do Produto'
            Width = 292
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'codigo'
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'quantidade'
            Title.Alignment = taCenter
            Title.Caption = 'Quantidade'
            Width = 69
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'data_validade'
            Title.Alignment = taCenter
            Title.Caption = 'Data Validade'
            Width = 74
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Title.Alignment = taCenter
            Title.Caption = 'Tipo Produto'
            Width = 71
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'valor'
            Title.Alignment = taCenter
            Title.Caption = 'Valor Unit'#225'rio'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'requer_prescricao'
            Title.Alignment = taCenter
            Title.Caption = 'Prescri'#231#227'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'condicoes_armazenamento'
            Title.Caption = 'Condi'#231#245'es de Armazenamento'
            Visible = True
          end>
      end
    end
  end
  object PnlPesquisar: TPanel
    Left = 0
    Top = 539
    Width = 766
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      766
      37)
    object Label4: TLabel
      Left = 7
      Top = 11
      Width = 43
      Height = 11
      Caption = 'Filtrar por:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object BtnPesquisar: TSpeedButton
      Left = 674
      Top = 3
      Width = 86
      Height = 27
      Anchors = [akTop, akRight]
      Caption = '&Pesquisar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFCCCCCCCCCCCCF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCC497FAA4980ACB1BDC6CFCFCFCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC407F
        AF1EAAFF5AC8FF4593C7BB8825B67E0EB57B09B67E0DB88113BB8211B6831B90
        7E5B7A7A7C7B79787B79788F816B72A1C558C8FFBAF2FF4193CCB67E0EFFFFFF
        FFFFFFFFFFFFB47800F0EEF481848DB6B9BEE4E8ECE2E5EAE4E6EAB8B7B7827A
        76CFE3ED3290D4FFFFFFB47B09FFFFFFFFFFFFFFFFFFC99A3B928267B9BBBFE8
        DDCEEEC57DF6D789FCE49AECE7D8BBBABC9B9084FFFFFFFFFFFFB47A07FFFFFF
        FFFFFFFFFFFFFFFFFF7B7A7CF0F3F8E7B572F0CF92F6DC94FFEFA4FBE499F0F2
        F8818288FFFFFFFFFFFFB47A08FFFFFFFFFFFFFFFFFFE1CAB07F7F81F5F9FEEB
        C696F5E1BEF3DAA0F6DB94F4D587F5F9FF868587FFFFFFFFFFFFB47B08FFFFFF
        D5BB9DDAC3A8B65A0084888CFEFFFFE3B076FAF2E4F4E1BDEFCE91ECC37CFEFF
        FF8A898BFFFFFFFFFFFFB47B08FFFFFFFFFFF7FFFFFFB65E06A9A39BCED2D5F6
        E3CFE2B074E9C494E5B571F8EBD7CFD1D79C8A67FFFFFFFFFFFFB47B09FFFFFF
        D6B892DBC1A1B5600ACBA2748F9093D3D7DCFFFFFFFFFFFFFFFFFFD1D3D79293
        9CB7821AFFFFFFFFFFFFB47B08FFFFFFFFFBE4FFFFF2B5600BE2B580D7AC7A9F
        8A7491959B9194988F9195B5B1ABFFFFFFB87E09FFFFFFFFFFFFB57B08FFFFFF
        DDB382E1BB8EB95D04BD6108BE6106BD6106C06003C06001BB5B00E2BA8BFFFF
        FFB67C09FFFFFFFFFFFFB57C09FFFFFF44C4FF46C8FFE5BB8649CEFF4ACFFFE7
        BD894ACFFF4ACEFFE5BA8542C7FFFFFFFFB67C09FFFFFFFFFFFFB67E0EFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFB67E0EFFFFFFFFFFFFBD8C27B67E0EB67C09B67B08B57B08B67B08B67B08B5
        7B08B67B08B67B08B57B08B67C09B67E0EBD8C27FFFFFFFFFFFF}
      OnClick = BtnPesquisarClick
      ExplicitLeft = 556
    end
    object EdtPesquisar: TEdit
      Left = 142
      Top = 6
      Width = 527
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = EdtPesquisarChange
    end
    object CbxFiltro: TComboBox
      Left = 55
      Top = 6
      Width = 84
      Height = 21
      TabOrder = 0
      Text = 'Descri'#231#227'o'
      Items.Strings = (
        'C'#243'digo'
        'Descri'#231#227'o')
    end
  end
end
