unit GrammarReader;

interface

uses
   Classes, SysUtils, Dialogs, Variants, Variables, Symbol, Rule, FAState, LRActionTable, LRAction;

type

   TEntryType = (EntryContentEmpty = 69,
                 EntryContentInteger = 73,
                 EntryContentString = 83,
                 EntryContentBoolean = 66,
                 EntryContentByte = 98
                );

   TRecordId =  (RecordIdParameters  = 80,   //P
                 RecordIdTableCounts = 84,   //T
                 RecordIdInitial     = 73,   //I
                 RecordIdSymbols     = 83,   //S
                 RecordIdCharSets    = 67,   //C
                 RecordIdRules       = 82,   //R
                 RecordIdDFAStates   = 68,   //D
                 RecordIdLRTables    = 76,   //L
                 RecordIdComment     = 33    //!
                );

   TGrammarReader = class
   private
      FBufferPos: Integer;
      FBuffer: AnsiString;
      FCurrentRecord: Variant;
      FEntryPos: Integer;
      FEntryCount: Integer;
      FVariableList: TVariableList;
      FSymbolTable: TList;
      FInitialDFAState: Integer;
      FInitialLALRState: Integer;
      FCharacterSetTable: TStringList;
      FRuleTable: TList;
      FDFA: TList;
      FActionTable: TList;
      FStartSymbol: Integer;
      function ReadUniString: string;
      function ReadInt16: Integer;
      function ReadByte: AnsiChar;
      function ReadEntry: Variant;
      function OpenFile(Filename: string): Boolean;
      //IBRAHIM
      function OpenStream(Stream : TStream): Boolean;
      function DoLoadTables: Boolean;
   public
      constructor Create;
      destructor Destroy; override;
      function GetNextRecord: Boolean;
      function RetrieveNext: Variant;
      //IBRAHIM
      function LoadTables(Filename: string): Boolean;overload;
      function LoadTables(Stream: TStream): Boolean;overload;

      property Buffer: Ansistring read FBuffer;
      property VariableList: TVariableList read FVariableList write FVariableList;
      property SymbolTable: TList read FSymbolTable write FSymbolTable;
      property CharacterSetTable: TStringList read FCharacterSetTable write FCharacterSetTable;
      property RuleTable: TList read FRuleTable write FRuleTable;
      property DFA: TList read FDFA write FDFA;
      property ActionTable: TList read FActionTable write FActionTable;
      property StartSymbol: Integer read FStartSymbol write FStartSymbol;
   end;

implementation

const
   FHeader: string = 'GOLD Parser Tables/v1.0';

constructor TGrammarReader.Create;
begin
   inherited Create;

end;

destructor TGrammarReader.Destroy;
begin

   inherited Destroy;
end;

function TGrammarReader.OpenFile(Filename: string): Boolean;
var
   GFile: TFileStream;
begin

   try
      GFile := TFileStream.Create(Filename, fmOpenRead);

      SetLength(FBuffer, GFile.Size);
      GFile.ReadBuffer(FBuffer[1], GFile.Size);

      GFile.Free;
      Result := True;

      FBufferPos := 1;
   except
      Result := False;

      FBufferPos := -1;
   end;

end;
//IBRAHIM
function TGrammarReader.OpenStream(Stream : TStream): Boolean;
begin
   try
      SetLength(FBuffer, Stream.Size);
      Stream.ReadBuffer(FBuffer[1], Stream.Size);

      Result := True;
      FBufferPos := 1;
   except
      Result := False;
      FBufferPos := -1;
   end;

end;

function TGrammarReader.GetNextRecord: Boolean;
var
   TypeOfRecord: Ansichar;
   Entries: Integer;
   n: Integer;
begin

   Result := False;

   TypeOfRecord := ReadByte;

   //Structure below is ready for future expansion
   case TypeOfRecord of
      'M':
      begin
         //Read the number of entry's
         Entries := ReadInt16;
         VarClear(FCurrentRecord);
         FCurrentRecord := VarArrayCreate([1, Entries], varVariant);
         FEntryCount := Entries;
         FEntryPos := 1;
         for n := 1 to Entries do
         begin
            FCurrentRecord[n] := ReadEntry;
         end;
         Result := True;
      end;
   end;


end;

function TGrammarReader.ReadUniString: string;
var
   uchr: Integer;
begin

   uchr := ReadInt16;
   while (uchr <> 0) do
   begin
      Result := Result + Chr(uchr);
      uchr := ReadInt16;
   end;

end;

function TGrammarReader.ReadInt16: Integer;
begin

   Result := ord(FBuffer[FBufferPos]) + ord(FBuffer[FBufferPos + 1]) * 256;

   FBufferPos := FBufferPos + 2;

end;

function TGrammarReader.ReadByte: AnsiChar;
begin

   Result := FBuffer[FBufferPos];

   Inc(FBufferPos);

end;

function TGrammarReader.ReadEntry: Variant;
var
   EntryType: AnsiChar;
begin

   EntryType := ReadByte;

   case TEntryType(EntryType) of
      EntryContentEmpty:
         Result := varEmpty;
      EntryContentInteger:
         Result := ReadInt16;
      EntryContentBoolean:
         begin
            Result := ReadByte;
            if Result = #1 then
               Result := True
            else
               Result := False;
         end;
      EntryContentString:
         Result := ReadUniString;
      EntryContentByte:
         Result := ReadByte;

   end;

end;

function TGrammarReader.RetrieveNext: Variant;
begin

   if FEntryPos <= FEntryCount then
   begin
      Result := FCurrentRecord[FEntryPos];
      Inc(FEntryPos);
   end else
   begin
      Result := varEmpty;
   end;

end;

function TGrammarReader.DoLoadTables: Boolean;
var
   Id: String;
   n: Integer;
   NewSymbol: TSymbol;
   NewRule: TRule;
   NewFAState: TFAState;
   bAccept: Boolean;
   NewActionTable: TLRActionTable;
   Item1, Item2, Item3: Integer;
begin

   FVariableList.Add('Name', '');
   FVariableList.Add('Version', '');
   FVariableList.Add('Author', '');
   FVariableList.Add('About', '');
   FVariableList.Add('Case Sensitive', '');
   FVariableList.Add('Start Symbol', '');

   Result := False;

    if FHeader = ReadUniString then
    begin

       while (FBufferPos < Length(FBuffer)) do
       begin
          Result := GetNextRecord;

          Id := String(RetrieveNext);

          case TRecordId(Id[1]) of
             RecordIdParameters:
             begin
                FVariableList.Value['Name'] := RetrieveNext;
                FVariableList.Value['Version'] := RetrieveNext;
                FVariableList.Value['Author'] := RetrieveNext;
                FVariableList.Value['About'] := RetrieveNext;
                FVariableList.Value['Case Sensitive'] := RetrieveNext;
                FVariableList.Value['Start Symbol'] := RetrieveNext;
                FStartSymbol := StrToInt(FVariableList.Value['Start Symbol']);
             end;

             RecordIdTableCounts:
             begin
                for n := 0 to RetrieveNext - 1 do
                   FSymbolTable.Add(nil);

                for n := 0 to RetrieveNext do
                   FCharacterSetTable.Add('');

                for n := 0 to RetrieveNext do
                   FRuleTable.Add(nil);

                for n := 0 to RetrieveNext do
                   FDFA.Add(nil);

                for n := 0 to RetrieveNext do
                   FActionTable.Add(nil);

             end;

             RecordIdInitial:
             begin
                FInitialDFAState := RetrieveNext;
                FInitialLALRState := RetrieveNext;
             end;

             RecordIdSymbols:
             begin
                NewSymbol := TSymbol.Create;

                n := RetrieveNext;
                NewSymbol.TableIndex := n;
                NewSymbol.Name := RetrieveNext;
                NewSymbol.Kind := RetrieveNext;
                RetrieveNext;

                FSymbolTable.Items[n] := NewSymbol;
             end;

             RecordIdCharSets:
             begin
                n := RetrieveNext;
                FCharacterSetTable.Strings[n] := RetrieveNext;
             end;

             RecordIdRules:
             begin
                NewRule := TRule.Create;
                n := RetrieveNext;
                NewRule.TableIndex := n;

                NewRule.RuleNonterminal := FSymbolTable.Items[RetrieveNext];

                RetrieveNext;

                while FEntryPos <= FEntryCount do
                begin
                   NewRule.AddItem(FSymbolTable.Items[RetrieveNext]);
                end;

                FRuleTable.Items[n] := NewRule;
             end;

             RecordIdDFAStates:
             begin
                NewFAState := TFAState.Create;
                n := RetrieveNext;

                bAccept := RetrieveNext;
                if bAccept then
                   NewFAState.AcceptSymbol := RetrieveNext
                else
                begin
                   NewFAState.AcceptSymbol := -1;
                   RetrieveNext;
                end;

                RetrieveNext;

                while FEntryPos <= FEntryCount do
                begin
                   Item1 := RetrieveNext;
                   Item2 := RetrieveNext;
                   NewFAState.AddEdge(IntToStr(Item1), Item2);
                   RetrieveNext;
                end;

                FDFA.Items[n] := NewFAState;

             end;

             RecordIdLRTables:
             begin
                NewActionTable := TLRActionTable.Create;

                n := RetrieveNext;
                RetrieveNext;

                while FEntryPos <= FEntryCount do
                begin
                   Item1 := RetrieveNext;
                   Item2 := RetrieveNext;
                   Item3 := RetrieveNext;
                   NewActionTable.AddItem(TSymbol(FSymbolTable.Items[Item1]), TActionConstants(Item2), Item3 );
                   RetrieveNext;
                end;

                FActionTable.Items[n] := NewActionTable;
             end;

          end;

       end;

       FVariableList.Value['Start Symbol'] := TSymbol(FSymbolTable.Items[StrToInt(FVariableList.Value['Start Symbol'])]).Name;
    end else
       Result := False;

end;

//IBRAHIM
function TGrammarReader.LoadTables(Filename: string): Boolean;
begin
   Result := OpenFile(Filename);
   if Result then
      Result := DoLoadTables;
end;

//IBRAHIM
function TGrammarReader.LoadTables(Stream: TStream): Boolean;
begin
   Result := OpenStream(Stream);
   if Result then
      Result := DoLoadTables;
end;

end.

