program wallet;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Autorisation in 'Autorisation.pas' {Autor},
  wrk in 'wrk.pas' {Work},
  Message in 'Message.pas' {Msge};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAutor, Autor);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TWork, Work);
  Application.CreateForm(TMsge, Msge);
  Application.Run;
end.
