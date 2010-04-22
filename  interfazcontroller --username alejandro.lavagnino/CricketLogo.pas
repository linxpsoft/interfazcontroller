(****************************************************
 TODO:
 - Check parameters count in Procedure Calls
****************************************************)
unit CricketLogo;

interface

uses
  Classes, GrammarReader, GOLDParser, Symbol, Token, IntList, Contnrs;



type

  TArray = class(TObject)
      Size: integer;
      Address: integer;
  end;

  TOutputEvent = procedure (aMessage : String) of object;
  TCricketLogoParser = class
    private
      FOnError: TOutputEvent;
      FLineNumber: integer;
      FHEX: TIntList;
      stackLevel: byte;
      (* To use LoadGrammarFromResource, create a file with extension ".rc"
         and put the following line into it:

         GRAMMAR RCDATA "CricketLogo.cgt"

         where CricketLogo.cgt is your compiled grammar. Put the .cgt-File in the same
         directory the .rc-File is in. In Delphi use Menu "Project/Add to project",
         to add the .rc-File.

         Then in Method Execute uncomment the call to LoadGrammarFromResource
         and comment the one to TGoldParser.LoadCompiledGrammar
      *)
      ExpStack: TObjectList;
      StaStack: TObjectList;
      ArrayStack: TStringList;
      ProcList, ProcStack, ParamStack, VarStack: TStringList;
      ProcAddress: integer;
      ArrayNextAddress, ArraySizeCheck: integer;
      currentProcIndex: integer;
      function LoadGrammarFromResource(aGoldParser : TGOLDParser) : Boolean;
      procedure ReplaceReduction (aParser : TGOLDParser);
      function ExpStackPop: TIntList;
      procedure ExpStackPush(L: TIntList);
      procedure StaStackPush(L: TIntList);
      function StaStackPop: TIntList;
      function ListMerge(L1,L2: TIntList):TIntList;
      procedure AddProc(Name,Params: string);
    public
      procedure Execute(aSource : String);
      // Set OnError to receive ErrorMessages
      property  OnError : TOutputEvent read FOnError write FOnError;
      property LineNumber: integer read FLineNumber write FLineNumber;
      property CompiledHEX: TIntList read FHEX;
  end;

  TProc = class
      Params: byte;
      Address: integer;
  end;

implementation

uses
  forms,
  sysutils,
  windows, RegExpr
  , Dialogs;

// constant definitions - this is Delphi <= 5 compatible!
// Symbols

const
	STACKSIZE = 20;
    GLOBALVARS = 16;
    ARRAYSIZE = 128;

     CINT8 = 1;
     CINT16 = 2;
     CLIST = 3;
     CEOL = 4;
     CEOLR = 5;
     CLTHING = 6;
     CSTOP = 7;
     CREALLYSTOP = 68;
     CRETURN = 8;
     CREPEAT = 9;
     CIF = 10;
     CIFELSE = 11;
     CWAITUNTIL = 14;
     CFOREVER = 15;
     CWAIT = 16;
     CTIMER = 17;
     CRESETT = 18;
     CRANDOM = 22;
     CPLUS = 23;
     CMINUS = 24;
     CMULT = 25;
     CDIV = 26;
     CMOD = 27;
     CEQUAL = 28;
     CGT = 29;
     CLT = 30;
     CAND = 31;
     COR = 32;
     CXOR = 33;
     CNEG = 34;
     CSETGLOBAL = 35;
     CGLOBAL = 36;
     CASET = 37;
     CAGET = 38;
     CRECALL = 40;
     CA = 46;
     CB = 47;
     CAB = 48;
     CON = 49;
     CONFOR = 50;
     COFF = 51;
     CTHISWAY = 52;
     CTHATWAY = 53;
     CRD = 54;
     CSENSOR1 = 55;
     CSENSOR2 = 56;
     CSETPOWER = 59;
     CBRAKE = 60;
     CC = 63;
     CD = 64;
     CCD = 65;
     CSENSOR3 = 73;
     CSENSOR4 = 74;
     CSENSOR5 = 75;
     CSENSOR6 = 76;
     CSENSOR7 = 77;
     CSENSOR8 = 78;
     CSWITCH1 = 57;
     CSWITCH2 = 58;
     CSWITCH3 = 79;
     CSWITCH4 = 80;
     CSWITCH5 = 81;
     CSWITCH6 = 82;
     CSWITCH7 = 83;
     CSWITCH8 = 84;
     CLOWBYTE = 71;
     CHIGHBYTE = 72;
     CSERVO_SET = 87;
	 CSERVO_LT = 88;
	 CSERVO_RT = 89;
	 CTALK_TO_MOTOR = 90;
     CPAP = 91;
     CPAPSTEPS = 92;
     CPAPSPEED = 93;

// Rules
const
    RULE_PROCEDURES                                            =  0; //  <Procedures> ::= <Procedure> <Procedures>
    RULE_PROCEDURES2                                           =  1; //  <Procedures> ::= <Procedure>
    RULE_PROCEDURE_TO_IDENTNAME_LPARAN_RPARAN_END              =  2; //  <Procedure> ::= to IdentName '(' <ParameterDeclarations> ')' <Statements> end
    RULE_PROCEDURE_TO_IDENTNAME_END                            =  3; //  <Procedure> ::= to IdentName <Statements> end
    RULE_PARAMETERDECLARATIONS_COMMA                           =  4; //  <ParameterDeclarations> ::= <ParameterDeclaration> ',' <ParameterDeclarations>
    RULE_PARAMETERDECLARATIONS                                 =  5; //  <ParameterDeclarations> ::= <ParameterDeclaration>
    RULE_PARAMETERDECLARATION_IDENTNAME                        =  6; //  <ParameterDeclaration> ::= IdentName
    RULE_STATEMENTS                                            =  7; //  <Statements> ::= <Statement> <Statements>
    RULE_STATEMENTS2                                           =  8; //  <Statements> ::= <Statement>
    RULE_STATEMENT_RETURN_LPARAN_RPARAN                        =  9; //  <Statement> ::= return '(' <Expression> ')'
    RULE_STATEMENT_REPEAT_LBRACKET_RBRACKET                    = 10; //  <Statement> ::= repeat <Expression> '[' <Statements> ']'
    RULE_STATEMENT_IF_LBRACKET_RBRACKET                        = 11; //  <Statement> ::= if <Expression> '[' <Statements> ']'
    RULE_STATEMENT_IFELSE_LBRACKET_RBRACKET_LBRACKET_RBRACKET  = 12; //  <Statement> ::= ifelse <Expression> '[' <Statements> ']' '[' <Statements> ']'
    RULE_STATEMENT_WAITUNTIL_LPARAN_RPARAN                     = 13; //  <Statement> ::= waituntil '[' <Expression> ']'
    RULE_STATEMENT_FOREVER_LBRACKET_RBRACKET                   = 14; //  <Statement> ::= forever '[' <Statements> ']'
    RULE_STATEMENT_WAIT_LPARAN_RPARAN                          = 15; //  <Statement> ::= wait '(' <Expression> ')'
    RULE_STATEMENT_STOP                                        = 16; //  <Statement> ::= stop
    RULE_STATEMENT_RESETT                                      = 17; //  <Statement> ::= resett
    RULE_STATEMENT_SEND_LPARAN_RPARAN                          = 18; //  <Statement> ::= send '(' <Expression> ')'
    RULE_STATEMENT_SET_LPARAN_IDENTNAME_COMMA_RPARAN           = 19; //  <Statement> ::= set '(' IdentName ',' <Expression> ')'
    RULE_STATEMENT_LIST_LPARAN_IDENTNAME_COMMA_RPARAN          = 20; //  <Statement> ::= list '(' IdentName ',' <Expression> ')'
    RULE_STATEMENT_SETITEM_LPARAN_IDENTNAME_COMMA_COMMA_RPARAN = 21; //  <Statement> ::= setitem '(' IdentName ',' <Expression> ',' <Expression> ')'
    RULE_STATEMENT_MOTORATTENTION                              = 22; //  <Statement> ::= MotorAttention
    RULE_STATEMENT_OUTPUT_LPARAN_RPARAN                        = 23; //  <Statement> ::= output '(' <MotorList> ')'
    RULE_STATEMENT_ON                                          = 24; //  <Statement> ::= on
    RULE_STATEMENT_ONFOR_LPARAN_RPARAN                         = 25; //  <Statement> ::= onfor '(' <Expression> ')'
    RULE_STATEMENT_OFF                                         = 26; //  <Statement> ::= off
    RULE_STATEMENT_THISWAY                                     = 27; //  <Statement> ::= thisway
    RULE_STATEMENT_THATWAY                                     = 28; //  <Statement> ::= thatway
    RULE_STATEMENT_RD                                          = 29; //  <Statement> ::= rd
    RULE_STATEMENT_BRAKE                                       = 30; //  <Statement> ::= brake
    RULE_STATEMENT_SETPOWER_LPARAN_RPARAN                      = 31; //  <Statement> ::= setpower '(' <Expression> ')'
    RULE_STATEMENT                                             = 32; //  <Statement> ::= <ProcedureCall>
    RULE_STATEMENT_SERVO_SET_LPARAN_RPARAN                     = 33; //  <Statement> ::= 'servo_set' '(' <Expression> ')'
    RULE_STATEMENT_SERVO_LT_LPARAN_RPARAN                      = 34; //  <Statement> ::= 'servo_lt' '(' <Expression> ')'
    RULE_STATEMENT_SERVO_RT_LPARAN_RPARAN                      = 35; //  <Statement> ::= 'servo_rt' '(' <Expression> ')'
    RULE_STATEMENT_PAP_LPARAN_RPARAN                           = 36; //  <Statement> ::= pap '(' <Expression> ')'
    RULE_STATEMENT_PAPSTEPS_LPARAN_RPARAN                      = 37; //  <Statement> ::= papsteps '(' <Expression> ')'
    RULE_STATEMENT_PAPSPEED_LPARAN_RPARAN                      = 38; //  <Statement> ::= papspeed '(' <Expression> ')'
    RULE_STATEMENT_STOPEXCLAM                                  = 39; //  <Statement> ::= 'stop!'
    RULE_EXPRESSION_AND                                        = 40; //  <Expression> ::= <Expression> and <Com Exp>
    RULE_EXPRESSION_OR                                         = 41; //  <Expression> ::= <Expression> or <Com Exp>
    RULE_EXPRESSION_XOR                                        = 42; //  <Expression> ::= <Expression> xor <Com Exp>
    RULE_EXPRESSION                                            = 43; //  <Expression> ::= <Com Exp>
    RULE_COMEXP_GT                                             = 44; //  <Com Exp> ::= <Com Exp> '>' <Add Exp>
    RULE_COMEXP_LT                                             = 45; //  <Com Exp> ::= <Com Exp> '<' <Add Exp>
    RULE_COMEXP_EQ                                             = 46; //  <Com Exp> ::= <Com Exp> '=' <Add Exp>
    RULE_COMEXP                                                = 47; //  <Com Exp> ::= <Add Exp>
    RULE_ADDEXP_PLUS                                           = 48; //  <Add Exp> ::= <Add Exp> '+' <Mult Exp>
    RULE_ADDEXP_MINUS                                          = 49; //  <Add Exp> ::= <Add Exp> '-' <Mult Exp>
    RULE_ADDEXP                                                = 50; //  <Add Exp> ::= <Mult Exp>
    RULE_MULTEXP_TIMES                                         = 51; //  <Mult Exp> ::= <Mult Exp> '*' <Negate Exp>
    RULE_MULTEXP_DIV                                           = 52; //  <Mult Exp> ::= <Mult Exp> '/' <Negate Exp>
    RULE_MULTEXP_PERCENT                                       = 53; //  <Mult Exp> ::= <Mult Exp> '%' <Negate Exp>
    RULE_MULTEXP                                               = 54; //  <Mult Exp> ::= <Negate Exp>
    RULE_NEGATEEXP_MINUS                                       = 55; //  <Negate Exp> ::= '-' <Value>
    RULE_NEGATEEXP_NOT                                         = 56; //  <Negate Exp> ::= not <Value>
    RULE_NEGATEEXP                                             = 57; //  <Negate Exp> ::= <Value>
    RULE_VALUE_REPORTER                                        = 58; //  <Value> ::= Reporter
    RULE_VALUE                                                 = 59; //  <Value> ::= <ProcedureCall>
    RULE_VALUE_NUMBERLITERAL                                   = 60; //  <Value> ::= NumberLiteral
    RULE_VALUE_LPARAN_RPARAN                                   = 61; //  <Value> ::= '(' <Expression> ')'
    RULE_VALUE_TIMER                                           = 62; //  <Value> ::= timer
    RULE_VALUE_SERIAL                                          = 63; //  <Value> ::= serial
    RULE_VALUE_NEWSERIALQUESTION                               = 64; //  <Value> ::= 'newserial?'
    RULE_VALUE_RANDOM                                          = 65; //  <Value> ::= random
    RULE_VALUE_RECALL                                          = 66; //  <Value> ::= recall
    RULE_VALUE_SENSOR1                                         = 67; //  <Value> ::= 'sensor1'
    RULE_VALUE_SENSOR2                                         = 68; //  <Value> ::= 'sensor2'
    RULE_VALUE_SENSOR3                                         = 69; //  <Value> ::= 'sensor3'
    RULE_VALUE_SENSOR4                                         = 70; //  <Value> ::= 'sensor4'
    RULE_VALUE_SENSOR5                                         = 71; //  <Value> ::= 'sensor5'
    RULE_VALUE_SENSOR6                                         = 72; //  <Value> ::= 'sensor6'
    RULE_VALUE_SENSOR7                                         = 73; //  <Value> ::= 'sensor7'
    RULE_VALUE_SENSOR8                                         = 74; //  <Value> ::= 'sensor8'
    RULE_VALUE_SWITCH1                                         = 75; //  <Value> ::= 'switch1'
    RULE_VALUE_SWITCH2                                         = 76; //  <Value> ::= 'switch2'
    RULE_VALUE_SWITCH3                                         = 77; //  <Value> ::= 'switch3'
    RULE_VALUE_SWITCH4                                         = 78; //  <Value> ::= 'switch4'
    RULE_VALUE_SWITCH5                                         = 79; //  <Value> ::= 'switch5'
    RULE_VALUE_SWITCH6                                         = 80; //  <Value> ::= 'switch6'
    RULE_VALUE_SWITCH7                                         = 81; //  <Value> ::= 'switch7'
    RULE_VALUE_SWITCH8                                         = 82; //  <Value> ::= 'switch8'
    RULE_VALUE_I2C_READ_LPARAN_RPARAN                          = 83; //  <Value> ::= 'i2c_read' '(' <Expression> ')'
    RULE_VALUE_HIGHBYTE_LPARAN_RPARAN                          = 84; //  <Value> ::= highbyte '(' <Expression> ')'
    RULE_VALUE_LOWBYTE_LPARAN_RPARAN                           = 85; //  <Value> ::= lowbyte '(' <Expression> ')'
    RULE_VALUE_ITEM_LPARAN_IDENTNAME_COMMA_RPARAN              = 86; //  <Value> ::= item '(' IdentName ',' <Expression> ')'
    RULE_MOTORLIST_LBRACKET_RBRACKET                           = 87; //  <MotorList> ::= '[' <MotorListItems> ']'
    RULE_MOTORLISTITEMS_COMMA_NUMBERLITERAL                    = 88; //  <MotorListItems> ::= <MotorListItems> ',' NumberLiteral
    RULE_MOTORLISTITEMS_NUMBERLITERAL                          = 89; //  <MotorListItems> ::= NumberLiteral
    RULE_PROCEDURECALL_IDENTNAME_LPARAN_RPARAN                 = 90; //  <ProcedureCall> ::= IdentName '(' <Parameters> ')'
    RULE_PROCEDURECALL_IDENTNAME                               = 91; //  <ProcedureCall> ::= IdentName
    RULE_PARAMETERS_COMMA                                      = 92; //  <Parameters> ::= <Parameter> ',' <Parameters>
    RULE_PARAMETERS                                            = 93; //  <Parameters> ::= <Parameter>
    RULE_PARAMETER                                             = 94; //  <Parameter> ::= <Expression>


{ TCricketLogoParser }

function TCricketLogoParser.ExpStackPop: TInTList;
var
	i: integer;
    L: TIntList;
begin
	Result := TIntList.CreateEx;
    if ExpStack.Count > 0 then
    begin
     L := ExpStack.Items[0] as TIntList;
     for i := 0 to L.IntCount - 1 do
         Result.Add(L.Integers[i]);
     ExpStack.Delete(0);
    end else
    Result := nil;
end;

procedure TCricketLogoParser.ExpStackPush(L: TIntList);
begin
    ExpStack.Insert(0,L);
end;


procedure TCricketLogoParser.StaStackPush(L: TIntList);
begin
    StaStack.Insert(0,L);
end;

function TCricketLogoParser.StaStackPop: TInTList;
var
	i: integer;
    L: TIntList;
begin
	Result := TIntList.CreateEx;
    if StaStack.Count > 0 then
    begin
     L := StaStack.Items[0] as TIntList;
     for i := 0 to L.IntCount - 1 do
         Result.Add(L.Integers[i]);
     StaStack.Delete(0);
    end else
    Result := nil;
end;


function TCricketLogoParser.ListMerge(L1,L2: TIntList):TIntList;
var
   i: integer;
begin
     for I := 0 to L2.IntCount - 1 do
         L1.Add(L2.Integers[i]);
     Result := L1;
end;

procedure TCricketLogoParser.AddProc(Name,Params: string);
var
   RegExp: TRegExpr;
   P: TProc;
   c: byte;
begin
    P := TProc.Create;
    RegExp := TRegExpr.Create;
//    RegExp.Expression := '([\"]{1}[a-z][_a-z0-9]*)';
    RegExp.Expression := '([a-z][_a-z0-9]*)';
    RegExp.ModifierI := True;
    RegExp.InputString := Params;
    c := 0;
    if RegExp.Exec then
    begin
    	Inc(c);
        while RegExp.ExecNext do
            Inc(c);
    end;
    P.Params := c;
    ProcList.AddObject(LowerCase(Name),P);
end;


procedure TCricketLogoParser.Execute(aSource : String);
var
   lParser    : TGOLDParser;
   lResponse  : TGPMessageConstants;
   lDone      : Boolean;
   zToken,i,j : Integer;
   lError     : String;
   L		  : TIntList;
   ProgCount  : Integer;
   RegExp     : TRegExpr;

begin
   lParser := TGOLDParser.Create;
   ExpStack := TObjectList.Create;
   ProcList := TStringList.Create;
   ProcStack := TStringList.Create;
   StaStack := TObjectList.Create;
   VarStack := TStringList.Create;
   ParamStack := TStringList.Create;
   ArrayStack := TStringList.Create;
   ProcAddress := 0;
   FHEX := TIntList.CreateEx;
   ProgCount := 0;

// Parsear nombres y parametros de procedimientos
   RegExp := TRegExpr.Create;
//   RegExp.Expression := 'to[\s]*([a-z][_a-z0-9]*)[\s]*(["]{1}[\w]+[\s]*)*';
   RegExp.Expression := 'to[\s]*([a-z][_a-z0-9]*)[\s\(]*([\w]+[\s]*)*[\)]*';
   RegExp.ModifierM := True;
   RegExp.ModifierI := True;
   RegExp.InputString := aSource;
   if RegExp.Exec then
   begin
     AddProc(RegExp.Match[1],RegExp.Match[2]);
     while RegExp.ExecNext do
	     AddProc(RegExp.Match[1],RegExp.Match[2]);
   end;

   try
(************************************************************
  change filename of compiled grammar or load from resource
************************************************************)
     if lParser.LoadCompiledGrammar(ExtractFilePath(Application.ExeName)+'CricketLogo.cgt') then begin
//     if LoadGrammarFromResource(lParser) then begin
        lParser.OpenTextString(aSource);
        lParser.TrimReductions := TRUE;
        lDone := False;
        while not lDone do begin
           lResponse := lParser.Parse;
           case lResponse of
{
             gpMsgTokenRead: begin
             //SDIAppForm.Memo.Lines.Add(lParser.CurrentToken.DataVar+IntToStr(lParser.CurrentToken.TableIndex));
                 case lParser.CurrentToken.TableIndex of
                      Rule_Statement_If_Lbracket_Rbracket:         	Inc(stackLevel);
                 end;
             end;
}
             gpMsgLexicalError: begin
               if Assigned(FOnError)
                 then FOnError('Line ' + IntToStr(lParser.CurrentLineNumber) +
                               ': Lexical Error: Cannot recognize token: ' +
                               lParser.CurrentToken.DataVar);
                 LineNumber := lParser.CurrentLineNumber;
               lDone := True;
             end;
             gpMsgSyntaxError: begin
               if Assigned(FOnError) then begin
                 lError := '';
                 for zToken := 0 to lParser.TokenCount - 1 do
                 lError := lError + ' ' + lParser.Tokens(zToken).Name;
                 FOnError('Line ' + IntToStr(lParser.CurrentLineNumber) +
                          ': Syntax Error: Expecting the following tokens: ' +
                          Trim(lError));
                 LineNumber := lParser.CurrentLineNumber;
               end; // if Assigned(FOnError)
               lDone := True;
             end;
             gpMsgReduction: begin
               ReplaceReduction(lParser);
               // Record linenumber for error messages in semantics check
               if lParser.CurrentReduction <> nil
                 then begin
                 	lParser.CurrentReduction.Tag := lParser.CurrentLineNumber;
                    LineNumber := lParser.CurrentLineNumber;
                 end;
             end;
             gpMsgAccept: begin
               //=== Success!
                for I := 0 to StaStack.Count - 1 do
                begin
                    L := StaStack.Items[i] as TIntList;
                    for j := 0 to L.IntCount - 1 do
                    begin
                        if (L.Integers[j] >= $8000) then
                        begin
                            ProcAddress := (ProcList.Objects[L.Integers[j+1]] as TProc).Address;
                            if L.Integers[j] = $8000 then
	                            L.Integers[j] := $80 + (ProcAddress shr 8)
                            else
	                            L.Integers[j] := $C0 + (ProcAddress shr 8);
                            L.Integers[j+1] := ProcAddress and $FF;
                            StaStack.Items[i] := L;
                        end;
                        CompiledHEX.Add(L.Integers[j]);
                    	//SDIAppForm.Memo.Lines.Add(IntToStr(L.Integers[j]));
 	                   //SDIAppForm.Memo.Lines.Add('-');
                    end
                end;
                ProgCount := CompiledHex.IntCount;
                with CompiledHex do
                begin
                    Insert(0,ProgCount and $FF);
                    Insert(0,ProgCount shr 8);
                    Insert(0,$85);
                    Insert(0,0);
                    Insert(0,0);
                	Insert(0,$83);
                    Add($83);
                    Add(ProgCount shr 8);
                    Add(ProgCount and $FF);
                    Add($85);
                    Add(0);
                    Add(3);
                    Add($80);
                    Add(0);
                    Add(0);
                    Add($83);
                    Add($0F);
                    Add($F0);
                    Add($85);
                    Add(0);
                    Add(2);
                    Add(ProgCount shr 8);
                    Add(ProgCount and $FF);
                end;

               (******************************************************************
                  enter code here
               *******************************************************************)
               lDone := True;
             end;
             gpMsgInternalError,
             gpMsgNotLoadedError: begin
               if Assigned(FOnError) then FOnError('Internal Parser error! Aborting!');
               lDone := True;
             end;
             gpMsgCommentError: begin
               if Assigned(FOnError)
                 then FOnError('Line ' + IntToStr(lParser.CurrentLineNumber) +
                               ': Syntax Error: Unexpected end of file!');
                 LineNumber := lParser.CurrentLineNumber;
               lDone := True;
             end;
           end;
        end;
     end else if Assigned(FOnError) then FOnError('Grammar could not be loaded!');
   finally
     lParser.Free;
   end; // try .. finally
end; // TCricketLogoParser.Execute

function TCricketLogoParser.LoadGrammarFromResource(aGoldParser: TGOLDParser) : Boolean;
var
  lMemStream : TMemoryStream;
  lResource : Pointer;
  lHandle   : Cardinal;

begin
  Result := TRUE;
  try
    lHandle := FindResource(0, 'GRAMMAR', RT_RCDATA);
    lResource := LockResource(LoadResource(0, lHandle));
    if lResource = nil then abort;
    lMemStream := TMemoryStream.Create;
    try
      lMemStream.WriteBuffer(lResource^, SizeofResource(0, lHandle));
      lMemStream.Position := 0;
     // if not aGoldParser.LoadCompiledGrammar(lMemStream) then abort;
    finally
      lMemStream.Free;
    end; // try .. finally
  except
    Result := FALSE;
  end; // try .. except
end; // TCricketLogoParser.LoadGrammarFromResource

procedure TCricketLogoParser.ReplaceReduction(aParser: TGOLDParser);
var
   i,j: integer;
   s: string;
   L,L1,L2,L3: TIntList;
   Motors: array[0..3] of byte;
   A: TArray;
begin
	L:= TIntList.CreateEx;
	L1:= TIntList.CreateEx;
	L2:= TIntList.CreateEx;
	L3:= TIntList.CreateEx;

//	for i := 0 to aParser.CurrentReduction.TokenCount - 1 do
//    	s := s + #32 + aParser.CurrentReduction.Tokens[i].DataVar +'('+ IntToStr(aParser.CurrentReduction.ParentRule.TableIndex) +')' ;
//    SDIAppForm.Memo.Lines.Add(s);


  case aParser.CurrentReduction.ParentRule.TableIndex of
    Rule_Procedures : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        StaStackPush(L);
    end; // <Procedures> ::= <Procedure> <Procedures>
    Rule_Procedures2 : begin

    end; // <Procedures> ::= <Procedure>
    RULE_PROCEDURE_TO_IDENTNAME_LPARAN_RPARAN_END : begin
    	s := LowerCase(aParser.CurrentReduction.Tokens[1].DataVar);
        if ProcStack.IndexOf(s) < 0 then
		begin
            L := StaStackPop;
            L.Insert(0,ParamStack.Count);
            ParamStack.Clear;
            L.Add(CSTOP);
            StaStackPush(L);
            ProcStack.Add(s);
            (ProcList.Objects[ProcList.IndexOf(s)] as TProc).Address := ProcAddress;
            ProcAddress := ProcAddress + L.IntCount;
            Inc(currentProcIndex);
        end else
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Procedure already declared');
                     abort;
          end;

    end; // <Procedure> ::= to ProcedureName <ParameterDeclarations> <Statements> end
    RULE_PROCEDURE_TO_IDENTNAME_END : begin
    	s := LowerCase(aParser.CurrentReduction.Tokens[1].DataVar);
        if ProcStack.IndexOf(s) < 0 then
		begin
	        L := StaStackPop;
            L.Insert(0,0);  // ZERO PARAMS
    	    L.Add(CSTOP);
        	StaStackPush(L);
            ProcStack.Add(s);
            (ProcList.Objects[ProcList.IndexOf(s)] as TProc).Address := ProcAddress;
            ProcAddress := ProcAddress + L.IntCount;
            Inc(currentProcIndex);
        end else
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Procedure already declared');
                     abort;
          end;

    end; // <Procedure> ::= to ProcedureName <Statements> end
    RULE_PARAMETERDECLARATIONS_COMMA : begin

    end; // <ParameterDeclarations> ::= <ParameterDeclaration> ',' <ParameterDeclarations>
    RULE_PARAMETERDECLARATIONS : begin

    end; // <ParameterDeclarations> ::= <ParameterDeclaration>
    RULE_PARAMETERDECLARATION_IDENTNAME : begin
    	s := aParser.CurrentReduction.Tokens[0].DataVar;
 //   	s := copy(s,2,Length(s));
        ParamStack.Add(s);
    end; // <ParameterDeclaration> ::= Receiver
    Rule_Statements : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        StaStackPush(L);
    end; // <Statements> ::= <Statement> <Statements>
    Rule_Statements2 : begin

    end; // <Statements> ::= <Statement>
    Rule_Statement_Return_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CRETURN);
    	StaStackPush(L);
    end; // <Statement> ::= return <Expression>
    Rule_Statement_Repeat_Lbracket_Rbracket : begin
        L1 := StaStackPop;
        L2 := StaStackPop;
        L := L2;
        L.Add(CLIST);
        L1 := StaStackPop;
        L.Add(L1.IntCount + 1);  // + EOL
        L := ListMerge(L,L1);
        L.Add(CEOL);
        L.Add(CREPEAT);
        StaStackPush(L);
    end; // <Statement> ::= repeat <Expression> '[' <Statements> ']'
    Rule_Statement_If_Lbracket_Rbracket : begin
        L1 := StaStackPop;
        L2 := StaStackPop;
        L := L2;
        L.Add(CLIST);
        L.Add(L1.IntCount + 1);
        L := ListMerge(L,L1);
        L.Add(CEOL);
        L.Add(CIF);
        StaStackPush(L);
    end; // <Statement> ::= if <Expression> '[' <Statements> ']'
    Rule_Statement_Ifelse_Lbracket_Rbracket_Lbracket_Rbracket : begin
        L1 := StaStackPop;
        L2 := StaStackPop;
        L3 := StaStackPop;
        L := L3;
        L.Add(CLIST);
        L.Add(L2.IntCount + 1);
        L := ListMerge(L,L2);
        L.Add(CEOL);
        L.Add(CLIST);
        L.Add(L1.IntCount + 1);
        L := ListMerge(L,L1);
        L.Add(CEOL);
        L.Add(CIFELSE);
        StaStackPush(L);
    end; // <Statement> ::= ifelse <Expression> '[' <Statements> ']' '[' <Statements> ']'
    RULE_STATEMENT_WAITUNTIL_LPARAN_RPARAN : begin
        L1 := StaStackPop;
        L.Add(CLIST);
        L.Add(L1.IntCount + 1);
        L := ListMerge(L,L1);
        L.Add(CEOLR);
        L.Add(CWAITUNTIL);
        StaStackPush(L);
    end; // <Statement> ::= waituntil '[' <Expression> ']'
    Rule_Statement_Forever_Lbracket_Rbracket : begin
        L1 := StaStackPop;
        L.Add(CLIST);
        L.Add(L1.IntCount + 1);
        L := ListMerge(L,L1);
        L.Add(CEOL);
        L.Add(CFOREVER);
        StaStackPush(L);
    end; // <Statement> ::= forever '[' <Statements> ']'
    Rule_Statement_Wait_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CWAIT);
    	StaStackPush(L);
    end; // <Statement> ::= wait <Expression>
    Rule_Statement_Stop : begin
    	L.Add(CSTOP);
    	StaStackPush(L);
    end; // <Statement> ::= stop
    RULE_STATEMENT_STOPEXCLAM : begin
    	L.Add(CREALLYSTOP);
    	StaStackPush(L);
    end; // <Statement> ::= stop
    Rule_Statement_Resett : begin
        L.Add(CRESETT);
        StaStackPush(L);
    end; // <Statement> ::= resett
    Rule_Statement_Send_LPARAN_RPARAN : begin

    end; // <Statement> ::= send <Expression>
    RULE_STATEMENT_SET_LPARAN_IDENTNAME_COMMA_RPARAN : begin
    	s := aParser.CurrentReduction.Tokens[1].DataVar;
 //   	s := copy(s,2,Length(s));
        if VarStack.IndexOf(s) >= 0 then
        begin
       	 i := VarStack.IndexOf(s);
         L := StaStackPop;
         L.Insert(0,i);
         L.Insert(0,CINT8);
         L.Add(CSETGLOBAL);
         StaStackPush(L);
        end	else
    	if VarStack.Count < GLOBALVARS then
        begin
         VarStack.Add(s);
         L := StaStackPop;
         L.Insert(0,VarStack.Count - 1);
         L.Insert(0,CINT8);
         L.Add(CSETGLOBAL);
         StaStackPush(L);
        end else
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Too many variables in stack');
                     Abort;
          end;

    end; // <Statement> ::= make Receiver <Expression>
    RULE_STATEMENT_LIST_LPARAN_IDENTNAME_COMMA_RPARAN : begin
    	s := aParser.CurrentReduction.Tokens[2].DataVar;
//        i := StrToInt(aParser.CurrentReduction.Tokens[4].DataVar);
        L := StaStackPop;
        i := L.Integers[1];
 //   	s := copy(s,2,Length(s));
        if ArrayStack.IndexOf(s) >= 0 then
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Array already declared');
                     Abort;
          end;
        if ArraySizeCheck + i > ARRAYSIZE then
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Array Maximum Size Exceed ('+IntToStr(ARRAYSIZE)+' Bytes)');
                     Abort;
          end;
    	ArraySizeCheck := ArraySizeCheck + i;
    	A := TArray.Create;
        A.Size := i;
        A.Address := ArrayNextAddress;
        ArrayNextAddress := ArrayNextAddress + i;
        ArrayStack.AddObject(s,A);
       	StaStackPush(L1); // VACIO PORQUE ES UNA DECLARACION INTERNA
    end; //  <Statement> ::= list '(' Receiver ',' NumberLiteral ')'
    RULE_STATEMENT_SETITEM_LPARAN_IDENTNAME_COMMA_COMMA_RPARAN : begin
    	s := aParser.CurrentReduction.Tokens[2].DataVar;
        if ArrayStack.IndexOf(s) >= 0 then
        begin
            A := ArrayStack.Objects[ArrayStack.IndexOf(s)] as TArray;
            L2 := StaStackPop;
            L1 := StaStackPop;
            L := ListMerge(L2,L1);
            L.Add(CINT8);
            L.Add(A.Address);
            L.Add(CASET);
            StaStackPush(L);
        end else
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: List not declared');
                     Abort;
          end;
    end; //  <Statement> ::= setitem '(' IdentName ',' <Expression> ',' <Expression> ')'
    RULE_STATEMENT_MOTORATTENTION: begin
    	s := aParser.CurrentReduction.Tokens[0].DataVar;
        for i := 0 to Length(s) - 1 do
        begin
            case s[i] of
            	'a': Motors[0] := 1;
                'b': Motors[1] := 2;
                'c': Motors[2] := 4;
                'd': Motors[3] := 8;
            end;
        end;
        for i := 0 to 3 do j := j + Motors[i];
        L.Add(1);
        L.Add(j);
    	L.Add(CTALK_TO_MOTOR);
    	StaStackPush(L);
    end; // <Statement> ::= MotorAttention
    Rule_Statement_Output_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CTALK_TO_MOTOR);
    	StaStackPush(L);
    end; // <Statement> ::= output
    Rule_Statement_On : begin
    	L.Add(CON);
    	StaStackPush(L);
    end; // <Statement> ::= on
    Rule_Statement_Onfor_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CONFOR);
    	StaStackPush(L);
    end; // <Statement> ::= onfor <Expression>
    Rule_Statement_Off : begin
    	L.Add(COFF);
    	StaStackPush(L);
    end; // <Statement> ::= off
    Rule_Statement_Thisway : begin
    	L.Add(CTHISWAY);
    	StaStackPush(L);
    end; // <Statement> ::= thisway
    Rule_Statement_Thatway : begin
    	L.Add(CTHATWAY);
    	StaStackPush(L);
    end; // <Statement> ::= thatway
    Rule_Statement_Rd : begin
    	L.Add(CRD);
    	StaStackPush(L);
    end; // <Statement> ::= rd
    Rule_Statement_Brake : begin
    	L.Add(CBRAKE);
    	StaStackPush(L);
    end; // <Statement> ::= break
    Rule_Statement_Servo_Set_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CSERVO_SET);
    	StaStackPush(L);
    end; // <Statement> ::= servo_set <Expression>
    Rule_Statement_Servo_Lt_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CSERVO_LT);
    	StaStackPush(L);
    end; // <Statement> ::= servo_lt <Expression>
    Rule_Statement_Servo_Rt_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CSERVO_RT);
    	StaStackPush(L);
    end; // <Statement> ::= servo_rt <Expression>
    Rule_Statement_Pap_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CPAP);
    	StaStackPush(L);
    end; // <Statement> ::= pap <Expression>
    Rule_Statement_Papsteps_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CPAPSTEPS);
    	StaStackPush(L);
    end; // <Statement> ::= papsteps <Expression>
    Rule_Statement_PapSpeed_LPARAN_RPARAN : begin
    	L := StaStackPop;
    	L.Add(CPAPSPEED);
    	StaStackPush(L);
    end; // <Statement> ::= papspeed <Expression>
    Rule_Statement_Setpower_LPARAN_RPARAN : begin
        L:= StaStackPop;
        L.Add(CSETPOWER);
        StaStackPush(L);
    end; // <Statement> ::= setpower <Expression>
    Rule_Statement : begin

    end; // <Statement> ::= <ProcedureCall>
    Rule_Expression_And : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CAND);
        StaStackPush(L);
    end; // <Expression> ::= <Expression> and <Com Exp>
    Rule_Expression_Or : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(COR);
        StaStackPush(L);
    end; // <Expression> ::= <Expression> or <Com Exp>
    Rule_Expression_Xor : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CXOR);
        StaStackPush(L);
    end; // <Expression> ::= <Expression> xor <Com Exp>
    Rule_Expression : begin

    end; // <Expression> ::= <Com Exp>
    Rule_Comexp_Gt : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CGT);
        StaStackPush(L);
    end; // <Com Exp> ::= <Com Exp> '>' <Add Exp>
    Rule_Comexp_Lt : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CLT);
        StaStackPush(L);
    end; // <Com Exp> ::= <Com Exp> '<' <Add Exp>
    Rule_Comexp_Eq : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CEQUAL);
        StaStackPush(L);
    end; // <Com Exp> ::= <Com Exp> '=' <Add Exp>
    Rule_Comexp : begin

    end; // <Com Exp> ::= <Add Exp>
    Rule_Addexp_Plus : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CPLUS);
        StaStackPush(L);
    end; // <Add Exp> ::= <Add Exp> '+' <Mult Exp>
    Rule_Addexp_Minus : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CMINUS);
        StaStackPush(L);
    end; // <Add Exp> ::= <Add Exp> '-' <Mult Exp>
    Rule_Addexp : begin

    end; // <Add Exp> ::= <Mult Exp>
    Rule_Multexp_Times : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CMULT);
        StaStackPush(L);
    end; // <Mult Exp> ::= <Mult Exp> '*' <Negate Exp>
    Rule_Multexp_Div : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CDIV);
        StaStackPush(L);
    end; // <Mult Exp> ::= <Mult Exp> '/' <Negate Exp>
    Rule_Multexp_Percent : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CMOD);
        StaStackPush(L);
    end; // <Mult Exp> ::= <Mult Exp> '%' <Negate Exp>
    Rule_Multexp : begin

    end; // <Mult Exp> ::= <Negate Exp>
    Rule_Negateexp_Minus : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CNEG);
        StaStackPush(L);
    end; // <Negate Exp> ::= '-' <Value>
    Rule_Negateexp_Not : begin
        L := StaStackPop;
        L := ListMerge(StaStackPop,L);
        L.Add(CNEG);
        StaStackPush(L);
    end; // <Negate Exp> ::= not <Value>
    Rule_Negateexp : begin

    end; // <Negate Exp> ::= <Value>
    Rule_Value_Reporter : begin
    	s := aParser.CurrentReduction.Tokens[0].DataVar;
    	s := copy(s,2,Length(s));
        if ParamStack.IndexOf(s) >= 0then
        begin
       	 i := ParamStack.IndexOf(s);
         L.Add(CLTHING);
         L.Add(i);
         StaStackPush(L);
        end else
        if VarStack.IndexOf(s) >= 0 then
        begin
       	 i := VarStack.IndexOf(s);
         L.Add(CINT8);
         L.Add(i);
         L.Add(CGLOBAL);
         StaStackPush(L);
        end	else
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Variable is not declared');
                     Abort;
          end;
    end; // <Value> ::= Reporter
    Rule_Value : begin

    end; // <Value> ::= <ProcedureCall>
    Rule_Value_Numberliteral : begin
        i := StrToInt(aParser.CurrentReduction.Tokens[0].DataVar);
        if (i >= 0) and (i < 256) then
        begin
            L.Add(CINT8);
            L.Add(i);
        end else
        if (i >= 256) and (i < 65536) then
        begin
            L.Add(CINT16);
    		L.Add((i and 65280) shr 8);
    		L.Add(i and 255);
        end else
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Integer out of range');
                     Abort;
          end;
        StaStackPush(L);
    end; // <Value> ::= NumberLiteral
    Rule_Value_Lparan_Rparan : begin

    end; // <Value> ::= '(' <Expression> ')'
    Rule_Value_Timer : begin
        L.Add(CTIMER);
        StaStackPush(L);
    end; // <Value> ::= timer
    Rule_Value_Serial : begin

    end; // <Value> ::= serial
    Rule_Value_Newserialquestion : begin

    end; // <Value> ::= 'newserial?'
    Rule_Value_Random : begin
        L.Add(CRANDOM);
        StaStackPush(L);
    end; // <Value> ::= random
    Rule_Value_Recall : begin

    end; // <Value> ::= recall
    Rule_Value_Sensor1 : begin
        L.Add(CSENSOR1);
        StaStackPush(L);
    end; // <Value> ::= 'sensor1'
    Rule_Value_Sensor2 : begin
        L.Add(CSENSOR2);
        StaStackPush(L);
    end; // <Value> ::= 'sensor2'
    Rule_Value_Sensor3 : begin
        L.Add(CSENSOR3);
        StaStackPush(L);
    end; // <Value> ::= 'sensor3'
    Rule_Value_Sensor4 : begin
        L.Add(CSENSOR4);
        StaStackPush(L);
    end; // <Value> ::= 'sensor4'
    Rule_Value_Sensor5 : begin
        L.Add(CSENSOR5);
        StaStackPush(L);
    end; // <Value> ::= 'sensor5'
    Rule_Value_Sensor6 : begin
        L.Add(CSENSOR6);
        StaStackPush(L);
    end; // <Value> ::= 'sensor6'
    Rule_Value_Sensor7 : begin
        L.Add(CSENSOR7);
        StaStackPush(L);
    end; // <Value> ::= 'sensor7'
    Rule_Value_Sensor8 : begin
        L.Add(CSENSOR8);
        StaStackPush(L);
    end; // <Value> ::= 'sensor8'
    Rule_Value_Switch1 : begin
        L.Add(CSWITCH1);
        StaStackPush(L);
    end; // <Value> ::= 'switch1'
    Rule_Value_Switch2 : begin
        L.Add(CSWITCH2);
        StaStackPush(L);
    end; // <Value> ::= 'switch2'
    Rule_Value_Switch3 : begin
        L.Add(CSWITCH3);
        StaStackPush(L);
    end; // <Value> ::= 'switch3'
    Rule_Value_Switch4 : begin
        L.Add(CSWITCH4);
        StaStackPush(L);
    end; // <Value> ::= 'switch4'
    Rule_Value_Switch5 : begin
        L.Add(CSWITCH5);
        StaStackPush(L);
    end; // <Value> ::= 'switch5'
    Rule_Value_Switch6 : begin
        L.Add(CSWITCH6);
        StaStackPush(L);
    end; // <Value> ::= 'switch6'
    Rule_Value_Switch7 : begin
        L.Add(CSWITCH7);
        StaStackPush(L);
    end; // <Value> ::= 'switch7'
    Rule_Value_Switch8 : begin
        L.Add(CSWITCH8);
        StaStackPush(L);
    end; // <Value> ::= 'switch8'
    Rule_Value_I2c_read_LPARAN_RPARAN : begin

    end; // <Value> ::= 'i2c_read' <Expression>
    Rule_Value_Highbyte_LPARAN_RPARAN : begin

    end; // <Value> ::= highbyte <Expression>
    Rule_Value_Lowbyte_LPARAN_RPARAN : begin

    end; // <Value> ::= lowbyte <Expression>
    RULE_VALUE_ITEM_LPARAN_IDENTNAME_COMMA_RPARAN : begin
    	s := LowerCase(aParser.CurrentReduction.Tokens[2].DataVar);
        if ArrayStack.IndexOf(s) >= 0 then
        begin
            A := ArrayStack.Objects[ArrayStack.IndexOf(s)] as TArray;
            L := StaStackPop;
            L.Add(CINT8);
            L.Add(A.Address);
            L.Add(CAGET);
            StaStackPush(L);
        end else
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: List not declared');
                     Abort;
          end;
    end;//  <Value> ::= item '(' IdentName ',' <Expression> ')'
    RULE_PROCEDURECALL_IDENTNAME_LPARAN_RPARAN : begin
      // PROCEDIMIENTOS LOGO
    	s := LowerCase(aParser.CurrentReduction.Tokens[0].DataVar);
        if ProcList.IndexOf(s) >= 0 then
        begin
        	if (ProcList.Objects[ProcList.IndexOf(s)] as TProc).Params > 0 then
            begin
            	if StaStack.Count > 0 then
	                L := ListMerge(StaStackPop,L)
                else
                if Assigned(FOnError)
                  then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                               ': Compiler Error: Stack empty');
		                     Abort;
                  end;
            end;
            if currentProcIndex = ProcList.IndexOf(s) then
            	L.Add($C000)  // LLAMADA A PROCEDIMIENTO CON RECURSION -> REEMPLAZAR POR $C0
            else
            	L.Add($8000);  // LLAMADA A PROCEDIMIENTO -> REEMPLAZAR POR $80
            L.Add(ProcList.IndexOf(s)); // VALOR PARA REEMPLAZAR POR LA DIRECCION
            StaStackPush(L);
        end else
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Procedure not declared');
                     Abort;
          end;
    end; // <ProcedureCall> ::= ProcedureName <Parameters>
    RULE_PROCEDURECALL_IDENTNAME : begin
      // PROCEDIMIENTOS LOGO
    	s := LowerCase(aParser.CurrentReduction.Tokens[0].DataVar);
        if ProcList.IndexOf(s) >= 0 then
        begin
            if currentProcIndex = ProcList.IndexOf(s) then
            	L.Add($C000)  // LLAMADA A PROCEDIMIENTO CON RECURSION -> REEMPLAZAR POR $C0
            else
            	L.Add($8000);  // LLAMADA A PROCEDIMIENTO -> REEMPLAZAR POR $80
            L.Add(ProcList.IndexOf(s)); // VALOR PARA REEMPLAZAR POR LA DIRECCION
            StaStackPush(L);
        end else
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Procedure not declared');
                     Abort;
          end;
    end; // <ProcedureCall> ::= ProcedureName
    RULE_MOTORLISTITEMS_NUMBERLITERAL : begin
       i := StrToInt(aParser.CurrentReduction.Tokens[0].DataVar);
       if not (i in [1,2,3,4]) then
       begin
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Invalid Output Number');
                     Abort;
       	end;
       end;
       L.Add(i);
       StaStackPush(L);
    end; //  <MotorListItems> ::= NumberLiteral
    RULE_MOTORLISTITEMS_COMMA_NUMBERLITERAL : begin
       i := StrToInt(aParser.CurrentReduction.Tokens[2].DataVar);
       if not (i in [1,2,3,4]) then
       begin
        if Assigned(FOnError)
          then begin FOnError('Line ' + IntToStr(aParser.CurrentLineNumber) +
                       ': Compiler Error: Invalid Output Number');
                     Abort;
       	end;
       end;
       L1 := StaStackPop;
       L.Add(i);
       L := ListMerge(L1,L);
       StaStackPush(L);
    end; //  <MotorListItems> ::= <MotorListItems> ',' NumberLiteral
    RULE_MOTORLIST_LBRACKET_RBRACKET : begin
        L1 := StaStackPop;
        for i := 0 to L1.IntCount - 1 do
        begin
            case L1.Integers[i] of
            	1: Motors[0] := 1;
                2: Motors[1] := 2;
                3: Motors[2] := 4;
                4: Motors[3] := 8;
            end;
        end;
        for i := 0 to 3 do j := j + Motors[i];
        L.Add(j);
        StaStackPush(L);
    end; //  <MotorList> ::= '[' <MotorListItems> ']'
    RULE_PARAMETERS_COMMA : begin
       L1 := StaStackPop;
       L2 := StaStackPop;
       L := ListMerge(L2,L1);
       StaStackPush(L);
    end; // <Parameters> ::= <Parameter> <Parameters>
    Rule_Parameters : begin

    end; // <Parameters> ::= <Parameter>
    Rule_Parameter : begin

    end; // <Parameter> ::= <Expression>
  end; // case aParser.CurrentReduction.ParentRule.TableIndex
//  L.Free;  L1.Free;  L2.Free;  L3.Free;
end; // TCricketLogoParser.ReplaceReduction

end.
