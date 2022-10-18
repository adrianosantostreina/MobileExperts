object FrmNewProject: TFrmNewProject
  Left = 0
  Top = 0
  Caption = 'Mobile Project Wizard'
  ClientHeight = 514
  ClientWidth = 820
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 514
    Align = alLeft
    TabOrder = 0
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 183
      Height = 512
      Align = alClient
      ExplicitLeft = 72
      ExplicitTop = 64
      ExplicitWidth = 105
      ExplicitHeight = 105
    end
  end
  object btnClose: TButton
    Left = 737
    Top = 481
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = btnCloseClick
  end
end
