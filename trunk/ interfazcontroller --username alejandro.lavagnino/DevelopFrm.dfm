object DevelopForm: TDevelopForm
  Left = 0
  Top = 0
  Caption = 'C'#243'digo'
  ClientHeight = 558
  ClientWidth = 899
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 899
    Height = 26
    UseSystemFont = False
    ActionManager = ActionManager
    Caption = 'ActionMainMenuBar1'
    ColorMap.HighlightColor = 16382458
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 16382458
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    PersistentHotKeys = True
    Spacing = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 539
    Width = 899
    Height = 19
    Panels = <>
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 26
    Width = 899
    Height = 26
    ActionManager = ActionManager
    Caption = 'ActionToolBar1'
    ColorMap.HighlightColor = 16382458
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 16382458
    Spacing = 0
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 52
    Width = 899
    Height = 487
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'C'#243'digo'
      object Splitter1: TSplitter
        Left = 0
        Top = 355
        Width = 891
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 352
        ExplicitWidth = 762
      end
      object Editor: TSynEdit
        Left = 0
        Top = 26
        Width = 891
        Height = 329
        Align = alClient
        ActiveLineColor = 15400959
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 0
        BookMarkOptions.BookmarkImages = MainForm.ImageList16
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Gutter.LeftOffset = 2
        Gutter.ShowLineNumbers = True
        Highlighter = SynPasSyn
        Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabIndent]
        TabWidth = 4
        WantTabs = True
      end
      object Panel1: TPanel
        Left = 0
        Top = 360
        Width = 891
        Height = 99
        Align = alBottom
        Caption = 'Panel1'
        TabOrder = 1
        object Consola: TSynMemo
          Left = 1
          Top = 1
          Width = 889
          Height = 97
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          TabOrder = 0
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Highlighter = SynPasSyn
          ReadOnly = True
          RightEdge = 0
          WordWrap = True
        end
      end
      object ActionToolBar2: TActionToolBar
        Left = 0
        Top = 0
        Width = 891
        Height = 26
        ActionManager = ActionManager
        Caption = 'ActionToolBar2'
        ColorMap.HighlightColor = 16382458
        ColorMap.BtnSelectedColor = clBtnFace
        ColorMap.UnusedColor = 16382458
        Spacing = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ventanas'
      ImageIndex = 1
      object EmbedLeft: TJvEmbeddedFormPanel
        Left = 0
        Top = 0
        Width = 233
        Height = 459
        AlwaysVisible = False
        FormLink = frmObjectInspector.OIEmbedForm
        Align = alLeft
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 233
        Top = 0
        Width = 658
        Height = 459
        Align = alClient
        TabOrder = 1
        object CP: TJvComponentPanel
          Left = 1
          Top = 1
          Width = 656
          Height = 28
          Align = alTop
          OnClick = CPClick
        end
        object EmbedPanel: TScrollBox
          Left = 1
          Top = 58
          Width = 656
          Height = 400
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          DockSite = True
          TabOrder = 1
          OnDockOver = EmbedPanelDockOver
          OnUnDock = EmbedPanelUnDock
        end
        object JvToolBar1: TJvToolBar
          Left = 1
          Top = 29
          Width = 656
          Height = 29
          ButtonHeight = 26
          ButtonWidth = 26
          Caption = 'JvToolBar1'
          Images = MainForm.ImageList16
          TabOrder = 2
          object sbtLock: TToolButton
            Left = 0
            Top = 0
            Hint = 'Lock'
            Caption = 'sbtLock'
            ImageIndex = 57
            OnClick = eveLock
          end
          object sbtCopy: TToolButton
            Left = 26
            Top = 0
            Hint = 'Copy'
            Caption = 'sbtCopy'
            ImageIndex = 21
            OnClick = eveCopy
          end
          object sbtCut: TToolButton
            Left = 52
            Top = 0
            Hint = 'Cut'
            Caption = 'sbtCut'
            ImageIndex = 23
            OnClick = eveCut
          end
          object sbtPaste: TToolButton
            Left = 78
            Top = 0
            Hint = 'Paste'
            Caption = 'sbtPaste'
            ImageIndex = 29
            OnClick = evePaste
          end
          object sbtDelete: TToolButton
            Left = 104
            Top = 0
            Hint = 'Delete'
            Caption = 'sbtDelete'
            ImageIndex = 200
            OnClick = eveDelete
          end
          object sbtSelectAll: TToolButton
            Left = 130
            Top = 0
            Hint = 'Select All'
            Caption = 'sbtSelectAll'
            ImageIndex = 296
            OnClick = eveSelectAll
          end
          object sbtAlignToGrid: TToolButton
            Left = 156
            Top = 0
            Hint = 'Align to Grid'
            Caption = 'sbtAlignToGrid'
            ImageIndex = 283
            OnClick = eveAlign
          end
          object sbtAlign: TToolButton
            Left = 182
            Top = 0
            Hint = 'Align'
            Caption = 'sbtAlign'
            ImageIndex = 299
            OnClick = sbtAlignClick
          end
          object sbtAlignmentPalette: TToolButton
            Left = 208
            Top = 0
            Hint = 'Alignment Palette'
            Caption = 'sbtAlignmentPalette'
            ImageIndex = 295
            OnClick = eveAlignPalette
          end
          object sbtTabOrder: TToolButton
            Left = 234
            Top = 0
            Hint = 'Tab Order'
            Caption = 'sbtTabOrder'
            ImageIndex = 297
            OnClick = eveTabOrder
          end
          object sbtSetup: TToolButton
            Left = 260
            Top = 0
            Hint = 'Setup'
            Caption = 'sbtSetup'
            ImageIndex = 121
            OnClick = sbtSetupClick
          end
          object sbtSave: TToolButton
            Left = 286
            Top = 0
            Action = FormSave
          end
          object sbtLoad: TToolButton
            Left = 312
            Top = 0
            Caption = 'sbtLoad'
            ImageIndex = 44
          end
        end
      end
    end
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = FileNew
                ImageIndex = 12
                ShortCut = 16462
              end
              item
                Action = FileOpen
                ImageIndex = 6
                ShortCut = 16463
              end
              item
                Action = Save
                ImageIndex = 40
                ShortCut = 16467
              end
              item
                Action = FileSaveAs
                ImageIndex = 19
                ShortCut = 123
              end>
            Caption = '&Archivo'
          end
          item
            Items = <
              item
                Action = EditUndo1
                ImageIndex = 33
                ShortCut = 16474
              end
              item
                Action = EditCut1
                ImageIndex = 23
                ShortCut = 16472
              end
              item
                Action = EditCopy1
                ImageIndex = 77
                ShortCut = 16451
              end
              item
                Action = EditPaste1
                ImageIndex = 29
                ShortCut = 16470
              end
              item
                Action = EditSelectAll1
                ShortCut = 16449
              end>
            Caption = '&Editar'
          end>
        ActionBar = ActionMainMenuBar1
      end
      item
        Items = <
          item
            Action = FileNew
            ImageIndex = 12
            ShortCut = 16462
          end
          item
            Action = FileOpen
            ImageIndex = 6
            ShowCaption = False
            ShortCut = 16463
          end
          item
            Action = Save
            ImageIndex = 40
            ShowCaption = False
            ShortCut = 16467
          end
          item
            Caption = '-'
          end
          item
            Action = Ejecutar
            Caption = '&Ejecutar'
            ImageIndex = 163
            ShortCut = 120
          end
          item
            Action = Pausar
            Caption = '&Pausar'
            ImageIndex = 108
          end
          item
            Action = Detener
            Caption = '&Detener'
            ImageIndex = 115
            ShowCaption = False
          end>
        ActionBar = ActionToolBar1
      end
      item
      end
      item
        Items = <
          item
            Action = EditUndo1
            ImageIndex = 33
            ShowCaption = False
            ShortCut = 16474
          end
          item
            Action = EditCut1
            ImageIndex = 23
            ShowCaption = False
            ShortCut = 16472
          end
          item
            Action = EditCopy1
            ImageIndex = 77
            ShowCaption = False
            ShortCut = 16451
          end
          item
            Action = EditPaste1
            ImageIndex = 29
            ShowCaption = False
            ShortCut = 16470
          end
          item
            Caption = '-'
          end>
        ActionBar = ActionToolBar2
      end>
    Images = MainForm.ImageList16
    Left = 776
    Top = 16
    StyleName = 'Platform Default'
    object Ejecutar: TAction
      Caption = 'Ejecutar'
      ImageIndex = 163
      ShortCut = 120
      OnExecute = EjecutarExecute
    end
    object FileNew: TAction
      Category = 'Archivo'
      Caption = '&Nuevo'
      ImageIndex = 12
      ShortCut = 16462
      OnExecute = FileNewExecute
    end
    object FileOpen: TFileOpen
      Category = 'Archivo'
      Caption = '&Abrir...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 6
      ShortCut = 16463
      OnAccept = FileOpenAccept
    end
    object Save: TAction
      Category = 'Archivo'
      Caption = '&Guardar'
      ImageIndex = 40
      ShortCut = 16467
      OnExecute = SaveExecute
    end
    object FileSaveAs: TFileSaveAs
      Category = 'Archivo'
      Caption = 'Guardar &Como...'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 19
      ShortCut = 123
      OnAccept = FileSaveAsAccept
    end
    object EditUndo1: TEditUndo
      Category = 'Editar'
      Caption = '&Undo'
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 33
      ShortCut = 16474
    end
    object EditCut1: TEditCut
      Category = 'Editar'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 23
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Editar'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 77
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Editar'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 29
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Editar'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object OpcionesEditor: TAction
      Category = 'Herramientas'
      Caption = 'Opciones del Editor'
      ImageIndex = 121
      OnExecute = OpcionesEditorExecute
    end
    object Pausar: TAction
      Caption = 'Pausar'
      ImageIndex = 108
    end
    object Detener: TAction
      Caption = 'Detener'
      ImageIndex = 115
      OnExecute = DetenerExecute
    end
    object FormSave: TFileSaveAs
      Category = 'Form'
      Caption = 'Save &As...'
      Dialog.Filter = 'Binary DFM-files|*.dfm|Text DFM-files|*.dfm'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 18
      OnAccept = FormSaveAccept
    end
    object FormOpen: TFileOpen
      Category = 'Form'
      Caption = '&Open...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 44
      ShortCut = 16463
    end
  end
  object SynPasSyn: TSynPasSyn
    KeyAttri.Foreground = 8404992
    NumberAttri.Foreground = clGreen
    NumberAttri.Style = [fsBold]
    FloatAttri.Foreground = clGreen
    FloatAttri.Style = [fsBold]
    HexAttri.Foreground = clTeal
    HexAttri.Style = [fsBold]
    StringAttri.Foreground = clRed
    CharAttri.Foreground = clRed
    SymbolAttri.Style = [fsBold]
    Left = 848
    Top = 16
  end
  object EditorOptions: TSynEditOptionsDialog
    UseExtendedStrings = False
    Left = 568
    Top = 16
  end
  object SynAutoCorrect: TSynAutoCorrect
    Items.Strings = (
      'for'#9'for i := 0 to Count - 1 do'
      'if'#9'if True then'
      'while'#9'while True do'
      'case'#9'case Item of')
    Options = [ascoIgnoreCase]
    Left = 704
    Top = 16
  end
  object pmnMain: TPopupMenu
    Left = 492
    Top = 16
    object mniAlignToGrid: TMenuItem
      Caption = 'Align to &Grid'
      OnClick = eveAlign
    end
    object mniBringToFront: TMenuItem
      Caption = 'Bring to &Front'
    end
    object mniSendToBack: TMenuItem
      Caption = 'Send to &Back'
    end
    object mniSep1: TMenuItem
      Caption = '-'
    end
    object mniCut: TMenuItem
      Caption = 'Cu&t'
      ShortCut = 8238
      OnClick = eveCut
    end
    object mniCopy: TMenuItem
      Caption = '&Copy'
      ShortCut = 16429
      OnClick = eveCopy
    end
    object mniPaste: TMenuItem
      Caption = '&Paste'
      ShortCut = 8237
      OnClick = evePaste
    end
    object mniDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = eveDelete
    end
    object mniSelectAll: TMenuItem
      Caption = 'Select &All'
      OnClick = eveSelectAll
    end
    object mniSep2: TMenuItem
      Caption = '-'
    end
    object mniLock: TMenuItem
      Caption = '&Lock'
      OnClick = eveLock
    end
  end
  object PSImport_Classes1: TPSImport_Classes
    EnableStreams = True
    EnableClasses = True
    Left = 456
    Top = 56
  end
  object PSImport_DateUtils1: TPSImport_DateUtils
    Left = 504
    Top = 56
  end
  object PSImport_Forms1: TPSImport_Forms
    EnableForms = True
    EnableMenus = True
    Left = 448
    Top = 32
  end
  object PSImport_Controls1: TPSImport_Controls
    EnableStreams = True
    EnableGraphics = True
    EnableControls = True
    Left = 552
    Top = 72
  end
  object PSImport_StdCtrls1: TPSImport_StdCtrls
    EnableExtCtrls = True
    EnableButtons = True
    Left = 592
    Top = 72
  end
  object PS: TPSScriptDebugger
    CompilerOptions = []
    OnLine = PSLine
    OnCompile = PSCompile
    Plugins = <>
    UsePreProcessor = False
    Left = 384
    Top = 16
  end
end
