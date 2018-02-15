object Form1: TForm1
  Left = 300
  Top = 240
  Width = 405
  Height = 290
  Caption = 'Login'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 114
    Top = 34
    Width = 86
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
  end
  object Label2: TLabel
    Left = 270
    Top = 34
    Width = 64
    Height = 13
    Caption = 'PIN 4 '#1094#1080#1092#1088#1099
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 80
    Width = 361
    Height = 153
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object Button6: TButton
    Left = 96
    Top = 8
    Width = 141
    Height = 25
    Caption = 'PlayPhoneCheck'
    TabOrder = 2
    OnClick = Button6Click
  end
  object Edit2: TEdit
    Left = 91
    Top = 49
    Width = 150
    Height = 21
    TabOrder = 3
    Text = '+'
  end
  object Edit3: TEdit
    Left = 255
    Top = 49
    Width = 112
    Height = 21
    TabOrder = 4
    Text = '1234'
  end
  object Button9: TButton
    Left = 248
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button9'
    TabOrder = 5
    OnClick = Button9Click
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocket1Connect
    OnRead = ClientSocket1Read
    OnError = ClientSocket1Error
    Left = 96
    Top = 88
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 128
    Top = 88
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 4000
    OnTimer = Timer2Timer
    Left = 168
    Top = 88
  end
  object Timer3: TTimer
    Enabled = False
    Interval = 4000
    OnTimer = Timer3Timer
    Left = 208
    Top = 88
  end
end
