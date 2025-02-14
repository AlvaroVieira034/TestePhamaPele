inherited FrmCadEntregador: TFrmCadEntregador
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Entregadores'
  ClientHeight = 528
  ClientWidth = 758
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 764
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlTopo: TPanel
    Width = 758
    inherited BtnInserir: TSpeedButton
      Left = 15
      OnClick = BtnInserirClick
      ExplicitLeft = 15
    end
    inherited BtnAlterar: TSpeedButton
      Left = 136
      OnClick = BtnAlterarClick
      ExplicitLeft = 136
    end
    inherited BtnExcluir: TSpeedButton
      Left = 257
      OnClick = BtnExcluirClick
      ExplicitLeft = 257
    end
    inherited BtnGravar: TSpeedButton
      Left = 378
      OnClick = BtnGravarClick
      ExplicitLeft = 378
    end
    inherited BtnCancelar: TSpeedButton
      Left = 499
      OnClick = BtnCancelarClick
      ExplicitLeft = 499
    end
    inherited BtnSair: TSpeedButton
      Left = 620
      OnClick = BtnSairClick
      ExplicitLeft = 620
    end
  end
  inherited PnlDados: TPanel
    Left = 0
    Top = 65
    Width = 758
    Height = 181
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 65
    ExplicitWidth = 748
    ExplicitHeight = 181
    inherited GrbDados: TGroupBox
      Left = 9
      Top = 6
      Width = 738
      Height = 167
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Dados do Entregador '
      ExplicitLeft = 9
      ExplicitTop = 6
      ExplicitWidth = 728
      ExplicitHeight = 167
      object Label8: TLabel
        Left = 22
        Top = 34
        Width = 37
        Height = 13
        Caption = 'C'#243'digo:'
      end
      object Label3: TLabel
        Left = 22
        Top = 95
        Width = 37
        Height = 13
        Caption = 'Ve'#237'culo:'
      end
      object Label4: TLabel
        Left = 30
        Top = 125
        Width = 29
        Height = 13
        Caption = 'Placa:'
      end
      object Label1: TLabel
        Left = 28
        Top = 64
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object Label2: TLabel
        Left = 299
        Top = 125
        Width = 46
        Height = 13
        Caption = 'Telefone:'
      end
      object Label5: TLabel
        Left = 475
        Top = 65
        Width = 6
        Height = 13
        Caption = '*'
      end
      object Label6: TLabel
        Left = 475
        Top = 96
        Width = 6
        Height = 13
        Caption = '*'
      end
      object Label7: TLabel
        Left = 474
        Top = 125
        Width = 6
        Height = 13
        Caption = '*'
      end
      object EdtCodigoEntregador: TEdit
        Left = 67
        Top = 30
        Width = 70
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 9
        TabOrder = 0
      end
      object EdtNome: TEdit
        Left = 67
        Top = 60
        Width = 402
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 1
      end
      object EdtTelefone: TEdit
        Left = 353
        Top = 121
        Width = 116
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 15
        TabOrder = 4
      end
      object EdtVeiculo: TEdit
        Left = 67
        Top = 91
        Width = 402
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 2
      end
      object EdtPlaca: TEdit
        Left = 67
        Top = 121
        Width = 116
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 3
      end
    end
  end
  inherited PnlGrid: TPanel
    Left = 0
    Top = 246
    Width = 758
    Height = 245
    Align = alClient
    inherited LblTotRegistros: TLabel
      Left = 631
      Top = 226
      ExplicitLeft = 631
      ExplicitTop = 226
    end
    inherited GrbGrid: TGroupBox
      Left = 9
      Top = 5
      Width = 738
      Height = 216
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Entregadores Cadastrados '
      ExplicitLeft = 9
      ExplicitTop = 5
      ExplicitWidth = 810
      ExplicitHeight = 216
      object DbGridEntregadores: TDBGrid
        Left = 9
        Top = 20
        Width = 720
        Height = 185
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = DbGridEntregadoresCellClick
        OnDblClick = DbGridEntregadoresDblClick
        OnKeyDown = DbGridEntregadoresKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'id_entregador'
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Alignment = taCenter
            Title.Caption = 'Nome do Entregador'
            Width = 236
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'veiculo'
            Title.Alignment = taCenter
            Title.Caption = 'Ve'#237'culo'
            Width = 154
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'placa'
            Title.Alignment = taCenter
            Title.Caption = 'Placa'
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Title.Alignment = taCenter
            Title.Caption = 'Telefone'
            Visible = True
          end>
      end
    end
  end
  object PnlPesquisar: TPanel
    Left = 0
    Top = 491
    Width = 758
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    ExplicitTop = 471
    ExplicitWidth = 780
    DesignSize = (
      758
      37)
    object BtnPesquisar: TSpeedButton
      Left = 661
      Top = 5
      Width = 90
      Height = 27
      Anchors = [akTop, akRight, akBottom]
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
      ExplicitLeft = 755
    end
    object Label12: TLabel
      Left = 12
      Top = 13
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
    object EdtPesquisar: TEdit
      Left = 157
      Top = 8
      Width = 501
      Height = 21
      Anchors = [akLeft, akTop, akRight, akBottom]
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = EdtPesquisarChange
      OnKeyPress = EdtPesquisarKeyPress
      ExplicitWidth = 523
    end
    object CbxFiltro: TComboBox
      Left = 61
      Top = 8
      Width = 94
      Height = 21
      ItemIndex = 1
      TabOrder = 0
      Text = 'Nome'
      OnChange = CbxFiltroChange
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        'Ve'#237'culo'
        '')
    end
  end
end
