unit CommProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TCommProgFrm = class(TForm)
    CommProgress: TProgressBar;
    Label1: TLabel;
    CommLabel: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CommProgFrm: TCommProgFrm;

implementation

{$R *.dfm}

end.
