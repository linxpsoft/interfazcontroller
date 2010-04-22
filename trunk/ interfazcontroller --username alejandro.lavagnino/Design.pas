(*  GREATIS RUNTIME FUSION COMPLETE DEMO      *)
(*  Copyright (C) 2003-2004 Greatis Software  *)
(*  http://www.greatis.com/delphicb/runtime/  *)
(*  http://www.greatis.com/bteam.html         *)

unit Design;

interface

uses
  Windows, Messages, Forms, SysUtils, IniFiles, Classes, Controls,
  StdCtrls, ExtCtrls, Dialogs, FDMain, CompInsp, Menus,
  ClassReg, CtrlDes, JvComponentBase, JvEmbeddedForms;

type

  TWindow = class(TForm)
    cmpFormDesigner: TFormDesigner;
    procedure FormShow(Sender: TObject);
    {$IFNDEF VER100}
    procedure cmpFormDesignerMessage(Sender: TObject; var Msg: tagMSG);
    {$ELSE}
    procedure cmpFormDesignerMessage(Sender: TObject; var Msg: TMSG);
    {$ENDIF}
    procedure cmpFormDesignerSelectControl(Sender: TObject;
      TheControl: TControl);
    procedure FormActivate(Sender: TObject);
    procedure cmpFormDesignerLoadControl(Sender: TObject;
      TheControl: TControl; IniFile: TIniFile);
    procedure cmpFormDesignerSaveControl(Sender: TObject;
      TheControl: TControl; IniFile: TIniFile);
    procedure FormCreate(Sender: TObject);
    procedure cmpFormDesignerControlDblClick(Sender: TObject;
      TheControl: TControl);
    procedure cmpFormDesignerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ShowYes(Sender: TObject);
    procedure ShowNo(Sender: TObject);
    procedure cmpFormDesignerChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure UpdateInfo;
  public
    { Public declarations }
    function AutoName(Component: TComponent): Boolean;
  end;

var
  Window: TWindow;

implementation

uses FDCmpPal, OIForm, DevelopFrm, ToolForm;
{$R *.DFM}

procedure TWindow.UpdateInfo;
begin
  if Assigned(cmpFormDesigner.Control) then
    if cmpFormDesigner.Component is TControl then
      with cmpFormDesigner.Control do
        Caption:=Format(
          'Name: %s; Class: %s; Left: %d; Top: %d; Width: %d; Height: %d',
          [Name,ClassName,Left,Top,Width,Height])
    else
      with cmpFormDesigner.Component do
        Caption:=Format('Name: %s; Class: %s',[Name,ClassName])
  else Caption:='[no selected controls]';
end;

function TWindow.AutoName(Component: TComponent): Boolean;
var
  i: Integer;
  CN: string;
begin
  Result:=False;
  if Assigned(Component) then
    with Component do
    begin
      if (Name='') or Assigned(Self.FindComponent(Name)) then
      begin
        CN:=Copy(ClassName,2,Pred(Length(ClassName)));
        for i:=1 to 32768 do
          if not Assigned(Self.FindComponent(CN+IntToStr(i))) then
          begin
            Name:=CN+IntToStr(i);
            Result:=True;
            Break;
          end;
      end;
    end;
end;

procedure TWindow.FormShow(Sender: TObject);
begin
  cmpFormDesigner.Active:=True;
  with frmObjectInspector do
  begin
    //cmbObjectInspector.Root:=Self;
    Show;
  end;
end;

procedure TWindow.cmpFormDesignerMessage(Sender: TObject; var Msg: TMSG);

var
  WinControl: TWinControl;
  NewComponent: TComponent;
  CC: TComponentContainer;
  P: TPoint;

  function GetPopupParent(W: HWND): HWND;
  begin
    Result:=W;
    while (Result<>0) and (Result<>Application.Handle) and (Result<>Handle) do
      Result:=GetParent(Result);
  end;

begin
  with Msg do
    case Message of
      WM_LBUTTONDBLCLK: Message:=0;
      WM_LBUTTONDOWN:
        if GetPopupParent(hwnd)=Handle then
        begin
          Message:=0;
          if hwnd=Handle then WinControl:=Self
          else
          begin
            WinControl:=cmpFormDesigner.FindWinControl(hwnd);
            while Assigned(WinControl) and
              not (csAcceptsControls in WinControl.ControlStyle) do
              WinControl:=WinControl.Parent;
          end;
          if Assigned(WinControl) and Assigned(DevelopForm.ComponentClass) then
          begin
            NewComponent:=TComponent(DevelopForm.ComponentClass.Create(Self));
            if Assigned(NewComponent) then
              if not AutoName(NewComponent) then NewComponent.Free
              else
              begin
                P:=Point(LoWord(lParam),HiWord(lParam));
                MapWindowPoints(hwnd,WinControl.Handle,P,1);
                if NewComponent is TControl then
                  with TControl(NewComponent) do
                  begin
                    Left:=P.X;
                    Top:=P.Y;
                    with cmpFormDesigner do
                      if SnapToGrid then AlignToGrid(TControl(NewComponent));
                    Parent:=WinControl;
                  end
                else
                  with cmpFormDesigner do
                  begin
                    CC:=FindComponentContainer(NewComponent);
                    if Assigned(CC) then
                    begin
                      with CC do
                      begin
                        Left:=P.X;
                        Top:=P.Y;
                      end;
                      if SnapToGrid then AlignToGrid(CC);
                    end;
                  end;
                cmpFormDesigner.Component:=NewComponent;
              end;
          end;
//          EditMode(frmToolForm.pgcMain);
          DevelopForm.CP.SelectedButton := -1;
          DevelopForm.ComponentClass := nil;
          cmpFormDesigner.Unlock;
        end;
    end;
end;

procedure TWindow.cmpFormDesignerSelectControl(Sender: TObject;
  TheControl: TControl);
var
  E: Boolean;
begin
  if Assigned(TheControl) then
    frmObjectInspector.cmpObjectInspector.Instance := TheControl;
    {$IFDEF TFD1COMPATIBLE}
//    frmToolForm.sbtLock.Down:=cmpFormDesigner.FixedControls.IndexOf(TheControl.Name)<>-1;
    {$ELSE}
   	if TheControl <> nil then
	    frmTooLForm.sbtLock.Down:=cmpFormDesigner.LockedControls.IndexOf(TheControl.Name)>= 0;
    {$ENDIF}
  UpdateInfo;
  E:=Assigned(cmpFormDesigner.Control);
  with frmToolForm do
  begin
    sbtLock.Enabled:=E;
    sbtAlignToGrid.Enabled:=E;
    sbtAlign.Enabled:=E;
    sbtSize.Enabled:=E;
    sbtDelete.Enabled:=E;
    mniLock.Enabled:=E;
    mniAlignToGrid.Enabled:=E;
    mniDelete.Enabled:=E;
    sbtCopy.Enabled:=E;
    sbtCut.Enabled:=E;
    mniCopy.Enabled:=E;
    mniCut.Enabled:=E;
  end;
end;

procedure TWindow.FormActivate(Sender: TObject);
begin
  ActiveControl:=nil;
  cmpFormDesigner.Update;
end;

procedure TWindow.cmpFormDesignerLoadControl(Sender: TObject;
  TheControl: TControl; IniFile: TIniFile);
begin
  if TheControl=Self then
    with IniFile do
    begin
      Left:=ReadInteger('@Form','Left',Left);
      Top:=ReadInteger('@Form','Top',Top);
      Width:=ReadInteger('@Form','Width',Width);
      Height:=ReadInteger('@Form','Height',Height);
    end;
end;

procedure TWindow.cmpFormDesignerSaveControl(Sender: TObject;
  TheControl: TControl; IniFile: TIniFile);
begin
  if TheControl=Self then
    with IniFile do
    begin
      WriteInteger('@Form','Left',Left);
      WriteInteger('@Form','Top',Top);
      WriteInteger('@Form','Width',Width);
      WriteInteger('@Form','Height',Height);
    end;
  with IniFile do
    if TheControl is TButton then
      with TButton(TheControl) do
      begin
        WriteString(Name,'OnClick',Self.MethodName(@OnClick));
      end;
end;

procedure TWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caNone;
end;

procedure TWindow.FormCreate(Sender: TObject);
begin
  cmpFormDesigner.PopupMenu:=frmToolForm.pmnMain;
end;

procedure TWindow.cmpFormDesignerControlDblClick(Sender: TObject;
  TheControl: TControl);
begin
  if Assigned(TheControl) then
  begin
    if TheControl is TComponentContainer then
      ShowMessage('Double-click on '+TComponentContainer(TheControl).Component.Name)
    else ShowMessage('Double-click on '+TheControl.Name);
    ActiveControl:=nil;
  end;
end;

procedure TWindow.cmpFormDesignerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  with frmToolForm do
    case Key of
      VK_INSERT:
        if Shift=[ssShift] then evePaste(nil)
        else
          if Shift=[ssCtrl] then eveCopy(nil);
      VK_DELETE:
        if Shift=[ssShift] then eveCut(nil)
        else
          if Shift=[] then eveDelete(nil);
    end;
end;

procedure TWindow.ShowYes(Sender: TObject);
begin
  ShowMessage('YES');
end;

procedure TWindow.ShowNo(Sender: TObject);
begin
  ShowMessage('NO');
end;

procedure TWindow.cmpFormDesignerChange(Sender: TObject);
begin
  UpdateInfo;
end;


end.
