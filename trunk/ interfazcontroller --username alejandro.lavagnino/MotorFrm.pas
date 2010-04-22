unit MotorFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ULLabel, ILAnalogInstrument, ILAngularGauge, SLStreamTypes,
  SLComponentCollection, LPDrawLayers, LPTransparentControl, ULBasicControl,
  ILGlassPanel, StdCtrls, ILLed, ExtCtrls;

type
  TMotorForm = class(TForm)
    VoltGauge: TILAngularGauge;
    VoltLabel: TULLabel;
    GridPanel1: TGridPanel;
    ILLed8: TILLed;
    Label2: TLabel;
    ILLed9: TILLed;
    Label3: TLabel;
    ILLed10: TILLed;
    Label4: TLabel;
    GridPanel2: TGridPanel;
    Label1: TLabel;
    ILLed5: TILLed;
    Label5: TLabel;
    ILLed6: TILLed;
    Label6: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MotorForm: TMotorForm;

implementation

{$R *.dfm}

end.
