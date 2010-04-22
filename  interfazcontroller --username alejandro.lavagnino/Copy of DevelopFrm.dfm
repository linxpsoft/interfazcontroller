object DevelopForm: TDevelopForm
  Left = 0
  Top = 0
  Caption = 'C'#243'digo'
  ClientHeight = 558
  ClientWidth = 770
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
  object Splitter1: TSplitter
    Left = 0
    Top = 418
    Width = 770
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 52
    ExplicitWidth = 487
  end
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 770
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
  object Editor: TSynEdit
    Left = 0
    Top = 52
    Width = 770
    Height = 366
    Align = alClient
    ActiveLineColor = 15400959
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 1
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 421
    Width = 770
    Height = 19
    Panels = <>
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 26
    Width = 770
    Height = 26
    ActionManager = ActionManager
    Caption = 'ActionToolBar1'
    ColorMap.HighlightColor = 16382458
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 16382458
    Spacing = 0
  end
  object Consola: TSynMemo
    Left = 0
    Top = 440
    Width = 770
    Height = 118
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 4
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Highlighter = SynPasSyn
    RightEdge = 0
    WordWrap = True
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
          end
          item
            Action = Ejecutar
            Caption = '&Ejecutar'
            ImageIndex = 163
            ShortCut = 120
          end
          item
            Action = Pausar
            Caption = 'Pau&sar'
            ImageIndex = 108
            ShowCaption = False
          end
          item
            Action = Detener
            Caption = '&Detener'
            ImageIndex = 115
            ShowCaption = False
          end>
        ActionBar = ActionToolBar1
      end>
    Images = MainForm.ImageList16
    Left = 376
    Top = 56
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
      Enabled = False
      ImageIndex = 108
      OnExecute = PausarExecute
    end
    object Detener: TAction
      Caption = 'Detener'
      Enabled = False
      ImageIndex = 115
      OnExecute = DetenerExecute
    end
  end
  object PaxPascal: TPaxPascalLanguage
    ExplicitOff = False
    CompleteBooleanEval = False
    UnitLookup = True
    PrintKeyword = 'print'
    PrintlnKeyword = 'println'
    Left = 456
    Top = 128
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
    Left = 456
    Top = 40
  end
  object PaxJS: TPaxJavaScriptLanguage
    Left = 416
    Top = 184
  end
  object EditorOptions: TSynEditOptionsDialog
    UseExtendedStrings = False
    Left = 504
    Top = 176
  end
  object PaxProgram: TPaxProgram
    Console = True
    Left = 488
    Top = 232
  end
  object PaxDebug: TPaxCompilerDebugger
    Left = 488
    Top = 288
  end
  object PaxTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = PaxTimerTimer
    Left = 616
    Top = 224
  end
  object PaxCompiler: TPaxCompiler
    Alignment = 1
    DebugMode = True
    Left = 400
    Top = 240
  end
end
