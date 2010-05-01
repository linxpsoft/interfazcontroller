(*  GREATIS RUNTIME FUSION COMPLETE DEMO      *)
(*  Copyright (C) 2003-2004 Greatis Software  *)
(*  http://www.greatis.com/delphicb/runtime/  *)
(*  http://www.greatis.com/bteam.html         *)

unit OIForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CompInsp, InspCtrl, ComCtrls, TypInfo, PropList,
  JvComponentBase, JvEmbeddedForms;

type
  TfrmObjectInspector = class(TForm)
    tbcObjectInspector: TTabControl;
    cmpObjectInspector: TComponentInspector;
    cmbObjectInspector: TComponentComboBox;
    OIEmbedForm: TJvEmbeddedFormLink;
    procedure FormResize(Sender: TObject);
    procedure tbcObjectInspectorChange(Sender: TObject);
    procedure cmbObjectInspectorChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmpObjectInspectorGetValuesList(Sender: TObject;
      TheIndex: Integer; const Strings: TStrings);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbObjectInspectorFilter(Sender: TObject; AComponent: TComponent;
      var EnableAdd: Boolean);
    procedure cmpObjectInspectorFilter(Sender: TObject; Prop: TProperty;
      var Result: Boolean);
    procedure cmpObjectInspectorValueDoubleClick(Sender: TObject;
      TheIndex: Integer; var EnableDefault: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmObjectInspector: TfrmObjectInspector;

implementation

{$R *.DFM}

uses FDMain, Design, EventsFrm, DevelopFrm, RegExpr;


procedure TfrmObjectInspector.cmbObjectInspectorFilter(Sender: TObject;
  AComponent: TComponent; var EnableAdd: Boolean);
begin
//   	EnableAdd := AComponent <> TDesignWindow.cmpFormDesigner;
	EnableAdd := AComponent.ClassName <> 'TFormDesigner';
end;

procedure TfrmObjectInspector.cmpObjectInspectorFilter(Sender: TObject;
  Prop: TProperty; var Result: Boolean);
begin
	Result := Prop.PropType.Kind <> tkClass;
    if cmpObjectInspector.Mode = imProperties then
    	Result := Result and (Prop.PropType.Kind <> tkMethod)
    else
    begin
    	Result := Result and (
        	(Prop.PropType =TypeInfo(TNotifyEvent)) or
            (Prop.PropType =TypeInfo(TMouseEvent)) or
            (Prop.PropType =TypeInfo(TKeyEvent)));
    	Result := Result and (Prop.PropType.Kind = tkMethod)
    end;
end;

procedure TfrmObjectInspector.cmpObjectInspectorGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
begin
  with cmpObjectInspector.Properties[TheIndex] do
    if (TypeKind=tkMethod) and (PropType=TypeInfo(TNotifyEvent)) then
      with Strings do
      begin
        Add('ShowYes');
        Add('ShowNo');
      end;

end;

procedure TfrmObjectInspector.cmpObjectInspectorValueDoubleClick(
  Sender: TObject; TheIndex: Integer; var EnableDefault: Boolean);
var
	Hash,Obj,Key: String;
	E: TEventHandler;
    i: integer;
    RegExp : TRegExpr;
begin
	Obj := DesignWindow.cmpFormDesigner.Control.Name;
    Hash := IntToStr(DesignWindow.cmpFormDesigner.Control.GetHashCode);
  	Key := cmpObjectInspector.Properties[TheIndex].Name;
  	EventsForm.Editor.Clear;
    with cmpObjectInspector.Properties[TheIndex] do
        if (TypeKind=tkMethod) then
            if (PropType=TypeInfo(TNotifyEvent)) then
                EventsForm.Editor.Lines.Add('procedure '+Obj+Key+'(Sender: TObject);')
            else if (PropType=TypeInfo(TMouseEvent)) then
            begin
                EventsForm.Editor.Lines.Add('procedure '+Obj+Key+'(Sender: TObject; Button: TMouseButton;');
                EventsForm.Editor.Lines.Add('		Shift: TShiftState; X, Y: Integer);');
            end;
    if EventsList.IndexOf(Hash+Key) >= 0 then
    begin
        EventsForm.Editor.Text := EventsForm.Editor.Text+(EventsList.Objects[EventsList.IndexOf(Hash+Key)] as TEventHandler).Source.Text;
    end else
    begin
        with EventsForm do
        begin
            Editor.Lines.Add('begin');
            Editor.Lines.Add('');
            Editor.Lines.Add('end;');
            Editor.CaretY :=  Editor.Lines.Count - 1;
            Editor.CaretX := 5;
        end;
    end;
   	EventsForm.ShowModal;
    if EventsForm.ModalResult = mrOK then
    begin
    	E := TEventHandler.Create;
        E.Source := TStringList.Create;
        E.Control := DesignWindow.cmpFormDesigner.Control;
        E.Event := Key;
        RegExp := TRegExpr.Create;
		RegExp.Expression := '^(var|begin)(.)*(end;)$';
   		RegExp.ModifierM := True;
   		RegExp.ModifierI := True;
        RegExp.ModifierS := True;
   		RegExp.InputString := EventsForm.Editor.Text;
	    if RegExp.Exec then
	        E.Source.Text := RegExp.Match[0];
       // E.Source.Text :=  EventsForm.Editor.Text;
        if EventsList.IndexOf(Hash+Key) >= 0 then
    		EventsList.Objects[EventsList.IndexOf(Hash+Key)] := E
        else EventsList.AddObject(Hash+Key,E);

    end;
end;

procedure TfrmObjectInspector.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	Action := caNone;
end;

procedure TfrmObjectInspector.FormResize(Sender: TObject);
begin
  cmbObjectInspector.Width:=ClientWidth;
  tbcObjectInspector.Height:=ClientHeight-cmbObjectInspector.Height-4;
end;

procedure TfrmObjectInspector.tbcObjectInspectorChange(Sender: TObject);
begin
  with cmpObjectInspector do
  begin
    Lock;
    try
      Mode:=TCompInspMode(tbcObjectInspector.TabIndex);
    finally
      Unlock;
    end;
  end;
end;

procedure TfrmObjectInspector.cmbObjectInspectorChange(Sender: TObject);
begin
  DesignWindow.cmpFormDesigner.Control:=TControl(cmbObjectInspector.Instance);
end;

procedure TfrmObjectInspector.FormShow(Sender: TObject);
begin
//  cmpObjectInspector.DefaultInstance:=frmDesign;
end;

end.
