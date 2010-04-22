unit DockForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TFormsForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    procedure Panel3DockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure Panel2DockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure Panel1DockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure Panel2UnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure Panel1UnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure Panel3StartDock(Sender: TObject; var DragObject: TDragDockObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormsForm: TFormsForm;

implementation

{$R *.dfm}

uses OIForm, ToolForm, Design, Setup;

procedure TFormsForm.FormShow(Sender: TObject);
begin
    Application.CreateForm(TfrmToolForm, frmToolForm);
	frmToolForm.ManualDock(Panel1);
    Application.CreateForm(TfrmObjectInspector, frmObjectInspector);
    frmObjectInspector.ManualDock(Panel2);
    Application.CreateForm(TWindow, Window);
    Window.ManualDock(Panel3);
    Application.CreateForm(TfrmSetup, frmSetup);
    frmToolForm.Show;
    frmObjectInspector.Show;
    Window.Show;
    Window.cmpFormDesigner.Active := True;
end;

procedure TFormsForm.Panel1DockOver(Sender: TObject; Source: TDragDockObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
	Accept :=  Source.Control = frmToolForm;
end;

procedure TFormsForm.Panel1UnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
	Allow := False;
end;

procedure TFormsForm.Panel2DockOver(Sender: TObject; Source: TDragDockObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
	Accept :=  Source.Control = frmObjectInspector;
end;

procedure TFormsForm.Panel2UnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
	Allow := False;
end;

procedure TFormsForm.Panel3DockOver(Sender: TObject; Source: TDragDockObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
	Accept :=  Source.Control = Window;
end;

procedure TFormsForm.Panel3StartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin
	Window.cmpFormDesigner.Update;
end;

end.
