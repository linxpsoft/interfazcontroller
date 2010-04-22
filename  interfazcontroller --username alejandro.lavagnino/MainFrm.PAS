unit MainFrm;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus, Contnrs,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, ActnMan, ActnCtrls, ActnMenus, AdSelCom,
  PlatformDefaultStyleActnCtrls, OoMisc, AdStMach, AdPort, ILLevelLed, ILMultiLed, ovcslide,
  ULLabel, ILAnalogInstrument, ILProgressBar, XPMan, InterfazSerial;

type
  TMainForm = class(TForm)
    OpenDialog: TOpenDialog;
    StatusBar: TStatusBar;
    ActionManager1: TActionManager;
    Action1: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    Programar: TAction;
    ImageList16: TImageList;
    XPManifest1: TXPManifest;
    WindowDesignerACt: TAction;
    procedure HelpAbout1Execute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure ProgramarExecute(Sender: TObject);
    procedure WindowDesignerACtExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPort = class(TObject)
    port: integer;
  end;

function NewInterfaz(Port:integer):word;
function GetBuffer: word;
procedure CloseInterfaz;
function GetBufferCount: word;
procedure TalkInterfaz(num: integer);
procedure TalkMotor(Motors: Byte);
procedure MotorOn;
procedure MotorOff;
procedure MotorInverse;
procedure MotorThisWay;
procedure MotorThatWay;
procedure MotorCoast;
procedure MotorPower(Power: byte);
procedure AllMotorsOff;
procedure TalkPAP(PAP: byte);
procedure PAPSpeed(Speed: byte);
procedure PAPSteps(Steps: byte);
procedure ServoPos(Pos: Byte);
procedure TalkSensor(Sensor: Byte);
function GetSensor:Word;
procedure SensorBurst(Sensors: Byte; Slow: Byte);
procedure StopBurst;
function GetBurstValue:Word;
function GetLastBurstValue: Word;
function GetBurstTick:LongWord;
function BurstCount:LongWord;
function NextBurst: Word;
procedure ClearBurst;
function GetSensorValue: LongWord;
function GetSensorTick: LongWord;
function NextSensorValue: Word;
procedure ClearSensorValues;
function SensorValuesCount: LongWord;
procedure SetTimer(Interval: Word);
procedure ClearTimer;
procedure SaveFile;
procedure CloseFile;
procedure SaveBurstToFile;
function SendProgramByte(B: Byte; Reverse: Byte): Word;
procedure SetBaudRate(BR: integer);


var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses InterfazFrm, CommFrm, CommProgress, DevelopFrm, about, DockForm;

var
  Forms: array[0..15]of TInterfazForm;
  curForm: byte;

function NewInterfaz(Port:integer):word;
var
  s: TInterfaz;
begin
  if IsPortAvailable(Port) then
  begin
    s := TInterfaz.Create(Port);
    Interfaces.Add(s);
    curInterfaz := Interfaces.Count - 1;
    maxInterfaz := maxInterfaz + 1;
    if (Interfaces.Items[curInterfaz] as TInterfaz).Com.Open then
      Result := curInterfaz
    else Result := High(Result);
  end else
    Result := High(Result);
end;


function GetBuffer: word;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).GetBufferFirst;
end;

procedure CloseInterfaz;
begin
    (Interfaces.Items[curInterfaz] as TInterfaz).Close;
end;

function GetBufferCount: word;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).Buffer.IntCount;
end;


procedure TalkInterfaz(num: integer);
begin
  curInterfaz := num;
end;

procedure TalkMotor(Motors: Byte);
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).TalkMotor(Motors);
end;

procedure MotorOn;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).MotorOn;
end;

procedure MotorOff;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).MotorOff;
end;

procedure MotorInverse;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).MotorInverse;
end;

procedure MotorThisWay;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).MotorThisWay;
end;

procedure MotorThatWay;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).MotorThatWay;
end;

procedure MotorCoast;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).MotorCoast;
end;

procedure MotorPower(Power: byte);
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).MotorPower(Power);
end;

procedure AllMotorsOff;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).AllMotorsOff;
end;

procedure TalkPAP(PAP: byte);
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).TalkPAP(PAP);
end;

procedure PAPSpeed(Speed: byte);
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).PAPSpeed(Speed);
end;

procedure PAPSteps(Steps: byte);
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).PAPSteps(Steps);
end;

procedure ServoPos(Pos: Byte);
begin
    (Interfaces.Items[curInterfaz] as TInterfaz).ServoPos(Pos);
end;

procedure TalkSensor(Sensor: Byte);
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).TalkSensor(Sensor);
end;

function GetSensor:Word;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).GetSensor;
end;

procedure SensorBurst(Sensors: Byte; Slow: Byte);
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).SensorBurst(Sensors,Slow);
end;

procedure StopBurst;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).StopBurst;
end;

function GetBurstValue:Word;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).GetBurstValue;
end;

function GetLastBurstValue: Word;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).GetLastBurstValue;
end;

function GetBurstTick:LongWord;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).GetBurstTick;
end;

function BurstCount:LongWord;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).BurstCount;
end;

function NextBurst: Word;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).NextBurst;
end;

procedure ClearBurst;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).ClearBurst;
end;

function GetSensorValue: LongWord;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).GetSensorValue;
end;

function GetSensorTick: LongWord;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).GetSensorTick;
end;

function NextSensorValue: Word;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).NextSensorValue;
end;

procedure ClearSensorValues;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).ClearSensorValues;
end;

function SensorValuesCount: LongWord;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).SensorValuesCount;
end;

procedure SetTimer(Interval: Word);
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).SetTimer(Interval);
end;

procedure ClearTimer;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).ClearTimer;
end;

procedure SaveFile;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).SaveFile;
end;

procedure CloseFile;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).CloseFile;
end;

procedure SaveBurstToFile;
begin
  (Interfaces.Items[curInterfaz] as TInterfaz).SaveBurstToFile;
end;

function SendProgramByte(B: Byte; Reverse: Byte): Word;
begin
  Result := (Interfaces.Items[curInterfaz] as TInterfaz).SendProgramByte(B,Reverse);
end;

procedure SetBaudRate(BR: integer);
begin
  BaudRate :=  BR;
end;



procedure TMainForm.Action1Execute(Sender: TObject);
var
  i: integer;
  s: string;
  p: TPort;
  F: TInterfazForm;
  curInterfaz: integer;
begin
  CommForm.CommCombo.Clear;
  ShowPortsInUse:= false;
  CommProgFrm.Show;
  for i := 0 to 100 do
  begin
    Str(i,s);
    CommProgFrm.CommProgress.Position := i;
    CommProgFrm.CommLabel.Caption := 'COM'+s;
    Application.ProcessMessages;
    if IsPortAvailable(i) then
    begin
      p := TPort.Create;
      p.port := i;
      CommForm.CommCombo.AddItem('COM'+s,p);
	  Application.ProcessMessages;
    end;
  end;
  CommProgFrm.Hide;
  if CommForm.CommCombo.Items.Count > 0 then
  begin
    CommForm.CommCombo.ItemIndex := 0;
    curInterfaz := -1;
	CommForm.ShowModal;
    if CommForm.ModalResult = mrOK then
    begin
      p := (CommForm.CommCombo.Items.Objects[CommForm.CommCombo.ItemIndex] as TPort);
      curInterfaz := NewInterfaz(p.port);
      if(curInterfaz >= 0) then
      begin
        Forms[curForm] := TInterfazForm.Create(Application);
        (Forms[curForm] as TInterfazForm).curInterfaz := curInterfaz;
        Inc(curForm);
      end else
        ShowMessage('Error al abrir el puerto');
    end
  end else
    ShowMessage('No hay puertos disponibles');
end;




procedure TMainForm.FormCreate(Sender: TObject);
begin
	Interfaces := TObjectList.Create;
	maxInterfaz:= 0;
  	curInterfaz:= 0;
  	BaudRate := 9600;
end;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;



procedure TMainForm.ProgramarExecute(Sender: TObject);
var
  D: TDevelopForm;
begin
//  D := TDevelopForm.Create(Application);
  Application.Createform(TDevelopForm,DevelopForm);
//  D.Show;
end;

procedure TMainForm.WindowDesignerACtExecute(Sender: TObject);
var
	W: TFormsForm;
begin
	W:= TFormsForm.Create(Application);
    W.Show;
end;


end.
