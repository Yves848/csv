object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 927
  ClientWidth = 1892
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 24
    Top = 55
    Width = 1825
    Height = 303
    ItemHeight = 13
    TabOrder = 1
  end
  object Button2: TButton
    Left = 128
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Split'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ListBox2: TListBox
    Left = 1496
    Top = 392
    Width = 353
    Height = 505
    ItemHeight = 13
    TabOrder = 3
  end
  object sg1: TJvStringGrid
    Left = 24
    Top = 392
    Width = 1449
    Height = 505
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goFixedRowDefAlign]
    TabOrder = 4
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = []
  end
  object btnLoad: TButton
    Left = 224
    Top = 24
    Width = 75
    Height = 25
    Caption = 'btnLoad'
    TabOrder = 5
    OnClick = btnLoadClick
  end
  object Button3: TButton
    Left = 936
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 320
    Top = 24
    Width = 75
    Height = 25
    Caption = 'count'
    TabOrder = 7
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=SmartRx'
      'User_Name=postgres'
      'Password=postgres'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 1360
    Top = 24
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorHome = 'C:\opt\pgsql_10'
    Left = 1472
    Top = 24
  end
  object FDCommand1: TFDCommand
    Connection = FDConnection1
    CommandKind = skCreate
    CommandText.Strings = (
      'CREATE TABLE public.af04_clear'
      '('
      '   ccode character varying(20) COLLATE pg_catalog."default",'
      '    cnom character varying(50) COLLATE pg_catalog."default",'
      '    cnomjf character varying(50) COLLATE pg_catalog."default",'
      '    cprenom character varying(50) COLLATE pg_catalog."default",'
      '    cnoss character varying(50) COLLATE pg_catalog."default",'
      '    csexe "char"'
      ')')
    Left = 1136
    Top = 32
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'insert into af04_clear '
      '(ccode,'
      'cnom,'
      'cnomjf,'
      'cprenom,'
      'cnoss,'
      'csexe)'
      'values'
      '(:ccode,'
      ':cnom,'
      ':cnomjf,'
      ':cprenom,'
      ':cnoss,'
      ':csexe)')
    Left = 960
    Top = 40
    ParamData = <
      item
        Name = 'CCODE'
        ParamType = ptInput
      end
      item
        Name = 'CNOM'
        ParamType = ptInput
      end
      item
        Name = 'CNOMJF'
        ParamType = ptInput
      end
      item
        Name = 'CPRENOM'
        ParamType = ptInput
      end
      item
        Name = 'CNOSS'
        ParamType = ptInput
      end
      item
        Name = 'CSEXE'
        ParamType = ptInput
      end>
  end
end
