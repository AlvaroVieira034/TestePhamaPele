inherited FrmCadCliente: TFrmCadCliente
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Clientes'
  ClientHeight = 572
  ClientWidth = 780
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 786
  ExplicitHeight = 601
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlTopo: TPanel
    Width = 780
    ExplicitWidth = 780
    inherited BtnInserir: TSpeedButton
      Left = 19
      OnClick = BtnInserirClick
      ExplicitLeft = 19
    end
    inherited BtnAlterar: TSpeedButton
      Left = 144
      OnClick = BtnAlterarClick
      ExplicitLeft = 144
    end
    inherited BtnExcluir: TSpeedButton
      Left = 269
      OnClick = BtnExcluirClick
      ExplicitLeft = 269
    end
    inherited BtnGravar: TSpeedButton
      Left = 394
      OnClick = BtnGravarClick
      ExplicitLeft = 394
    end
    inherited BtnCancelar: TSpeedButton
      Left = 519
      OnClick = BtnCancelarClick
      ExplicitLeft = 519
    end
    inherited BtnSair: TSpeedButton
      Left = 644
      OnClick = BtnSairClick
      ExplicitLeft = 644
    end
  end
  inherited PnlDados: TPanel
    Left = 0
    Top = 65
    Width = 780
    Height = 208
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 65
    ExplicitWidth = 780
    ExplicitHeight = 208
    inherited GrbDados: TGroupBox
      Left = 7
      Top = 5
      Width = 762
      Height = 197
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Dados do Cliente '
      ExplicitLeft = 7
      ExplicitTop = 5
      ExplicitWidth = 762
      ExplicitHeight = 197
      object Label6: TLabel
        Left = 296
        Top = 61
        Width = 51
        Height = 13
        Caption = 'Endere'#231'o*'
      end
      object Label7: TLabel
        Left = 701
        Top = 106
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object Label8: TLabel
        Left = 24
        Top = 18
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label10: TLabel
        Left = 295
        Top = 18
        Width = 84
        Height = 13
        Caption = 'Nome do Cliente*'
      end
      object BtnPesquisarCep: TSpeedButton
        Left = 134
        Top = 76
        Width = 28
        Height = 22
        Hint = 'Pesquisar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FA
          FB5B6E8E425672856F71FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFAFBFC7989A263AECF56B0E227416AFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE788BA960A8
          CC73DAFE1980D5556F97FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFF4F6F97894B45FAED374D8FE187FD35376A4ECEEF2FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAAB6C94096CA74D7FE1982
          D8517DB1ECEFF3FFFFFFFFFFFFFFFFFFD9D2D39C867F957E6B9B8671937D73AD
          9D9CD8CFCEA59A9D3C75A7197DD25387C1F0F3F7FFFFFFFFFFFFFFFFFFBCAEAE
          A68361F2DE97FEFEB2FEFEC3FEFED7DCD3BC866D688D6D6A9B9AA486AED8EBF1
          F7FFFFFFFFFFFFFFFFFFD5CDCEA57D59FEE996FEEC9EFDF7AEFDFEC4FDFDD6FE
          FEF2F0EDE3846966DAD1D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8076F0C57A
          FBD687FBE195FDF8B0FDFEC2FDFDD6FDFDE8FEFEFECABEB0C3B6B6FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFA67A5BFED784F8D68CFBE69CFCF6B2FDFEC9FDFDCEFD
          FDDBFDFDE1FCFBDBA3918EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBB855AFBD283
          F8DC8FF9E39EFBEDA8FDFBC2FDFDCCFDFDC8FDFDCEFEFED2A6928CFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFB18362FDCC79FBEB9FFDFED0FCF8D8FCEEABFDFBBEFD
          FDB6FDFEBCFCFBB9B09F97FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5998BF2B66A
          FCE395FDFDBEFDFED1FBE9A6FCF1A8FBEB9EFEFBABE1D39ACEC4C2FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFDCD4D3CB9264FDC875FBE698FBEEA3FBE69AF6D689FC
          DE8FFBE396BFA792F3F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDCFC2BF
          D29A6BF2B86CF9CC7BF9D182FBD07DF1CA83CAAE92E3DCDCFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEE3DCDBCBB0A0D2A57DD8AA7DCEAE90D1
          C1B8F0EDEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnPesquisarCepClick
      end
      object Label3: TLabel
        Left = 24
        Top = 61
        Width = 25
        Height = 13
        Caption = 'Cep*'
      end
      object Label1: TLabel
        Left = 24
        Top = 106
        Width = 34
        Height = 13
        Caption = 'Bairro*'
      end
      object Label2: TLabel
        Left = 296
        Top = 106
        Width = 39
        Height = 13
        Caption = 'Cidade*'
      end
      object Label4: TLabel
        Left = 24
        Top = 151
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label5: TLabel
        Left = 296
        Top = 151
        Width = 28
        Height = 13
        Caption = 'E-mail'
      end
      object EdtCep: TEdit
        Left = 24
        Top = 77
        Width = 106
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 2
        OnChange = EdtCepChange
        OnKeyPress = EdtCepKeyPress
      end
      object EdtEndereco: TEdit
        Left = 295
        Top = 77
        Width = 447
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 3
      end
      object EdtEstado: TEdit
        Left = 701
        Top = 122
        Width = 41
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 6
      end
      object EdtCodigoCliente: TEdit
        Left = 24
        Top = 35
        Width = 70
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 9
        TabOrder = 0
      end
      object EdtNome: TEdit
        Left = 295
        Top = 35
        Width = 447
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 1
      end
      object EdtBairro: TEdit
        Left = 24
        Top = 122
        Width = 233
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 4
      end
      object EdtCidade: TEdit
        Left = 295
        Top = 122
        Width = 319
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 5
      end
      object EdtTelefone: TEdit
        Left = 24
        Top = 166
        Width = 129
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 15
        TabOrder = 7
      end
      object EdtEmail: TEdit
        Left = 295
        Top = 166
        Width = 320
        Height = 21
        CharCase = ecLowerCase
        MaxLength = 100
        TabOrder = 8
      end
    end
  end
  inherited PnlGrid: TPanel
    Left = 0
    Top = 273
    Width = 780
    Height = 262
    Align = alClient
    ExplicitLeft = 0
    ExplicitTop = 273
    ExplicitWidth = 780
    ExplicitHeight = 262
    inherited LblTotRegistros: TLabel
      Left = 680
      Top = 243
      Anchors = [akRight, akBottom]
      ExplicitLeft = 680
      ExplicitTop = 243
    end
    inherited GrbGrid: TGroupBox
      Left = 7
      Top = 4
      Width = 762
      Height = 235
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Clientes Cadastrados '
      ExplicitLeft = 7
      ExplicitTop = 4
      ExplicitWidth = 762
      ExplicitHeight = 235
      object DbGridClientes: TDBGrid
        Left = 9
        Top = 20
        Width = 743
        Height = 205
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = DbGridClientesCellClick
        OnDblClick = DbGridClientesDblClick
        OnKeyDown = DbGridClientesKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'id_cliente'
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Alignment = taCenter
            Title.Caption = 'Nome do Cliente'
            Width = 281
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'cep'
            Title.Alignment = taCenter
            Title.Caption = 'CEP'
            Width = 73
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Title.Alignment = taCenter
            Title.Caption = 'Endere'#231'o'
            Width = 268
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'bairro'
            Title.Alignment = taCenter
            Title.Caption = 'Bairro'
            Width = 134
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade'
            Title.Alignment = taCenter
            Title.Caption = 'Cidade'
            Width = 223
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'estado'
            Title.Alignment = taCenter
            Title.Caption = 'Estado'
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Title.Alignment = taCenter
            Title.Caption = 'Telefone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'email'
            Title.Caption = 'E-mail'
            Visible = True
          end>
      end
    end
  end
  object PnlPesquisar: TPanel
    Left = 0
    Top = 535
    Width = 780
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      780
      37)
    object BtnPesquisar: TSpeedButton
      Left = 683
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
      Width = 523
      Height = 21
      Anchors = [akLeft, akTop, akRight, akBottom]
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = EdtPesquisarChange
      OnKeyPress = EdtPesquisarKeyPress
    end
    object CbxFiltro: TComboBox
      Left = 61
      Top = 8
      Width = 94
      Height = 21
      TabOrder = 0
      Text = 'Nome'
      OnChange = CbxFiltroChange
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        'Cidade')
    end
  end
end
