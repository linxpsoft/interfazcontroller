unit SourceFeeder;

interface

uses
   Classes;

type

   TSourceFeeder = class
   private
      FText: string;
      FPointer: Integer;
   public
      constructor Create;
      function ReadFromBuffer(Size: Integer; DiscardReadText: Boolean; ReturnAllText: Boolean): String;
      function Done: Boolean;
      function ReadLine: String;
      property Text: string read FText write FText;
   end;

implementation

constructor TSourceFeeder.Create;
begin
   FPointer := 1;
end;

function TSourceFeeder.Done: Boolean;
begin

   Result := FPointer >= Length(FText);

end;

function TSourceFeeder.ReadFromBuffer(Size: Integer; DiscardReadText: Boolean; ReturnAllText: Boolean): String;
var
   Available: Integer;
begin
   //This function takes data from the buffer and creates a string of the
   //appropiate size. This can be destructive (advanced position) or not

   //22 April 2002
   //Delphi version: Fix a bug here, 'FPointer' changed to 'FPointer - 1'. The
   //last byte of the input source wasnt returned. Now it does :)
   if (FPointer - 1) + Size > Length(FText) then
      Available := Length(FText) - FPointer
   else
      Available := Size;


   if ReturnAllText then
      Result := copy(FText, FPointer, Available)    //Get data
   else if Available >= Size then
      Result := copy(FText, FPointer + Size - 1, 1)
   else
      ReadFromBuffer := '';


   if DiscardReadText then
      FPointer := FPointer + Available;


end;

function TSourceFeeder.ReadLine: String;
var
   EndReached: Boolean;
   ch: string;
begin

   EndReached := False;
   while not (EndReached) and (not Done) do
   begin
      ch := ReadFromBuffer(1, True, True);
      if (ch = #10) or (ch = #13) then         //End char
      begin
          ch := ReadFromBuffer(1, False, True);
          if (ch = #10) or (ch = #13) then     //Discard second of line-feed, carriage return pair
              ReadFromBuffer(1, True, True);

          EndReached := True;
      end else
          Result := Result + ch;

   end;

end;

end.
