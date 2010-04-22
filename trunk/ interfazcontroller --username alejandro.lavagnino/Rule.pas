unit Rule;

{
'================================================================================
' Class Name:
'      Rule
'
' Instancing:
'      Public; Non-creatable  (VB Setting: 2- PublicNotCreatable)
'
' Purpose:
'      The Rule class is used to represent the logical structures of the grammar.
'      Rules consist of a head containing a nonterminal followed by a series of
'      both nonterminals and terminals.
'
' Author(s):
'      Devin Cook
'      GOLDParser@DevinCook.com
'
' Dependacies:
'      Symbol Class, SymbolList Class
'
'================================================================================
 Conversion to Delphi:
      Beany
      Beany@cloud.demon.nl

 Conversion status: Done, not tested
}

interface

uses
   Classes, SysUtils, Symbol;

type

   TRule = class
   private
      FRuleNonterminal: TSymbol;
      FRuleSymbols: TList;
      FTableIndex: Integer;
      function GetSymbolCount: Integer;
      procedure SetNonterminal(NewNonterminal: TSymbol);
      function GetNonterminal: TSymbol;
      function GetSymbols(Index: Integer): TSymbol;
   public
      constructor Create;
      destructor Destroy; override;
      procedure AddItem(Item: TSymbol);
      function Name: string;
      function Definition: string;
      function ContainsOneNonTerminal: Boolean;
      function Text: String;
      property SymbolCount: Integer read GetSymbolCount;
      property RuleNonterminal: TSymbol read GetNonterminal write SetNonterminal;
      property TableIndex: Integer read FTableIndex write FTableIndex;
      property Symbols[Index: Integer]: TSymbol read GetSymbols;
   end;

implementation

constructor TRule.Create;
begin
   inherited Create;
   FRuleSymbols := TList.Create;

   FTableIndex := -1;

end;

destructor TRule.Destroy;
//var
//   n: Integer;
begin

   //for n := 0 to FRuleSymbols.Count - 1 do
   //   TSymbol(FRuleSymbols.Items[n]).Free;

   FRuleSymbols.Free;

   inherited Destroy;
end;

function TRule.GetSymbolCount: Integer;
begin

   Result := FRuleSymbols.Count;

end;

function TRule.Name: string;
begin

   Result := '<' + FRuleNonterminal.Name + '>';

end;

procedure TRule.SetNonterminal(NewNonterminal: TSymbol);
begin

   FRuleNonterminal := NewNonterminal;

end;

function TRule.GetNonterminal: TSymbol;
begin

   Result := FRuleNonterminal;

end;

procedure TRule.AddItem(Item: TSymbol);
begin

   FRuleSymbols.Add(Item);

end;

function TRule.Definition: string;
var
   n: Integer;
begin

   for n := 0 to FRuleSymbols.Count - 1 do
      Result := Result + TSymbol(FRuleSymbols.Items[n]).Text + ' ';

   Result := Trim(Result);

end;

function TRule.ContainsOneNonTerminal: Boolean;
begin

   Result := False;

   if FRuleSymbols.Count = 1 then
      if TSymbol(FRuleSymbols.Items[0]).Kind = SymbolTypeNonterminal then
         Result := True;
end;

function TRule.GetSymbols(Index: Integer): TSymbol;
begin

   Result := FRuleSymbols.Items[Index];

end;

function TRule.Text: String;
begin

   Result := Name + ' ::= ' + Definition;

end;

end.
