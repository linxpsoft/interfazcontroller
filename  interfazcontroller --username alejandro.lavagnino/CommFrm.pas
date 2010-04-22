unit CommFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TCommForm = class(TForm)
    CommCombo: TComboBox;
    PortLabel: TLabel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CommForm: TCommForm;

implementation

{$R *.dfm}

end.
