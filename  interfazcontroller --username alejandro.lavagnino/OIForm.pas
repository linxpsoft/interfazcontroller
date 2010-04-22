(*  GREATIS RUNTIME FUSION COMPLETE DEMO      *)
(*  Copyright (C) 2003-2004 Greatis Software  *)
(*  http://www.greatis.com/delphicb/runtime/  *)
(*  http://www.greatis.com/bteam.html         *)

unit OIForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CompInsp, InspCtrl, ComCtrls, TypInfo, Design, PropList,
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmObjectInspector: TfrmObjectInspector;

implementation

{$R *.DFM}

uses FDMain;


procedure TfrmObjectInspector.cmbObjectInspectorFilter(Sender: TObject;
  AComponent: TComponent; var EnableAdd: Boolean);
begin
   	EnableAdd := AComponent <> Window.cmpFormDesigner;
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
  Window.cmpFormDesigner.Control:=TControl(cmbObjectInspector.Instance);
end;

procedure TfrmObjectInspector.FormShow(Sender: TObject);
begin
//  cmpObjectInspector.DefaultInstance:=frmDesign;
end;

end.
