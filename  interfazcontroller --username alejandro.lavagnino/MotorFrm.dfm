object MotorForm: TMotorForm
  Left = 0
  Top = 0
  Caption = 'Salida'
  ClientHeight = 353
  ClientWidth = 195
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object VoltGauge: TILAngularGauge
    Left = 12
    Top = 9
    Transparent = False
    Border.BevelOuter.Width.Value = 0.019999999552965160
    Border.BevelInner.Width.Value = 0.019999999552965160
    Border.Width._Floats = (
      (
        Value
        0.000000000000000000))
    Border.CornerRadius.Value = 0.100000001490116100
    Caption.Font.Name = 'Microsoft Sans Serif'
    Caption.Font.Style = [fsBold]
    Caption.Font.Brush.Color = -16777216
    Caption.Font.Brush.Gradient.CenterColor.Point.AutoCenter = True
    Caption.Font.Brush.Gradient.CenterColor.Point._Floats = (
      (
        X
        0.000000000000000000)
      (
        Y
        0.000000000000000000))
    Caption.Font.Brush.Hatch.Style = HatchStyleHorizontal
    Caption.Font.Brush.LinearGradientMode = lmHorizontal
    Caption.Font.Pen.Brush.Color = -16777216
    Caption.Font.Pen.Brush.Gradient.CenterColor.Point.AutoCenter = True
    Caption.Font.Pen.Brush.Gradient.CenterColor.Point._Floats = (
      (
        X
        0.000000000000000000)
      (
        Y
        0.000000000000000000))
    Caption.Font.Pen.Brush.Hatch.Style = HatchStyleHorizontal
    Caption.Font.Pen.Brush.LinearGradientMode = lmHorizontal
    Caption.Font.Pen.Width = 1.000000000000000000
    Caption.Font.Pen.DashStyle.Style = DashStyleSolid
    Caption.Font.Pen.DashStyle._Floats = (
      (
        Offset
        0.000000000000000000))
    Caption.Font.Pen.Enabled = False
    Caption.Font.Pen.AdditionalPens = <>
    Caption.Font.Pen._Floats = (
      (
        MiterLimit
        0.000000000000000000))
    Caption.Font.Size.Value = 0.090000003576278680
    Caption.Position.X._Floats = (
      (
        Value
        0.000000000000000000))
    Caption.Position.Y.Value = 0.699999988079071100
    Caption.Text = 'Voltaje (Volts)'
    Caption.AdditionalCaptions = <>
    Caption._Floats = (
      (
        Angle
        0.000000000000000000))
    Scale.Position.Value = 0.899999976158142100
    Scale.Precision.NumberDigits = 2
    Scale.Precision.FixedPrecision = False
    Scale.MajorTicks.Visible = True
    Scale.MajorTicks.Thickness.Value = 0.019999999552965160
    Scale.MajorTicks.Length.Value = 0.050000000745058060
    Scale.MajorTicks.Count = 11
    Scale.MajorTicks.Brush.Color = -16777216
    Scale.MajorTicks.Brush.Gradient.CenterColor.Point.AutoCenter = True
    Scale.MajorTicks.Brush.Gradient.CenterColor.Point._Floats = (
      (
        X
        0.000000000000000000)
      (
        Y
        0.000000000000000000))
    Scale.MajorTicks.Brush.Hatch.Style = HatchStyleHorizontal
    Scale.MajorTicks.Brush.LinearGradientMode = lmHorizontal
    Scale.MajorTicks.Labels.Position.Value = 0.750000000000000000
    Scale.MajorTicks.Labels.Visible = True
    Scale.MajorTicks.Labels.Font.Name = 'Microsoft Sans Serif'
    Scale.MajorTicks.Labels.Font.Style = [fsBold]
    Scale.MajorTicks.Labels.Font.Brush.Color = -16777216
    Scale.MajorTicks.Labels.Font.Brush.Gradient.CenterColor.Point.AutoCenter = True
    Scale.MajorTicks.Labels.Font.Brush.Gradient.CenterColor.Point._Floats = (
      (
        X
        0.000000000000000000)
      (
        Y
        0.000000000000000000))
    Scale.MajorTicks.Labels.Font.Brush.Hatch.Style = HatchStyleHorizontal
    Scale.MajorTicks.Labels.Font.Brush.LinearGradientMode = lmHorizontal
    Scale.MajorTicks.Labels.Font.Pen.Brush.Color = -16777216
    Scale.MajorTicks.Labels.Font.Pen.Brush.Gradient.CenterColor.Point.AutoCenter = True
    Scale.MajorTicks.Labels.Font.Pen.Brush.Gradient.CenterColor.Point._Floats = (
      (
        X
        0.000000000000000000)
      (
        Y
        0.000000000000000000))
    Scale.MajorTicks.Labels.Font.Pen.Brush.Hatch.Style = HatchStyleHorizontal
    Scale.MajorTicks.Labels.Font.Pen.Brush.LinearGradientMode = lmHorizontal
    Scale.MajorTicks.Labels.Font.Pen.Width = 1.000000000000000000
    Scale.MajorTicks.Labels.Font.Pen.DashStyle.Style = DashStyleSolid
    Scale.MajorTicks.Labels.Font.Pen.DashStyle._Floats = (
      (
        Offset
        0.000000000000000000))
    Scale.MajorTicks.Labels.Font.Pen.Enabled = False
    Scale.MajorTicks.Labels.Font.Pen.AdditionalPens = <>
    Scale.MajorTicks.Labels.Font.Pen._Floats = (
      (
        MiterLimit
        0.000000000000000000))
    Scale.MajorTicks.Labels.Font.Size.Value = 0.090000003576278680
    Scale.MajorTicks.Labels._Floats = (
      (
        Angle
        0.000000000000000000))
    Scale.MajorTicks.MinTick.Visible = True
    Scale.MajorTicks.MinTick.TickLabel.Visible = True
    Scale.MajorTicks.MaxTick.Visible = True
    Scale.MajorTicks.MaxTick.TickLabel.Visible = True
    Scale.MinorTicks.Visible = True
    Scale.MinorTicks.Thickness.Value = 0.009999999776482582
    Scale.MinorTicks.Length.Value = 0.019999999552965160
    Scale.MinorTicks.Count = 4
    Scale.MinorTicks.Brush.Color = -16777216
    Scale.MinorTicks.Brush.Gradient.CenterColor.Point.AutoCenter = True
    Scale.MinorTicks.Brush.Gradient.CenterColor.Point._Floats = (
      (
        X
        0.000000000000000000)
      (
        Y
        0.000000000000000000))
    Scale.MinorTicks.Brush.Hatch.Style = HatchStyleHorizontal
    Scale.MinorTicks.Brush.LinearGradientMode = lmHorizontal
    Scale.MinorTicks.Labels.Position.Value = 0.850000023841857900
    Scale.MinorTicks.Labels.Visible = False
    Scale.MinorTicks.Labels.Font.Name = 'Microsoft Sans Serif'
    Scale.MinorTicks.Labels.Font.Style = [fsBold]
    Scale.MinorTicks.Labels.Font.Brush.Color = -16777216
    Scale.MinorTicks.Labels.Font.Brush.Gradient.CenterColor.Point.AutoCenter = True
    Scale.MinorTicks.Labels.Font.Brush.Gradient.CenterColor.Point._Floats = (
      (
        X
        0.000000000000000000)
      (
        Y
        0.000000000000000000))
    Scale.MinorTicks.Labels.Font.Brush.Hatch.Style = HatchStyleHorizontal
    Scale.MinorTicks.Labels.Font.Brush.LinearGradientMode = lmHorizontal
    Scale.MinorTicks.Labels.Font.Pen.Brush.Color = -16777216
    Scale.MinorTicks.Labels.Font.Pen.Brush.Gradient.CenterColor.Point.AutoCenter = True
    Scale.MinorTicks.Labels.Font.Pen.Brush.Gradient.CenterColor.Point._Floats = (
      (
        X
        0.000000000000000000)
      (
        Y
        0.000000000000000000))
    Scale.MinorTicks.Labels.Font.Pen.Brush.Hatch.Style = HatchStyleHorizontal
    Scale.MinorTicks.Labels.Font.Pen.Brush.LinearGradientMode = lmHorizontal
    Scale.MinorTicks.Labels.Font.Pen.Width = 1.000000000000000000
    Scale.MinorTicks.Labels.Font.Pen.DashStyle.Style = DashStyleSolid
    Scale.MinorTicks.Labels.Font.Pen.DashStyle._Floats = (
      (
        Offset
        0.000000000000000000))
    Scale.MinorTicks.Labels.Font.Pen.Enabled = False
    Scale.MinorTicks.Labels.Font.Pen.AdditionalPens = <>
    Scale.MinorTicks.Labels.Font.Pen._Floats = (
      (
        MiterLimit
        0.000000000000000000))
    Scale.MinorTicks.Labels.Font.Size.Value = 0.064999997615814210
    Scale.MinorTicks.Labels._Floats = (
      (
        Angle
        0.000000000000000000))
    Scale.MinAngle = 315.000000000000000000
    Scale.MaxAngle = 225.000000000000000000
    Ranges.Position.Value = 0.009999999776482582
    Ranges.Ranges = <>
    Ranges.Width.Value = 0.025000000372529030
    Hand.Length.Value = 0.779999971389770500
    Hand.TailLength.Value = 0.400000005960464400
    Hand.TipWidth.Value = 0.019999999552965160
    Hand.TailIndentSize.Value = 0.070000000298023220
    Hand.TailWidth.Value = 0.100000001490116100
    Center.Bottom.Size.Value = 0.200000002980232200
    Center.Bottom.Color = 1686143104
    Center.Top.Size.Value = 0.143000006675720200
    Center.Top.Color = -9404272
    Value = 5.500000000000000000
    Max = 12.000000000000000000
    _Floats = (
      (
        Min
        0.000000000000000000))
  end
  object VoltLabel: TULLabel
    Left = 24
    Top = 177
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
  object GridPanel1: TGridPanel
    Left = 16
    Top = 208
    Width = 148
    Height = 77
    BevelOuter = bvNone
    ColumnCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 25.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = ILLed8
        Row = 0
      end
      item
        Column = 1
        Control = Label2
        Row = 0
      end
      item
        Column = 0
        Control = ILLed9
        Row = 1
      end
      item
        Column = 1
        Control = Label3
        Row = 1
      end
      item
        Column = 0
        Control = ILLed10
        Row = 2
      end
      item
        Column = 1
        Control = Label4
        Row = 2
      end>
    RowCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 25.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 25.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 25.000000000000000000
      end>
    TabOrder = 2
    DesignSize = (
      148
      77)
    object ILLed8: TILLed
      Left = 2
      Top = 2
      Anchors = []
      Transparent = False
      Border.BevelOuter.Width.Value = 0.100000001490116100
      Border.BevelInner.Width.Value = 0.100000001490116100
      Border.Width._Floats = (
        (
          Value
          0.000000000000000000))
      Border.CornerRadius.Value = 0.300000011920929000
    end
    object Label2: TLabel
      Left = 36
      Top = 6
      Width = 100
      Height = 13
      Anchors = []
      AutoSize = False
      Caption = 'Encendida'
      ExplicitLeft = 62
    end
    object ILLed9: TILLed
      Left = 2
      Top = 27
      Anchors = []
      Transparent = False
      Border.BevelOuter.Width.Value = 0.100000001490116100
      Border.BevelInner.Width.Value = 0.100000001490116100
      Border.Width._Floats = (
        (
          Value
          0.000000000000000000))
      Border.CornerRadius.Value = 0.300000011920929000
    end
    object Label3: TLabel
      Left = 36
      Top = 31
      Width = 100
      Height = 13
      Anchors = []
      AutoSize = False
      Caption = 'Apagada'
      ExplicitLeft = 26
      ExplicitTop = 32
    end
    object ILLed10: TILLed
      Left = 2
      Top = 52
      Anchors = []
      Transparent = False
      Border.BevelOuter.Width.Value = 0.100000001490116100
      Border.BevelInner.Width.Value = 0.100000001490116100
      Border.Width._Floats = (
        (
          Value
          0.000000000000000000))
      Border.CornerRadius.Value = 0.300000011920929000
    end
    object Label4: TLabel
      Left = 36
      Top = 56
      Width = 100
      Height = 13
      Anchors = []
      AutoSize = False
      Caption = 'Frenada'
      ExplicitTop = 59
    end
  end
  object GridPanel2: TGridPanel
    Left = 18
    Top = 291
    Width = 146
    Height = 18
    BevelOuter = bvNone
    ColumnCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 25.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 25.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 25.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 25.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = Label1
        Row = 0
      end
      item
        Column = 1
        Control = ILLed5
        Row = 0
      end
      item
        Column = 2
        Control = Label5
        Row = 0
      end
      item
        Column = 3
        Control = ILLed6
        Row = 0
      end
      item
        Column = 4
        Control = Label6
        Row = 0
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 3
    DesignSize = (
      146
      18)
    object Label1: TLabel
      Left = 1
      Top = 2
      Width = 47
      Height = 13
      Anchors = []
      Caption = 'Direcci'#243'n:'
      ExplicitLeft = 9
    end
    object ILLed5: TILLed
      Left = 52
      Top = 0
      Height = 18
      Anchors = []
      Transparent = False
      Border.BevelOuter.Width.Value = 0.100000001490116100
      Border.BevelInner.Width.Value = 0.100000001490116100
      Border.Width._Floats = (
        (
          Value
          0.000000000000000000))
      Border.CornerRadius.Value = 0.300000011920929000
    end
    object Label5: TLabel
      Left = 84
      Top = 2
      Width = 7
      Height = 13
      Anchors = []
      Caption = 'A'
      ExplicitLeft = 75
    end
    object ILLed6: TILLed
      Left = 102
      Top = 0
      Height = 18
      Anchors = []
      Transparent = False
      Border.BevelOuter.Width.Value = 0.100000001490116100
      Border.BevelInner.Width.Value = 0.100000001490116100
      Border.Width._Floats = (
        (
          Value
          0.000000000000000000))
      Border.CornerRadius.Value = 0.300000011920929000
    end
    object Label6: TLabel
      Left = 134
      Top = 2
      Width = 6
      Height = 13
      Anchors = []
      Caption = 'B'
      ExplicitLeft = 128
      ExplicitTop = -6
    end
  end
end
