unit TokenStack;

{
'================================================================================
' Class Name:
'      TokenStack
'
' Instancing:
'      Private; Internal  (VB Setting: 1 - Private)
'
' Purpose:
'      This class is used by the GOLDParser class to store tokens during parsing.
'      In particular, this class is used the the LALR(1) state machine.
'
' Author(s):
'      Devin Cook
'      GOLDParser@DevinCook.com
'
' Dependacies:
'      Token Class
'
'================================================================================
 Conversion to Delphi:
      Beany
      Beany@cloud.demon.nl

 Conversion status: Done, not tested
}

interface

uses
   Classes, Token, Reduction;

type
   TTokenStack = class
   private
      MemberList: TList;
      function GetCount: Integer;
      procedure SetCount(Value: Integer);
      function GetMember(Index: Integer): TToken;
      procedure SetMember(Index: Integer; TheToken: TToken);
   public
      constructor Create;
      destructor Destroy; override;
      procedure Clear;
      procedure Push(TheToken: TToken);
      function Pop: TToken;
      function Top: TToken;
      property Count: Integer read GetCount write SetCount;
      property Member[Index: Integer]: TToken read GetMember write SetMember;
   end;

implementation

//In test condition:
//The number of TokenStack created = the number of TokenStack destroyed.
constructor TTokenStack.Create;
begin
   inherited Create;

   MemberList := TList.Create;
end;

destructor TTokenStack.Destroy;
begin
   Clear;
   MemberList.Free;

   inherited Destroy;
end;

function TTokenStack.GetCount: Integer;
begin
   Result := MemberList.Count;
end;

procedure TTokenStack.SetCount(Value: Integer);
begin
   //Not necassery in Delphi because of the TList
   //If 0 then clear the list
   if Value = 0 then
      Clear;
end;

procedure TTokenStack.Clear;
var
   a: Integer;
begin

   for a := 0 to MemberList.Count - 1 do
      TToken(MemberList.Items[a]).Free;

end;

function TTokenStack.GetMember(Index: Integer): TToken;
begin
   if (Index >= 0) and (Index < MemberList.Count) then
      Result := MemberList.items[Index]
   else
      Result := nil;
end;

procedure TTokenStack.SetMember(Index: Integer; TheToken: TToken);
begin

   if Index < MemberList.Count then
   begin
      MemberList.Items[Index] := TheToken //Possible memory leak, old item should be removed?
   end
   else
      MemberList.Add(TheToken);

end;

procedure TTokenStack.Push(TheToken: TToken);
begin

   MemberList.Add(TheToken);

end;

function TTokenStack.Pop: TToken;
begin

   if MemberList.Count > 0 then
   begin
      Result := MemberList.Items[MemberList.Count - 1];
      MemberList.Delete(MemberList.Count - 1);
   end else
      Result := nil;

end;

function TTokenStack.Top: TToken;
begin

   if MemberList.Count > 0 then
      Result := MemberList.Items[MemberList.Count - 1]
   else
      Result := nil;

end;


end.
