unit SalidasFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ILLevelLed, ILLed, ILMultiLed, StdCtrls, ovceditf, ovcedpop,
  ovcedsld, ovcbase, ButtonGroup, SLStreamTypes, SLComponentCollection,
  LPDrawLayers, LPTransparentControl, ULBasicControl;

type
  TSalidasForm = class(TForm)
    procedure ButtonGroup1Items0Click(Sender: TObject);
    procedure ButtonGroup1Items1Click(Sender: TObject);
    procedure ButtonGroup1Items2Click(Sender: TObject);
    procedure ButtonGroup1Items3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SalidasForm: TSalidasForm;

implementation

{$R *.dfm}

uses MotorFrm;

procedure TSalidasForm.Button7Click(Sender: TObject);
var
  MFrm: TMotorForm;
begin
  MFrm := TMotorForm.Create(Self);
  MFrm.Show;
end;

procedure TSalidasForm.ButtonGroup1Items0Click(Sender: TObject);
begin
  ILLED1.Value := not ILLED1.Value;
end;

procedure TSalidasForm.ButtonGroup1Items1Click(Sender: TObject);
begin
  ILLED2.Value := not ILLED2.Value;
end;

procedure TSalidasForm.ButtonGroup1Items2Click(Sender: TObject);
begin
  ILLED3.Value := not ILLED3.Value;
end;

procedure TSalidasForm.ButtonGroup1Items3Click(Sender: TObject);
begin
  ILLED4.Value := not ILLED4.Value;
end;

procedure TSalidasForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
