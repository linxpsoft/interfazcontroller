unit FAState;

{
'================================================================================
' Class Name:
'      FAState
'
' Instancing:
'      Private; Internal  (VB Setting: 1 - Private)
'
' Purpose:
'      Represents a state in the Deterministic Finite Automata which is used by
'      the tokenizer.
'
' Author(s):
'      Devin Cook
'      GOLDParser@DevinCook.com
'
' Dependacies:
'      FAEdge
'
'================================================================================
 Conversion to Delphi:
      Beany
      Beany@cloud.demon.nl

 Conversion status: Done, not tested
}

interface

uses
   Classes, SysUtils, Dialogs;

type

   PFAEdge = ^TFAEdge;
   TFAEdge = record
      Characters: Integer;
      TargetIndex: Integer;
   end;

   TFAState = class
   private
      FEdges: TList;
      FAcceptSymbol: Integer;
      function GetEdgeCount: Integer;
   public
      constructor Create;
      destructor Destroy; override;
      procedure AddEdge(Characters: string; Target: Integer);
      function Edge(Index: Integer): TFAEdge;
      property AcceptSymbol: Integer read FAcceptSymbol write FAcceptSymbol;
      property EdgeCount: Integer read GetEdgeCount;
   end;

implementation

constructor TFAState.Create;
begin
   inherited Create;

   FEdges := TList.Create;

end;

destructor TFAState.Destroy;
var
   n: Integer;
begin

   for n := 0 to FEdges.Count - 1 do
      Dispose(FEdges.Items[n]);

   FEdges.Free;

   inherited Destroy;
end;

procedure TFAState.AddEdge(Characters: string; Target: Integer);
var
   NewEdge: PFAEdge;
   Index: Integer;
   n: Integer;
begin

   if Characters = '' then
   begin
      New(NewEdge);

      //NewEdge^.Characters := ''; //?? Its declared as an Integer in the original VB code!!
      NewEdge^.Characters := 0;
      NewEdge^.TargetIndex := Target;
      FEdges.Add(NewEdge);
   end else
   begin
      Index := -1;
      n := 0;
      while (n < FEdges.Count) and (Index = -1) do
      begin
         if PFAEdge(FEdges.Items[n])^.TargetIndex = Target then
             Index := n;

         n := n + 1;
      end;

      if Index = -1 then
      begin
         New(NewEdge);
         NewEdge^.Characters := StrToInt(Characters);
         NewEdge^.TargetIndex := Target;
         FEdges.Add(NewEdge);
      end else
         PFAEdge(FEdges.Items[Index])^.Characters := StrToInt(IntToStr(PFAEdge(FEdges.Items[Index])^.Characters) + Characters);

   end;

end;

function TFAState.GetEdgeCount: Integer;
begin

   Result := FEdges.Count;

end;

function TFAState.Edge(Index: Integer): TFAEdge;
begin

   Result := PFAEdge(FEdges.Items[Index])^;

end;

end.
