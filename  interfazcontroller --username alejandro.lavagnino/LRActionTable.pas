unit LRActionTable;

{
'================================================================================
' Class Name:
'      LRActionTable
'
' Instancing:
'      Private; Internal  (VB Setting: 1 - Private)
'
' Purpose:
'      This class contains the actions (reduce/shift) and goto information
'      for a STATE in a LR parser. Essentially, this is just a row of actions in
'      the LR state transition table. The only data structure is a list of
'      LR Actions.
'
' Author(s):
'      Devin Cook
'      GOLDParser@DevinCook.com
'
' Dependacies:
'      LRAction Class
'
'================================================================================
 Conversion to Delphi:
      Beany
      Beany@cloud.demon.nl

 Conversion status: Done, not tested
}

interface

uses
   Classes, Dialogs, SysUtils, LRAction, Symbol;

Type

   TLRActionTable = class
   private
      MemberList: TList;
      function GetCount: Integer;
      function GetItem(Index: Integer): TLRAction;
   public
      constructor Create;
      destructor Destroy; override;
      function ActionIndexForSymbol(SymbolIndex: Integer): Integer;
      procedure AddItem(TheSymbol: TSymbol; Action: TActionConstants; Value: Integer);
      property Count: Integer read GetCount;
      property Item[Index: Integer]: TLRAction read GetItem;
   end;

implementation

constructor TLRActionTable.Create;
begin
   inherited Create;

   MemberList := TList.Create;

end;

destructor TLRActionTable.Destroy;
var
   n: Integer;
begin

   for n := 0 to MemberList.Count - 1 do
      if MemberList.Items[n] <> nil then
         TLRAction(MemberList.Items[n]).Free;

   MemberList.Free;

   inherited Destroy;
end;

function TLRActionTable.ActionIndexForSymbol(SymbolIndex: Integer): Integer;
var
   n: Integer;
   Found: Boolean;
begin

   n := 0;
   Found := False;
   Result := -1;

   while (not Found) and (n < MemberList.Count) do
   begin
      if TLRAction(MemberList.Items[n]).Symbol.TableIndex = SymbolIndex then
      begin
         Result := n;
         Found := True;
      end;
      n := n + 1;
   end;


end;

procedure TLRActionTable.AddItem(TheSymbol: TSymbol; Action: TActionConstants; Value: Integer);
var
   TableEntry: TLRAction;
begin

   TableEntry := TLRAction.Create;
   TableEntry.Symbol := TheSymbol;

   TableEntry.Action := Action;
   TableEntry.Value := Value;

   MemberList.Add(TableEntry);
end;

function TLRActionTable.GetCount: Integer;
begin

   Result := MemberList.Count;

end;

function TLRActionTable.GetItem(Index: Integer): TLRAction;
begin

   Result := MemberList.Items[Index];
end;

end.
