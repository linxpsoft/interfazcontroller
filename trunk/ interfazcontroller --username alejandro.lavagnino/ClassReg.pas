(*  GREATIS RUNTIME FUSION COMPLETE DEMO      *)
(*  Copyright (C) 2003-2004 Greatis Software  *)
(*  http://www.greatis.com/delphicb/runtime/  *)
(*  http://www.greatis.com/bteam.html         *)

unit ClassReg;

interface

implementation

uses Scripter, Controls, StdCtrls;

initialization
  RegisterType(TypeInfo(TControl),SizeOf(TControl));
    RegisterMethod(TControl.ClassName,'procedure Hide;',@TControl.Hide);
end.
