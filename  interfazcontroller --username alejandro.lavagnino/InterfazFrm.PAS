unit InterfazFrm;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, ActnList, ComCtrls,
  PlatformDefaultStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, ActnMenus, SysUtils,
  ButtonGroup, SLStreamTypes, SLComponentCollection, LPDrawLayers, Dialogs,
  LPTransparentControl, ULBasicControl, ILLed, ovceditf, ovcedpop, ovcedsld,
  ovcbase, ovcef, ovcpb, ovcnf, ExtCtrls, ILLevelLed, ILMultiLed, ovcslide,
  ULLabel, ILAnalogInstrument, ILProgressBar, SLScope, Mask,
  SynEditOptionsDialog, SynEditHighlighter, SynHighlighterGeneral, SynEdit,
  SynMemo, Buttons, Spin, StdActns, SynAutoCorrect;

const
  MAXSALIDAS = 4;
  MAXSENSORES = 6;

type

  TOperacion = (
                opEncender = 0,
                opApagar = 1,
                opFrenar = 2,
                opInvertir = 3,
                opDirA = 4,
                opDirB = 5,
                opPotencia = 6
              );

  TEstado = (
              eApagado = 0,
              eEncendido = 1,
              eFrenado = 2
            );

  TDireccion = (
                DirA = 0,
                DirB = 1
              );

  TSalida = class
    Estado: TEstado;
    Direccion: TDireccion;
    Potencia: Byte;
    eLED, dLED: TILMultiLed;
    pLED: TILLevelLED;
  end;

  TSensor = class
    Meter: TILProgressBar;
    Display: TULLabel;
  end;

  TInterfazForm = class(TForm)
    GroupBox10: TGroupBox;
    Display1: TULLabel;
    Meter1: TILProgressBar;
    Button18: TButton;
    Button19: TButton;
    GroupBox11: TGroupBox;
    Button20: TButton;
    Button21: TButton;
    GroupBox12: TGroupBox;
    Button22: TButton;
    Button23: TButton;
    GroupBox13: TGroupBox;
    Button24: TButton;
    Button25: TButton;
    GroupBox14: TGroupBox;
    Button26: TButton;
    Button27: TButton;
    GroupBox15: TGroupBox;
    Button28: TButton;
    Button29: TButton;
    Meter2: TILProgressBar;
    Display2: TULLabel;
    Meter3: TILProgressBar;
    Display3: TULLabel;
    Meter4: TILProgressBar;
    Display4: TULLabel;
    Meter5: TILProgressBar;
    Display5: TULLabel;
    Meter6: TILProgressBar;
    Display6: TULLabel;
    TabSheet3: TTabSheet;
    Scope: TSLScope;
    ActionToolBar1: TActionToolBar;
    ScopeActions: TActionManager;
    Desplazar: TAction;
    DesplazarChk: TCheckBox;
    DesplazarEdt: TOvcNumericField;
    TabSheet4: TTabSheet;
    Editor: TSynEdit;
    SynHighLighter: TSynGeneralSyn;
    EditorOptions: TSynEditOptionsDialog;
    ActionMainMenuBar2: TActionMainMenuBar;
    Consola: TSynMemo;
    Splitter1: TSplitter;
    GroupBox9: TGroupBox;
    ButtonGroup3: TButtonGroup;
    ILLedPAP1: TILLed;
    ILLedPAP2: TILLed;
    Label1: TLabel;
    PotenciaSlider: TTrackBar;
    PotenciaEdit: TSpinEdit;
    Label2: TLabel;
    PAPVelEdit: TSpinEdit;
    PaPVelSlider: TTrackBar;
    StepsEdit: TSpinEdit;
    Label3: TLabel;
    GroupBox16: TGroupBox;
    Label4: TLabel;
    ServoEdit: TSpinEdit;
    ServoSlider: TTrackBar;
    DownloadProgress: TProgressBar;
    ProgramActionManager: TActionManager;
    Ejecutar: TAction;
    FileNew: TAction;
    FileOpen: TFileOpen;
    Save: TAction;
    FileSaveAs: TFileSaveAs;
    EditUndo1: TEditUndo;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    OpcionesEditor: TAction;
    Pausar: TAction;
    Detener: TAction;
    CompilarAct: TAction;
    DescargarAct: TAction;
    ActionToolBar2: TActionToolBar;
    ProgSynAutoCorrect: TSynAutoCorrect;
    procedure DesplazarExecute(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure EditorOptionsActExecute(Sender: TObject);
    procedure ButtonedEdit1Click(Sender: TObject);
    procedure ButtonGroup1ButtonClicked(Sender: TObject; Index: Integer);
    procedure ButtonGroup3ButtonClicked(Sender: TObject; Index: Integer);
    procedure PotenciaSliderChange(Sender: TObject);
    procedure PAPVelEditChange(Sender: TObject);
    procedure PaPVelSliderChange(Sender: TObject);
    procedure StepsEditChange(Sender: TObject);
    procedure ServoEditChange(Sender: TObject);
    procedure ServoSliderChange(Sender: TObject);
    procedure CompileActExecute(Sender: TObject);
    procedure OnCompileError(aMessage: string);
    procedure DownloadActExecute(Sender: TObject);
      public
    curInterfaz: word;
    Animar, Sensar: Byte;
    Salidas: array[0..MAXSALIDAS] of TSalida;
    Sensores: array[0..MAXSENSORES] of TSensor;
    Burst: Boolean;
    procedure Header;
    procedure DoAnimar(LED: TILLED; Value: Byte);
    procedure DoSensar(LED: TILLED; Value: Byte);
    procedure UpdateLeds(i: byte);
    procedure UpdateStatus(op: TOperacion;v: Byte);
    procedure UpdateSensores;
    procedure ResetSensores;
    procedure SaveBurstData(s: byte);
      published
    ActionMainMenuBar1: TActionMainMenuBar;
    StatusBar1: TStatusBar;
    InterfazActionManager: TActionManager;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    ILLed1: TILLed;
    ILLed2: TILLed;
    ILLed3: TILLed;
    ILLed4: TILLed;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    GroupBox3: TGroupBox;
    Button7: TButton;
    S1eLED: TILMultiLed;
    Button8: TButton;
    S1dLED: TILMultiLed;
    S1pLED: TILLevelLed;
    GroupBox4: TGroupBox;
    Button9: TButton;
    S2eLED: TILMultiLed;
    Button10: TButton;
    S2dLED: TILMultiLed;
    S2pLED: TILLevelLed;
    GroupBox5: TGroupBox;
    Button11: TButton;
    S3eLED: TILMultiLed;
    Button12: TButton;
    S3dLED: TILMultiLed;
    S3pLED: TILLevelLed;
    GroupBox6: TGroupBox;
    Button13: TButton;
    S4eLED: TILMultiLed;
    Button14: TButton;
    S4dLED: TILMultiLed;
    S4pLED: TILLevelLed;
    TabSheet2: TTabSheet;
    Encender: TAction;
    Apagar: TAction;
    Frenar: TAction;
    Invertir: TAction;
    DirtoA: TAction;
    DirtoB: TAction;
    Potencia: TAction;
    GroupBox7: TGroupBox;
    LedS1: TILLed;
    LedS2: TILLed;
    LedS3: TILLed;
    LedS4: TILLed;
    ButtonGroup1: TButtonGroup;
    ButtonGroup2: TButtonGroup;
    LedS5: TILLed;
    LedS6: TILLed;
    GroupBox8: TGroupBox;
    Button15: TButton;
    Button16: TButton;
    ModeCheck: TCheckBox;
    Button17: TButton;
    ComboBoxEx1: TComboBoxEx;
    BurstTimer: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EncenderExecute(Sender: TObject);
    procedure ApagarExecute(Sender: TObject);
    procedure FrenarExecute(Sender: TObject);
    procedure InvertirExecute(Sender: TObject);
    procedure DirtoAExecute(Sender: TObject);
    procedure DirtoBExecute(Sender: TObject);
    procedure PotenciaExecute(Sender: TObject);
    procedure PotenciaEditChange(Sender: TObject);
    procedure ButtonGroup2Items0Click(Sender: TObject);
    procedure ButtonGroup2Items1Click(Sender: TObject);
    procedure ButtonGroup2Items2Click(Sender: TObject);
    procedure ButtonGroup2Items3Click(Sender: TObject);
    procedure ButtonGroup2Items4Click(Sender: TObject);
    procedure ButtonGroup2Items5Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure BurstTimerTimer(Sender: TObject);
    procedure Button16Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses MainFrm, CommFrm, MotorFrm, CricketLogo, IntList;


procedure TInterfazForm.DoAnimar(LED: TILLED; Value: Byte);
begin
  LED.Value := not LED.Value;
  if LED.Value then Animar := Animar + Value
  else Animar := Animar - Value;
end;

procedure TInterfazForm.DoSensar(LED: TILLED; Value: Byte);
begin
  LED.Value := not LED.Value;
  if LED.Value then Sensar := Sensar + Value
  else Sensar := Sensar - Value;
end;

procedure TInterfazForm.DownloadActExecute(Sender: TObject);
var
	Parser: TCricketLogoParser;
    i,j: integer;
    s: string;
begin
	Consola.Clear;
	Parser:= TCricketLogoParser.Create;
    Parser.OnError := OnCompileError;
    Parser.Execute(Editor.Text);
    with Parser.CompiledHEX do
    if IntCount > 0 then
    begin
    	if IntCount > 980 then
        begin
        	Consola.Lines.Add('Error: Program Size Limit Exceed: 980 bytes.');
        	Abort;
        end;
    	Editor.Enabled := False;
        for i := 0 to IntCount - 1 do
        begin
            if (i > 5) and (i < IntCount - 16) then
            	j := SendProgramByte(Integers[i],1)
            else
            	j := SendProgramByte(Integers[i],0);
            DownloadProgress.Position := Trunc(100 * i / IntCount);
            if j = 0 then
            begin
            	Editor.Enabled := True;
            	Consola.Lines.Add('Error: Download error');
            	abort;
            end;
//        	s := s +#32+ Format('%.2x',[Parser.CompiledHEX.Integers[i]]);
        end;
        DownloadProgress.Position := 100;
        Editor.Enabled := True;
        Consola.Lines.Add('Downloaded!');
    end;
end;

procedure TInterfazForm.UpdateLeds(i: byte);
var
  S: TSalida;
begin
  S := Salidas[i];
  S.eLED.States.Items[0].Value := S.Estado = eEncendido;
  S.eLED.States.Items[1].Value := S.Estado = eFrenado;
  S.dLED.States.Items[0].Value := S.Direccion = DirA;
  S.dLED.States.Items[1].Value := S.Direccion = DirB;
  S.pLED.Value := S.Potencia;
end;

procedure TInterfazForm.UpdateStatus(op: TOperacion;v: Byte);
var
  i: integer;
  S: TSalida;
begin
  for I := 0 to MAXSALIDAS - 1 do
    if ((Animar and (1 shl i)) shr i) = 1 then
    begin
      S := Salidas[i] as TSalida;
      case op of
        opEncender: S.Estado := eEncendido;
        opApagar: S.Estado := eApagado;
        opFrenar: S.Estado := eFrenado;
        opInvertir:
          if S.Direccion = DirA then
            S.Direccion := DirB
          else S.Direccion := DirA;
        opDirA: S.Direccion := DirA;
        opDirB: S.Direccion := DirB;
        opPotencia: S.Potencia:= v;
      end;
      Salidas[i] := S;
      UpdateLeds(i);
    end;
end;

procedure TInterfazForm.PAPVelEditChange(Sender: TObject);
begin
    if PAPVelEdit.Value >= 0 then
    begin
		PAPVelSlider.Position := PAPVElEdit.Value;
        Header;
        PAPSpeed(PAPVelEdit.Value);
    end;
end;


procedure TInterfazForm.PaPVelSliderChange(Sender: TObject);
begin
	PAPVelEdit.Value := PAPVelSlider.Position;
end;

procedure TInterfazForm.UpdateSensores;
var
  i: integer;
  st: string;
  S: TSensor;
  w: Word;
begin
  for I := 0 to MAXSENSORES - 1 do
    if ((Sensar and (1 shl i)) shr i) = 1 then
    begin
      S:= Sensores[i] as TSensor;
      TalkInterfaz(curInterfaz);
      TalkSensor(i);
      if(BurstCount > 0) then
      begin
        w:= GetLastBurstValue;
        S.Meter.Value := w;
        Str(w,st);
        S.Display.Caption := st;
        Scope.Channels[i].Visible := True;
        Scope.Channels[i].Data.AddYData(PWord(@w),1);
      end;
    end;
end;

procedure TInterfazForm.ResetSensores;
var
  i: integer;
  st: string;
  S: TSensor;
begin
  for I := 0 to MAXSENSORES - 1 do
  begin
    if ((Sensar and (1 shl i)) shr i) = 1 then
    begin
      S:= Sensores[i] as TSensor;
      S.Meter.Value := 0;
      S.Display.Caption := '0';
    end;
  end;
end;

procedure TInterfazForm.SaveBurstData(s: byte);
var
  i: integer;
begin
  TalkInterfaz(curInterfaz);
  TalkSensor(s);
  if BurstCount > 0 then
    SaveBurstToFile
  else
    ShowMessage('No hay datos almacenados');
end;

procedure TInterfazForm.ServoEditChange(Sender: TObject);
begin
	if ServoEdit.Value >= 0 then
    begin
    	ServoSlider.Position := ServoEdit.Value;
        Header;
        MotorOn;
        ServoPos(ServoEdit.Value);
		UpdateStatus(opEncender,0);
    end;
end;

procedure TInterfazForm.ServoSliderChange(Sender: TObject);
begin
	ServoEdit.Value := ServoSlider.Position;
end;

procedure TInterfazForm.StepsEditChange(Sender: TObject);
begin
	if StepsEdit.Value > 0 then
    begin
    	Header;
        PAPSteps(StepsEdit.Value);
    end;
end;

procedure TInterfazForm.Header;
begin
  TalkInterfaz(curInterfaz);
  TalkMotor(Animar);
end;

procedure TInterfazForm.ApagarExecute(Sender: TObject);
begin
  Header;
  MotorCoast;
  UpdateStatus(opApagar,0);
end;

procedure TInterfazForm.BurstTimerTimer(Sender: TObject);
begin
  UpdateSensores;
end;

procedure TInterfazForm.Button15Click(Sender: TObject);
var
  i: byte;
begin
  if ModeCheck.Checked then i := 1 else i := 0;
  TalkInterfaz(curInterfaz);
  SensorBurst(Sensar,i);
  for I := 0 to MAXSENSORES - 1 do
  begin
    Scope.Channels[i].Data.Clear;
    Scope.Channels[i].Visible := False;
    if ((Sensar and (1 shl i)) shr i) = 1 then
    begin
      Scope.Channels[i].Visible := True;
    end;
  end;
  BurstTimer.Enabled := true;
  Burst := True;
//  while Burst do
//  begin
//    UpdateSensores;
//    Application.ProcessMessages;
//  end;
end;

procedure TInterfazForm.Button16Click(Sender: TObject);
begin
  TalkInterfaz(curInterfaz);
  StopBurst;
  BurstTimer.Enabled := false;
  Burst := False;
  ResetSensores;
end;

procedure TInterfazForm.Button18Click(Sender: TObject);
begin
  SaveBurstData(0);
end;

procedure TInterfazForm.Button20Click(Sender: TObject);
begin
  SaveBurstData(1);
end;

procedure TInterfazForm.Button22Click(Sender: TObject);
begin
  SaveBurstData(2);
end;

procedure TInterfazForm.Button24Click(Sender: TObject);
begin
  SaveBurstData(3);
end;

procedure TInterfazForm.Button26Click(Sender: TObject);
begin
  SaveBurstData(4);
end;

procedure TInterfazForm.Button28Click(Sender: TObject);
begin
  SaveBurstData(5);
end;

procedure TInterfazForm.Button7Click(Sender: TObject);
var
  MFrm: TMotorForm;
begin
  MFrm := TMotorForm.Create(Self);
  MFrm.Show;
end;

procedure TInterfazForm.ButtonedEdit1Click(Sender: TObject);
begin
	ShowMessage('hola');
end;

procedure TInterfazForm.ButtonGroup1ButtonClicked(Sender: TObject;
  Index: Integer);
begin
  case Index of
  	0: DoAnimar(ILLED1,1);
  	1: DoAnimar(ILLED2,2);
  	2: DoAnimar(ILLED3,4);
  	3: DoAnimar(ILLED4,8);
  end;
end;


procedure TInterfazForm.ButtonGroup2Items0Click(Sender: TObject);
begin
  DoSensar(LedS1,1);
end;

procedure TInterfazForm.ButtonGroup2Items1Click(Sender: TObject);
begin
  DoSensar(LedS2,2);
end;

procedure TInterfazForm.ButtonGroup2Items2Click(Sender: TObject);
begin
  DoSensar(LedS3,4);
end;

procedure TInterfazForm.ButtonGroup2Items3Click(Sender: TObject);
begin
  DoSensar(LedS4,8);
end;

procedure TInterfazForm.ButtonGroup2Items4Click(Sender: TObject);
begin
  DoSensar(LedS5,16);
end;

procedure TInterfazForm.ButtonGroup2Items5Click(Sender: TObject);
begin
  DoSensar(LedS6,32);
end;

procedure TInterfazForm.ButtonGroup3ButtonClicked(Sender: TObject;
  Index: Integer);
begin
	case Index of
        0: DoAnimar(ILLedPAP1, 32);
        1: DoAnimar(ILLedPAP2, 64);
    end;
end;

procedure TInterfazForm.OnCompileError(aMessage: string);
begin
	Consola.Clear;
    Consola.Lines.Add(aMessage);
end;

procedure TInterfazForm.CompileActExecute(Sender: TObject);
var
	Parser: TCricketLogoParser;
    i: integer;
    s: string;
begin
	Consola.Clear;
	Parser:= TCricketLogoParser.Create;
    Parser.OnError := OnCompileError;
    Parser.Execute(Editor.Text);
    if Parser.CompiledHEX.IntCount > 0 then
    begin
    	if Parser.CompiledHEX.IntCount > 980 then
        begin
        	Consola.Lines.Add('Error: Program Size Limit Exceed: 980 bytes.');
        	Abort;
        end;
        for i := 0 to Parser.CompiledHEX.IntCount - 1 do
        	s := s +#32+ Format('%.2x',[Parser.CompiledHEX.Integers[i]]);
        Consola.Lines.Add(s);
       	Consola.Lines.Add('Compiled!');
    end;

end;

procedure TInterfazForm.DesplazarExecute(Sender: TObject);
begin
  if DesplazarChk.Checked then
    Scope.SizeLimit := DesplazarEdt.AsInteger
  else
    Scope.SizeLimit := 0;
end;

procedure TInterfazForm.DirtoAExecute(Sender: TObject);
begin
  Header;
  MotorThisWay;
  UpdateStatus(opDirA,0);
end;

procedure TInterfazForm.DirtoBExecute(Sender: TObject);
begin
  Header;
  MotorThatWay;
  UpdateStatus(opDirB,0);
end;

procedure TInterfazForm.EditorOptionsActExecute(Sender: TObject);
var
	Opts: TSynEditorOptionsContainer;
begin
	Opts:= TSynEditorOptionsContainer.Create(Editor);
    Opts.Assign(Editor);
	if EditorOptions.Execute(Opts) then
    	Opts.AssignTo(Editor);
end;

procedure TInterfazForm.EncenderExecute(Sender: TObject);
begin
  Header;
  MotorOn;
  UpdateStatus(opEncender,0);
end;

procedure TInterfazForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('¿Desconectar la interfaz?','Interfaz',MB_OKCANCEL) = idOK then
  begin
    TalkInterfaz(curInterfaz);
    CloseInterfaz;
    Action := caFree
  end
  else Action := caNone;
end;

procedure TInterfazForm.FormCreate(Sender: TObject);
var
  p: TPort;
  i: Integer;
begin
  for i := 0 to MAXSALIDAS - 1 do
    Salidas[i] := TSalida.Create;
  with Salidas[0] do
  begin
      eLed := S1eLED;
      dLed := S1dLED;
      pLed := S1pLED;
  end;
  with Salidas[1] do
  begin
      eLed := S2eLED;
      dLed := S2dLED;
      pLed := S2pLED;
  end;
  with Salidas[2] do
  begin
      eLed := S3eLED;
      dLed := S3dLED;
      pLed := S3pLED;
  end;
  with Salidas[3] do
  begin
      eLed := S4eLED;
      dLed := S4dLED;
      pLed := S4pLED;
  end;
  for i := 0 to MAXSENSORES - 1 do
    Sensores[i] := TSensor.Create;
  with Sensores[0] do
  begin
    Meter:= Meter1;
    Display:= Display1;
  end;
  with Sensores[1] do
  begin
    Meter:= Meter2;
    Display:= Display2;
  end;
  with Sensores[2] do
  begin
    Meter:= Meter3;
    Display:= Display3;
  end;
  with Sensores[3] do
  begin
    Meter:= Meter4;
    Display:= Display4;
  end;
  with Sensores[4] do
  begin
    Meter:= Meter5;
    Display:= Display5;
  end;
  with Sensores[5] do
  begin
    Meter:= Meter6;
    Display:= Display6;
  end;

  Animar := 0;
  PageControl.ActivePage := PageControl.Pages[0];
end;

procedure TInterfazForm.FrenarExecute(Sender: TObject);
begin
  Header;
  MotorOff;
  UpdateStatus(opFrenar,0);
end;

procedure TInterfazForm.InvertirExecute(Sender: TObject);
begin
  Header;
  MotorInverse;
  UpdateStatus(opInvertir,0);
end;

procedure TInterfazForm.PotenciaEditChange(Sender: TObject);
var
  s: string;
begin
  if PotenciaEdit.Value >= 0 then
  begin
      PotenciaSlider.Position := PotenciaEdit.Value;
	  Potencia.Execute;
  end;
end;

procedure TInterfazForm.PotenciaExecute(Sender: TObject);
var
  b: Byte;
begin
  Header;
  b := Trunc(PotenciaEdit.Value);
  MotorPower(b);
  UpdateStatus(opPotencia,Trunc(PotenciaEdit.Value));
end;

procedure TInterfazForm.PotenciaSliderChange(Sender: TObject);
begin
	PotenciaEdit.Value := PotenciaSlider.Position;
end;

end.
