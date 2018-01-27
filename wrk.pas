unit wrk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DateUtils, jpeg;

type
  TWork = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel9: TPanel;
    Panel10: TPanel;
    Edit1: TEdit;
    Panel11: TPanel;
    Panel12: TPanel;
    Edit2: TEdit;
    Label4: TLabel;
    Panel13: TPanel;
    Panel14: TPanel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label5: TLabel;
    Panel15: TPanel;
    Panel16: TPanel;
    Edit4: TEdit;
    Panel17: TPanel;
    Panel18: TPanel;
    Label6: TLabel;
    Edit5: TEdit;
    Panel19: TPanel;
    Panel20: TPanel;
    Edit6: TEdit;
    Button3: TButton;
    Button4: TButton;
    luu: TListView;
    Button5: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lv2: TListView;
    TabSheet5: TTabSheet;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Memo1: TMemo;
    Panel25: TPanel;
    Panel26: TPanel;
    Memo2: TMemo;
    TabSheet6: TTabSheet;
    Panel27: TPanel;
    Memo3: TMemo;
    Panel28: TPanel;
    ComboBox1: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Button6: TButton;
    Button7: TButton;
    Label12: TLabel;
    ListView3: TListView;
    ListView1: TListView;
    TabSheet7: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Panel37: TPanel;
    Label17: TLabel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel40: TPanel;
    Panel41: TPanel;
    Image1: TImage;
    Label13: TLabel;
    Memo4: TMemo;
    Panel29: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    Panel33: TPanel;
    Edit7: TEdit;
    Button9: TButton;
    Panel34: TPanel;
    Edit8: TEdit;
    Label18: TLabel;
    Edit9: TEdit;
    Button8: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label13Click(Sender: TObject);
    procedure Panel30MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel30MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel30Click(Sender: TObject);
    procedure Panel39Click(Sender: TObject);
    procedure Panel38Click(Sender: TObject);
    procedure Panel29Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure lv2ColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv2SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Work: TWork;

procedure OutEp1(line:string);

implementation

uses Unit1, Autorisation;

{$R *.dfm}

function  GetExePath:string;
var i:word;s:string;
begin
   s:=Paramstr(0);
   for i:=length(s) downto 1 do
   if (s[i]='\')or(s[i]=':') then begin
   setlength(s,i);
   GetExePath:=s;
   exit;
   end;
end;

procedure OutEp1(line:string);
var ListItem:TListItem;s,s1,s2:string;R1,R2,p:real;k,d,dd:integer;address,category,time,amount,confirm,txid:string;
    str:StrArray;N:word;
begin with Work do begin
    String_to_array(line,str,N);
    address:=str[1];category:=str[2];time:=str[3];amount:=str[4];confirm:=str[5];txid:=str[6];
    ListItem := lv2.Items.Add;
    ListItem.Caption :=address;
    ListItem.SubItems.Add(txid);
    ListItem.SubItems.Add(datetimetostr(UnixToDateTime(strtoint(time))));
    ListItem.SubItems.Add(amount);
    ListItem.SubItems.Add(category);
    ListItem.SubItems.Add(confirm);
end end;

procedure TWork.FormShow(Sender: TObject);
begin
    lv2.Columns[1].Width:=0 ;
    Autor.visible:=false;
    Label13Click(sender);
Autor.edit1.Text:='';
Autor.edit2.Text:='';
end;

procedure TWork.Button2Click(Sender: TObject);
begin
     edit4.Text:='';
     edit5.Text:='0,0';
     //edit3.Text:='';
end;

procedure TWork.Button7Click(Sender: TObject);
begin
    memo3.Lines.Clear;
end;

procedure TWork.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Autor.close;//application.Terminate;
end;

procedure TWork.Label13Click(Sender: TObject);
var s:string;
begin
     label13.Visible:=false;
     s:='GetWaletFullInfo'+' '+ConnectionName+' '+go.UrundomKey+' ';//+'test';//+' ';
     Form1.SendToServer(s);
end;

procedure TWork.Panel30MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    Panel30.Color:=$004080FF;
end;

procedure TWork.Panel30MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    Panel30.Color:=$00B9DCFF;
end;

procedure TWork.Panel30Click(Sender: TObject);
var s:string;
begin
     s:='CreateNewAdres'+' '+ConnectionName+' '+go.UrundomKey+' '+'*';//+' ';
     Form1.SendToServer(s);
end;

procedure TWork.Panel39Click(Sender: TObject);
begin
    memo4.Text:='list is empty';

end;

procedure TWork.Panel38Click(Sender: TObject);
var s:string;
begin
     memo4.Lines.Clear;
     s:='GetCloudAdreses'+' '+ConnectionName+' '+go.UrundomKey+' '+'*';//+' ';
     Form1.SendToServer(s);
end;

procedure TWork.Panel29Click(Sender: TObject);
begin
     memo4.Lines.Clear;
end;

procedure TWork.Button3Click(Sender: TObject);
var s:string;
begin
    // Perhaps you need a call back here to ensure the privacy of the transaction
     memo4.Lines.Clear;
     if length(edit4.Text)<>34 then begin showmessage('Invalid Address!');exit;end;
     if strtofloatdef(edit5.Text,0)<=0.00001 then begin showmessage('Invalid amount!');exit;end;
     if strtointdef(edit7.Text,0)<=0 then begin showmessage('Invalid Confirmation Num.!');exit;end;
     s:='SendFrom'+' '+ConnectionName+' '+go.UrundomKey+' '+Edit4.text+' '+Edit5.text+' '+Edit7.text;//+' ';
     Form1.SendToServer(s);
     edit5.Text:='0,0';
end;

procedure TWork.Button9Click(Sender: TObject);
var s:string;
begin
     lv2.Items.Clear;
     memo4.Lines.Clear;
     s:='listtransactions'+' '+ConnectionName+' '+go.UrundomKey+' *';//+' ';
     Form1.SendToServer(s);
end;

procedure TWork.lv2ColumnClick(Sender: TObject; Column: TListColumn);
begin
     if lv2.Columns[1].Width>0 then lv2.Columns[1].Width:=0 else lv2.Columns[1].Width:=550;
end;

procedure TWork.lv2SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
    edit8.Text:=item.SubItems.Strings[0];
end;

procedure TWork.Button6Click(Sender: TObject);
var s:string;
begin
     s:='SndMsg'+' '+ConnectionName+' '+go.UrundomKey+' <'+edit9.text+'> '+ComboBox1.Text;//+' ';
     Form1.SendToServer(s);
     edit9.text:='';
end;

end.
