unit DevelopFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Contnrs,
  Dialogs, PaxProgram, PaxCompiler, PaxRegister, PaxJavaScriptLanguage, SynEditHighlighter,
  SynHighlighterJScript, ComCtrls, SynEdit, PlatformDefaultStyleActnCtrls,
  ActnList, ActnMan, ToolWin, ActnCtrls, ActnMenus, SynHighlighterPas,
  SynHighlighterGeneral, SynHighlighterMulti, SynEditOptionsDialog, ExtActns,
  StdActns, PaxCompilerDebugger, ExtCtrls, SynMemo, StdCtrls, PaxDfm,
  PaxScripter, BASE_PARSER, PaxPascal, SynAutoCorrect, SynCompletionProposal,
  JvComponentBase, JvInterpreter, JvInterpreterFm, JvExControls, JvEmbeddedForms,
  JvDesignSurface, JvExExtCtrls, JvExtComponent, JvCaptionPanel, ImgList,
  JvLookOut, CtrlDes, JvOutlookBar, Menus, Buttons, JvComponentPanel,
  JvSpeedButton, JvExComCtrls, JvToolBar;

type
  TDevelopForm = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionManager: TActionManager;
    StatusBar1: TStatusBar;
    Ejecutar: TAction;
    SynPasSyn: TSynPasSyn;
    EditorOptions: TSynEditOptionsDialog;
    FileOpen: TFileOpen;
    FileSaveAs: TFileSaveAs;
    Save: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    ActionToolBar1: TActionToolBar;
    OpcionesEditor: TAction;
    FileNew: TAction;
    Pausar: TAction;
    Detener: TAction;
    SynAutoCorrect: TSynAutoCorrect;
    JvPascal: TJvInterpreterFm;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Editor: TSynEdit;
    Panel1: TPanel;
    Consola: TSynMemo;
    Splitter1: TSplitter;
    TabSheet2: TTabSheet;
    EmbedLeft: TJvEmbeddedFormPanel;
    Panel2: TPanel;
    CP: TJvComponentPanel;
    EmbedPanel: TScrollBox;
    JvToolBar1: TJvToolBar;
    sbtLock: TToolButton;
    sbtCopy: TToolButton;
    sbtCut: TToolButton;
    sbtPaste: TToolButton;
    sbtDelete: TToolButton;
    sbtSelectAll: TToolButton;
    sbtAlignToGrid: TToolButton;
    sbtAlignmentPalette: TToolButton;
    sbtTabOrder: TToolButton;
    sbtAlign: TToolButton;
    sbtSetup: TToolButton;
    sbtSave: TToolButton;
    sbtLoad: TToolButton;
    FormSave: TFileSaveAs;
    FormOpen: TFileOpen;
    procedure EjecutarExecute(Sender: TObject);
    procedure SaveExecute(Sender: TObject);
    procedure FileSaveAsAccept(Sender: TObject);
    procedure FileOpenAccept(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OpcionesEditorExecute(Sender: TObject);
    procedure FileNewExecute(Sender: TObject);
    procedure PausarExecute(Sender: TObject);
    procedure DetenerExecute(Sender: TObject);
    procedure PaxTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaxScripterAssignScript(Sender: TPaxScripter);
    procedure PaxScripterRunning(Sender: TPaxScripter; N: Integer;
      var Handled: Boolean);
    procedure JvPascalGetValue(Sender: TObject; Identifier: string;
      var Value: Variant; Args: TJvInterpreterArgs; var Done: Boolean);
    procedure JvPascalGetUnitSource(UnitName: string; var Source: string;
      var Done: Boolean);
    procedure EmbedPanelDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure CPClick(Sender: TObject; Button: Integer);
    procedure eveLock(Sender: TObject);
    procedure eveAlign(Sender: TObject);
    procedure eveDelete(Sender: TObject);
    procedure eveCut(Sender: TObject);
    procedure evePaste(Sender: TObject);
    procedure eveCopy(Sender: TObject);
    procedure eveSelectAll(Sender: TObject);
    procedure eveAlignPalette(Sender: TObject);
    procedure eveTabOrder(Sender: TObject);
    procedure sbtAlignClick(Sender: TObject);
    procedure sbtSetupClick(Sender: TObject);
    procedure FormSaveAccept(Sender: TObject);

  private
    FileName: TFileName;
    { Private declarations }
  public
    { Public declarations }
    DesignClass: string;
    StickyClass: Boolean;
    ComponentClass: TComponentClass;
  end;

  TConsole = class(TObject)
      Console: TSynMemo;
      procedure Write(s: Variant);
      procedure Clear;
  end;

var
  DevelopForm: TDevelopForm;
  Console: TConsole;

implementation

{$R *.dfm}

uses MainFrm, OoMisc, OIForm, ToolForm, Design, Setup, FDMain;

const
	MAXCLASSES = 7;

var
   cClasses: array[0..MAXCLASSES] of TComponentClass = (
    TLabel,
   	TButton,
    TEdit,
    TCheckBox,
    TPanel,
    TImage,
    TMainMenu,
    TTimer);



procedure TConsole.Write(s: Variant);
begin
	Console.Lines.Add(VarToStr(s));
end;

procedure TConsole.Clear;
begin
    Console.Lines.Clear;
end;

procedure TDevelopForm.EjecutarExecute(Sender: TObject);
begin
{  PaxScripter.ResetScripter;
  if PaxScripter.Compile then
  begin
    Ejecutar.Enabled := False;
    Pausar.Enabled := True;
    Detener.Enabled := True;
    PaxTimer.Enabled := true;
    PaxScripter.Run;
  end
  else
      ShowMessage(PaxScripter.ErrorDescription);
  }
//  JvPascal.Source := 'procedure CloseButtonClick(Sender: TObject);begin showmessage(''rtretertert3453454'');end;';
//  JvPascal.Run;
  JvPascal.RunUnit('test.pas');
  JvPascal.Source := 'program A; uses test; '+Editor.Text;
  JvPascal.Run;
end;


procedure TDevelopForm.EmbedPanelDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
	Accept :=  Source.Control = Window;
end;

procedure TDevelopForm.CPClick(Sender: TObject; Button: Integer);
begin
	CP.SelectedButton := Button;
	ComponentClass := cClasses[Button];
  	with Window.cmpFormDesigner do
    	if Assigned(ComponentClass) then
    	begin
      		if not Locked then Lock;
    	end
    	else Unlock;

end;

procedure TDevelopForm.DetenerExecute(Sender: TObject);
begin
//    PaxProgram.Pause;
//    PaxProgram.DiscardPause;
    Detener.Enabled := False;
    Pausar.Enabled := False;
    Ejecutar.Enabled := True;
end;

procedure TDevelopForm.FileNewExecute(Sender: TObject);
begin
	if Editor.Modified then
    begin
        if MessageDlg('¿Vaciar el contenido del editor? Los cambios no guardados se perderán.',mtWarning,MBOKCANCEL,0) <> mrOK then
        	abort;
    end;
    Editor.ClearAll;
    FileName := '';
    Editor.Modified := False;
end;

procedure TDevelopForm.FileOpenAccept(Sender: TObject);
begin
	if Editor.Modified then
    begin
        if MessageDlg('¿Reemplazar el contenido del editor? Los cambios no guardados se perderán.',mtWarning,MBOKCANCEL,0) <> mrOK then
        	abort;
    end;
	FileName := FileOpen.Dialog.FileName;
    Editor.Lines.LoadFromFile(FileName);
    Editor.Modified := False;
end;

procedure TDevelopForm.FileSaveAsAccept(Sender: TObject);
begin
	FileName := FileSaveAs.Dialog.FileName;
    Editor.Lines.SaveToFile(FileName);
    Editor.Modified := False;
end;

procedure TDevelopForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
	res: integer;
begin
{    if PaxProgram.IsRunning then
    begin
        PaxProgram.Pause;
        PaxProgram.DiscardPause;
    end;
    if PaxProgram.IsPaused then
    	PaxProgram.DiscardPause;
}	if Editor.Modified then
    begin
        res := MessageDlg('¿Guardar el contenido del editor? Los cambios no guardados se perderán.',mtWarning,MBYESNOCANCEL,0);
        if res = mrYes then
        begin
        	if Filename = '' then
            begin
                if FileSaveAs.Dialog.Execute then
                	FileName := FileSaveAs.Dialog.FileName;
            end;
        	if Filename = '' then Abort;
            Editor.Lines.LoadFromFile(FileName);
            Action := caFree;
        end;
        if res = mrNo then 	Action := caFree;
        if res = mrCancel then 	Action := caNone;
    end else
    	Action := caFree;
end;

procedure JvConsoleWrite( var Value :Variant; Args :TJvInterpreterArgs );
begin
    Console.Write(Args.Values[0]);
    Console.Console.TopLine := Console.Console.Lines.Count;
    Application.ProcessMessages;
end;
procedure JvConsoleClear( var Value :Variant; Args :TJvInterpreterArgs );
begin
    Console.Clear;
end;
procedure JvWait( var Value :Variant; Args :TJvInterpreterArgs );
begin
	DelayTicks(Args.Values[0],True);
end;
procedure JvNewInterfaz( var Value :Variant; Args :TJvInterpreterArgs );
begin
	Value := NewInterfaz(Args.Values[0]);
end;
procedure JvCloseInterfaz( var Value :Variant; Args :TJvInterpreterArgs );
begin
	CloseInterfaz;
end;
procedure JvTalkInterfaz( var Value :Variant; Args :TJvInterpreterArgs );
begin
	TalkInterfaz(Args.Values[0]);
end;
procedure JvTalkMotor( var Value :Variant; Args :TJvInterpreterArgs );
begin
	TalkMotor(Args.Values[0]);
end;
procedure JvMotorOn( var Value :Variant; Args :TJvInterpreterArgs );
begin
	MotorOn;
end;
procedure JvMotorOff( var Value :Variant; Args :TJvInterpreterArgs );
begin
	MotorCoast;
end;
procedure JvMotorInv( var Value :Variant; Args :TJvInterpreterArgs );
begin
	MotorInverse;
end;
procedure JvMotorDirA( var Value :Variant; Args :TJvInterpreterArgs );
begin
	MotorThisWay;
end;
procedure JvMotorDirB( var Value :Variant; Args :TJvInterpreterArgs );
begin
	MotorThatWay;
end;
procedure JvMotorBrake( var Value :Variant; Args :TJvInterpreterArgs );
begin
	MotorOff;
end;
procedure JvMotorPower( var Value :Variant; Args :TJvInterpreterArgs );
begin
	MotorPower(Args.Values[0]);
end;
procedure JvAllMotorsOff( var Value :Variant; Args :TJvInterpreterArgs );
begin
	AllMotorsOff;
end;
procedure JvTalkPAP( var Value :Variant; Args :TJvInterpreterArgs );
begin
	TalkPAP(Args.Values[0]);
end;
procedure JvSetSpeed( var Value :Variant; Args :TJvInterpreterArgs );
begin
	PAPSpeed(Args.Values[0]);
end;
procedure JvSetSteps( var Value :Variant; Args :TJvInterpreterArgs );
begin
	PAPSteps(Args.Values[0]);
end;
procedure JvServoPos( var Value :Variant; Args :TJvInterpreterArgs );
begin
	ServoPos(Args.Values[0]);
end;
procedure JvSensor( var Value :Variant; Args :TJvInterpreterArgs );
begin
	TalkSensor(Args.Values[0]);
end;
procedure JvGetSensor( var Value :Variant; Args :TJvInterpreterArgs );
begin
	Value := GetSensor;
end;
procedure JvBurst( var Value :Variant; Args :TJvInterpreterArgs );
begin
    if Bool(Args.Values[1]) then
		SensorBurst(Args.Values[0],1)
    else
		SensorBurst(Args.Values[0],0);
end;
procedure JvGetBurstValue( var Value :Variant; Args :TJvInterpreterArgs );
begin
	Value := GetBurstValue;
end;
procedure JvGetBurstTick( var Value :Variant; Args :TJvInterpreterArgs );
begin
	Value := GetBurstTick;
end;
procedure JvGetLastBurstValue( var Value :Variant; Args :TJvInterpreterArgs );
begin
	Value := GetLastBurstValue;
end;
procedure JvStopBurst( var Value :Variant; Args :TJvInterpreterArgs );
begin
	StopBurst;
end;
procedure JvBurstCount( var Value :Variant; Args :TJvInterpreterArgs );
begin
	Value := BurstCount;
end;
procedure JvNextBurst( var Value :Variant; Args :TJvInterpreterArgs );
begin
	Value := NextBurst;
end;
procedure JvClearBurst( var Value :Variant; Args :TJvInterpreterArgs );
begin
	ClearBurst;
end;

procedure AddImage(AClass: TComponentClass; X,Y: integer; ImageList: TImageList);
var
   I: Timage;
begin
	I:= TImage.Create(nil);
    RegisterClass(AClass);
    with I.Picture do
    begin
	    Bitmap.LoadFromResourceName(Hinstance,AClass.ClassName);
    	Bitmap.SetSize(X,Y);
    	ImageList.AddMasked(Bitmap,clOlive) ;
    end;
end;

function GetImage(AClass: TComponentClass; X,Y: integer): TBitmap;
var
   I: Timage;
begin
	I:= TImage.Create(nil);
    RegisterClass(AClass);
    with I.Picture do
    begin
	    Bitmap.LoadFromResourceName(Hinstance,AClass.ClassName);
    	Bitmap.SetSize(X,Y);
	    Result := Bitmap;
    end;
end;


procedure TDevelopForm.FormCreate(Sender: TObject);
var
	i: integer;
begin
	CP.ShowHint := True;
	CP.ButtonCount := MAXCLASSES + 1;
    for i := 0 to MAXCLASSES do
    with CP.Buttons[i] do
    begin
        Glyph := GetImage(cClasses[i],24,24);
        Hint := cClasses[i].ClassName;
        ShowHint := True;
    end;
    Application.CreateForm(TfrmToolForm, frmToolForm);
   // EmbedTop.DockLinkedForm;
    Application.CreateForm(TfrmObjectInspector, frmObjectInspector);
    EmbedLeft.DockLinkedForm;
    Application.CreateForm(TWindow, Window);
    EmbedPanel.UseDockManager := True;
    Window.ManualDock(EmbedPanel);
    Application.CreateForm(TfrmSetup, frmSetup);
    Window.cmpFormDesigner.Active := True;
    Console:= TConsole.Create;
    Console.Console := Consola;

 with GlobalJvInterpreterAdapter  do
 begin
	AddFunction('Consola','Print',JvConsoleWrite,1,[varString],varEmpty);
	AddFunction('Consola','Clear',JvConsoleClear,0,[],varEmpty);
	AddFunction('Interfaz','Wait',JvWait,1,[varInteger],varEmpty);
	AddFunction('Interfaz','newInterfaz',JvNewInterfaz,1,[varByte],varWord);
	AddFunction('Interfaz','closeInterfaz',JvCloseInterfaz,0,[],varEmpty);
	AddFunction('Interfaz','Interfaz',JvTalkInterfaz,1,[varByte],varEmpty);
	AddFunction('Interfaz','Outputs',JvTalkMotor,1,[varByte],varEmpty);
 	AddFunction('Interfaz','setOn',JvMotorOn,0,[],varEmpty);
	AddFunction('Interfaz','setOff',JvMotorOff,0,[],varEmpty);
	AddFunction('Interfaz','setInv',JvMotorInv,0,[],varEmpty);
	AddFunction('Interfaz','setDirA',JvMotorDirA,0,[],varEmpty);
	AddFunction('Interfaz','setDirB',JvMotorDirA,0,[],varEmpty);
	AddFunction('Interfaz','setBrake',JvMotorBrake,0,[],varEmpty);
	AddFunction('Interfaz','setPower',JvMotorPower,1,[varByte],varEmpty);
	AddFunction('Interfaz','setAllOff',JvAllMotorsOff,0,[],varEmpty);
	AddFunction('Interfaz','Steppers',JvTalkPAP,1,[varByte],varEmpty);
	AddFunction('Interfaz','setSpeed',JvSetSpeed,1,[varByte],varEmpty);
	AddFunction('Interfaz','setSteps',JvSetSteps,1,[varByte],varEmpty);
	AddFunction('Interfaz','ServoPos',JvServoPos,1,[varByte],varEmpty);
	AddFunction('Interfaz','Sensor',JvSensor,1,[varByte],varEmpty);
	AddFunction('Interfaz','getSensor',JvGetSensor,0,[],varWord);
	AddFunction('Interfaz','Burst',JvBurst,2,[varByte,varBoolean],varEmpty);
	AddFunction('Interfaz','StopBurst',JvStopBurst,0,[],varEmpty);
	AddFunction('Interfaz','getBurstValue',JvGetBurstValue,0,[],varWord);
	AddFunction('Interfaz','getBurstTick',JvGetBurstTick,0,[],varWord);
	AddFunction('Interfaz','getLastBurstValue',JvGetLastBurstValue,0,[],varWord);
	AddFunction('Interfaz','BurstCount',JvBurstCount,0,[],varWord);
	AddFunction('Interfaz','nextBurst',JvNextBurst,0,[],varWord);
	AddFunction('Interfaz','clearBurst',JvClearBurst,0,[],varEmpty);

 end;
end;

procedure TDevelopForm.FormSaveAccept(Sender: TObject);
begin
    With FormSave.Dialog do
     Window.cmpFormDesigner.SaveToDFM(FileName,TDFMFormat(Pred(FilterIndex)));
end;

procedure TDevelopForm.JvPascalGetUnitSource(UnitName: string;
  var Source: string; var Done: Boolean);
begin
	if UnitName = 'form' then
    begin
         Source := 'Unit test;procedure CloseButtonClick(Sender: TObject);begin 	Ad; end; procedure Main; begin  Button1.OnClick := CloseButtonClick; end; end.';
         Done := True;
    end;
end;

procedure TDevelopForm.JvPascalGetValue(Sender: TObject; Identifier: string;
  var Value: Variant; Args: TJvInterpreterArgs; var Done: Boolean);
var
  I: Integer;
begin
  if AnsiSameText(Identifier, 'Self') then
  begin
    Value := O2V(Window);
    Done := True;
    Exit;
  end;

  for I := 0 to Window.ComponentCount - 1 do
  begin
    if AnsiSameText(Identifier, Window.Components[I].Name) then
    begin
      Value := O2V(Window.Components[I]);
      Done := True;
      Exit;
    end;
  end;
end;

procedure TDevelopForm.OpcionesEditorExecute(Sender: TObject);
var
	Opts: TSynEditorOptionsContainer;
begin
	Opts:= TSynEditorOptionsContainer.Create(Editor);
    Opts.Assign(Editor);
	if EditorOptions.Execute(Opts) then
    	Opts.AssignTo(Editor);
end;

procedure TDevelopForm.PausarExecute(Sender: TObject);
begin
{
	if PaxProgram.IsPaused then
    begin
    	PaxProgram.Resume;
        Pausar.ImageIndex := 108;
    end else
    begin
    	PaxProgram.Pause;
        Editor.CaretY := PaxDebug.SourceLineNumber + 1;
        Pausar.ImageIndex := 109;
    end;
}
end;

procedure TDevelopForm.PaxScripterAssignScript(Sender: TPaxScripter);
begin
//  PaxScripter.AddModule('Main', 'paxPascal');
//  PaxScripter.AddCode('Main', Editor.Text);
end;

procedure TDevelopForm.PaxScripterRunning(Sender: TPaxScripter; N: Integer;
  var Handled: Boolean);
begin
	Application.ProcessMessages;
end;

procedure TDevelopForm.PaxTimerTimer(Sender: TObject);
begin
{
    if (not PaxProgram.IsPaused) and (not PaxDebug.IsPaused) and (not PaxProgram.IsRunning) then
    begin
	    Ejecutar.Enabled := True;
    	Pausar.Enabled := False;
	    Detener.Enabled := False;
    	PaxTimer.Enabled := False;
    end;
}
end;

procedure TDevelopForm.SaveExecute(Sender: TObject);
begin
    if FileName = '' then
    begin
        if FileSaveAs.Dialog.Execute then
        begin
            FileName := FileSaveAs.Dialog.FileName;
            Editor.Lines.SaveToFile(FileName);
            Editor.Modified := False;
        end
    end	else
    begin
	    Editor.Lines.SaveToFile(FileName);
        Editor.Modified := False;
    end;

end;

procedure TDevelopForm.sbtAlignClick(Sender: TObject);
begin
  Window.cmpFormDesigner.AlignDialog;
end;

procedure TDevelopForm.sbtSetupClick(Sender: TObject);
begin
 frmSetup.ShowModal;
end;

procedure TDevelopForm.eveLock(Sender: TObject);
var
  i,IDX: Integer;
begin
  if Sender<>sbtLock then sbtLock.Down:=not sbtLock.Down;
  {$IFDEF TFD1COMPATIBLE}
  with Window.cmpFormDesigner,FixedControls do
  {$ELSE}
  with Window.cmpFormDesigner,LockedControls do
  {$ENDIF}
    for i:=0 to Pred(ControlCount) do
    begin
      IDX:=IndexOf(Controls[i].Name);
      if sbtLock.Down then
      begin
        if IDX=-1 then Add(Controls[i].Name);
      end
      else
        if IDX<>-1 then Delete(IDX);
    end;
end;

procedure TDevelopForm.eveAlign(Sender: TObject);
var
  i: Integer;
begin
  with Window.cmpFormDesigner do
    for i:=0 to Pred(ControlCount) do
      if not IsLocked(Controls[i]) then
        AlignToGrid(Controls[i]);
end;

procedure TDevelopForm.eveDelete(Sender: TObject);
begin
  if sbtDelete.Enabled then
    with Window.cmpFormDesigner do
      while ControlCount>0 do Controls[0].Free;
  with frmObjectInspector,cmbObjectInspector do
  begin
    Root:=Window;
    Instance:=Window;
    cmpObjectInspector.Instance:=Window;
  end;
end;

procedure TDevelopForm.eveCut(Sender: TObject);
begin
  if sbtCut.Enabled then
    Window.cmpFormDesigner.CutToClipboard;
end;

procedure TDevelopForm.evePaste(Sender: TObject);
begin
  if sbtPaste.Enabled then
    Window.cmpFormDesigner.PasteFromClipboard;
end;

procedure TDevelopForm.eveCopy(Sender: TObject);
begin
  if sbtCopy.Enabled then
    Window.cmpFormDesigner.CopyToClipboard;
end;

procedure TDevelopForm.eveSelectAll(Sender: TObject);
begin
  Window.cmpFormDesigner.SelectAll;
end;

procedure TDevelopForm.eveAlignPalette(Sender: TObject);
begin
  Window.cmpFormDesigner.ShowAlignmentPalette;
end;

procedure TDevelopForm.eveTabOrder(Sender: TObject);
begin
  Window.cmpFormDesigner.TabOrderDialog;
end;


end.

{  // CREAR UNA UNIDAD PARA UN FORM
   L := TStringList.Create;
  try
    with PaxDfm.UsedUnits do
    begin
      Add('Controls');
      Add('StdCtrls');
      Add('Graphics');
      Add('Forms');
      Add('Dialogs');  hace falta ??
    end;

    PaxDfm.Parse('test.dfm', L);
//    PaxScripter.AddModule('1', 'paxPascal');
//    PaxScripter.AddCode('Main', L.Text);
  Editor.Text := L.Text;
  finally
    L.Free;
  end;
}
{
//  PaxScripter.RegisterObject('Form',frmDesign);
  RegisterClassType(TConsole, -1);
  RegisterMethod(TConsole,'procedure Write(s: Variant);',@TConsole.Write);
  RegisterMethod(TConsole,'procedure Clear;',@TConsole.Clear);
  PaxScripter.RegisterObject('Console', Console);
//  RegisterRoutine('procedure PrintC(s: string);',@PrintC);
  RegisterRoutine('function IntToStr(X: cardinal): String;', @IntToStr);
  RegisterRoutine('procedure Wait(ticks: integer);', @Wait);
  RegisterRoutine('procedure Wait(ticks: integer);', @Wait);
  RegisterRoutine('function NewInterfaz(port: integer):word;', @INewInterfaz);
  RegisterRoutine('procedure CloseInterfaz;', @CloseInterfaz);
  RegisterRoutine('procedure Interfaz(num: integer);', @ITalkInterfaz);
  RegisterRoutine('procedure Outputs(Motors: Byte);', @ITalkMotor);
  RegisterRoutine('procedure setOn;', @MotorOn);
  RegisterRoutine('procedure setOff;', @MotorOff);
  RegisterRoutine('procedure setInv;', @MotorInverse);
  RegisterRoutine('procedure setDirA;', @MotorThisWay);
  RegisterRoutine('procedure setDirB;', @MotorThatway);
  RegisterRoutine('procedure setCoast;', @MotorCoast);
  RegisterRoutine('procedure setPower(power: Byte);', @IMotorPower);
  RegisterRoutine('procedure Steppers(PAP: Byte);', @ITalkPAP);
  RegisterRoutine('procedure setSpeed(Speed: Byte);', @IPAPSpeed);
  RegisterRoutine('procedure setSteps(Steps: Byte);', @IPAPSteps);
  RegisterRoutine('procedure ServoPos(Pos: Byte);', @IServoPos);
  RegisterRoutine('procedure Sensor(Sensor: Byte);', @ITalkSensor);
  RegisterRoutine('function GetSensor: Word;', @GetSensor);
  RegisterRoutine('procedure Burst(Sensors: Byte; Slow: Byte);', @ISensorBurst);
  RegisterRoutine('procedure StopBurst;', @StopBurst);
  RegisterRoutine('function GetBurstValue: Word;', @GetBurstValue);
  RegisterRoutine('function GetBurstTick: Word;', @GetBurstTick);
  RegisterRoutine('function GetLastBurstValue: Word;', @GetLastBurstValue);
  RegisterRoutine('function BurstCount: Word;', @BurstCount);
  RegisterRoutine('function NextBurst: Word;', @NextBurst);
  RegisterRoutine('procedure ClearBurst;', @ClearBurst);
 }
