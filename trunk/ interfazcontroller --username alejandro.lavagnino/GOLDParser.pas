unit GOLDParser;

{
'===================================================================
' Class Name:
'    GOLDParser (basic version)
'
' Instancing:
'      Public; Creatable  (VB Setting: 5 - MultiUse)
'
' Purpose:
'    This is the main class in the GOLD Parser Engine and is used to perform
'    all duties required to the parsing of a source text string. This class
'    contains the LALR(1) State Machine code, the DFA State Machine code,
'    character table (used by the DFA algorithm) and all other structures and
'    methods needed to interact with the developer.
'
'Author(s):
'   Devin Cook
'
'Public Dependencies:
'   Token, Rule, Symbol, Reduction
'
'Private Dependencies:
'   ObjectList, SimpleDatabase, SymbolList, StringList, VariableList, TokenStack
'
'Revision History:
'   June 9, 2001:
'      Added the ReductionMode property and modified the Reduction object (which was
'      used only for internal use). In addition the Reduction property was renamed to
'      CurrentReduction to avoid possible name conflicts in different programming languages
'      (which this VB source will be converted to eventually)
'   Sept 5, 2001:
'      I was alerted to an error in the engine logic by Szczepan Holyszewski [rulatir@poczta.arena.pl].
'      When reading tokens inside a block quote, the line-comment token would still eliminate the rest
'      of a line - possibly eliminating the block quote end.
'   Nov 28, 2001:
'      Fixed several errors.
'   December 2001:
'      Added the TrimReductions property and required logic
'===================================================================
 Conversion to Delphi:
      Beany
      Beany@cloud.demon.nl

 Conversion status: Done, not tested

 Delphi Version: 6.0

 Delphi GOLDParser version: 0.1 (very alpha!)


 Conversion Readme:

 This is a pretty straightforward conversion of the GOLDParser VB version.
 The most important difference is the GrammarReader and the SourceFeeder classes.
 These classes take care of reading the grammar and feeding the parser with code
 wich must be parsed. The reading of the grammar looks the same as in the VB
 version, but the LookaheadStream is not being used. The feeding of the source
 is also being done without the LookaheadStream.

 TODO's(in no particulair order):

 1. DONE 22 April 2002: Get rid of the Variant type's. It can be done without.
    The code will run faster without Variants. They can also produce weird errors.
 2. Optimize the code. Its currently a pretty straightforward conversion. It
    can be done better, wich will result in cleaner and faster code.
 3. Intensive testing. I did some tests, wich succeeded, but I want to test it
    more to be sure it does what it is supposed to do. Any input on this
    would be helpfull! ;)
 4. DONE 24 April 2002(well, I hope so!): Check if there are no memory leaks. I have the feeling there are some, but
    I have to get in to it.
 5. Write some documentation
 6. ALTHOUGH IT LOOKS LIKE ITS DONE: ALMOST DONE, JUST SOME MINOR THINGS: Make
    a nice component of this all so it can be easily used with a Delphi
    application
 7. DONE 23 April 2002: Make sure the interface has the same functionality compared to the VB
    ActiveX version.



 Warranty: None ofcourse :) If it works for you, GOOD! If it doesnt, don't demand
 that I will fix it. You can ask me, but I can't guarantee anything!



'================================================================================
'
'                 The GOLD Parser Freeware License Agreement
'                 ==========================================
'
'this software Is provided 'as-is', without any expressed or implied warranty.
'In no event will the authors be held liable for any damages arising from the
'use of this software.
'
'Permission is granted to anyone to use this software for any purpose. If you
'use this software in a product, an acknowledgment in the product documentation
'would be deeply appreciated but is not required.
'
'In the case of the GOLD Parser Engine source code, permission is granted to
'anyone to alter it and redistribute it freely, subject to the following
'restrictions:
'
'   1. The origin of this software must not be misrepresented; you must not
'      claim that you wrote the original software.
'
'   2. Altered source versions must be plainly marked as such, and must not
'      be misrepresented as being the original software.
'
'   3. This notice may not be removed or altered from any source distribution
'
'================================================================================
}

interface

uses
   Classes, SysUtils,
   GrammarReader, Variables, LRAction, LRActionTable, FAState, Rule, Symbol,
   TokenStack, Token, Reduction, SourceFeeder;

type

   TCompareMode = (vbBinaryCompare, vbTextCompare);
   TGPMessageConstants = (gpMsgEmpty = 0,                   //Nothing
                          gpMsgTokenRead = 1,               //A new token is read
                          gpMsgReduction = 2,               //A rule is reduced
                          gpMsgAccept = 3,                  //Grammar complete
                          gpMsgNotLoadedError = 4,          //Now grammar is loaded
                          gpMsgLexicalError = 5,            //Token not recognized
                          gpMsgSyntaxError = 6,             //Token is not expected
                          gpMsgCommentError = 7,            //Reached the end of the file - mostly due to being stuck in comment mode
                          gpMsgInternalError = 8            //Something is wrong, very wrong
                         );

   TParseResultConstants = (ParseResultEmpty = 0,
                            ParseResultAccept = 1,
                            ParseResultShift = 2,
                            ParseResultReduceNormal = 3,
                            ParseResultReduceEliminated = 4,
                            ParseResultSyntaxError = 5,
                            ParseResultInternalError = 6
                           );

   TGOLDParser = class
   private
      FGrammarReader: TGrammarReader;
      FVariableList: TVariableList;
      FSymbolTable: TList;
      FInitialDFAState: Integer;
      FInitialLALRState: Integer;
      FCharacterSetTable: TStringList;
      FRuleTable: TList;
      FDFA: TList;
      FActionTable: TList;

      FTablesLoaded: Boolean;
      FTrimReductions: Boolean;

      kErrorSymbol: TSymbol;
      kEndSymbol: TSymbol;

      pCompareMode: TCompareMode;

      FCurrentLALR: Integer;
      pLineNumber: Integer;
      pCommentLevel: Integer;
      pHaveReduction: Boolean;

      FStack: TTokenStack;
      FTokens: TTokenStack;
      FInputTokens: TTokenStack;

      pSource: TSourceFeeder;
      procedure PrepareToParse;
      function RetrieveToken(Source: TSourceFeeder): TToken;
      procedure DiscardRestOfLine;
      function ParseToken(NextToken: TToken): TParseResultConstants;
      function GetCurrentReduction: TReduction;
      procedure SetCurrentReduction(NewReduction: TReduction);
      function GetRuleTableCount: Integer;
      function GetRuleTableEntry(Index: Integer): TRule;
      function GetSymbolTableCount: Integer;
      function GetSymbolTableEntry(Index: Integer): TSymbol;
   public
      constructor Create;
      destructor Destroy; override;
      procedure Reset;
      procedure Clear;
      procedure PushInputToken(TheToken: TToken);
      function LoadCompiledGrammar(FileName: String): Boolean;
      function OpenTextString(Text: String): Boolean;
      function ReadTextString: string;
      function Parse: TGPMessageConstants;
      function CurrentToken: TToken;
      function TokenCount: Integer;
      function Tokens(Index: Integer): TToken;
      function Parameter(ParamName: string): string;
      function PopInputToken: TToken;
      property TrimReductions: Boolean read FTrimReductions write FTrimReductions;
      property CurrentReduction: TReduction read GetCurrentReduction write SetCurrentReduction;
      property CurrentLineNumber: Integer read pLineNumber;
      property RuleTableCount: Integer read GetRuleTableCount;
      property RuleTableEntry[Index: Integer]: TRule read GetRuleTableEntry;
      property SymbolTableCount: Integer read GetSymbolTableCount;
      property SymbolTableEntry[Index: Integer]: TSymbol read GetSymbolTableEntry;
   end;

implementation

constructor TGOLDParser.Create;
begin
   inherited Create;

   FStack := TTokenStack.Create;
   FTokens := TTokenStack.Create;
   FInputTokens := TTokenStack.Create;

   FGrammarReader := TGrammarReader.Create;
   pSource := TSourceFeeder.Create;

   FVariableList := TVariableList.Create;
   FSymbolTable := TList.Create;
   FCharacterSetTable := TStringList.Create;
   FRuleTable := TList.Create;
   FDFA := TList.Create;
   FActionTable := TList.Create;

   FGrammarReader.VariableList := FVariableList;
   FGrammarReader.SymbolTable := FSymbolTable;
   FGrammarReader.CharacterSetTable := FCharacterSetTable;
   FGrammarReader.RuleTable := FRuleTable;
   FGrammarReader.DFA := FDFA;
   FGrammarReader.ActionTable := FActionTable;

   FTablesLoaded := False;
   FTrimReductions := False;

end;

destructor TGOLDParser.Destroy;
var
   n: Integer;
begin

   for n := 0 to FActionTable.Count - 1 do
      if FActionTable.Items[n] <> nil then
         TLRActionTable(FActionTable.Items[n]).Free;

   FActionTable.Free;

   for n := 0 to FDFA.Count - 1 do
      TFAState(FDFA.Items[n]).Free;

   FDFA.Free;

   for n := 0 to FRuleTable.Count - 1 do
      TRule(FRuleTable.Items[n]).Free;

   FRuleTable.Free;

   FCharacterSetTable.Free;

   for n := 0 to FSymbolTable.Count - 1 do
      TSymbol(FSymbolTable.Items[n]).Free;

   FSymbolTable.Free;

   FVariableList.Free;

   pSource.Free;
   FGrammarReader.Free;

   FInputTokens.Free;
   FTokens.Free;

   FStack.Free;

   inherited Destroy;
end;

procedure TGOLDParser.Reset;
var
   n: Integer;
begin

   for n := 0 to FSymbolTable.Count - 1 do
   begin
      case TSymbol(FSymbolTable.Items[n]).Kind of
         SymbolTypeError:
            kErrorSymbol := FSymbolTable.Items[n];
         SymbolTypeEnd:
            kEndSymbol := FSymbolTable.Items[n];
      end;
   end;

   //if FTablesLoaded then
      if (FVariableList.Value['Case Sensitive'] = 'True') then
         pCompareMode := vbBinaryCompare
      else
         pCompareMode := vbTextCompare;

   FCurrentLALR := FInitialLALRState;
   pLineNumber := 1;
   pCommentLevel := 0;
   pHaveReduction := False;

   FTokens.Clear;
   FInputTokens.Clear;
   FStack.Clear;

end;

procedure TGOLDParser.Clear;
var
   n: Integer;
begin

   for n := 0 to FSymbolTable.Count - 1 do
      TSymbol(FSymbolTable.Items[n]).Free;

   FSymbolTable.Clear;
   FRuleTable.Clear;
   FCharacterSetTable.Clear;
   FVariableList.ClearValues;
   FTokens.Clear;
   FInputTokens.Clear;

   Reset;

end;

function TGOLDParser.LoadCompiledGrammar(FileName: String): Boolean;
begin
   Reset;
   Result := FGrammarReader.LoadTables(Filename);
end;

function TGOLDParser.OpenTextString(Text: String): Boolean;
begin

   Reset;
   pSource.Text := Text;
   PrepareToParse;
   Result := True;

end;

function TGOLDParser.ReadTextString: string;
begin
   Result := pSource.Text;
end;

procedure TGOLDParser.PrepareToParse;
var
   Start: TToken;
begin
   //Added 12/23/2001: The token stack is empty until needed
   Start := TToken.Create;

   Start.State := FInitialLALRState;
   Start.ParentSymbol := TSymbol(FSymbolTable.Items[ FGrammarReader.StartSymbol ]);

   FStack.Push(Start);

end;

function TGOLDParser.Parse: TGPMessageConstants;
var
   Done: Boolean;
   ReadToken: TToken;
   ParseResult: TParseResultConstants;
begin

   Result := gpMsgEmpty;

   if (FActionTable.Count < 1) or (FDFA.Count < 1) then
      Result := gpMsgNotLoadedError
   else
   begin
      Done := False;
      while not Done do
      begin
         if FInputTokens.Count = 0 then                     //We must read a token
         begin
            ReadToken := RetrieveToken(pSource);
            if ReadToken = nil then
            begin
               Result := gpMsgInternalError;
               Done := True;
            end else if ReadToken.Kind <> SymbolTypeWhitespace then
            begin
               FInputTokens.Push(ReadToken);
               if (pCommentLevel = 0) and (ReadToken.Kind <> SymbolTypeCommentLine) and (ReadToken.Kind <> SymbolTypeCommentStart) then
               begin
                  Result := gpMsgTokenRead;
                  Done := True;
               end;
            end else
               ReadToken.Free;

         end else if pCommentLevel > 0 then           //We are in a block comment
         begin
            ReadToken := FInputTokens.Pop;

            case ReadToken.Kind of
            SymbolTypeCommentStart:
               Inc(pCommentLevel);
            SymbolTypeCommentEnd:
               Dec(pCommentLevel);
            SymbolTypeEnd:
               begin
                  Result := gpMsgCommentError;
                  Done := True;
               end;
            else
               //Do nothing, ignore
               //The 'comment line' symbol is ignored as well
            end;
            ReadToken.Free;
         end else
         begin

            ReadToken := FInputTokens.Top;

            case ReadToken.Kind of
            SymbolTypeCommentStart:
               begin
                  Inc(pCommentLevel);
                  FInputTokens.Pop;                           //Remove it
               end;
            SymbolTypeCommentLine:
               begin
                  FInputTokens.Pop;                           //Remove it and rest of line
                  DiscardRestOfLine;                          //Procedure also increments the line number
               end;
            SymbolTypeError:
               begin
                  Result := gpMsgLexicalError;
                  Done := True;
               end;
            else                                      //FINALLY, we can parse the token
               begin
                  ParseResult := ParseToken(ReadToken);
                  //NEW 12/2001: Now we are using the internal enumerated constant
                  case ParseResult of
                  ParseResultAccept:
                     begin
                        Result := gpMsgAccept;
                        Done := True;
                     end;
                  ParseResultInternalError:
                     begin
                        Result := gpMsgInternalError;
                        Done := True;
                     end;
                  ParseResultReduceNormal:
                     begin
                        Result := gpMsgReduction;
                        Done := True;
                     end;
                  ParseResultShift:                      //A simple shift, we must continue
                        FInputTokens.Pop;                       //Okay, remove the top token, it is on the stack
                  ParseResultSyntaxError:
                     begin
                        Result := gpMsgSyntaxError;
                        Done := True;
                     end;
                  end;
               end;
            end;
         end;
      end;
   end;

end;

function TGOLDParser.RetrieveToken(Source: TSourceFeeder): TToken;      //Symbol Index
var
   Done: Boolean;
   Found: Boolean;
   CurrentDFA: Integer;
   CurrentPosition: Integer;
   LastAcceptState: Integer;
   LastAcceptPosition: Integer;
   ch: string;
   n: Integer;
   CharSetIndex: Integer;
   comp1, comp2: string;
   Target: Integer;
begin

   Result := TToken.Create;

   Done := False;
   CurrentDFA := FInitialDFAState;           //The first state is almost always #1.
   CurrentPosition := 1;                    //Next byte in the input LookaheadStream
   LastAcceptState := -1;                   //We have not yet accepted a character string
   LastAcceptPosition := -1;

   Target := 0;

   if not pSource.Done then
   begin
      while not Done do
      begin
         ch := pSource.ReadFromBuffer(CurrentPosition, False, False);
         if ch = '' then
            Found := False
         else
         begin
            n := 0;
            Found := False;

            While (n < TFAState(FDFA.Items[CurrentDFA]).EdgeCount) and (not Found) do
            begin
               CharSetIndex := TFAState(FDFA.Items[CurrentDFA]).Edge(n).Characters;
               comp1 := FCharacterSetTable.Strings[CharSetIndex];
               comp2 := ch;
               if pCompareMode = vbTextCompare then
               begin
                  comp1 := UpperCase(comp1);
                  comp2 := UpperCase(comp2);
               end;

               if Pos(comp2, comp1) <> 0 then
               begin
                  Found := True;
                  Target := TFAState(FDFA.Items[CurrentDFA]).Edge(n).TargetIndex;
               end;
               Inc(n);
            end;
         end;

         //======= This block-if statement checks whether an edge was found from the current state.
         //======= If so, the state and current position advance. Otherwise it is time to exit the main loop
         //======= and report the token found (if there was it fact one). If the LastAcceptState is -1,
         //======= then we never found a match and the Error Token is created. Otherwise, a new token
         //======= is created using the Symbol in the Accept State and all the characters that
         //======= comprise it.

         if Found then
         begin
            //======= This code checks whether the target state accepts a token. If so, it sets the
            //======= appropiate variables so when the algorithm in done, it can return the proper
            //======= token and number of characters.
            if TFAState(FDFA.Items[Target]).AcceptSymbol <> -1 then
               begin
                  LastAcceptState := Target;
                  LastAcceptPosition := CurrentPosition;
               end;

            CurrentDFA := Target;
            Inc(CurrentPosition);
         end else                                           //No edge found
         begin
            Done := True;
            if LastAcceptState = -1 then                //Tokenizer cannot recognize symbol
            begin
               Result.ParentSymbol := kErrorSymbol;
               Result.DataVar := pSource.ReadFromBuffer(1, True, True);
            end else                                                //Create Token, read characters
            begin
               Result.ParentSymbol := TSymbol(FSymbolTable.Items[TFAState(FDFA.Items[LastAcceptState]).AcceptSymbol]);
               Result.DataVar := pSource.ReadFromBuffer(LastAcceptPosition, True, True);    //The data contains the total number of accept characters
            end;
         end;

         //DoEvents
      end;
   end else
   begin
      Result.DataVar := '';
      Result.ParentSymbol := kEndSymbol;
   end;

   //======= Count Carriage Returns and increment the Line Number. This is done for the
   //======= Developer and is not necessary for the DFA algorithm
   for n := 1 To Length(Result.DataVar) do
   begin
      if Result.DataVar[n] = #13 then
         Inc(pLineNumber);
   end;
   //If pLineNumber Mod 1000 = 0 Then Stop

end;

procedure TGOLDParser.DiscardRestOfLine;
var
   sTemp: string;
begin

   //Kill the current line - basically for line comments
   sTemp := pSource.ReadLine;

   //01/26/2002: Fixed bug. Inc counter
   inc(pLineNumber);
end;

function TGOLDParser.ParseToken(NextToken: TToken): TParseResultConstants;
var
   Index: Integer;
   RuleIndex: Integer;
   CurrentRule: TRule;
   Head: TToken;
   NewReduction: TReduction;
   n: Integer;
begin

   Result := ParseResultEmpty;

   Index := TLRActionTable(FActionTable.Items[FCurrentLALR]).ActionIndexForSymbol(NextToken.ParentSymbol.TableIndex);

   if Index <> -1 then              //Work - shift or reduce
   begin
      pHaveReduction := False;       //Will be set true if a reduction is made
      FTokens.Count := 0;

      case TLRActionTable(FActionTable.Items[FCurrentLALR]).Item[Index].Action of
      ActionAccept:
         begin
            pHaveReduction := True;
            Result := ParseResultAccept;
         end;
      ActionShift:
         begin
            FCurrentLALR := TLRActionTable(FActionTable.Items[FCurrentLALR]).Item[Index].Value;
            NextToken.State := FCurrentLALR;
            FStack.Push(NextToken);
            Result := ParseResultShift;
         end;
      ActionReduce:
         begin
            //Produce a reduction - remove as many tokens as members in the rule & push a nonterminal token


            RuleIndex := TLRActionTable(FActionTable.Items[FCurrentLALR]).Item[Index].Value;
            CurrentRule := FRuleTable.Items[RuleIndex];

            //======== Create Reduction
            if (FTrimReductions) and (CurrentRule.ContainsOneNonTerminal) then
            begin
               //NEW 12/2001
               //The current rule only consists of a single nonterminal and can be trimmed from the
               //parse tree. Usually we create a new Reduction, assign it to the Data property
               //of Head and push it on the stack. However, in this case, the Data property of the
               //Head will be assigned the Data property of the reduced token (i.e. the only one
               //on the stack).
               //In this case, to save code, the value popped of the stack is changed into the head.

               Head := FStack.Pop;
               Head.ParentSymbol := CurrentRule.RuleNonterminal;

               Result := ParseResultReduceEliminated;
            end else                                           //Build a Reduction
            begin
               pHaveReduction := True;
               NewReduction := TReduction.Create;
               With NewReduction do
               begin
                  ParentRule := CurrentRule;
                  TokenCount := CurrentRule.SymbolCount;
                  for n := TokenCount - 1 downto 0 do
                     Tokens[n] := FStack.Pop;

               end;

               Head := TToken.Create;
               Head.DataObj := NewReduction;
               Head.ParentSymbol := CurrentRule.RuleNonterminal;

               Result := ParseResultReduceNormal;
            end;

            //========== Goto
            Index := FStack.Top.State;

            //========= If n is -1 here, then we have an Internal Table Error!!!!
            n := TLRActionTable(FActionTable.Items[Index]).ActionIndexForSymbol(CurrentRule.RuleNonterminal.TableIndex);
            if n <> -1 then
            begin
               FCurrentLALR := TLRActionTable(FActionTable.Items[Index]).Item[n].Value;

               Head.State := FCurrentLALR;
               FStack.Push(Head);
           end else
               Result := ParseResultInternalError;


         end;
      end;
   end else
   begin
      //=== Syntax Error! Fill Expected Tokens
      FTokens.Clear;
      for n := 0 to TLRActionTable(FActionTable.Items[FCurrentLALR]).Count - 1 do
      begin
         //01/26/2002: Fixed bug. EOF was not being added to the expected tokens
         case TLRActionTable(FActionTable.Items[FCurrentLALR]).Item[n].Symbol.Kind of
         SymbolTypeTerminal, SymbolTypeEnd:
            begin
               Head := TToken.Create;
               Head.DataVar := '';
               Head.ParentSymbol := TLRActionTable(FActionTable.items[FCurrentLALR]).Item[n].Symbol;
               FTokens.Push(Head);
            end;
         end;
       end;
       //If pTokens.Count = 0 Then Stop
       Result := ParseResultSyntaxError;

   end;

end;

function TGOLDParser.CurrentToken: TToken;
begin

   Result := FInputTokens.Top;

end;

function TGOLDParser.GetCurrentReduction: TReduction;
begin
    if pHaveReduction then
        Result := FStack.Top.DataObj
    else
        Result := nil;

end;

procedure TGOLDParser.SetCurrentReduction(NewReduction: TReduction);
begin

   if pHaveReduction then
      FStack.Top.DataObj := NewReduction;

end;

function TGOLDParser.TokenCount: Integer;
begin

   Result := FTokens.Count;

end;

function TGOLDParser.Tokens(Index: Integer): TToken;
begin

   Result := FTokens.Member[Index];


end;

function TGOLDParser.GetRuleTableCount: Integer;
begin
   Result := FRuleTable.Count;
end;

function TGOLDParser.GetRuleTableEntry(Index: Integer): TRule;
begin

   Result := FRuleTable.Items[Index];

end;

function TGOLDParser.GetSymbolTableCount: Integer;
begin

   Result := FSymbolTable.Count;

end;

function TGOLDParser.GetSymbolTableEntry(Index: Integer): TSymbol;
begin

   Result := FSymbolTable.Items[Index];

end;

function TGOLDParser.Parameter(ParamName: string): string;
begin

   Result := FVariableList.Value[ParamName];

end;

function TGOLDParser.PopInputToken: TToken;
begin

   Result := FInputTokens.Pop;

end;

procedure TGOLDParser.PushInputToken(TheToken: TToken);
begin

   FInputTokens.Push(TheToken);

end;

end.
