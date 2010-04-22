unit DevelopFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Contnrs,
  Dialogs, PaxProgram, PaxCompiler, PaxRegister, PaxJavaScriptLanguage, SynEditHighlighter,
  SynHighlighterJScript, ComCtrls, SynEdit, PlatformDefaultStyleActnCtrls,
  ActnList, ActnMan, ToolWin, ActnCtrls, ActnMenus, SynHighlighterPas,
  SynHighlighterGeneral, SynHighlighterMulti, SynEditOptionsDialog, ExtActns,
  StdActns, PaxCompilerDebugger, ExtCtrls, SynMemo, StdCtrls;

type
  TDevelopForm = class(TForm)
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionManager: TActionManager;
    Editor: TSynEdit;
    StatusBar1: TStatusBar;
    Ejecutar: TAction;
    PaxPascal: TPaxPascalLanguage;
    SynPasSyn: TSynPasSyn;
    PaxJS: TPaxJavaScriptLanguage;
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
    PaxProgram: TPaxProgram;
    PaxDebug: TPaxCompilerDebugger;
    PaxTimer: TTimer;
    PaxCompiler: TPaxCompiler;
    Splitter1: TSplitter;
    Consola: TSynMemo;
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
  private
    FileName: TFileName;
    { Private declarations }
  public
    { Public declarations }
  end;

  TConsole = class(TObject)
      Console: TSynMemo;
      procedure Write(s: string);
  end;

  THandler = class(TObject)
      Handler: integer;
      Address: Pointer;
  end;

var
  DevelopForm: TDevelopForm;
  Console: TConsole;
  Handlers: TObjectList;

implementation

{$R *.dfm}

uses MainFrm, OoMisc, Design, IMPORT_Forms, IMPORT_Classes;

procedure Wait(ticks: Integer);
begin
  DelayTicks(ticks,True);
  //ShowMessage('wait');
end;

procedure TConsole.Write(s: string);
begin
    Console.Lines.Add(s);
//    ShowMessage('a');
end;

procedure RegHandler(H: integer; A: Pointer);
var
	Hd: THandler;
begin
  Hd := THandler.Create;
  Hd.Handler := H;
  Hd.Address := A;
  Handlers.Add(Hd);
end;

procedure TDevelopForm.EjecutarExecute(Sender: TObject);
var
  H, F, i: integer;
  HDev: integer;
  C : TComponent;
  P: Pointer;
//  PaxCompiler: TPaxCompiler;
 // PaxProgram: TPaxProgram;
begin
//  PaxCompiler := TPaxCompiler.Create(Self);
 // PaxProgram := TPaxProgram.Create(Self);

//  ShowMessage(IntToStr(frmDesign.ComponentCount));
//  ShowMessage(frmDesign.Components[0].ClassName);

  try
  PaxCompiler.Reset;
  PaxCompiler.RegisterLanguage(PaxPascal);

  F := PaxCompiler.RegisterClassType(0, TfrmDesign);
  PaxCompiler.RegisterObject(0, 'Form', F, @frmDesign);
{
  H := PaxCompiler.RegisterClassType(0, TButton);
  for I := 0 to frmDesign.ComponentCount - 1 do
  begin
      C := frmDesign.Components[i];
      if C.ClassName = 'TButton' then
      begin
		  PaxCompiler.RegisterObject(0, C.Name, H, C);
      end;
  end;
//  PaxCompiler.RegisterObject(0, 'Button1', H, Addr(frmDesign.Button1));
//  PaxCompiler.RegisterObject(0, 'Button2', H, @frmDesign.Button2);
 }

  HDev := PaxCompiler.RegisterClassType(0, TConsole);
  PaxCompiler.RegisterVariable(0,'Console', HDev,@Console);
  PaxCompiler.RegisterHeader(HDev,'procedure Write(s: string);',@TConsole.Write);

  H := PaxCompiler.RegisterRoutine(0, 'Wait', _typeVOID, _ccRegister);
  PaxCompiler.RegisterParameter(H, _typeINTEGER, 1);
  RegHandler(H, @Wait);
  H := PaxCompiler.RegisterRoutine(0, 'NewInterfaz', _typeWORD, _ccSTDCALL);
  PaxCompiler.RegisterParameter(H, _typeINTEGER, 1);
  RegHandler(H, @NewInterfaz);
  H := PaxCompiler.RegisterRoutine(0, 'TalkInterfaz', _typeVOID, _ccSTDCALL);
  PaxCompiler.RegisterParameter(H, _typeINTEGER, 1);
  RegHandler(H, @TalkInterfaz);
  H := PaxCompiler.RegisterRoutine(0, 'TalkMotor', _typeVOID, _ccSTDCALL);
  PaxCompiler.RegisterParameter(H, _typeINTEGER, 1);
  RegHandler(H, @TalkMotor);
  H := PaxCompiler.RegisterRoutine(0, 'MotorOn', _typeVOID, _ccSTDCALL);
  RegHandler(H, @MotorOn);
  H := PaxCompiler.RegisterRoutine(0, 'MotorOff', _typeVOID, _ccSTDCALL);
  RegHandler(H, @MotorOff);
  H := PaxCompiler.RegisterRoutine(0, 'MotorInverse', _typeVOID, _ccSTDCALL);
  RegHandler(H,@MotorInverse);

  PaxCompiler.AddModule('Main', PaxPascal.LanguageName);
  PaxCompiler.AddCode('Main', Editor.Text);
  PaxCompiler.DebugMode := true;
  PaxDebug.RegisterCompiler(PaxCompiler,PaxProgram);
  if PaxCompiler.Compile(PaxProgram) then
  begin
    for i := 0 to Handlers.Count - 1 do
        PaxProgram.SetAddress((Handlers[i] as THandler).Handler,(Handlers[i] as THandler).Address );
    Handlers.Clear;

    Ejecutar.Enabled := False;
    Pausar.Enabled := True;
    Detener.Enabled := True;
    PaxTimer.Enabled := true;
    PaxProgram.Run;
  end
  else
    for I:=0 to PaxCompiler.ErrorCount - 1 do
      ShowMessage(PaxCompiler.ErrorMessage[I]);
  finally
   	//PaxCompiler.Free;
   //	PaxProgram.Free;
  end;
end;


procedure TDevelopForm.DetenerExecute(Sender: TObject);
begin
    PaxProgram.Pause;
    PaxProgram.DiscardPause;
    Detener.Enabled := False;
    Pausar.Enabled := False;
    Ejecutar.Enabled := True;
    PaxTimer.Enabled := False;
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
    if PaxProgram.IsRunning then
    begin
        PaxProgram.Pause;
        PaxProgram.DiscardPause;
    end;
    if PaxProgram.IsPaused then
    	PaxProgram.DiscardPause;
	if Editor.Modified then
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

procedure TDevelopForm.FormCreate(Sender: TObject);
begin
    Console:= TConsole.Create;
    Console.Console := Consola;
    Handlers := TObjectList.Create;
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
end;

procedure TDevelopForm.PaxTimerTimer(Sender: TObject);
begin
    if (not PaxProgram.IsPaused) and (not PaxDebug.IsPaused) and (not PaxProgram.IsRunning) then
    begin
	    Ejecutar.Enabled := True;
    	Pausar.Enabled := False;
	    Detener.Enabled := False;
    	PaxTimer.Enabled := False;
    end;
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

end.
