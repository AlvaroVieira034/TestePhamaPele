inherited FrmCadEntregas: TFrmCadEntregas
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Sele'#231#227'o de Pedidos Para Entrega'
  ClientHeight = 575
  ClientWidth = 911
  KeyPreview = True
  Position = poMainFormCenter
  ExplicitWidth = 917
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlTopo: TPanel
    Width = 911
    ExplicitWidth = 805
    inherited BtnInserir: TSpeedButton
      Left = 56
      ExplicitLeft = 56
    end
    inherited BtnAlterar: TSpeedButton
      Left = 190
      ExplicitLeft = 190
    end
    inherited BtnExcluir: TSpeedButton
      Left = 323
      ExplicitLeft = 323
    end
    inherited BtnGravar: TSpeedButton
      Left = 456
      ExplicitLeft = 456
    end
    inherited BtnCancelar: TSpeedButton
      Left = 589
      ExplicitLeft = 589
    end
    inherited BtnSair: TSpeedButton
      Left = 719
      ExplicitLeft = 719
    end
  end
  inherited PnlDados: TPanel
    Left = 0
    Top = 65
    Width = 911
    Height = 271
    Align = alClient
    ExplicitLeft = 0
    ExplicitTop = 65
    ExplicitWidth = 911
    ExplicitHeight = 281
    inherited GrbDados: TGroupBox
      Left = 8
      Top = 2
      Width = 893
      Height = 260
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Pedidos dispon'#237'veis para entrega '
      ExplicitLeft = 8
      ExplicitTop = 2
      ExplicitWidth = 900
      ExplicitHeight = 260
      object Label7: TLabel
        Left = 14
        Top = 24
        Width = 58
        Height = 13
        Caption = 'Entregador:'
      end
      object LCbxNomeEntregador: TDBLookupComboBox
        Left = 77
        Top = 20
        Width = 356
        Height = 21
        KeyField = 'ID_ENTREGADOR'
        ListField = 'NOME'
        TabOrder = 0
      end
      object DbGridPedidos: TDBGrid
        Left = 10
        Top = 49
        Width = 847
        Height = 201
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'pedido'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_pedido'
            Width = 72
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor_total'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome_cliente'
            Width = 265
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Width = 271
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status_entrega'
            Width = 128
            Visible = True
          end>
      end
      object BtnAddItemGrid: TButton
        Left = 862
        Top = 49
        Width = 25
        Height = 24
        Anchors = [akTop, akRight]
        ImageIndex = 0
        Images = FrmMain.ImageList
        TabOrder = 2
      end
    end
  end
  inherited PnlGrid: TPanel
    Left = 0
    Top = 336
    Width = 911
    Height = 239
    Align = alBottom
    ExplicitLeft = 0
    ExplicitTop = 336
    ExplicitWidth = 911
    ExplicitHeight = 239
    inherited LblTotRegistros: TLabel
      Left = 731
      Top = 126
      ExplicitLeft = 721
      ExplicitTop = 126
    end
    inherited GrbGrid: TGroupBox
      Left = 8
      Top = 5
      Width = 893
      Height = 227
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Pedidos selecionados para entrega'
      ExplicitLeft = 8
      ExplicitTop = 5
      ExplicitWidth = 893
      ExplicitHeight = 227
      object DBGrid1: TDBGrid
        Left = 10
        Top = 19
        Width = 847
        Height = 198
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'pedido'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome_cliente'
            Width = 246
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Width = 267
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'entregador'
            Width = 211
            Visible = True
          end>
      end
      object BtnDelItemGrid: TButton
        Left = 862
        Top = 20
        Width = 25
        Height = 24
        Anchors = [akTop, akRight]
        ImageIndex = 1
        Images = FrmMain.ImageList
        TabOrder = 1
      end
    end
  end
end
