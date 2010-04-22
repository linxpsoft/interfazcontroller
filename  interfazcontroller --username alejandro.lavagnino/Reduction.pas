unit Reduction;

{
'================================================================================
' Class Name:
'      Reduction
'
' Instancing:
'      Public; Creatable  (VB Setting: 5 - MultiUse)
'
' Purpose:
'      This class is used by the engine to hold a reduced rule. Rather the contain
'      a list of Symbols, a reduction contains a list of Tokens corresponding to the
'      the rule it represents. This class is important since it is used to store the
'      actual source program parsed by the Engine.
'
' Author(s):
'      Devin Cook
'      GOLDParser@DevinCook.com
'
' Dependacies:
'      Token Class, Rule Class
'
'================================================================================
 Conversion to Delphi:
      Beany
      Beany@cloud.demon.nl

 Conversion status: Done, not tested
}

interface

uses
   Classes, Rule, Token;

type

   TReduction = class
   private
      FTokens: TList;
      FTokenCount: Integer;
      FParentRule: TRule;
      FTag: Integer;
      procedure SetTokenCount(Value: Integer);
      procedure SetToken(Index: Integer; Value: TToken);
      function GetToken(Index: Integer): TToken;
   public
      constructor Create;
      destructor Destroy; override;
      property ParentRule: TRule read FParentRule write FParentRule;
      property TokenCount: Integer read FTokenCount write SetTokenCount;
      property Tag: Integer read FTag write FTag;
      property Tokens[Index: Integer]: TToken read GetToken write SetToken;
   end;

implementation

constructor TReduction.Create;
begin
   inherited Create;

   FTokens := TList.Create;
end;

destructor TReduction.Destroy;
var
   n: Integer;
begin

   for n := 0 to FTokens.Count - 1 do
   begin
      if FTokens.Items[n] <> nil then
      begin
         TReduction(TToken(FTokens.Items[n]).DataObj).Free;
         TToken(FTokens.Items[n]).DataObj := nil;
      end;
      if FTokens.Items[n] <> nil then
         TToken(FTokens.Items[n]).Free;
   end;

   FTokens.Free;

   inherited Destroy;
end;


procedure TReduction.SetTokenCount(Value: Integer);
var
   n: Integer;
begin

   if Value < 1 then
   begin
      for n := 0 to FTokens.Count - 1 do
         TToken(FTokens.Items[n]).Free;
      FTokens.Clear;
      FTokenCount := 0;
   end else
   begin
      FTokenCount := Value;
      for n := 0 to FTokenCount do
         FTokens.Add(nil);
   end;

end;

procedure TReduction.SetToken(Index: Integer; Value: TToken);
begin

   FTokens[Index] := Value;
end;

function TReduction.GetToken(Index: Integer): TToken;
begin

   Result := FTokens.items[Index];

end;

end.
