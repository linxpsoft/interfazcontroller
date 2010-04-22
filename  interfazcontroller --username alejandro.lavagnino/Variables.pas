unit Variables;

{
'================================================================================
' Class Name:
'      VariableList
'
' Instancing:
'      Private; Internal  (VB Setting: 1 - Private)
'
' Purpose:
'      This is a very simple class that stores a list of "variables". The GOLDParser
'      class uses a this class to store the parameter fields.
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
================================================================================
}

interface

uses
   Classes;

type
   PVariableType = ^TVariableType;
   TVariableType = record
      Name: string;
      Value: string;
   end;

   TVariableList = class
   private
      MemberList: TList;
      function GetCount: Integer;
      function GetValue(Name: string): string;
      procedure SetValue(Name: string; Value: string);
   public
      constructor Create;
      destructor Destroy; override;
      function Add(Name: string; Value: string): Boolean;
      function Name(Index: Integer): string;
      function VariableIndex(Name: string): Integer;
      procedure ClearValues();
      property Count: Integer read GetCount;
      property Value[Name: string]: string read GetValue write SetValue;
   end;

implementation

constructor TVariableList.Create;
begin
   inherited Create;

   MemberList := TList.Create;

end;

destructor TVariableList.Destroy;
var
   n: Integer;
begin

   for n := 0 to MemberList.Count - 1 do
   begin
      PVariableType(MemberList.Items[n])^.Name := '';
      PVariableType(MemberList.Items[n])^.Value := '';
      Dispose(MemberList.Items[n]);
   end;

   MemberList.Free;

   inherited Destroy;
end;

function TVariableList.Add(Name: string; Value: string): Boolean;
var
   n: Integer;
   Found: Boolean;
   NewVar: PVariableType;
begin

   n := 0;
   Found := False;

   while (n < MemberList.Count) and (not Found) do
   begin
      Found := PVariableType(MemberList.Items[n])^.Name = Name;
      Inc(n);
   end;

   if not Found then
   begin
      New(NewVar);
      NewVar^.Name := Name;
      NewVar^.Value := Value;
      MemberList.Add(NewVar);
   end;

   Add := not Found;

end;

procedure TVariableList.ClearValues();
var
   n: Integer;
begin

   for n := 0 to MemberList.Count - 1 do
      PVariableType(MemberList.Items[n])^.Value := '';
end;

function TVariableList.GetCount: Integer;
begin
   Result := MemberList.Count;
end;

function TVariableList.Name(Index: Integer): string;
begin

   if (Index >= 0) and (Index < MemberList.Count) then
      Result := PVariableType(MemberList.Items[Index])^.Name;
end;

function TVariableList.VariableIndex(Name: string): Integer;
var
   n: Integer;
begin

   Result := -1;
   for n := 0 to MemberList.Count - 1 do
   begin
      if PVariableType(MemberList.Items[n])^.Name = Name then
      begin
         Result := n;
         Break;
      end;
   end;

end;

function TVariableList.GetValue(Name: string): string;
var
   R: integer;
begin

   R := VariableIndex(Name);
   if R <> -1 then
      Result := PVariableType(MemberList.Items[R])^.Value;

end;

procedure TVariableList.SetValue(Name: string; Value: string);
begin

   PVariableType(MemberList.Items[VariableIndex(Name)])^.Value := Value;

end;

end.

