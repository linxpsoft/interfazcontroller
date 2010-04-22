object FormsForm: TFormsForm
  Left = 0
  Top = 0
  Caption = 'Window Designer'
  ClientHeight = 413
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 233
    Top = 65
    Width = 4
    Height = 348
    ExplicitLeft = 0
    ExplicitTop = 1
    ExplicitHeight = 346
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 699
    Height = 65
    Align = alTop
    DockSite = True
    TabOrder = 0
    OnDockOver = Panel1DockOver
    OnUnDock = Panel1UnDock
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 233
    Height = 348
    Align = alLeft
    DockSite = True
    TabOrder = 1
    OnDockOver = Panel2DockOver
    OnUnDock = Panel2UnDock
  end
  object Panel3: TPanel
    Left = 237
    Top = 65
    Width = 462
    Height = 348
    Align = alClient
    DockSite = True
    TabOrder = 2
    OnDockOver = Panel3DockOver
    OnStartDock = Panel3StartDock
  end
end
