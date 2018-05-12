unit S1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, z_lib, jpeg, ExtCtrls, s2;

type
  TStep1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Image1: TImage;
    Image2: TImage;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Memo2: TMemo;
    Label1: TLabel;
    Image3: TImage;
    StaticText3: TStaticText;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Step1: TStep1;
  ly:integer;
  tlk:Tstringlist;
  
procedure CheckDrive;

implementation

uses unit1;

{$R *.dfm}

procedure CheckDrive;
begin  with Step1 do begin
    ltr:='';
    GetDrive(ltr);
    if ltr<>'' then begin
    //tlk.text:=memo2.text;
    memo2.Lines.Clear;
    memo2.Text:='Извлеките все USB накопители и нажмите ОК';
    StaticText2.Visible:=false;image2.Visible:=false;
    timer1.Enabled:=true;
    end else begin
    timer1.Enabled:=false;
    StaticText2.Visible:=true;
    image2.Visible:=true;
    memo2.text:=tlk.text;
    DS.step:=0;
    end;
end end;

procedure TStep1.Button1Click(Sender: TObject);
begin
    memo1.Text:=GetVintID('c:');
end;

procedure TStep1.FormShow(Sender: TObject);
begin
    Form1.Button1.Click;
    CheckDrive;
end;

procedure TStep1.Image2Click(Sender: TObject);
begin
    step2.show;
    visible:=false;
end;


procedure TStep1.Timer1Timer(Sender: TObject);
begin
    Timer1.Enabled:=false;
    CheckDrive;
end;

procedure TStep1.FormCreate(Sender: TObject);
begin
    //ly:=left;
    //left:=-1000;
    tlk:=Tstringlist.Create;
    tlk.text:=memo2.text;
end;

procedure TStep1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    tlk.Free;
end;

end.
