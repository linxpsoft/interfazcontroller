object CommForm: TCommForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Nueva Interfaz'
  ClientHeight = 103
  ClientWidth = 254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  GlassFrame.Enabled = True
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PortLabel: TLabel
    Left = 24
    Top = 19
    Width = 32
    Height = 13
    Caption = 'Puerto'
  end
  object CommCombo: TComboBox
    Left = 72
    Top = 16
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 72
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 153
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    Default = True
    ModalResult = 2
    TabOrder = 2
  end
end
