unit test;
interface
uses
  Controls,
  StdCtrls,
  Graphics,
  Forms;
type
  Tfrm = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    constructor Create(AOwner: TComponent);
	procedure Button1Click(Sender: TObject);
  end;

var
  frm: Tfrm;
implementation

constructor Tfrm.Create(AOwner: TComponent);
begin
  inherited;
  Button1 := TButton.Create(Self);
  Button1.Name := 'Button1';
  Button1.Parent := Self;
  Button1.Caption := '';
  with Button1 do
  begin
    Left := 376;
    Top := 240;
    Width := 75;
    Height := 25;
    Caption := 'Button1';
	onClick := Button1Click;
    TabOrder := 8;
  end;
  CheckBox1 := TCheckBox.Create(Self);
  CheckBox1.Name := 'CheckBox1';
  CheckBox1.Parent := Self;
  CheckBox1.Caption := '';
  with CheckBox1 do
  begin
    Left := 584;
    Top := 120;
    Width := 97;
    Height := 17;
    Caption := 'CheckBox1';
    TabOrder := 9;
  end;
  Left := -1387;
  Top := 238;
  Caption := '[no selected components]';
  ClientHeight := 529;
  ClientWidth := 952;
  Color := clBtnFace;
  Font.Charset := DEFAULT_CHARSET;
  Font.Color := clWindowText;
  Font.Height := -11;
  Font.Name := 'Tahoma';
  Font.Style := [];
  OldCreateOrder := True;
  Position := poDesigned;
  ShowHint := True;
  Visible := True;
  PixelsPerInch := 96;
end;

procedure Tfrm.Button1Click(Sender: TObject);
begin
	Print('holas');
end;

end.

