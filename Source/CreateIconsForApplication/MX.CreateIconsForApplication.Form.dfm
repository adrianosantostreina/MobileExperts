object FrmCreateIconsForApplication: TFrmCreateIconsForApplication
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Create Icons for Application'
  ClientHeight = 372
  ClientWidth = 669
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 17
  object Label1: TLabel
    Left = 0
    Top = 8
    Width = 40
    Height = 17
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 586
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 0
    Top = 26
    Width = 257
    Height = 25
    TabOrder = 1
    Text = 'Edit1'
  end
  object ListBox1: TListBox
    Left = 0
    Top = 55
    Width = 661
    Height = 283
    ItemHeight = 17
    TabOrder = 2
  end
end
