unit S2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, mmsystem, z_lib;

type
  TStep2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Memo2: TMemo;
    Label1: TLabel;
    Image3: TImage;
    StaticText3: TStaticText;
    Timer1: TTimer;
    Panel1: TPanel;
    Edit1: TEdit;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    Edit2: TEdit;
    Image4: TImage;
    Image5: TImage;
    Button1: TButton;
    Timer2: TTimer;
    Image6: TImage;
    Image7: TImage;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Step2: TStep2;
    ltr:string;

procedure GetDrive(var ltr:string);
procedure F1reg(err,pin:string);

implementation

uses unit1,s1;

var lst1,lst2:TStringlist;

{$R *.dfm}

procedure F1reg(err,pin:string);
var s:string;
begin with Step2 do begin

   if DS.step=7 then begin
   if (err<>'0')or(err='3') then begin
   Step2.memo2.Lines.Add('"К сожалению эту флешку нельзя использовать! ');
   DS.step:=1;
   end else begin
   s:=pin+'***';
   memo2.Text:='Ваш кошелек успешно зарегистрирован.';
   memo2.Lines.Add('Ваш шестизначный пин код: '+s);
   memo2.Lines.Add('Вместо *** вставьте три цифры, которые прямо сейчас вы слышите по телефону.');
   DS.step:=8;
   end;
   exit;
   end;

   if (err='1')or(err='3') then begin
   Step2.memo2.Lines.Add('"К сожалению эту флешку нельзя использовать! ');
   DS.step:=1;
   end;
   if err='2' then begin
   Step2.memo2.Lines.Add('"К сожалению этот телефонный номер нельзя зарегистрировать! ');
   DS.step:=1;
   end;
   if err='0' then begin
   Step2.memo2.Lines.Add('Ok, Ваш телефонный номер Успешно подтвержден!');
   Step2.memo2.Lines.Add('Теперь приступим к регистрации флешки №2, для этого извлеките флешку №1 и нажмите "Продолжить"');
   Timer2.Enabled:=false;
   DS.step:=6;
   end;

end end;

procedure GetDrive(var ltr:string);
var Drive: Char; //Буква диска
const pref = ':\';
begin
for Drive := 'B' to 'Z' do if GetDriveType(PChar(Drive + pref)) = DRIVE_REMOVABLE then
ltr:=Drive;//+ pref;
end;

procedure TStep2.FormShow(Sender: TObject);
begin
   //playsound(pchar(curdir+'1.wav'),1,1);
   memo2.Text:='Вставьте флешку №1 в USB слот вашего компьютера..';
   FlashSerial(lst1);
   timer1.Enabled:=true;
end;

procedure TStep2.Timer1Timer(Sender: TObject);
label 1;
var i,j:integer;
begin
   FlashSerial(lst2);
   if lst2.Count=lst1.Count then exit;
   for i:=0 to lst2.Count-1 do begin
   for j:=0 to lst1.Count-1 do if lst2.Strings[i]=lst1.Strings[j] then goto 1;
    if DS.step=7 then begin
    DS.Vint2:=lst2.Strings[i];
    DS.Vint1:=lst1.Strings[i];
    //DS.step:=7;
    Image2Click(Sender);
   end else begin
   timer1.Enabled:=false;
    GetDrive(ltr);
    DS.VLC:=GetVintID('c:');
    DS.VL1:=GetVintID(ltr+':');
    DS.Vint1:=lst2.Strings[i];
    memo2.Visible:=false;
    image3.Picture.Assign(image4.Picture);
    StaticText2.Visible:=true;image2.Visible:=true;
    DS.step:=3;
   end;

 1:end;

end;

procedure TStep2.Button1Click(Sender: TObject);
var s:string;
begin
  // GetDrive(ltr);
  // showmessage(ltr);
   s:='Clear_DB'+' '+ConnectionName+' * ';
   form1.ClientSocket1.Socket.SendText(s+#13) ;
end;

procedure TStep2.Edit1Change(Sender: TObject);
var k:integer;s:string;
begin
    if (edit1.Text='')then begin edit1.Text:='+';edit1.SelStart:=length(edit1.Text);end;
    if (edit1.Text='')or(edit1.Text='+') then exit;
    s:=edit1.Text;
    k:=strtointdef(s[length(s)],-1);
    if k=-1 then setlength(s,length(s)-1);
    edit1.Text:=s;
    edit1.SelStart:=length(edit1.Text);
end;

procedure TStep2.Image2Click(Sender: TObject);
var s:string;
begin
    case DS.step of
    1:begin
    Step2.Visible:=false;
    Step1.Visible:=true;
    CheckDrive;
    end;

    3:begin
    DS.Phone:=edit1.Text;
    DS.Mail :=edit2.Text;
    if (pos('@',DS.Mail)=0)or(pos('.',DS.Mail)=0) then begin showmessage('Не верный e-mail');exit; end;
    if length(DS.Phone)<12 then begin showmessage('Не верный номер телефона');exit; end;
    memo2.Lines.Clear;
    memo2.Visible:=true;
    memo2.Lines.Add('Проверьте Ваши данные');
    memo2.Lines.Add('Номер телефона: '+DS.Phone);
    memo2.Lines.Add('E-mail: '+DS.Mail);
    memo2.Lines.Add('Буква вставленной флешки: "'+ltr+'"');
    DS.step:=4;
    DS.PinStepCount:=0;
    end;

    4:begin
    memo2.Lines.Clear;
    image3.Picture.Assign(image5.Picture);
    memo2.Lines.Add('Подтверждение телефонного номера.');
    memo2.Lines.Add('Ожидайте звонка на Ваш телефон..');
    memo2.Lines.Add('Поднимите трубку, переведите телефон в тоновый набор и введите одноразовый код подтверждения:');
    memo2.Lines.Add('');
    DS.Pin:=inttostr(gen(1000,9999));
    memo2.Lines.Add(DS.Pin);
    DS.step:=5;
       DS.URundomKey:=inttostr(gen(1000,9999))+inttostr(gen(1000,9999))+inttostr(gen(1000,9999));
       inc(DS.PinStepCount);
       s:='PlayPhoneCheck'+' '+ConnectionName+' '+DS.URundomKey+' '+DS.Phone+' '+DS.Pin+' '+inttostr(DS.PinStepCount)+' ';
       form1.ClientSocket1.Socket.SendText(s+#13) ;
       timer2.Enabled:=true;
    end;

    5:begin
    memo2.Lines.Clear;
    if DS.PinOk=false then begin
    DS.step:=4;
    memo2.Lines.Add('Ошибка!');
    memo2.Lines.Add('Нажмите "Продолжить" для повторения операции.');
    end else begin
       DS.URundomKey:=inttostr(gen(1000,9999))+inttostr(gen(1000,9999))+inttostr(gen(1000,9999));
       s:='CheckWalet'+' '+
       ConnectionName +' <'+
       DS.Vint1       +'> <'+
       DS.Vint2       +'> <'+
       DS.VLC         +'> <'+
       DS.VL1         +'> <'+
       DS.VL2         +'> <'+
       DS.Phone       +'> <'+
       DS.Mail        +'> <'+
       DS.Pin         +'> <'+
       DS.URundomKey  +'> ';
       form1.ClientSocket1.Socket.SendText(s+#13) ;
    DS.step:=6;
    timer1.Enabled:=false;
    end;
    end;

    6:begin
    image3.Picture.Assign(image6.Picture);
    memo2.Text:='Вставьте флешку №2 в USB слот вашего компьютера..';
    FlashSerial(lst1);
    DS.step:=7;
    timer1.Enabled:=true;
    end;

    7:begin
    GetDrive(ltr);
       DS.URundomKey:=inttostr(gen(1000,9999))+inttostr(gen(1000,9999))+inttostr(gen(1000,9999));
       s:='CheckEndWalet'+' '+
       ConnectionName +' <'+
       DS.Vint1       +'> <'+
       DS.Vint2       +'> <'+
       DS.VLC         +'> <'+
       DS.VL1         +'> <'+
       DS.VL2         +'> <'+
       DS.Phone       +'> <'+
       DS.Mail        +'> <'+
       DS.Pin         +'> <'+
       DS.URundomKey  +'> ';
       form1.ClientSocket1.Socket.SendText(s+#13) ;
    timer1.Enabled:=false;
    end;

    8:begin
    StaticText2.Visible:=false;image2.Visible:=false;
    memo2.Text:='Для начала работы с Вашим кошельком вставьте флешку №1 и запустите приложение Walet.exe.';
    memo2.Lines.Add('Удачной работы!');
    end;

    end;
end;

procedure TStep2.Timer2Timer(Sender: TObject);
begin
    Timer2.Enabled:=false;
    DS.PinOk:=false;
    Image2Click(Sender);
end;

procedure TStep2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   application.Terminate;
end;

end.
