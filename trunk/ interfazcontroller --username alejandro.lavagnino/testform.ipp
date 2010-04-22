uses test;
procedure Handler(Sender);
begin
  print "Hello from paxScript!";
end;

begin
frm := TFrm.Create(nil);
frm.Button1.OnClick := Handler;
end.


