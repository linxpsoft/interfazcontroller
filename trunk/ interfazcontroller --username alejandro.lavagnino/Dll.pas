unit Dll;

interface

function NewInterfaz(Port:integer):word; stdcall; external 'interfaz.dll';
function GetBuffer: word; stdcall; external 'interfaz.dll';
procedure CloseInterfaz; stdcall; external 'interfaz.dll';
function GetBufferCount: word; stdcall; external 'interfaz.dll';
procedure TalkInterfaz(num: integer); stdcall; external 'interfaz.dll';
procedure TalkMotor(Motors: Byte); stdcall; external 'interfaz.dll';
procedure MotorOn; stdcall; external 'interfaz.dll';
procedure MotorOff; stdcall; external 'interfaz.dll';
procedure MotorInverse; stdcall; external 'interfaz.dll';
procedure MotorThisWay; stdcall; external 'interfaz.dll';
procedure MotorThatWay; stdcall; external 'interfaz.dll';
procedure MotorCoast; stdcall; external 'interfaz.dll';
procedure MotorPower(Power: byte); stdcall; external 'interfaz.dll';
procedure AllMotorsOff; stdcall; external 'interfaz.dll';
procedure TalkPAP(PAP: byte); stdcall; external 'interfaz.dll';
procedure PAPSpeed(Speed: byte); stdcall; external 'interfaz.dll';
procedure PAPSteps(Steps: byte); stdcall; external 'interfaz.dll';
procedure ServoPos(Pos: Byte); stdcall; external 'interfaz.dll';
procedure TalkSensor(Sensor: Byte); stdcall; external 'interfaz.dll';
function GetSensor:Word; stdcall; external 'interfaz.dll';
procedure SensorBurst(Sensors: Byte; Slow: Byte); stdcall; external 'interfaz.dll';
procedure StopBurst; stdcall; external 'interfaz.dll';
function GetBurstValue:Word; stdcall; external 'interfaz.dll';
function GetLastBurstValue:Word; stdcall; external 'interfaz.dll';
function GetBurstTick:LongWord; stdcall; external 'interfaz.dll';
function BurstCount:LongWord; stdcall; external 'interfaz.dll';
function NextBurst: Word; stdcall; external 'interfaz.dll';
procedure ClearBurst; stdcall; external 'interfaz.dll';
function GetSensorValue: LongWord; stdcall; external 'interfaz.dll';
function GetSensorTick: LongWord; stdcall; external 'interfaz.dll';
function NextSensorValue: Word; stdcall; external 'interfaz.dll';
procedure ClearSensorValues; stdcall; external 'interfaz.dll';
function SensorValuesCount: LongWord; stdcall; external 'interfaz.dll';
procedure SetTimer(Interval: Word); stdcall; external 'interfaz.dll';
procedure ClearTimer; stdcall; external 'interfaz.dll';
procedure SaveFile; stdcall; external 'interfaz.dll';
procedure CloseFile; stdcall; external 'interfaz.dll';
procedure SaveBurstToFile; stdcall; external 'interfaz.dll';
function SendProgramByte(B: Byte; Reverse: Byte): Word; stdcall; external 'interfaz.dll';
procedure SetBaudRate(BR: integer); stdcall; external 'interfaz.dll';

function INewInterfaz(port: integer): Word;
procedure ITalkInterfaz(num: integer);
procedure ITalkMotor(Motors: Byte);
procedure IMotorPower(power: Byte);
procedure ITalkPAP(PAP: byte);
procedure IPAPSPeed(Speed: byte);
procedure IPAPSteps(Steps: byte);
procedure IServoPos(Pos: byte);
procedure ITalkSensor(Sensor: byte);
procedure ISensorBurst(Sensors: Byte; Slow: Byte);
procedure ISetTimer(Interval: Word);
procedure ISetBaudRate(BR: integer);

implementation

function INewInterfaz(port: integer): Word;
begin
	Result := NewInterfaz(port);
end;
procedure ITalkInterfaz(num: integer);
begin
    TalkInterfaz(num);
end;
procedure ITalkMotor(Motors: Byte);
begin
    TalkMotor(Motors);
end;
procedure IMotorPower(power: Byte);
begin
    MotorPower(power);
end;
procedure ITalkPAP(PAP: byte);
begin
    TalkPAP(PAP)
end;
procedure IPAPSPeed(Speed: byte);
begin
    PAPSPeed(Speed);
end;
procedure IPAPSteps(Steps: byte);
begin
    PAPSteps(Steps);
end;
procedure IServoPos(Pos: byte);
begin
    ServoPos(Pos);
end;
procedure ITalkSensor(Sensor: byte);
begin
    TalkSensor(Sensor)
end;
procedure ISensorBurst(Sensors: Byte; Slow: Byte);
begin
    SensorBurst(Sensors,Slow);
end;
procedure ISetTimer(Interval: Word);
begin
	SetTimer(Interval);
end;
procedure ISetBaudRate(BR: integer);
begin
    SetBaudRate(BR);
end;

end.
