object FrmPesquisaPedidos: TFrmPesquisaPedidos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pesquisa de Pedidos'
  ClientHeight = 397
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlPesquisar: TPanel
    Left = 0
    Top = 360
    Width = 693
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      693
      37)
    object Label4: TLabel
      Left = 11
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
      Left = 514
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
      ExplicitLeft = 498
    end
    object BtnSelecionar: TSpeedButton
      Left = 601
      Top = 3
      Width = 39
      Height = 27
      Hint = 'Seleciona registro posicionado no grid'
      Anchors = [akTop, akRight]
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9CCDB93C9C75188A5C78
        BBA0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFA0CFBC1E926652D5BC57E0C92BA27B95C9B4FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA3D1BF2093684BD0B538CAAA35C8A74C
        D2B81E9165CFE6DDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA5D1BF
        24946A4BD0B53ACBAB31C5A231C5A23CCDAE47C5A873B79CFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFABD4C426956B4DD1B63ACBAB38CAA942CDAE41C9AB3A
        CCAC44D3B638AD8A8CC5AEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF26916658D8C0
        3FCFB037C9A94CD4B92E9D752C9A714DD2B83CCDAE4CD6BB2B9970BADCCEFFFF
        FFFFFFFFFFFFFFFFFFFFAED6C63EB19050DAC150D7BE319F7997CAB69FCEBB2F
        9C754ED5BA41D0B34ECEB362AF91FAFCFBFFFFFFFFFFFFFFFFFFFFFFFF85C1A9
        3FB08F36A17C97CAB5FFFFFFFFFFFF99CBB7349F7A4ED6BC48D6BA45B99A8AC3
        ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBBDCCFDDEDE7FFFFFFFFFFFFFFFFFFFF
        FFFF99CAB73AA38050D7BF51DAC139A27FAFD5C6FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF98CAB63DA68355DCC455D5
        BD349871E7F3EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF95C8B441AA885BE0CB50C4A993C7B3FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF94C8B445AD
        8D62E6D245AD8DAED5C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF96C8B549B1925FDDC85FAC8EFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFB0D6C74AB192B0D6C7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCE4DBFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnSelecionarClick
      ExplicitLeft = 585
    end
    object BtnSair: TSpeedButton
      Left = 641
      Top = 3
      Width = 39
      Height = 27
      Hint = 'Sair'
      Anchors = [akTop, akRight]
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFEDEDEDCDCDCDCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCA0B2C04B7DA368A4D95C5C5C5D5B5C
        5E5B5B5E5A5A5D5A5A5B5A5B5A5B5B5A5B5B5A5B5B5B5A5A5C59565768764E7E
        A44C80AC5082AB65A2D5FFFFFFFFFFFFFFFFFF3A6BA16B69666F68696C6A696C
        6A696C6A696C6A686E67624C89BA4E85B24D83AE5D8CB2629ED1FFFFFFFFFFFF
        CCCCCC009147068A4E6E606469636467646367646367646268615B4F8ABB5086
        B44F84B16895B95F9BCDFFFFFFCCCCCC00894552DCB0008E477257606B5B6067
        5E6064606062605F645D57518DBE528AB75187B4739FC25D97C9CCCCCC008744
        65D7B400DAA2008641008B44008F461C7D50645A5C605C5A6058525490C2558C
        BA4E81AD7EA6C85A94C4008A4874DABD00CD9C00CC9C00D29E00D5A05FF0D000
        91466353585D57565B534D5794C5588EBC47749B88AFCF5790C0008A4886DEC8
        00C59C00C49B63DCC85FDECA5EE4CF0092475E4F55585353574F4A5A96CA5B8F
        BE22B9F795B5D3548DBCFFFFFF0087439BE0D100C1A000863F008D4400924717
        7A4C584E5154504F524B455B9ACD5C91C120B7F59EBCD75189B8FFFFFFFFFFFF
        008843A2E6DA0090475B414B57474D544A4E514C4E4F4D4C4D46415E9CD25C95
        C55990C1A6C4DF4E86B5FFFFFFFFFFFFFFFFFF00904603874A5244494E484A4D
        494A4C4A4A4C48484A423D60A0D55D98C95894C6AFCCE64B83B0FFFFFFFFFFFF
        FFFFFF4C7AAE47423F4A4443484644484644484644474542433C365FA1D85C9A
        CC5896C9B8D3EB4980ACFFFFFFFFFFFFFFFFFF4C7EAF443832433B37433D3843
        3D38433D38423B363C332CB9DAF57FB0DA5495CCC0DAEF467CA8FFFFFFFFFFFF
        FFFFFF83A6C34B81AE4B83B04A83B04A83B04A83B04A82AF447DA9709CBFB9D5
        EBB3D1EAC1DBF24279A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAF2F9CEE3F53F75A1}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnSairClick
      ExplicitLeft = 625
    end
    object EdtPesquisar: TEdit
      Left = 160
      Top = 6
      Width = 348
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object CbxFiltro: TComboBox
      Left = 59
      Top = 6
      Width = 97
      Height = 21
      ItemIndex = 0
      TabOrder = 0
      Text = 'Data'
      OnClick = CbxFiltroClick
      Items.Strings = (
        'Data'
        'Cliente')
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 693
    Height = 360
    Align = alClient
    Caption = ' Selecione um pedido '
    TabOrder = 1
    DesignSize = (
      693
      360)
    object DbGridPedidos: TDBGrid
      Left = 10
      Top = 20
      Width = 673
      Height = 320
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DbGridPedidosDblClick
      OnKeyDown = DbGridPedidosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'ID_PEDIDO'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'd. Pedido'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DATA_PEDIDO'
          Title.Alignment = taCenter
          Title.Caption = 'Data do Pedido'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMECLIENTE'
          Title.Caption = 'Nome do Cliente'
          Width = 386
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_PEDIDO'
          Title.Alignment = taRightJustify
          Title.Caption = 'Total do Pedido'
          Width = 97
          Visible = True
        end>
    end
  end
end
