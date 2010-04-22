program Mdiapp;

uses
  Forms,
  MainFrm in 'MainFrm.PAS' {MainForm},
  InterfazFrm in 'InterfazFrm.PAS' {InterfazForm},
  about in 'about.pas' {AboutBox},
  MotorFrm in 'MotorFrm.pas' {MotorForm},
  CommFrm in 'CommFrm.pas' {CommForm},
  DevelopFrm in 'DevelopFrm.pas' {DevelopForm},
  Design in 'Design.pas' {Window},
  OIForm in 'OIForm.pas' {frmObjectInspector},
  Setup in 'Setup.pas' {frmSetup},
  ToolForm in 'ToolForm.pas' {frmToolForm},
  DockForm in 'DockForm.pas' {FormsForm},
  Dll in 'Dll.pas',
  CricketLogo in 'CricketLogo.pas',
  CommProgress in 'CommProgress.pas' {CommProgFrm},
  InterfazSerial in '..\DLL\InterfazSerial.pas',
  JvInterpreter_all in 'C:\Program Files\CodeGear\RAD Studio\6.0\VCL\jvcl\run\JvInterpreter_all.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TCommForm, CommForm);
  Application.CreateForm(TCommProgFrm, CommProgFrm);
  Application.Run;
end.
