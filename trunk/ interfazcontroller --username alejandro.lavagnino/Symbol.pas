unit Symbol;

{
'================================================================================
' Class Name:
'      Symbol
'
' Instancing:
'      Public; Non-creatable  (VB Setting: 2- PublicNotCreatable)
'
' Purpose:
'       This class is used to store of the nonterminals used by the Deterministic
'       Finite Automata (DFA) and LALR Parser. Symbols can be either
'       terminals (which represent a class of tokens - such as identifiers) or
'       nonterminals (which represent the rules and structures of the grammar).
'       Terminal symbols fall into several catagories for use by the GOLD Parser
'       Engine which are enumerated below.
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
   Classes;


type
   TSymbolTypeConstants = (SymbolTypeNonterminal = 0,     //Normal nonterminal
                          SymbolTypeTerminal = 1,        //Normal terminal
                          SymbolTypeWhitespace = 2,      //Type of terminal
                          SymbolTypeEnd = 3,             //End character (EOF)
                          SymbolTypeCommentStart = 4,    //Comment start
                          SymbolTypeCommentEnd = 5,      //Comment end
                          SymbolTypeCommentLine = 6,     //Comment line
                          SymbolTypeError = 7            //Error symbol
                         );
   kQuotedChars = set of Char;


   TSymbol = class
   private
      pName: String;
      pKind: TSymbolTypeConstants;
      //pPattern: String; Obsolete?
      //pVariableLength: Boolean;  Obsolete?
      pTableIndex: Integer;
      procedure SetName(NewName: string);
      procedure SetKind(TheType: TSymbolTypeConstants);
      procedure SetTableIndex(Index: Integer);
      function GetText: string;
      function PatternFormat(Source: string): string;
   public
      constructor Create;
      destructor Destroy; override;
      property Kind: TSymbolTypeConstants read pKind write SetKind;
      property TableIndex: Integer read pTableIndex write SetTableIndex;
      property Name: string read pName write SetName;
      property Text: string read GetText;
   end;

implementation

   const pkQuotedChars = ['|', '-', '+', '*', '?', '(', ')', '[', ']', '{', '}', '<', '>', '!'];

//In test condition:
//The number of Symbols created = the number of symbols destroyed.
constructor TSymbol.Create;
begin
   inherited Create;

   pTableIndex := -1;
end;

destructor TSymbol.Destroy;
begin
   inherited Destroy;
end;

procedure TSymbol.SetName(NewName: string);
begin
   if (pName <> NewName) then
      pName := NewName;
end;

procedure TSymbol.SetKind(TheType: TSymbolTypeConstants);
begin
   if (pKind <> TheType) then
      pKind := TheType;
end;

procedure TSymbol.SetTableIndex(Index: Integer);
begin
   if (pTableIndex <> Index) then
      pTableIndex := Index;
end;

function TSymbol.GetText: string;
begin

   case pKind of
      SymbolTypeNonterminal: Result := '<' + pName + '>';
      SymbolTypeTerminal: Result := PatternFormat(pName);
   else
      Result := '(' + Name + ')';
   end;

end;

function TSymbol.PatternFormat(Source: string): string;
var
   c: Integer;
begin

   for c := 1 to Length(Source) do
   begin
      if Source[c] = '''' then
         Result := Result + ''''''
      else if (Source[c] in pkQuotedChars) or (Source[c] = '"') then
         Result := Result + '''' + Source[c] + '''';
   end;

end;

end.
