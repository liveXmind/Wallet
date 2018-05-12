program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  S1 in 'S1.pas' {Step1},
  S2 in 'S2.pas' {Step2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TStep1, Step1);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TStep2, Step2);
  Application.Run;
end.
