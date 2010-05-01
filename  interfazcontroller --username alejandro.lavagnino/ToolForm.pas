(*  GREATIS RUNTIME FUSION COMPLETE DEMO      *)
(*  Copyright (C) 2003-2004 Greatis Software  *)
(*  http://www.greatis.com/delphicb/runtime/  *)
(*  http://www.greatis.com/bteam.html         *)

unit ToolForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, Clipbrd, Menus, FDMain, FDCmpPal,
  Mask, Scripter, JvComponentBase, JvEmbeddedForms;

type
  TfrmToolForm = class(TForm)
    pgcMain: TPageControl;
    opdMain: TOpenDialog;
    svdMain: TSaveDialog;
    pmnMain: TPopupMenu;
    mniLock: TMenuItem;
    mniAlignToGrid: TMenuItem;
    mniCut: TMenuItem;
    mniCopy: TMenuItem;
    mniPaste: TMenuItem;
    mniDelete: TMenuItem;
    mniSep1: TMenuItem;
    mniBringToFront: TMenuItem;
    mniSendToBack: TMenuItem;
    mniSep2: TMenuItem;
    mniSelectAll: TMenuItem;
    Panel1: TPanel;
    sbtOpen: TSpeedButton;
    sbtSave: TSpeedButton;
    sbtAlignToGrid: TSpeedButton;
    sbtLock: TSpeedButton;
    sbtCut: TSpeedButton;
    sbtCopy: TSpeedButton;
    sbtPaste: TSpeedButton;
    sbtDelete: TSpeedButton;
    sbtSetup: TSpeedButton;
    sbtAlign: TSpeedButton;
    sbtSize: TSpeedButton;
    sbtAlignPalette: TSpeedButton;
    sbtTabOrder: TSpeedButton;
    sbtSelectAll: TSpeedButton;
    sbtSource: TSpeedButton;
    sbtRun: TSpeedButton;
    ToolEmbed: TJvEmbeddedFormLink;
    procedure sbtPaletteButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure eveLock(Sender: TObject);
    procedure eveAlign(Sender: TObject);
    procedure eveDelete(Sender: TObject);
    procedure eveCut(Sender: TObject);
    procedure evePaste(Sender: TObject);
    procedure eveCopy(Sender: TObject);
    procedure sbtOpenClick(Sender: TObject);
    procedure sbtSaveClick(Sender: TObject);
    procedure pmnMainPopup(Sender: TObject);
    procedure sbtSetupClick(Sender: TObject);
    procedure sbtAboutClick(Sender: TObject);
    procedure mniBringToFrontClick(Sender: TObject);
    procedure mniSendToBackClick(Sender: TObject);
    procedure sbtAlignClick(Sender: TObject);
    procedure sbtSizeClick(Sender: TObject);
    procedure eveSelectAll(Sender: TObject);
    procedure eveAlignPalette(Sender: TObject);
    procedure eveTabOrder(Sender: TObject);
    procedure sbtObjectInspectorClick(Sender: TObject);
    procedure sbtSourceClick(Sender: TObject);
    procedure sbtRunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    ComponentClass: TComponentClass;
  end;

var
  frmToolForm: TfrmToolForm;

implementation

uses Design, Setup, About, OIForm;

{$R *.DFM}

procedure TfrmToolForm.sbtPaletteButtonClick(Sender: TObject);
begin
  ComponentClass:=(Sender as TPaletteButton).ComponentClass;
  with DesignWindow.cmpFormDesigner do
    if Assigned(ComponentClass) then
    begin
      if not Locked then Lock;
    end
    else Unlock;
end;

procedure TfrmToolForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caNone;
end;

procedure TfrmToolForm.FormCreate(Sender: TObject);
begin
//  CreatePalettePage(pgcMain,'Standard',[TLabel,TEdit,TMemo,TButton,TCheckBox,TRadioButton,TListBox,TComboBox,TGroupBox,TPanel,TMemo],sbtPaletteButtonClick);
//  CreatePalettePage(pgcMain,'Additional',[TBitBtn,TSpeedButton,TMaskEdit,TImage,TShape,TBevel,TStaticText],sbtPaletteButtonClick);
//  CreatePalettePage(pgcMain,'Dialogs',[TOpenDialog,TSaveDialog,TFontDialog,TColorDialog],sbtPaletteButtonClick);

end;

procedure TfrmToolForm.FormShow(Sender: TObject);
begin
//  Window.Show;
//  RegisterClasses([TScripter,TVBLang]);
end;

procedure TfrmToolForm.eveLock(Sender: TObject);
var
  i,IDX: Integer;
begin
  if Sender<>sbtLock then sbtLock.Down:=not sbtLock.Down;
  {$IFDEF TFD1COMPATIBLE}
  with DesignWindow.cmpFormDesigner,FixedControls do
  {$ELSE}
  with DesignWindow.cmpFormDesigner,LockedControls do
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

procedure TfrmToolForm.pmnMainPopup(Sender: TObject);
begin
  mniLock.Checked:=sbtLock.Down;
end;

procedure TfrmToolForm.eveAlign(Sender: TObject);
var
  i: Integer;
begin
  with DesignWindow.cmpFormDesigner do
    for i:=0 to Pred(ControlCount) do
      if not IsLocked(Controls[i]) then
        AlignToGrid(Controls[i]);
end;

procedure TfrmToolForm.eveDelete(Sender: TObject);
begin
  if sbtDelete.Enabled then
    with DesignWindow.cmpFormDesigner do
      while ControlCount>0 do Controls[0].Free;
  with frmObjectInspector,cmbObjectInspector do
  begin
    Root:=DesignWindow;
    Instance:=DesignWindow;
    cmpObjectInspector.Instance:=DesignWindow;
  end;
end;

procedure TfrmToolForm.eveCut(Sender: TObject);
begin
  if sbtCut.Enabled then
    DesignWindow.cmpFormDesigner.CutToClipboard;
end;

procedure TfrmToolForm.evePaste(Sender: TObject);
begin
  if sbtPaste.Enabled then
    DesignWindow.cmpFormDesigner.PasteFromClipboard;
end;

procedure TfrmToolForm.eveCopy(Sender: TObject);
begin
  if sbtCopy.Enabled then
    DesignWindow.cmpFormDesigner.CopyToClipboard;
end;

procedure TfrmToolForm.sbtOpenClick(Sender: TObject);
begin
  with opdMain do
    if Execute then
      DesignWindow.cmpFormDesigner.LoadFromDFM(FileName,TDFMFormat(Pred(FilterIndex)));
end;

procedure TfrmToolForm.sbtSaveClick(Sender: TObject);
begin
  with svdMain do
    if Execute then
      DesignWindow.cmpFormDesigner.SaveToDFM(FileName,TDFMFormat(Pred(FilterIndex)));
end;

procedure TfrmToolForm.sbtSetupClick(Sender: TObject);
begin
  frmSetup.ShowModal;
end;

procedure TfrmToolForm.sbtAboutClick(Sender: TObject);
begin
//  frmAbout.ShowModal;
end;

procedure TfrmToolForm.mniBringToFrontClick(Sender: TObject);
var
  i: Integer;
begin
  with DesignWindow.cmpFormDesigner do
  begin
    for i:=Pred(ControlCount) downto 0 do Controls[i].BringToFront;
    Update;
  end;
end;

procedure TfrmToolForm.mniSendToBackClick(Sender: TObject);
var
  i: Integer;
begin
  with DesignWindow.cmpFormDesigner do
  begin
    for i:=Pred(ControlCount) downto 0 do Controls[i].SendToBack;
    Update;
  end;
end;

procedure TfrmToolForm.sbtAlignClick(Sender: TObject);
begin
  DesignWindow.cmpFormDesigner.AlignDialog;
end;

procedure TfrmToolForm.sbtSizeClick(Sender: TObject);
begin
  DesignWindow.cmpFormDesigner.SizeDialog;
end;

procedure TfrmToolForm.eveSelectAll(Sender: TObject);
begin
  DesignWindow.cmpFormDesigner.SelectAll;
end;

procedure TfrmToolForm.eveAlignPalette(Sender: TObject);
begin
  DesignWindow.cmpFormDesigner.ShowAlignmentPalette;
end;

procedure TfrmToolForm.eveTabOrder(Sender: TObject);
begin
  DesignWindow.cmpFormDesigner.TabOrderDialog;
end;

procedure TfrmToolForm.sbtObjectInspectorClick(Sender: TObject);
begin
  frmObjectInspector.Show;
end;

procedure TfrmToolForm.sbtSourceClick(Sender: TObject);
var
  NewSource: string;
begin
//  with Window.Scripter do
//  begin
//    NewSource:=Source;
//    if EditSource(NewSource,'') then Source:=NewSource;
//  end;
end;

procedure TfrmToolForm.sbtRunClick(Sender: TObject);
begin
  DesignWindow.cmpFormDesigner.Active:=not (Sender as TSpeedButton).Down;
end;

end.
