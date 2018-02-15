unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, z_lib, s1, ExtCtrls;

type
  TForm1 = class(TForm)
    ClientSocket1: TClientSocket;
    Button1: TButton;
    Memo1: TMemo;
    Button6: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Edit3: TEdit;
    Label2: TLabel;
    Button9: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SendToServer(s:string);
  end;

   StrArray=array[1..1000] of string;//1000 - количество блоков данных разделенных пробелом или <>

   TDS=record
      step  : integer;
      Vint1 : string;//all info
      Vint2 : string;
      VLC   : string;//leter
      VL1   : string;
      VL2   : string;
      Phone : string;
      Mail  : string;
      Pin   : string;
      URundomKey : string;
      PinOk : boolean;
      PinStepCount :integer;
   end;

   TGo = record
      ID         : string;
      Vo1        : string;
      UrundomKey : string;
   end;

var
  Form1: TForm1;
  ConnectionName:string;// надо запомнить для текущего соединения
  curdir:string;
  DS:TDS;
  go:tgo;

procedure String_to_array(s:string;var str:StrArray;var N:word); // OBRABOTKA STROKI

implementation

uses S2, Autorisation, wrk, Message;

var   ep:real;       //промежуточное значение псевдо генепатора

{$R *.dfm}

  function GenP(gran:cardinal):word;//gran-верхняя граница диапазона
  begin
    ep:=abs(sin(ep));
    ep:=ep*100;
    ep:=ep-trunc(ep);
    GenP:=trunc(ep*gran);
  end;

  function GenCiclNam(d,N:cardinal):cardinal;
  var i:cardinal;
  begin
    ep:=d;
    for i:=1 to N do begin
    ep:=abs(sin(ep));
    ep:=ep*429496729;
    end;
    GenCiclNam:=trunc(ep);
  end;

procedure String_Pack(var s:string);
var i:cardinal;d:byte;k:integer;


begin
    GenCiclNam(15436757,1);
    k:=length(s);
    for i:=1 to k do begin
    d:=ord(s[i])+GenP(20);
    s[i]:=chr(d);
    end;
end;

procedure String_UnPack(var s:string);
var i:cardinal;d:byte;
begin
    GenCiclNam(15436757,1);
    for i:=1 to length(s) do begin
    d:=ord(s[i])-GenP(20);
    s[i]:=chr(d);
    end;
end;


procedure String_to_array(s:string;var str:StrArray;var N:word); // OBRABOTKA STROKI
var i:integer;ss:string;
 procedure go;
 begin
      if (ss=' ')or(ss='') then exit;
      Inc(N);
      str[N]:=ss;
      ss:='';
 end;

begin
    N:=0;ss:='';i:=1;
    if length(s)>9999 then exit;
//    for i:= 1 to length(s) do
    while pos('<>',s)>0 do insert('^',s,pos('<>',s)+1);
    while i<=length(s) do begin
      if (s[i]=' ')and(i=length(s))then break else
      if (s[i]=' ')and(s[i+1]='<')then begin inc(i,2);go; repeat ss:=ss+s[i];inc(i);until (s[i]='>')or(i=length(s));end else
      if (i=1     )and(s[i]  ='<')then begin inc(i,1);go; repeat ss:=ss+s[i];inc(i);until (s[i]='>')or(i=length(s));end else
      if (s[i]<>' ') then ss:=ss+s[i] else go;
    inc(i);
    end;
    Inc(N);str[N]:=ss;
end;

procedure TForm1.SendToServer(s:string);
begin

   ClientSocket1.Socket.SendText(s+#13) ;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 curdir:=GetExePath;
end;

function jsn(s,par:string): string;
var i:integer;rez:string;
begin
    //"balance":0.00003000,"unconfirmed_balance":0.00000000,"
    {"result":"n4o7t4niwogqNjUQWHUrxejgPUjUhUfBPv","error":null,"id":"BTCExposed"}
    rez:='';
    for i:=pos(par,s)+length(par) to length(s) do
    if s[i]=',' then break else begin rez:=rez+s[i];if rez[length(rez)]='.' then rez[length(rez)]:=',';end;
    jsn:=rez;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject;  Socket: TCustomWinSocket);
var str:StrArray;N:word;s,command,UTransactionID,URundomKey,Amount,ClientID,Err:string;
    Comand,VL1:string;

    procedure _StartClient;
    var balance:string;
    begin
    go.UrundomKey:=str[3];
    end;

    procedure GetWaletFullInfo;
    var r1,r2,r3:real;s:string;
    begin
    go.UrundomKey:=str[3];
    //"result":1.00895973,"
    s:=ExtractTextBetween(str[4],'"result":',',"');
    //s:=StringReplace(s,'.',',',[rfReplaceAll, rfIgnoreCase]);
    work.Panel2.Caption:=s;
    work.Panel4.Caption:='0,00000000';
    work.Panel6.Caption:=s;
    work.label13.Visible:=true;
    {r1:=strtofloat(jsn(str[4],'"balance":'));
    work.Panel2.Caption:=floattostrF(r1,ffNumber, 2, 8);
    r2:=strtofloat(jsn(str[4],'"unconfirmed_balance":'));
    work.Panel4.Caption:=floattostrF(r2,ffNumber, 2, 8);
    r3:=r1+r2;
    work.Panel6.Caption:=floattostrF(r3,ffNumber, 2, 8);
    work.label13.Visible:=true;  }
    end;

    procedure CreateNewAdres;
    var s:string;
    begin
    go.UrundomKey:=str[3];
    {"result":"n4o7t4niwogqNjUQWHUrxejgPUjUhUfBPv","error":null,"id":"BTCExposed"}
    s:=ExtractTextBetween(str[4],'"result":"','","');
    work.Memo4.Lines.Add(s);
    end;

    procedure GetCloudAdreses;
    var s,d:string;i:integer;
    begin
    go.UrundomKey:=str[3];
    //"result":["miENXkQ9qQ9fxvtsbG2KTuRr7tsYhwH9iS","mjg63joU4VZTpnqZ4rVXH4GYuLYHjEe2h6","mpJrTUfm939YhL2mB2AyGchUv5G5GAE3tp","n3K95zpSF3YXsLEKTcpEQsNy4qJGmfjB3W","n4o7t4niwogqNjUQWHUrxejgPUjUhUfBPv"],"error":null,"id":"BTCExposed"}
      d:=str[4];
      s:='';
      for i:=1 to length(d) do begin
      if s='-' then s:=d[i]                         else
      if (length(s)>0)and(d[i]<>'"') then s:=s+d[i] else
      if (d[i]='"')and (s='') then s:='-'           else
        if (d[i]='"')and (s<>'') then begin
        if s='error' then break;
        if length(s)>20 then
        work.Memo4.Lines.Add(s);
        s:='';
        end;
      end;
    end;

    procedure SendFrom;
    var s:string;
    begin
    go.UrundomKey:=str[3];
//<- SendFrom RyRe35e0ACySBuDaexY5PvaKDi8pWMD {"result":"982a3ad22c6964bb1a203387f0267f880ae3bd66949d0872f06e1ffd2d8ec694","error":null,"id":"BTCExposed"}
    s:=ExtractTextBetween(str[4],'"result":"','","');
    //work.Memo4.Lines.Add(s);
    Msge.Label1.Caption:='Transaction ID';
    Msge.Edit1.Text:=s;
    if not Msge.Visible then Msge.Showmodal;
    end;

    procedure listtransactions;
    var s:string; count,i:integer;
    begin
    go.UrundomKey:=str[3];
    count:=strtoint(str[4]);
    for i:=1 to count do OutEp1(str[i+4]);
    //OutEp1(str[4],str[5],str[6],str[7],str[8],str[9]);
    //work.Memo4.Lines.Add(s);
    end;

    procedure URKError;
    var s:string;
    begin
    go.UrundomKey:=str[3];
    if str[4]='20' then begin Autor.Show;work.visible:=false; exit;end;
    if str[4]='22' then  work.Panel31.Caption:='Error: No Money!';
    if str[4]='23' then  work.Panel31.Caption:='Error: Address!';
    work.Panel31.Font.Color:=clred;
    timer1.Enabled:=false;
    timer3.Enabled:=true;
    end;

    procedure _SndMsg;
    var s:string; count,i:integer;
    begin
       Work.memo3.Lines.Add(str[3]);
    end;

    procedure _CreateOffer;
    var s:string; count,i:integer;
    begin
    go.UrundomKey:=str[3];
       showmessage('Success');
    end;

    procedure _GetOffers;
    var s:string; count,i:integer;
    begin
    go.UrundomKey:=str[3];
       for i:=4 to n-1 do
       OutOfr(str[i]);
    end;

begin
   s:=Socket.ReceiveText;
   String_to_array(s,str,N);//N-количество элементов = тебе не понадобица
   memo1.Lines.Add('<- '+s);// В МЕМО <- c2 *  //<- VHOD S SERVERA, c2- otvet na etu komandu, , * - luboi nabor textovyh komand


   if str[1]='_StartClient'     then _StartClient     else
   if str[1]='GetWaletFullInfo' then GetWaletFullInfo else
   if str[1]='CreateNewAdres'   then CreateNewAdres   else
   if str[1]='GetCloudAdreses'  then GetCloudAdreses  else
   if str[1]='SendFrom'         then SendFrom         else
   if str[1]='listtransactions' then listtransactions else
   if str[1]='URKError'         then URKError         else
   if str[1]='_SndMsg'          then _SndMsg          else
   if str[1]='_CreateOffer'     then _CreateOffer     else
   if str[1]='_GetOffers'       then _GetOffers       else

   if str[1]='c2' then begin
   ConnectionName := str[2];// определене имени соединения
       VL1:=GetVintID(curdir[1]);
       go.Vo1:=VL1;
       Timer2.Enabled:=true;
       //autor.Panel1.Caption:=curdir[1]+' '+ VL1;
       //VL1:='B4FE-5315';
       s:='CheckVL1'+' '+ConnectionName+' '+VL1;//+' ';
       form1.ClientSocket1.Socket.SendText(s+#13) ;
   exit;
   end;

   if str[1]='_PlayPhoneCheck' then begin
   ConnectionName := str[2];
      if str[5]='0' then begin
      work.show;
      s:='StartClient'+' '+ConnectionName;//+' ';
      form1.ClientSocket1.Socket.SendText(s+#13) ;
      end else Autor.Panel1.Caption:='Error';
   exit;
   end;

   if str[1]='_CheckVL1' then begin
   //ConnectionName := str[2];
   go.ID:=str[3];
   //CheckVL1();
   exit;
   end;

   if str[1]='_CheckPin' then begin
      if str[3]='0' then begin
      work.show;
      Form1.visible:=false;
      s:='StartClient'+' '+ConnectionName;//+' ';
      form1.ClientSocket1.Socket.SendText(s+#13) ;
      end else Autor.Panel1.Caption:='Error';
   exit;
   end;


   //String_UnPack(s); ENCRIPTOR
   //String_to_array(s,str,N);
   memo1.Lines.Add('<- '+s);
   Comand         := str[2];

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ClientSocket1.host:='185.27.194.203';//'127.0.0.1';
// ClientSocket1.host:='127.0.0.1';
 ClientSocket1.Port:=8765; //Communicator
 ClientSocket1.Open;
end;

procedure TForm1.Button6Click(Sender: TObject);
var pin,rejim,URundomKey,Phone,s:string;
begin
       URundomKey:='33333333';
       Phone:=edit2.text;//'';
       pin:=edit3.text;//'1234';
       s:='PlayPhoneCheck'+' '+ConnectionName+' '+URundomKey+' '+Phone+' '+pin;
       ClientSocket1.Socket.SendText(s+#13) ;
end;

procedure TForm1.Button9Click(Sender: TObject);
var sProperty:string;i:integer;lst1:Tstringlist;
begin
    // run('f:\Project1.exe');
    FlashSerial(lst1);
    memo1.Lines:=lst1;
   // if ClientSocket1.Active then memo1.Lines.Add('1') else  memo1.Lines.Add('0');
end;

procedure TForm1.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
   if ErrorEvent= eeConnect  then begin memo1.Lines.Add('Try to connect'); Timer1.Enabled:=true;end;
   ErrorCode:=0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    //Timer1.Enabled:=false;
    if not ClientSocket1.Active then begin if not autor.Visible then autor.Show;work.visible:=false; autor.Panel1.Caption:='Connecting..'; ClientSocket1.Close; ClientSocket1.Open;end
    else work.Panel31.Caption:='Connected';
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    Autor.panel1.caption:='Connected';

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
       if GetVintID(curdir[1])<>go.Vo1 then application.Terminate;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
    Timer3.Enabled:=false;
    //work.Panel31.Caption:='Ready';
    work.Panel31.Font.Color:=clblack;
    timer1.Enabled:=true;
end;

end.
