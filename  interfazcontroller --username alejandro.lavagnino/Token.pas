unit Token;

{
'================================================================================
' Class Name:
'      Token
'
' Instancing:
'      Public; Creatable  (VB Setting: 5 - MultiUse)
'
' Purpose:
'       While the Symbol represents a class of terminals and nonterminals, the
'       Token represents an individual piece of information.
'       Ideally, the token would inherit directly from the Symbol Class, but do to
'       the fact that Visual Basic 5/6 does not support this aspect of Object Oriented
'       Programming, a Symbol is created as a member and its methods are mimicked.
'
' Author(s):
'      Devin Cook
'      GOLDParser@DevinCook.com
'
' Dependacies:
'      Symbol class
'
'================================================================================
 Conversion to Delphi:
      Beany
      Beany@cloud.demon.nl

 Conversion status: Done, not tested
}

interface

uses
   Symbol, SysUtils;

type
   TToken = class
   private
      pState: Integer;
      pDataVar: string;
      pDataObj: Pointer;
      pParentSymbol: TSymbol;
      function GetKind: TSymbolTypeConstants;
      function GetName: string;
      function GetParentSymbol: TSymbol;
      procedure SetParentSymbol(Value: TSymbol);
      function GetDataVar: string;
      procedure SetdataVar(Value: string);
      function GetDataObj: Pointer;
      procedure SetdataObj(Value: Pointer);
      function GetTableIndex: Integer;
      function GetText: string;
      function GetState: Integer;
      procedure SetState(Value: Integer);
   public
      constructor Create;
      destructor Destroy; override;
      property Kind: TSymbolTypeConstants read GetKind;
      property Name: string read GetName;
      property ParentSymbol: TSymbol read GetParentSymbol write SetParentSymbol;
      property DataVar: string read GetDataVar write SetDataVar;
      property DataObj: Pointer read GetDataObj write SetDataObj;
      property TableIndex: Integer read GetTableIndex;
      property Text: string read GetText;
      property State: Integer read GetState write SetState;
   end;

implementation

constructor TToken.Create;
begin
   inherited Create;

   pDataVar := '0'; // ???
   //pDataObj := nil;
end;

destructor TToken.Destroy;
begin

   pDataVar := '';
   TObject(pDataObj).Free;
   pDataObj := nil;

   inherited Destroy;

end;

function TToken.GetKind: TSymbolTypeConstants;
begin
   Result := pParentSymbol.Kind;
end;

function TToken.GetName: string;
begin
   Result := pParentSymbol.Name;
end;

function TToken.GetParentSymbol: TSymbol;
begin
   Result := pParentSymbol;
end;

procedure TToken.SetParentSymbol(Value: TSymbol);
begin
   if pParentSymbol <> Value then
      pParentSymbol := Value;
end;

function TToken.GetDataVar: string;
begin
   Result := pDataVar;
end;

procedure TToken.SetdataVar(Value: string);
begin
   if pDataVar <> Value then
      pDataVar := Value;
end;

function TToken.GetDataObj: Pointer;
begin
   Result := pDataObj;
end;

procedure TToken.SetdataObj(Value: Pointer);
begin
   if pDataObj <> Value then
      pDataObj := Value;
end;

function TToken.GetTableIndex: Integer;
begin
   Result := pParentSymbol.TableIndex;
end;

function TToken.GetText: string;
begin
   Result := pParentSymbol.Text;
end;

function TToken.GetState: Integer;
begin
   Result := pState;
end;

procedure TToken.SetState(Value: Integer);
begin
   if pState <> Value then
      pState := Value;
end;

end.
