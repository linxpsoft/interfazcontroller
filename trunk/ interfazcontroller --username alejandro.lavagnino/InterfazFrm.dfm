object InterfazForm: TInterfazForm
  Left = 44
  Top = 47
  Caption = 'Interfaz'
  ClientHeight = 494
  ClientWidth = 697
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 697
    Height = 26
    UseSystemFont = False
    ActionManager = ProgramActionManager
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
    Top = 475
    Width = 697
    Height = 19
    Panels = <>
  end
  object PageControl: TPageControl
    Left = 0
    Top = 26
    Width = 697
    Height = 449
    ActivePage = TabSheet4
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Salidas'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 16
        Top = 16
        Width = 153
        Height = 89
        Caption = 'Animar'
        TabOrder = 0
        object ILLed1: TILLed
          Left = 24
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object ILLed2: TILLed
          Left = 50
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object ILLed3: TILLed
          Left = 76
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object ILLed4: TILLed
          Left = 102
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object ButtonGroup1: TButtonGroup
          Left = 23
          Top = 20
          Width = 121
          Height = 28
          BevelEdges = []
          BorderStyle = bsNone
          ButtonWidth = 25
          Items = <
            item
              Caption = ' 1'
            end
            item
              Caption = ' 2'
            end
            item
              Caption = ' 3'
            end
            item
              Caption = ' 4'
            end>
          TabOrder = 4
          OnButtonClicked = ButtonGroup1ButtonClicked
        end
      end
      object GroupBox2: TGroupBox
        Left = 184
        Top = 17
        Width = 417
        Height = 89
        Caption = 'Operar'
        TabOrder = 1
        object Label1: TLabel
          Left = 264
          Top = 25
          Width = 41
          Height = 13
          Caption = 'Potencia'
        end
        object Button1: TButton
          Left = 16
          Top = 21
          Width = 75
          Height = 25
          Action = Encender
          TabOrder = 0
        end
        object Button2: TButton
          Left = 97
          Top = 21
          Width = 75
          Height = 25
          Action = Apagar
          TabOrder = 1
        end
        object Button3: TButton
          Left = 16
          Top = 52
          Width = 75
          Height = 25
          Action = Frenar
          TabOrder = 2
        end
        object Button4: TButton
          Left = 97
          Top = 52
          Width = 75
          Height = 25
          Action = Invertir
          TabOrder = 3
        end
        object Button5: TButton
          Left = 178
          Top = 21
          Width = 75
          Height = 25
          Action = DirtoA
          TabOrder = 4
        end
        object Button6: TButton
          Left = 178
          Top = 52
          Width = 75
          Height = 25
          Action = DirtoB
          TabOrder = 5
        end
        object PotenciaSlider: TTrackBar
          Left = 259
          Top = 52
          Width = 150
          Height = 25
          Max = 255
          Position = 255
          TabOrder = 6
          ThumbLength = 15
          TickStyle = tsManual
          OnChange = PotenciaSliderChange
        end
        object PotenciaEdit: TSpinEdit
          Left = 311
          Top = 24
          Width = 89
          Height = 22
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 255
          OnChange = PotenciaEditChange
        end
      end
      object GroupBox3: TGroupBox
        Left = 16
        Top = 199
        Width = 113
        Height = 129
        Caption = 'Salida 1'
        TabOrder = 2
        object Button7: TButton
          Left = 17
          Top = 50
          Width = 75
          Height = 25
          Caption = 'Ver Estado'
          TabOrder = 0
          OnClick = Button7Click
        end
        object S1eLED: TILMultiLed
          Left = 17
          Top = 24
          Hint = 'Estado'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          States = <
            item
              Name = 'Encendido'
              Color = -16711936
              Value = False
            end
            item
              Name = 'Frenado'
              Color = -65536
              Value = False
            end>
          InputPins.Count = 2
          InputPins.Form = InterfazForm
        end
        object Button8: TButton
          Left = 17
          Top = 81
          Width = 75
          Height = 25
          Caption = 'Secuenciar'
          TabOrder = 2
        end
        object S1dLED: TILMultiLed
          Left = 43
          Top = 24
          Hint = 'Direcci'#243'n'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          States = <
            item
              Name = 'Dir.A'
              Color = -65536
              Value = False
            end
            item
              Name = 'Dir.B'
              Color = -16711936
              Value = False
            end>
          InputPins.Count = 2
          InputPins.Form = InterfazForm
        end
        object S1pLED: TILLevelLed
          Left = 69
          Top = 24
          Hint = 'Potencia'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          Colors = <
            item
              Color = -16711936
            end
            item
              Color = -5383962
            end
            item
              Color = -256
            end
            item
              Color = -23296
            end
            item
              Color = -65536
            end>
          Max = 255.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
      end
      object GroupBox4: TGroupBox
        Left = 144
        Top = 200
        Width = 113
        Height = 129
        Caption = 'Salida 2'
        TabOrder = 3
        object Button9: TButton
          Left = 17
          Top = 50
          Width = 75
          Height = 25
          Caption = 'Ver Estado'
          TabOrder = 0
        end
        object S2eLED: TILMultiLed
          Left = 17
          Top = 24
          Hint = 'Estado'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          States = <
            item
              Name = 'Encendido'
              Color = -16711936
              Value = False
            end
            item
              Name = 'Frenado'
              Color = -65536
              Value = False
            end>
          InputPins.Count = 2
          InputPins.Form = InterfazForm
        end
        object Button10: TButton
          Left = 17
          Top = 81
          Width = 75
          Height = 25
          Caption = 'Secuenciar'
          TabOrder = 2
        end
        object S2dLED: TILMultiLed
          Left = 43
          Top = 24
          Hint = 'Direcci'#243'n'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          States = <
            item
              Name = 'Dir.A'
              Color = -65536
              Value = False
            end
            item
              Name = 'Dir.B'
              Color = -16711936
              Value = False
            end>
          InputPins.Count = 2
          InputPins.Form = InterfazForm
        end
        object S2pLED: TILLevelLed
          Left = 69
          Top = 24
          Hint = 'Potencia'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          Colors = <
            item
              Color = -16711936
            end
            item
              Color = -5383962
            end
            item
              Color = -256
            end
            item
              Color = -23296
            end
            item
              Color = -65536
            end>
          Max = 255.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
      end
      object GroupBox5: TGroupBox
        Left = 272
        Top = 200
        Width = 113
        Height = 129
        Caption = 'Salida 3'
        TabOrder = 4
        object Button11: TButton
          Left = 17
          Top = 50
          Width = 75
          Height = 25
          Caption = 'Ver Estado'
          TabOrder = 0
        end
        object S3eLED: TILMultiLed
          Left = 17
          Top = 24
          Hint = 'Estado'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          States = <
            item
              Name = 'Encendido'
              Color = -16711936
              Value = False
            end
            item
              Name = 'Frenado'
              Color = -65536
              Value = False
            end>
          InputPins.Count = 2
          InputPins.Form = InterfazForm
        end
        object Button12: TButton
          Left = 17
          Top = 81
          Width = 75
          Height = 25
          Caption = 'Secuenciar'
          TabOrder = 2
        end
        object S3dLED: TILMultiLed
          Left = 43
          Top = 24
          Hint = 'Direcci'#243'n'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          States = <
            item
              Name = 'Dir.A'
              Color = -65536
              Value = False
            end
            item
              Name = 'Dir.B'
              Color = -16711936
              Value = False
            end>
          InputPins.Count = 2
          InputPins.Form = InterfazForm
        end
        object S3pLED: TILLevelLed
          Left = 69
          Top = 24
          Hint = 'Potencia'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          Colors = <
            item
              Color = -16711936
            end
            item
              Color = -5383962
            end
            item
              Color = -256
            end
            item
              Color = -23296
            end
            item
              Color = -65536
            end>
          Max = 255.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
      end
      object GroupBox6: TGroupBox
        Left = 400
        Top = 200
        Width = 113
        Height = 129
        Caption = 'Salida 4'
        TabOrder = 5
        object Button13: TButton
          Left = 17
          Top = 50
          Width = 75
          Height = 25
          Caption = 'Ver Estado'
          TabOrder = 0
        end
        object S4eLED: TILMultiLed
          Left = 17
          Top = 24
          Hint = 'Estado'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          States = <
            item
              Name = 'Encendido'
              Color = -16711936
              Value = False
            end
            item
              Name = 'Frenado'
              Color = -65536
              Value = False
            end>
          InputPins.Count = 2
          InputPins.Form = InterfazForm
        end
        object Button14: TButton
          Left = 17
          Top = 81
          Width = 75
          Height = 25
          Caption = 'Secuenciar'
          TabOrder = 2
        end
        object S4dLED: TILMultiLed
          Left = 43
          Top = 24
          Hint = 'Direcci'#243'n'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          States = <
            item
              Name = 'Dir.A'
              Color = -65536
              Value = False
            end
            item
              Name = 'Dir.B'
              Color = -16711936
              Value = False
            end>
          InputPins.Count = 2
          InputPins.Form = InterfazForm
        end
        object S4pLED: TILLevelLed
          Left = 69
          Top = 24
          Hint = 'Potencia'
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
          InactiveColor = -8355712
          Colors = <
            item
              Color = -16711936
            end
            item
              Color = -5383962
            end
            item
              Color = -256
            end
            item
              Color = -23296
            end
            item
              Color = -65536
            end>
          Max = 255.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
      end
      object GroupBox9: TGroupBox
        Left = 16
        Top = 112
        Width = 369
        Height = 81
        Caption = 'Paso a paso'
        TabOrder = 6
        object Label2: TLabel
          Left = 98
          Top = 20
          Width = 45
          Height = 13
          Caption = 'Velocidad'
        end
        object Label3: TLabel
          Left = 262
          Top = 19
          Width = 28
          Height = 13
          Caption = 'Pasos'
        end
        object ButtonGroup3: TButtonGroup
          Left = 24
          Top = 20
          Width = 68
          Height = 28
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ButtonWidth = 25
          Items = <
            item
              Caption = ' 1'
            end
            item
              Caption = ' 2'
            end>
          TabOrder = 0
          OnButtonClicked = ButtonGroup3ButtonClicked
        end
        object ILLedPAP1: TILLed
          Left = 24
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object ILLedPAP2: TILLed
          Left = 50
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object PAPVelEdit: TSpinEdit
          Left = 149
          Top = 18
          Width = 85
          Height = 22
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 255
          OnChange = PAPVelEditChange
        end
        object PaPVelSlider: TTrackBar
          Left = 93
          Top = 44
          Width = 150
          Height = 25
          Max = 255
          Position = 255
          TabOrder = 4
          ThumbLength = 15
          TickStyle = tsManual
          OnChange = PaPVelSliderChange
        end
        object StepsEdit: TSpinEdit
          Left = 263
          Top = 38
          Width = 85
          Height = 22
          MaxValue = 8192
          MinValue = 0
          TabOrder = 5
          Value = 255
          OnChange = StepsEditChange
        end
      end
      object GroupBox16: TGroupBox
        Left = 400
        Top = 112
        Width = 185
        Height = 81
        Caption = 'Servo'
        TabOrder = 7
        object Label4: TLabel
          Left = 22
          Top = 22
          Width = 38
          Height = 13
          Caption = 'Posici'#243'n'
        end
        object ServoEdit: TSpinEdit
          Left = 73
          Top = 18
          Width = 96
          Height = 22
          MaxValue = 45
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = ServoEditChange
        end
        object ServoSlider: TTrackBar
          Left = 19
          Top = 44
          Width = 150
          Height = 25
          Max = 45
          TabOrder = 1
          ThumbLength = 15
          TickStyle = tsManual
          OnChange = ServoSliderChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Sensores'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox7: TGroupBox
        Left = 16
        Top = 16
        Width = 201
        Height = 89
        Caption = 'Sensores'
        TabOrder = 0
        object LedS1: TILLed
          Left = 24
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object LedS2: TILLed
          Left = 50
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object LedS3: TILLed
          Left = 76
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object LedS4: TILLed
          Left = 102
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object ButtonGroup2: TButtonGroup
          Left = 24
          Top = 20
          Width = 161
          Height = 28
          BevelEdges = []
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ButtonWidth = 25
          Items = <
            item
              Caption = ' 1'
              OnClick = ButtonGroup2Items0Click
            end
            item
              Caption = ' 2'
              OnClick = ButtonGroup2Items1Click
            end
            item
              Caption = ' 3'
              OnClick = ButtonGroup2Items2Click
            end
            item
              Caption = ' 4'
              OnClick = ButtonGroup2Items3Click
            end
            item
              Caption = ' 5'
              OnClick = ButtonGroup2Items4Click
            end
            item
              Caption = ' 6'
              OnClick = ButtonGroup2Items5Click
            end>
          TabOrder = 4
        end
        object LedS5: TILLed
          Left = 128
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
        object LedS6: TILLed
          Left = 154
          Top = 47
          Transparent = False
          Border.BevelOuter.Width.Value = 0.100000001490116100
          Border.BevelInner.Width.Value = 0.100000001490116100
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.CornerRadius.Value = 0.300000011920929000
          ShowGlow = False
        end
      end
      object GroupBox8: TGroupBox
        Left = 231
        Top = 16
        Width = 313
        Height = 89
        Caption = 'Sensar'
        TabOrder = 1
        object Button15: TButton
          Left = 24
          Top = 20
          Width = 75
          Height = 25
          Caption = 'Tomar Datos'
          TabOrder = 0
          OnClick = Button15Click
        end
        object Button16: TButton
          Left = 24
          Top = 51
          Width = 75
          Height = 25
          Caption = 'Detener'
          TabOrder = 1
          OnClick = Button16Click
        end
        object ModeCheck: TCheckBox
          Left = 112
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Modo Lento'
          TabOrder = 2
        end
        object Button17: TButton
          Left = 216
          Top = 47
          Width = 75
          Height = 25
          Caption = 'Ver Sensor'
          TabOrder = 3
        end
        object ComboBoxEx1: TComboBoxEx
          Left = 105
          Top = 50
          Width = 105
          Height = 22
          ItemsEx = <
            item
              Caption = 'Sensor 1'
            end
            item
              Caption = 'Sensor 2'
            end
            item
              Caption = 'Sensor 3'
            end
            item
              Caption = 'Sensor 4'
            end
            item
              Caption = 'Sensor 5'
            end
            item
              Caption = 'Sensor 6'
            end>
          Style = csExDropDownList
          ItemHeight = 16
          TabOrder = 4
        end
      end
      object GroupBox10: TGroupBox
        Left = 16
        Top = 111
        Width = 96
        Height = 290
        Caption = 'Sensor 1'
        TabOrder = 2
        object Display1: TULLabel
          Left = 9
          Top = 183
          Width = 75
          Transparent = False
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          Font.Brush.Color = -16777216
          Font.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Brush.Color = -16777216
          Font.Pen.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Pen.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Pen.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Pen.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Width = 1.000000000000000000
          Font.Pen.DashStyle.Style = DashStyleSolid
          Font.Pen.DashStyle._Floats = (
            (
              Offset
              0.000000000000000000))
          Font.Pen.Enabled = False
          Font.Pen.AdditionalPens = <>
          Font.Pen._Floats = (
            (
              MiterLimit
              0.000000000000000000))
          Font.Size.Value = 1.000000000000000000
          Caption = '0'
          _Floats = (
            (
              Angle
              0.000000000000000000))
        end
        object Meter1: TILProgressBar
          Left = 34
          Top = 26
          Width = 25
          Height = 151
          Transparent = False
          Color = -1
          Border.BevelOuter.Width.Value = 1.000000000000000000
          Border.BevelOuter.Width.Proportional = False
          Border.BevelInner.Width.Value = 1.000000000000000000
          Border.BevelInner.Width.Proportional = False
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.Gap.Value = 0.050000000745058060
          Border.CornerRadius.Value = 0.250000000000000000
          Gauge.Blocks.Size.Value = 0.029999999329447740
          Gauge.Blocks.Gap.Value = 0.009999999776482582
          Gauge.Blocks.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.Colors = <
            item
              Color = -16711936
              Range = 0.750000000000000000
            end
            item
              Color = -65536
              Range = 1.000000000000000000
            end>
          Gauge.Background.Color = 0
          Gauge.Background.BlockColor = 0
          Rotation.Angle = 90.000000000000000000
          Rotation.Width = 20.000000000000000000
          Max = 1023.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
        object Button18: TButton
          Left = 9
          Top = 214
          Width = 75
          Height = 25
          Caption = 'Guardar'
          TabOrder = 2
          OnClick = Button18Click
        end
        object Button19: TButton
          Left = 8
          Top = 245
          Width = 75
          Height = 25
          Caption = 'Timer'
          TabOrder = 3
        end
      end
      object GroupBox11: TGroupBox
        Left = 118
        Top = 111
        Width = 96
        Height = 290
        Caption = 'Sensor 2'
        TabOrder = 3
        object Button20: TButton
          Left = 9
          Top = 214
          Width = 75
          Height = 25
          Caption = 'Guardar'
          TabOrder = 0
          OnClick = Button20Click
        end
        object Button21: TButton
          Left = 8
          Top = 245
          Width = 75
          Height = 25
          Caption = 'Timer'
          TabOrder = 1
        end
        object Meter2: TILProgressBar
          Left = 35
          Top = 26
          Width = 25
          Height = 151
          Transparent = False
          Color = -1
          Border.BevelOuter.Width.Value = 1.000000000000000000
          Border.BevelOuter.Width.Proportional = False
          Border.BevelInner.Width.Value = 1.000000000000000000
          Border.BevelInner.Width.Proportional = False
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.Gap.Value = 0.050000000745058060
          Border.CornerRadius.Value = 0.250000000000000000
          Gauge.Blocks.Size.Value = 0.029999999329447740
          Gauge.Blocks.Gap.Value = 0.009999999776482582
          Gauge.Blocks.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.Colors = <
            item
              Color = -16711936
              Range = 0.750000000000000000
            end
            item
              Color = -65536
              Range = 1.000000000000000000
            end>
          Gauge.Background.Color = 0
          Gauge.Background.BlockColor = 0
          Rotation.Angle = 90.000000000000000000
          Rotation.Width = 20.000000000000000000
          Max = 1023.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
        object Display2: TULLabel
          Left = 15
          Top = 183
          Width = 65
          Transparent = False
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          Font.Brush.Color = -16777216
          Font.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Brush.Color = -16777216
          Font.Pen.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Pen.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Pen.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Pen.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Width = 1.000000000000000000
          Font.Pen.DashStyle.Style = DashStyleSolid
          Font.Pen.DashStyle._Floats = (
            (
              Offset
              0.000000000000000000))
          Font.Pen.Enabled = False
          Font.Pen.AdditionalPens = <>
          Font.Pen._Floats = (
            (
              MiterLimit
              0.000000000000000000))
          Font.Size.Value = 1.000000000000000000
          Caption = '0'
          _Floats = (
            (
              Angle
              0.000000000000000000))
        end
      end
      object GroupBox12: TGroupBox
        Left = 220
        Top = 111
        Width = 96
        Height = 290
        Caption = 'Sensor 3'
        TabOrder = 4
        object Button22: TButton
          Left = 9
          Top = 214
          Width = 75
          Height = 25
          Caption = 'Guardar'
          TabOrder = 0
          OnClick = Button22Click
        end
        object Button23: TButton
          Left = 8
          Top = 245
          Width = 75
          Height = 25
          Caption = 'Timer'
          TabOrder = 1
        end
        object Meter3: TILProgressBar
          Left = 36
          Top = 26
          Width = 25
          Height = 151
          Transparent = False
          Color = -1
          Border.BevelOuter.Width.Value = 1.000000000000000000
          Border.BevelOuter.Width.Proportional = False
          Border.BevelInner.Width.Value = 1.000000000000000000
          Border.BevelInner.Width.Proportional = False
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.Gap.Value = 0.050000000745058060
          Border.CornerRadius.Value = 0.250000000000000000
          Gauge.Blocks.Size.Value = 0.029999999329447740
          Gauge.Blocks.Gap.Value = 0.009999999776482582
          Gauge.Blocks.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.Colors = <
            item
              Color = -16711936
              Range = 0.750000000000000000
            end
            item
              Color = -65536
              Range = 1.000000000000000000
            end>
          Gauge.Background.Color = 0
          Gauge.Background.BlockColor = 0
          Rotation.Angle = 90.000000000000000000
          Rotation.Width = 20.000000000000000000
          Max = 1023.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
        object Display3: TULLabel
          Left = 15
          Top = 183
          Width = 65
          Transparent = False
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          Font.Brush.Color = -16777216
          Font.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Brush.Color = -16777216
          Font.Pen.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Pen.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Pen.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Pen.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Width = 1.000000000000000000
          Font.Pen.DashStyle.Style = DashStyleSolid
          Font.Pen.DashStyle._Floats = (
            (
              Offset
              0.000000000000000000))
          Font.Pen.Enabled = False
          Font.Pen.AdditionalPens = <>
          Font.Pen._Floats = (
            (
              MiterLimit
              0.000000000000000000))
          Font.Size.Value = 1.000000000000000000
          Caption = '0'
          _Floats = (
            (
              Angle
              0.000000000000000000))
        end
      end
      object GroupBox13: TGroupBox
        Left = 322
        Top = 111
        Width = 96
        Height = 290
        Caption = 'Sensor 4'
        TabOrder = 5
        object Button24: TButton
          Left = 9
          Top = 214
          Width = 75
          Height = 25
          Caption = 'Guardar'
          TabOrder = 0
          OnClick = Button24Click
        end
        object Button25: TButton
          Left = 8
          Top = 245
          Width = 75
          Height = 25
          Caption = 'Timer'
          TabOrder = 1
        end
        object Meter4: TILProgressBar
          Left = 34
          Top = 26
          Width = 25
          Height = 151
          Transparent = False
          Color = -1
          Border.BevelOuter.Width.Value = 1.000000000000000000
          Border.BevelOuter.Width.Proportional = False
          Border.BevelInner.Width.Value = 1.000000000000000000
          Border.BevelInner.Width.Proportional = False
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.Gap.Value = 0.050000000745058060
          Border.CornerRadius.Value = 0.250000000000000000
          Gauge.Blocks.Size.Value = 0.029999999329447740
          Gauge.Blocks.Gap.Value = 0.009999999776482582
          Gauge.Blocks.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.Colors = <
            item
              Color = -16711936
              Range = 0.750000000000000000
            end
            item
              Color = -65536
              Range = 1.000000000000000000
            end>
          Gauge.Background.Color = 0
          Gauge.Background.BlockColor = 0
          Rotation.Angle = 90.000000000000000000
          Rotation.Width = 20.000000000000000000
          Max = 1023.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
        object Display4: TULLabel
          Left = 14
          Top = 183
          Width = 65
          Transparent = False
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          Font.Brush.Color = -16777216
          Font.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Brush.Color = -16777216
          Font.Pen.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Pen.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Pen.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Pen.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Width = 1.000000000000000000
          Font.Pen.DashStyle.Style = DashStyleSolid
          Font.Pen.DashStyle._Floats = (
            (
              Offset
              0.000000000000000000))
          Font.Pen.Enabled = False
          Font.Pen.AdditionalPens = <>
          Font.Pen._Floats = (
            (
              MiterLimit
              0.000000000000000000))
          Font.Size.Value = 1.000000000000000000
          Caption = '0'
          _Floats = (
            (
              Angle
              0.000000000000000000))
        end
      end
      object GroupBox14: TGroupBox
        Left = 424
        Top = 111
        Width = 96
        Height = 290
        Caption = 'Sensor 5'
        TabOrder = 6
        object Button26: TButton
          Left = 9
          Top = 214
          Width = 75
          Height = 25
          Caption = 'Guardar'
          TabOrder = 0
          OnClick = Button26Click
        end
        object Button27: TButton
          Left = 8
          Top = 245
          Width = 75
          Height = 25
          Caption = 'Timer'
          TabOrder = 1
        end
        object Meter5: TILProgressBar
          Left = 34
          Top = 26
          Width = 25
          Height = 151
          Transparent = False
          Color = -1
          Border.BevelOuter.Width.Value = 1.000000000000000000
          Border.BevelOuter.Width.Proportional = False
          Border.BevelInner.Width.Value = 1.000000000000000000
          Border.BevelInner.Width.Proportional = False
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.Gap.Value = 0.050000000745058060
          Border.CornerRadius.Value = 0.250000000000000000
          Gauge.Blocks.Size.Value = 0.029999999329447740
          Gauge.Blocks.Gap.Value = 0.009999999776482582
          Gauge.Blocks.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.Colors = <
            item
              Color = -16711936
              Range = 0.750000000000000000
            end
            item
              Color = -65536
              Range = 1.000000000000000000
            end>
          Gauge.Background.Color = 0
          Gauge.Background.BlockColor = 0
          Rotation.Angle = 90.000000000000000000
          Rotation.Width = 20.000000000000000000
          Max = 1023.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
        object Display5: TULLabel
          Left = 14
          Top = 183
          Width = 65
          Transparent = False
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          Font.Brush.Color = -16777216
          Font.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Brush.Color = -16777216
          Font.Pen.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Pen.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Pen.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Pen.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Width = 1.000000000000000000
          Font.Pen.DashStyle.Style = DashStyleSolid
          Font.Pen.DashStyle._Floats = (
            (
              Offset
              0.000000000000000000))
          Font.Pen.Enabled = False
          Font.Pen.AdditionalPens = <>
          Font.Pen._Floats = (
            (
              MiterLimit
              0.000000000000000000))
          Font.Size.Value = 1.000000000000000000
          Caption = '0'
          _Floats = (
            (
              Angle
              0.000000000000000000))
        end
      end
      object GroupBox15: TGroupBox
        Left = 526
        Top = 111
        Width = 96
        Height = 290
        Caption = 'Sensor 6'
        TabOrder = 7
        object Button28: TButton
          Left = 9
          Top = 214
          Width = 75
          Height = 25
          Caption = 'Guardar'
          TabOrder = 0
          OnClick = Button28Click
        end
        object Button29: TButton
          Left = 8
          Top = 245
          Width = 75
          Height = 25
          Caption = 'Timer'
          TabOrder = 1
        end
        object Meter6: TILProgressBar
          Left = 34
          Top = 26
          Width = 25
          Height = 151
          Transparent = False
          Color = -1
          Border.BevelOuter.Width.Value = 1.000000000000000000
          Border.BevelOuter.Width.Proportional = False
          Border.BevelInner.Width.Value = 1.000000000000000000
          Border.BevelInner.Width.Proportional = False
          Border.Width._Floats = (
            (
              Value
              0.000000000000000000))
          Border.Gap.Value = 0.050000000745058060
          Border.CornerRadius.Value = 0.250000000000000000
          Gauge.Blocks.Size.Value = 0.029999999329447740
          Gauge.Blocks.Gap.Value = 0.009999999776482582
          Gauge.Blocks.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.EdgeRadius._Floats = (
            (
              Value
              0.000000000000000000))
          Gauge.Colors = <
            item
              Color = -16711936
              Range = 0.750000000000000000
            end
            item
              Color = -65536
              Range = 1.000000000000000000
            end>
          Gauge.Background.Color = 0
          Gauge.Background.BlockColor = 0
          Rotation.Angle = 90.000000000000000000
          Rotation.Width = 20.000000000000000000
          Max = 1023.000000000000000000
          _Floats = (
            (
              Min
              0.000000000000000000)
            (
              Value
              0.000000000000000000))
        end
        object Display6: TULLabel
          Left = 14
          Top = 183
          Width = 65
          Transparent = False
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          Font.Brush.Color = -16777216
          Font.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Brush.Color = -16777216
          Font.Pen.Brush.Gradient.CenterColor.Point.AutoCenter = True
          Font.Pen.Brush.Gradient.CenterColor.Point._Floats = (
            (
              X
              0.000000000000000000)
            (
              Y
              0.000000000000000000))
          Font.Pen.Brush.Hatch.Style = HatchStyleHorizontal
          Font.Pen.Brush.LinearGradientMode = lmHorizontal
          Font.Pen.Width = 1.000000000000000000
          Font.Pen.DashStyle.Style = DashStyleSolid
          Font.Pen.DashStyle._Floats = (
            (
              Offset
              0.000000000000000000))
          Font.Pen.Enabled = False
          Font.Pen.AdditionalPens = <>
          Font.Pen._Floats = (
            (
              MiterLimit
              0.000000000000000000))
          Font.Size.Value = 1.000000000000000000
          Caption = '0'
          _Floats = (
            (
              Angle
              0.000000000000000000))
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Scope'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Scope: TSLScope
        Left = 0
        Top = 26
        Width = 689
        Height = 395
        Cursor = crDefault
        Align = alClient
        Zooming.Mode = zmBoth
        NavigateMode = nmPan
        TabOrder = 0
        InputPins.Count = 6
        InputPins.Form = InterfazForm
        XInputPins.Count = 6
        XInputPins.Form = InterfazForm
        YAxis.Align = vaLeft
        YAxis.MinorTicks.Count = 0
        YAxis.MajorTicks.Step = 10.000000000000000000
        YAxis.Font.Charset = DEFAULT_CHARSET
        YAxis.Font.Color = clWhite
        YAxis.Font.Height = -11
        YAxis.Font.Name = 'Arial'
        YAxis.Font.Style = []
        YAxis.AxisLabel.Font.Charset = DEFAULT_CHARSET
        YAxis.AxisLabel.Font.Color = clWhite
        YAxis.AxisLabel.Font.Height = -13
        YAxis.AxisLabel.Font.Name = 'Arial'
        YAxis.AxisLabel.Font.Style = [fsBold]
        YAxis.AxisLabel.Text = 'Valores'
        YAxis.Format.PrecisionMode = dpmGeneral
        YAxis.Min.Range.High.Enabled = False
        YAxis.Min.Range.Low.Enabled = False
        YAxis.Min.Value = 0.000000000000000000
        YAxis.Max.Range.High.Enabled = False
        YAxis.Max.Range.Low.Enabled = False
        YAxis.Max.Value = 1023.000000000000000000
        YAxis.Zooming.Range.High.Enabled = False
        YAxis.Zooming.Range.Low.Enabled = True
        YAxis.DataView.Lines.Pen.Color = clGreen
        YAxis.DataView.ZeroLine.Pen.Color = clWhite
        YAxis.AdditionalAxes = <>
        YAxis.MinMax = (
          0.000000000000000000
          1023.000000000000000000
          -1000.000000000000000000
          1000.000000000000000000
          -1000.000000000000000000
          1000.000000000000000000
          0.000000100000000000
          100000000.000000000000000000)
        XAxis.Align = vaBottom
        XAxis.MinorTicks.Count = 0
        XAxis.MajorTicks.Step = 10.000000000000000000
        XAxis.Font.Charset = DEFAULT_CHARSET
        XAxis.Font.Color = clWhite
        XAxis.Font.Height = -11
        XAxis.Font.Name = 'Arial'
        XAxis.Font.Style = []
        XAxis.AxisLabel.Font.Charset = DEFAULT_CHARSET
        XAxis.AxisLabel.Font.Color = clWhite
        XAxis.AxisLabel.Font.Height = -13
        XAxis.AxisLabel.Font.Name = 'Arial'
        XAxis.AxisLabel.Font.Style = [fsBold]
        XAxis.AxisLabel.Text = 'Muestras'
        XAxis.Format.PrecisionMode = dpmGeneral
        XAxis.TicksMode = atmAuto
        XAxis.UnitScale.Exponent = 0
        XAxis.Min.Range.High.Enabled = False
        XAxis.Min.Range.Low.Enabled = False
        XAxis.Min.Tick.Value = 0.000000000000000000
        XAxis.Min.Value = 0.000000000000000000
        XAxis.Max.Range.High.Enabled = False
        XAxis.Max.Range.Low.Enabled = False
        XAxis.Max.Tick.Value = 1024.000000000000000000
        XAxis.Max.Mode = mamValue
        XAxis.Max.Value = 1024.000000000000000000
        XAxis.Zooming.Range.High.Enabled = False
        XAxis.Zooming.Range.Low.Enabled = True
        XAxis.DataView.Lines.Pen.Color = clGreen
        XAxis.DataView.ZeroLine.Pen.Color = clWhite
        XAxis.AdditionalAxes = <>
        XAxis.MinMaxRange = (
          -1000.000000000000000000
          1000.000000000000000000
          -1000.000000000000000000
          1000.000000000000000000
          0.000000100000000000
          100000000.000000000000000000)
        Legend.Align = vaRight
        Legend.Font.Charset = DEFAULT_CHARSET
        Legend.Font.Color = clWhite
        Legend.Font.Height = -11
        Legend.Font.Name = 'Arial'
        Legend.Font.Style = []
        Legend.Channels.Caption.Font.Charset = DEFAULT_CHARSET
        Legend.Channels.Caption.Font.Color = clWhite
        Legend.Channels.Caption.Font.Height = -13
        Legend.Channels.Caption.Font.Name = 'Arial'
        Legend.Channels.Caption.Font.Style = []
        Legend.Channels.Caption.Text = 'Sensores'
        Legend.ChannelLinks.Caption.Font.Charset = DEFAULT_CHARSET
        Legend.ChannelLinks.Caption.Font.Color = clWhite
        Legend.ChannelLinks.Caption.Font.Height = -13
        Legend.ChannelLinks.Caption.Font.Name = 'Arial'
        Legend.ChannelLinks.Caption.Font.Style = []
        Legend.MarkerGroups.Caption.Font.Charset = DEFAULT_CHARSET
        Legend.MarkerGroups.Caption.Font.Color = clWhite
        Legend.MarkerGroups.Caption.Font.Height = -13
        Legend.MarkerGroups.Caption.Font.Name = 'Arial'
        Legend.MarkerGroups.Caption.Font.Style = []
        Legend.Zones.Caption.Font.Charset = DEFAULT_CHARSET
        Legend.Zones.Caption.Font.Color = clWhite
        Legend.Zones.Caption.Font.Height = -13
        Legend.Zones.Caption.Font.Name = 'Arial'
        Legend.Zones.Caption.Font.Style = []
        Legend.Zones.Caption.Text = 'Zonas'
        Legend.Ellipses.Caption.Font.Charset = DEFAULT_CHARSET
        Legend.Ellipses.Caption.Font.Color = clWhite
        Legend.Ellipses.Caption.Font.Height = -13
        Legend.Ellipses.Caption.Font.Name = 'Arial'
        Legend.Ellipses.Caption.Font.Style = []
        Legend.Ellipses.Caption.Text = 'Elipses'
        Legend.Cursors.Caption.Font.Charset = DEFAULT_CHARSET
        Legend.Cursors.Caption.Font.Color = clWhite
        Legend.Cursors.Caption.Font.Height = -13
        Legend.Cursors.Caption.Font.Name = 'Arial'
        Legend.Cursors.Caption.Font.Style = []
        Legend.Cursors.Caption.Text = 'Cursores'
        Legend.CursorLinks.Caption.Font.Charset = DEFAULT_CHARSET
        Legend.CursorLinks.Caption.Font.Color = clWhite
        Legend.CursorLinks.Caption.Font.Height = -13
        Legend.CursorLinks.Caption.Font.Name = 'Arial'
        Legend.CursorLinks.Caption.Font.Style = []
        Legend.CursorLinks.Caption.Text = 'Cursores Unidos'
        Legend.CustomGroups = <>
        Title.Align = vaTop
        Title.Text = 'Scope'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -21
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        DataView.Border.Pen.Color = clGreen
        Trails.Font.Charset = DEFAULT_CHARSET
        Trails.Font.Color = clWhite
        Trails.Font.Height = -11
        Trails.Font.Name = 'Arial'
        Trails.Font.Style = []
        Highlighting.MouseHitPoint.PointLabel.Font.Charset = DEFAULT_CHARSET
        Highlighting.MouseHitPoint.PointLabel.Font.Color = clWhite
        Highlighting.MouseHitPoint.PointLabel.Font.Height = -11
        Highlighting.MouseHitPoint.PointLabel.Font.Name = 'Arial'
        Highlighting.MouseHitPoint.PointLabel.Font.Style = []
        MarkerGroups = <>
        Zones = <>
        Ellipses = <>
        Channels = <
          item
            Name = 'Sensor 1'
            Color = clRed
            Points.Visible = False
            Points.Shape = psCircle
            Points.Brush.Color = clRed
            Points.Brush.Style = bsSolid
            Points.Pen.Color = clRed
            ChannelMode = cmLine
            ShadeMode = csmZero
            Markers = <>
            AxisIndex_ = (
              0
              0)
          end
          item
            Name = 'Sensor 2'
            Color = clLime
            Points.Visible = False
            Points.Shape = psCircle
            Points.Brush.Color = clRed
            Points.Brush.Style = bsSolid
            Points.Pen.Color = clRed
            ChannelMode = cmLine
            ShadeMode = csmZero
            Markers = <>
            AxisIndex_ = (
              0
              0)
          end
          item
            Name = 'Sensor 3'
            Color = clBlue
            Points.Visible = False
            Points.Shape = psCircle
            Points.Brush.Color = clRed
            Points.Brush.Style = bsSolid
            Points.Pen.Color = clRed
            ChannelMode = cmLine
            ShadeMode = csmZero
            Markers = <>
            AxisIndex_ = (
              0
              0)
          end
          item
            Name = 'Sensor 4'
            Color = clYellow
            Points.Visible = False
            Points.Shape = psCircle
            Points.Brush.Color = clRed
            Points.Brush.Style = bsSolid
            Points.Pen.Color = clRed
            ChannelMode = cmLine
            ShadeMode = csmZero
            Markers = <>
            AxisIndex_ = (
              0
              0)
          end
          item
            Name = 'Sensor 5'
            Color = clAqua
            Points.Visible = False
            Points.Shape = psCircle
            Points.Brush.Color = clRed
            Points.Brush.Style = bsSolid
            Points.Pen.Color = clRed
            ChannelMode = cmLine
            ShadeMode = csmZero
            Markers = <>
            AxisIndex_ = (
              0
              0)
          end
          item
            Name = 'Sensor 6'
            Color = clMoneyGreen
            Points.Visible = False
            Points.Shape = psCircle
            Points.Brush.Color = clRed
            Points.Brush.Style = bsSolid
            Points.Pen.Color = clRed
            ChannelMode = cmLine
            ShadeMode = csmZero
            Markers = <>
            AxisIndex_ = (
              0
              0)
          end>
        Cursors = <>
        CursorLinks = <>
        ChannelLinks = <>
        SizeLimit = 1000
        ExplicitTop = 23
        ExplicitHeight = 398
      end
      object ActionToolBar1: TActionToolBar
        Left = 0
        Top = 0
        Width = 689
        Height = 26
        ActionManager = ScopeActions
        ColorMap.HighlightColor = 16382458
        ColorMap.BtnSelectedColor = clBtnFace
        ColorMap.UnusedColor = 16382458
        Spacing = 0
        ExplicitTop = 1
      end
      object DesplazarChk: TCheckBox
        Left = -2
        Top = 3
        Width = 97
        Height = 17
        Action = Desplazar
        Caption = 'Desplazar cada'
        TabOrder = 2
      end
      object DesplazarEdt: TOvcNumericField
        Left = 101
        Top = 1
        Width = 54
        Height = 21
        Cursor = crIBeam
        DataType = nftLongInt
        CaretOvr.Shape = csBlock
        EFColors.Disabled.BackColor = clWindow
        EFColors.Disabled.TextColor = clGrayText
        EFColors.Error.BackColor = clRed
        EFColors.Error.TextColor = clBlack
        EFColors.Highlight.BackColor = clHighlight
        EFColors.Highlight.TextColor = clHighlightText
        Options = []
        PictureMask = 'iiiiiiiiiii'
        TabOrder = 3
        RangeHigh = {FFFFFF7F000000000000}
        RangeLow = {00000000000000000000}
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Program'
      ImageIndex = 3
      object Splitter1: TSplitter
        Left = 0
        Top = 321
        Width = 689
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 26
        ExplicitWidth = 254
      end
      object Editor: TSynEdit
        Left = 0
        Top = 52
        Width = 689
        Height = 269
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
        Gutter.LeftOffset = 2
        Gutter.ShowLineNumbers = True
        Highlighter = SynHighLighter
        Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceHomeKey, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoTabIndent, eoTabsToSpaces]
      end
      object ActionMainMenuBar2: TActionMainMenuBar
        Left = 0
        Top = 0
        Width = 689
        Height = 26
        UseSystemFont = False
        ActionManager = ProgramActionManager
        Caption = 'ActionMainMenuBar2'
        ColorMap.HighlightColor = 16382458
        ColorMap.BtnSelectedColor = clBtnFace
        ColorMap.UnusedColor = 16382458
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Spacing = 0
      end
      object Consola: TSynMemo
        Left = 0
        Top = 324
        Width = 689
        Height = 80
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 2
        Gutter.DigitCount = 2
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Gutter.LeftOffset = 10
        Gutter.Width = 20
        ReadOnly = True
        RightEdge = 0
        WordWrap = True
      end
      object DownloadProgress: TProgressBar
        Left = 0
        Top = 404
        Width = 689
        Height = 17
        Align = alBottom
        TabOrder = 3
      end
      object ActionToolBar2: TActionToolBar
        Left = 0
        Top = 26
        Width = 689
        Height = 26
        ActionManager = ProgramActionManager
        Caption = 'ActionToolBar2'
        ColorMap.HighlightColor = 16382458
        ColorMap.BtnSelectedColor = clBtnFace
        ColorMap.UnusedColor = 16382458
        Spacing = 0
      end
    end
  end
  object InterfazActionManager: TActionManager
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Caption = '&Interfaz'
          end>
      end>
    Left = 376
    Top = 8
    StyleName = 'Platform Default'
    object Encender: TAction
      Category = 'Interfaz'
      Caption = 'Encender'
      OnExecute = EncenderExecute
    end
    object Apagar: TAction
      Category = 'Interfaz'
      Caption = 'Apagar'
      OnExecute = ApagarExecute
    end
    object Frenar: TAction
      Category = 'Interfaz'
      Caption = 'Frenar'
      OnExecute = FrenarExecute
    end
    object Invertir: TAction
      Category = 'Interfaz'
      Caption = 'Invertir'
      OnExecute = InvertirExecute
    end
    object DirtoA: TAction
      Category = 'Interfaz'
      Caption = 'DirA'
      OnExecute = DirtoAExecute
    end
    object DirtoB: TAction
      Category = 'Interfaz'
      Caption = 'DirB'
      OnExecute = DirtoBExecute
    end
    object Potencia: TAction
      Category = 'Interfaz'
      Caption = 'Potencia'
      OnExecute = PotenciaExecute
    end
  end
  object BurstTimer: TTimer
    Enabled = False
    Interval = 2
    OnTimer = BurstTimerTimer
    Left = 448
    Top = 8
  end
  object ScopeActions: TActionManager
    ActionBars = <
      item
      end>
    Left = 512
    Top = 8
    StyleName = 'Platform Default'
    object Desplazar: TAction
      Caption = 'Desplazar'
      OnExecute = DesplazarExecute
    end
  end
  object SynHighLighter: TSynGeneralSyn
    CommentAttri.Foreground = clGray
    Comments = [csCStyle]
    DetectPreprocessor = False
    IdentifierAttri.Foreground = clBlack
    IdentifierChars = '_0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    KeyAttri.Foreground = 8404992
    KeyWords.Strings = (
      'AND'
      'BRAKE'
      'FOREVER '
      'HIGHBYTE'
      'IF '
      'IFELSE '
      'ITEM'
      'LIST '
      'LOWBYTE'
      'NEWSERIAL?'
      'NOT'
      'OFFTHISWAY'
      'ON'
      'ONFOR'
      'OR'
      'OUTPUT '
      'PAP '
      'PAPSPEED '
      'PAPSTEPS '
      'RANDOM'
      'RECALL '
      'REPEAT '
      'RESETT'
      'RETURN '
      'SEND '
      'SENSOR1'
      'SENSOR2'
      'SENSOR3'
      'SENSOR4'
      'SENSOR5'
      'SENSOR6'
      'SENSOR7'
      'SENSOR8'
      'SERIAL'
      'SERVO_LT '
      'SERVO_RT '
      'SERVO_SET '
      'SET '
      'SETITEM '
      'SETPOWER'
      'STOP'
      'STOP!'
      'SWITCH1'
      'SWITCH2'
      'SWITCH3'
      'SWITCH4'
      'SWITCH5'
      'SWITCH6'
      'SWITCH7'
      'SWITCH8'
      'THATWAYRD'
      'TIMER'
      'TO'
      'WAIT '
      'WAITUNTIL '
      'XOR')
    NumberAttri.Foreground = clGreen
    NumberAttri.Style = [fsBold]
    StringAttri.Foreground = clMaroon
    SymbolAttri.Style = [fsBold]
    StringDelim = sdDoubleQuote
    Left = 584
    Top = 8
  end
  object EditorOptions: TSynEditOptionsDialog
    UseExtendedStrings = False
    Left = 640
    Top = 8
  end
  object ProgramActionManager: TActionManager
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
      end
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
          end
          item
            Items = <
              item
                Action = OpcionesEditor
                Caption = '&Opciones del Editor'
                ImageIndex = 121
              end>
            Caption = '&Herramientas'
          end
          item
            Items = <
              item
                Action = CompilarAct
                Caption = '&Compilar'
                ImageIndex = 264
                ShortCut = 120
              end
              item
                Action = DescargarAct
                Caption = '&Descargar'
                ImageIndex = 130
                ShortCut = 121
              end>
            Caption = '&Programa'
          end>
        ActionBar = ActionMainMenuBar2
      end
      item
      end
      item
        Items = <
          item
            Action = FileNew
            ImageIndex = 12
            ShowCaption = False
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
            Action = CompilarAct
            Caption = 'C&ompilar'
            ImageIndex = 264
            ShowCaption = False
            ShortCut = 120
          end
          item
            Action = DescargarAct
            Caption = '&Descargar'
            ImageIndex = 130
            ShowCaption = False
            ShortCut = 121
          end>
        ActionBar = ActionToolBar2
      end>
    Images = MainForm.ImageList16
    Left = 264
    Top = 8
    StyleName = 'Platform Default'
    object Ejecutar: TAction
      Caption = 'Ejecutar'
      ImageIndex = 163
      ShortCut = 120
    end
    object FileNew: TAction
      Category = 'Archivo'
      Caption = '&Nuevo'
      ImageIndex = 12
      ShortCut = 16462
    end
    object FileOpen: TFileOpen
      Category = 'Archivo'
      Caption = '&Abrir...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 6
      ShortCut = 16463
    end
    object Save: TAction
      Category = 'Archivo'
      Caption = '&Guardar'
      ImageIndex = 40
      ShortCut = 16467
    end
    object FileSaveAs: TFileSaveAs
      Category = 'Archivo'
      Caption = 'Guardar &Como...'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 19
      ShortCut = 123
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
      OnExecute = EditorOptionsActExecute
    end
    object Pausar: TAction
      Caption = 'Pausar'
      Enabled = False
      ImageIndex = 108
    end
    object Detener: TAction
      Caption = 'Detener'
      Enabled = False
      ImageIndex = 115
    end
    object CompilarAct: TAction
      Category = 'Programa'
      Caption = 'Compilar'
      ImageIndex = 264
      ShortCut = 120
      OnExecute = CompileActExecute
    end
    object DescargarAct: TAction
      Category = 'Programa'
      Caption = 'Descargar'
      ImageIndex = 130
      ShortCut = 121
      OnExecute = DownloadActExecute
    end
  end
  object ProgSynAutoCorrect: TSynAutoCorrect
    Editor = Editor
    Items.Strings = (
      'if'#9'if <Condition> [ ]'
      'ifelse'#9'ifelse <Condition> [ ] [ ]'
      'repeat'#9'repeat <Times> [ ] '
      'forever'#9'forever [ ]'
      'waituntil'#9'waituntil ( ) '
      'set'#9'set ( Var, Value )'
      'setitem'#9'setitem ( Var, Index , Value )'
      'list'#9'list ( Var, Size)'
      'item'#9'item ( Var, Index )')
    Left = 624
    Top = 56
  end
end
