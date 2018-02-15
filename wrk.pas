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
    ListView1: TListView;
    TabSheet7: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Panel37: TPanel;
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
    Label19: TLabel;
    ComboBox2: TComboBox;
    Label20: TLabel;
    Label21: TLabel;
    Panel9: TPanel;
    Panel10: TPanel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel35: TPanel;
    Panel36: TPanel;
    Panel42: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Image11: TImage;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    Panel45: TPanel;
    Label23: TLabel;
    Panel46: TPanel;
    Panel47: TPanel;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Image18: TImage;
    Panel48: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    ListView4: TListView;
    lo1: TListView;
    lo2: TListView;
    GroupBox2: TGroupBox;
    ComboBox3: TComboBox;
    Panel43: TPanel;
    Panel44: TPanel;
    StaticText5: TStaticText;
    ComboBox4: TComboBox;
    StaticText6: TStaticText;
    Label30: TLabel;
    Edit1: TEdit;
    Label22: TLabel;
    Edit2: TEdit;
    StaticText7: TStaticText;
    Edit3: TEdit;
    Label24: TLabel;
    Label31: TLabel;
    Image19: TImage;
    Edit11: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    Edit10: TEdit;
    BR: TRadioButton;
    SR: TRadioButton;
    Button1: TButton;
    Label34: TLabel;
    Label35: TLabel;
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
    procedure ComboBox2Select(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox3Select(Sender: TObject);
    procedure ComboBox4Select(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Image18Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lo1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Panel46Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Work: TWork;
  CCrnsy : string;

//procedure OutEp1(address,category,time,amount,confirm,txid:string);
procedure OutEp1(line:string);
procedure OutOfr(Line:string);

implementation

uses Unit1, Autorisation;

{$R *.dfm}



procedure OutOfr(Line:string);
var ListItem:TListItem;r1,r2:single;s:string;st:StrArray;N:word;
    Direction,bay,sell,AmountB,AmountS,tim,IDN:string;
begin with Work do begin
    String_to_array(line,st,N);
    Direction:=st[1];
    bay      :=st[2];
    sell     :=st[3];
    AmountB  :=st[4];
    AmountS  :=st[5];
    tim      :=st[6];
    IDN      :=st[7];
    r1:=strtofloat(stringreplace(AmountB,'.',',',[rfReplaceAll]));
    r2:=strtofloat(stringreplace(Amounts,'.',',',[rfReplaceAll]));
    str(r2/r1:2:6,s);
    ListItem := lo1.Items.Add;
    ListItem.Caption :=s;
    str(r1:2:6,s);
    ListItem.SubItems.Add(s);
    str(r2:2:6,s);
    ListItem.SubItems.Add(s);
    ListItem.SubItems.Add(IDN);
end end;

procedure OutEp1(line:string);
var ListItem:TListItem;s,s1,s2:string;R1,R2,p:real;k,d,dd:integer;address,category,time,amount,confirm,txid:string;
    str:StrArray;N:word;
begin with Work do begin
    String_to_array(line,str,N);
    if n<6 then exit;
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
//    CCrnsy:='18332';
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
     s:='GetWaletFullInfo'+' '+ConnectionName+' '+go.UrundomKey+' * '+CCrnsy;//+'test';//+' ';
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
     s:='CreateNewAdres'+' '+ConnectionName+' '+go.UrundomKey+' * '+CCrnsy;//+' ';
     Form1.SendToServer(s);
end;

procedure TWork.Panel39Click(Sender: TObject);
begin
    memo4.Text:='Список пуст';

end;

procedure TWork.Panel38Click(Sender: TObject);
var s:string;
begin
     memo4.Lines.Clear;
     s:='GetCloudAdreses'+' '+ConnectionName+' '+go.UrundomKey+' * '+CCrnsy;//+' ';
     Form1.SendToServer(s);
end;

procedure TWork.Panel29Click(Sender: TObject);
begin
     memo4.Lines.Clear;
end;

procedure TWork.Button3Click(Sender: TObject);
var s:string;
begin

     memo4.Lines.Clear;
     if length(edit4.Text)<>34 then begin showmessage('Invalid Address!');exit;end;
     if strtofloatdef(edit5.Text,0)<=0.00001 then begin showmessage('Invalid amount');exit;end;
     if strtointdef(edit7.Text,0)<=0 then begin showmessage('Invalid Confirmation Num.!');exit;end;
     s:='SendFrom'+' '+ConnectionName+' '+go.UrundomKey+' '+Edit4.text+' '+Edit5.text+' '+Edit7.text+' '+CCrnsy;//;
     Form1.SendToServer(s);
     edit5.Text:='0,0';
end;

procedure TWork.Button9Click(Sender: TObject);
var s:string;
begin
     lv2.Items.Clear;
     memo4.Lines.Clear;
     s:='listtransactions'+' '+ConnectionName+' '+go.UrundomKey+' * '+CCrnsy;//;
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

procedure TWork.ComboBox2Select(Sender: TObject);
begin
   case ComboBox2.ItemIndex of
     0:begin
       CCrnsy:='18332';
       Label6.Caption:='BTC';
       Panel41.Caption:='BTC';
       Label21.Caption:='BTC';
       end;
     1:begin
       CCrnsy:='19332';
       Label6.Caption:='LTC';
       Panel41.Caption:='LTC';
       Label21.Caption:='LTC';
       end;
   end;
   Label13click(sender);
   Button4.Click;
   lv2.Items.Clear;
   edit8.Text:='';
   Panel29click(sender);
end;

procedure TWork.FormCreate(Sender: TObject);
begin
    CCrnsy:='18332';
end;

procedure TWork.ComboBox3Select(Sender: TObject);
begin
     if ComboBox3.ItemIndex=0 then panel43.Color:=$004080FF else panel43.Color:=clsilver;
     panel43.Caption:=ComboBox3.Text;
     label24.Caption:=ComboBox3.Text;
     label32.Caption:=ComboBox3.Text;
end;

procedure TWork.ComboBox4Select(Sender: TObject);
begin
     if ComboBox4.ItemIndex=0 then panel44.Color:=$004080FF else panel44.Color:=clsilver;
//     panel44.Color:=$004080FF;
     panel44.Caption:=ComboBox4.Text;
     label31.Caption:=ComboBox4.Text;
     label33.Caption:=ComboBox4.Text;
end;

procedure TWork.Edit11Change(Sender: TObject);
var r1,r2:single;s,g:string;i:integer;
begin
    g:='1234567890,.';
    for i:=1 to length(edit3.Text) do if pos(edit3.Text[i],g)=0 then begin edit3.Text:='0'; exit;end;
    for i:=1 to length(edit11.Text) do if pos(edit11.Text[i],g)=0 then begin edit11.Text:='0'; exit;end;
    StaticText7.Caption:=edit11.Text;
    if BR.Checked then r1:=strtofloat(stringreplace(edit3.Text,'.',',',[rfReplaceAll])) else r1:=strtofloat(stringreplace(edit10.Text,'.',',',[rfReplaceAll]));
    r2:=strtofloat(stringreplace(edit11.Text,'.',',',[rfReplaceAll]));
    str(r1*r2:2:6,s);
    if BR.Checked then edit10.Text:=s else edit3.Text:=s;
end;

procedure TWork.Image18Click(Sender: TObject);
var s,direction:string;
begin
     if (label24.Caption='***')or(label31.Caption='***') then begin showmessage('Please select currensy'); exit;end;
     if BR.Checked then direction:='1' else direction:='2';
     s:='CreateOffer'+' '+ConnectionName+' '+go.UrundomKey+' '+direction+' '+inttostr(ComboBox3.ItemIndex)+' '+inttostr(ComboBox4.ItemIndex)+' '+edit3.Text+' '+edit11.Text+' '+edit10.Text;//+' ';
     Form1.SendToServer(s);
end;

procedure TWork.Button1Click(Sender: TObject);
var s:string;
begin
     lo1.Items.Clear;
     lo2.Items.Clear;
     s:='GetOffers'+' '+ConnectionName+' '+go.UrundomKey;//+' '+direction+' '+inttostr(ComboBox3.ItemIndex)+' '+inttostr(ComboBox3.ItemIndex)+' '+edit3.Text+' '+edit11.Text+' '+edit10.Text;//+' ';
     Form1.SendToServer(s);
end;

procedure TWork.lo1SelectItem(Sender: TObject; Item: TListItem;  Selected: Boolean);
begin
    edit1.text:=item.SubItems.Strings[0];
    edit2.text:=item.SubItems.Strings[1];
    StaticText7.Caption:=item.Caption;
    label35.Caption:=item.SubItems.Strings[2];
end;

procedure TWork.Panel46Click(Sender: TObject);
var s:string;
begin
     if label35.Caption='*' then begin showmessage('Please select couple'); exit;end;
     s:='GoExchange'+' '+ConnectionName+' '+go.UrundomKey+' '+label35.Caption;
     Form1.SendToServer(s);
end;

end.
