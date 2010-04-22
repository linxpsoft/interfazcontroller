object CommProgFrm: TCommProgFrm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Interfaz'
  ClientHeight = 103
  ClientWidth = 254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 142
    Height = 13
    Caption = 'Buscando Puertos Disponibles'
  end
  object CommLabel: TLabel
    Left = 24
    Top = 64
    Width = 3
    Height = 13
  end
  object CommProgress: TProgressBar
    Left = 24
    Top = 43
    Width = 193
    Height = 14
    TabOrder = 0
  end
end
