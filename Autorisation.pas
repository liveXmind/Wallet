unit Autorisation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TAutor = class(TForm)
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Panel3: TPanel;
    Label7: TLabel;
    Button2: TButton;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Autor: TAutor;

//procedure CheckVL1();

implementation

uses Unit1;

{$R *.dfm}

function gen(x1,x2:longint):int64;
const p1=100000;
var l,h:int64;m:real;
begin
     m:=time*p1+random;
     h:=trunc(m);
     m:=m-h;
     l:=trunc(m*p1);
     gen:=l*(x2-x1+1)div (p1)+x1;
end;

procedure TAutor.FormShow(Sender: TObject);
var VL1,s:string;
begin
       form1.Button1.Click;
       button2.Visible:=true;
       //form1.Show;
end;

procedure TAutor.Button1Click(Sender: TObject);
var VL1,s:string;       //'471340'
begin
       label9.Caption:='****';
       s:='CheckPin'+' '+ConnectionName+' '+go.ID+' <'+edit1.Text+'> '+' <'+edit2.Text+'> <'+label9.Caption+'> ';
       form1.ClientSocket1.Socket.SendText(s+#13) ;
       if length(edit1.Text)<6 then if form1.ClientSocket1.Active then  panel1.Caption:='Waiting for the key';
end;

procedure TAutor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
application.Terminate;
end;

procedure TAutor.FormCreate(Sender: TObject);
begin
//     edit1.Text:='';
//     edit2.Text:='';
end;

procedure TAutor.Button2Click(Sender: TObject);
var s:string;       //'471340'
begin
       button2.Visible:=false;
       label9.Caption:=inttostr(gen(1000,9999));
       s:='CheckPin'+' '+ConnectionName+' '+go.ID+' <'+edit1.Text+'> '+' <'+edit2.Text+'> <'+label9.Caption+'> ';
       form1.ClientSocket1.Socket.SendText(s+#13) ;
end;

end.
