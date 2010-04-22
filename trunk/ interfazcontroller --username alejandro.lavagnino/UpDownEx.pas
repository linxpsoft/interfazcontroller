//*****************************************************************//
//                                                                 //
//  TUpDownEx                                                      //
//  Copyright© BrandsPatch LLC                                     //
//  http://www.explainth.at                                        //
//                                                                 //
//  UpDown control with edit box for direct number input           //
//  Install this component into your component palette             //
//  using Component -> Install Component                           //
//                                                                 //
//  All Rights Reserved                                            //
//                                                                 //
//  Permission is granted to use, modify and redistribute          //
//  the code in this Delphi unit on the condition that this        //
//  notice is retained unchanged.                                  //
//                                                                 //
//  BrandsPatch declines all responsibility for any losses,        //
//  direct or indirect, that may arise  as a result of using       //
//  this code.                                                     //
//                                                                 //
//*****************************************************************//
unit UpDownEx;

interface

uses Windows,SysUtils,Classes,StdCtrls,Controls,ComCtrls,ExtCtrls,Buttons,PanelEx;

type TUpDownTypes = (updtUp,updtDown);

type TAdjustCallBack = procedure(AAdjust:TUpDownTypes) of Object;
type TOnAdjust = procedure(Sender:TObject;Position:Integer) of Object;

type TArrowBox = class(TPanelEx)
private
  FACBK:TAdjustCallBack;
  FButtons:array[TUpDownTypes] of TSpeedButton;
public
  constructor CreateEx(AOwner:TComponent;AACBK:TAdjustCallBack);
  procedure ButtonMU(Sender:TObject;Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
  procedure ShareHeight;
end;

type TUpDownEx = class(TPanel)
private
  FArrows:TArrowBox;
  FEdit:TEdit;

  FIncrement:Word;
  FMax:Word;
  FMin:Word;
  FPos:Word;

  FOnAdjust:TOnAdjust;
  procedure SetIncrement(Value:Word);
  procedure SetMaximum(Value:Word);
  procedure SetMinimum(Value:Word);
  procedure SetPosition(Value:Word);
  procedure SetPositionEx(Value:Integer);

  procedure EditKU(Sender:TObject;var Key:Word;Shift:TShiftState);
  procedure PerformAdjust(AdjType:TUpDownTypes);
  procedure WhenReSized(Sender:TObject);
public
  constructor Create(AOwner:TComponent);override;
  property Adjuster:TArrowBox read FArrows;
  property Editor:TEdit read FEdit;
  property PositionEx:Integer write SetPositionEx;
published
  property OnAdjust:TOnAdjust read FOnAdjust write FOnAdjust;
  property Increment:Word read FIncrement write SetIncrement;
  property Maximum:Word read FMax write SetMaximum;
  property Minimum:Word read FMin write SetMinimum;
  property Position:Word read FPos write SetPosition;
end;

procedure Register;

implementation

uses Forms,Graphics;

procedure Register;
begin
  RegisterComponents('ExplainThat',[TUpDownEx]);
  {To use this component in your applications just install it from
   the Component/Install Component menu item.}
end;

constructor TArrowBox.CreateEx(AOwner:TComponent;AACBK:TAdjustCallBack);
var AWC:TWinControl absolute AOwner;

  function MakeArrow(AAlign:TAlign;ACaption:Char;ATag:Integer):TSpeedButton;
  begin
    Result:=TSpeedButton.Create(Self);
    InsertControl(Result);
    with Result do
    begin
      Font.Name:='Marlett';
      Font.Size:=6;
      Caption:=ACaption;
      Height:=AWC.ClientHeight shr 1;
      Align:=AAlign;
      Tag:=ATag;
      Flat:=True;
      OnMouseUp:=ButtonMU;
      {Note that for the up/down arrow buttons to appear correctly
       you must set the Font.CharSet property of the parent control
       to DEFAULT_CHARSET}
    end;
  end;

begin
  Create(AOwner);
  AWC.InsertControl(Self);
  BevelInner:=bvNone;
  BevelOuter:=bvNone;
  BorderStyle:=bsNone;
  Caption:='';
  FACBK:=AACBK;

  ParentFont:=False;
  Font.Name:='Marlett';
  Font.Size:=6;
  ClientWidth:=Canvas.TextWidth('W') + 2;
  ClientHeight:=(Canvas.TextHeight('5')) shl 1 + 2;
  DisableAlign;
  try
    FButtons[updtUp]:=MakeArrow(alTop,'5',ord(updtUp));
    FButtons[updtDown]:=MakeArrow(alClient,'6',ord(updtDown));
  finally EnableAlign end;
  {We create a panel and place two speed buttons in it. The Marlett font
   gives us the up and down arrows required. FACBK is a callback function
   used to trigger the OnAdjust event in the parent TUpDownEx control.

   Note how the clientheight and width of the panel are assigned. Also
   note the way Disable/EnableAlign methods are used to ensure correct
   drawing of the two button controls}
end;

procedure TArrowBox.ButtonMU(Sender:TObject;Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
begin
  if Assigned(FACBK) then FACBK(TUpDownTypes(TComponent(Sender).Tag));
  {Capture the MouseUp event on the button and trigger the callback function.
  This triggers the OnAdjust event handler in the parent application. Typically
  this would be used to respond to position changes.}
end;

procedure TArrowBox.ShareHeight;
var AHeight:Integer;
begin
  AHeight:=ClientHeight shr 1;
  DisableAlign;
  try
    FButtons[updtUp].Align:=alNone;
    FButtons[updtDown].Align:=alNone;

    FButtons[updtUp].Height:=AHeight;
    FButtons[updtDown].Height:=ClientHeight - AHeight;
    FButtons[updtDown].Top:=AHeight;
  finally EnableAlign end;
  {When the form is resized, screen resolution changes etc we must
   ensure that the up/down arrow buttons share the available client
   height equally.}
end;

constructor TUpDownEx.Create(AOwner:TComponent);
var AWC:TWinControl absolute AOwner;
begin
  inherited;
  AWC.InsertControl(Self);
  Caption:='';
  BevelInner:=bvNone;
  BevelOuter:=bvNone;
  BorderStyle:=bsSingle;

  DisableAlign;
  try
    FEdit:=TEdit.Create(Self);
    InsertControl(FEdit);
    with FEdit do
    begin
      AutoSelect:=False;//don't want text to be highlighted
      FEdit.BevelKind:=bkNone;
      BorderStyle:=bsSingle;
      MaxLength:=3;
      OnKeyUp:=EditKU;
      Self.ClientHeight:=FEdit.Height;
      Align:=alClient;
      Width:=Canvas.TextWidth('WWW');
    end;

    FArrows:=TArrowBox.CreateEx(Self,PerformAdjust);
    ClientWidth:=FEdit.Width + FArrows.Width;
    FArrows.Align:=alRight;

  finally EnableAlign end;
  FIncrement:=1;FMax:=100;FMin:=0;
  Position:=0;
  OnReSize:=WhenReSized;
end;
//------------------------------------------------------------------------------
procedure TUpDownEx.SetIncrement(Value:Word);
begin
  if (Value > FMax - FMin) then Value:=Trunc((FMax - FMin)/10);
  //if increment is too big use ca 1/10th of max->min range
  FIncrement:=Value;
end;

procedure TUpDownEx.SetMaximum(Value:Word);
begin
  if (Value >= FMin) then FMax:=Value;
  PositionEx:=FMin;
  //set the position to a safe value - without triggering a callback
end;

procedure TUpDownEx.SetMinimum(Value:Word);
begin
  if (Value < FMax) then FMin:=Value;
  PositionEx:=FMin;
  //set position to a safe value - without triggering a callback
end;

procedure TUpDownEx.SetPosition(Value:Word);
begin
  if (FMin <= Value) and (FMax >= Value) then
  begin
    FPos:=Value;
    FEdit.Text:=IntToStr(Value);

    with FArrows do
    begin
      FButtons[updtUp].Enabled:=(FPos + FIncrement <= FMax);
      FButtons[updtDown].Enabled:=(FPos - FIncrement >= FMin);
    end;
    //enable/disable button state as appropriate

    FEdit.Text:=IntToStr(Value);
    if Assigned(FOnAdjust) and not(csDesigning in ComponentState) then FOnAdjust(Self,FPos);
  end;
end;

procedure TUpDownEx.SetPositionEx(Value:Integer);
var P:TOnAdjust;
begin
  P:=FOnAdjust;
  FOnAdjust:=nil;
  try Position:=Value finally FOnAdjust:=P end;
  //adjust position without triggering a callback event
end;

procedure TUpDownEx.EditKU(Sender:TObject;var Key:Word;Shift:TShiftState);
var i:Integer;
    AText:String;
begin
  AText:=FEdit.Text;

  if (Length(AText) = 0) then exit;
  i:=StrToIntDef(AText,FMin);
  if (i > FMax) then i:=FMax;
  Position:=i;
end;

procedure TUpDownEx.PerformAdjust(AdjType:TUpDownTypes);
begin
  case AdjType of
    updtUp:Position:=FPos + FIncrement;
    updtDown:Position:=FPos - FIncrement;
  end;
  //arrow buttons clicked so change position
  FEdit.SetFocus;
  //return focus to editbox ready for next edit
end;

procedure TUpDownEx.WhenReSized(Sender:TObject);
begin
  FArrows.ShareHeight;
  //on every resize event ensure buttons share avail height equally
end;

end.
