unit LRAction;

{
'================================================================================
' Class Name:
'      LRAction
'
' Instancing:
'      Private; Internal  (VB Setting: 1 - Private)
'
' Purpose:
'      This class represents an action in a LALR State. There is one and only one
'      action for any given symbol.
'
' Author(s):
'      Devin Cook
'      GOLDParser@DevinCook.com
'
' Dependacies:
'      (None)
'
'================================================================================
 Conversion to Delphi:
      Beany
      Beany@cloud.demon.nl

 Conversion status: Done, not tested
}

interface

uses
   Symbol, Dialogs, SysUtils;

type

   TActionConstants = (ActionShift = 1,       //Shift a symbol and goto a state
                       ActionReduce = 2,      //Reduce by a specified rule
                       ActionGoto = 3,        //Goto to a state on reduction
                       ActionAccept = 4,      //Input successfully parsed
                       ActionError = 5        //Programmars see this often!
                      );
   TLRAction = class
   private
      FSymbol: TSymbol;
      FAction: TActionConstants;
      FValue: Integer;
      function GetSymbol: TSymbol;
      procedure SetSymbol(Sym: TSymbol);
      function GetSymbolIndex: Integer;
   public
      constructor Create;
      destructor Destroy; override;
      property Value: Integer read FValue write FValue;
      property Action: TActionConstants read FAction write FAction;
      property Symbol: TSymbol read GetSymbol write SetSymbol;
      property SymbolIndex: Integer read GetSymbolIndex;
   end;

implementation

constructor TLRAction.Create;
begin
   inherited Create;

end;

destructor TLRAction.Destroy;
begin

   inherited Destroy;
end;

function TLRAction.GetSymbol: TSymbol;
begin
   Result := FSymbol;
end;

procedure TLRAction.SetSymbol(Sym: TSymbol);
begin
   FSymbol := Sym;
end;

function TLRAction.GetSymbolIndex: Integer;
begin

   Result := FSymbol.TableIndex;

end;

end.
