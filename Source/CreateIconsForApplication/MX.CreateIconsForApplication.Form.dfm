object FrmCreateIconsForApplication: TFrmCreateIconsForApplication
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Create Icons for Application'
  ClientHeight = 658
  ClientWidth = 926
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 17
  object pnlTools: TPanel
    Left = 0
    Top = 0
    Width = 926
    Height = 74
    Align = alTop
    TabOrder = 0
    object pnlTop: TPanel
      Left = 1
      Top = 1
      Width = 924
      Height = 71
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      TabOrder = 0
      ExplicitTop = -30
      ExplicitWidth = 183
      DesignSize = (
        924
        71)
      object lblCurrentProject: TLabel
        Left = 8
        Top = 8
        Width = 56
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Alignment = taRightJustify
        Caption = 'Filename'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnSelectProject: TButton
        Left = 693
        Top = 28
        Width = 222
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akTop, akRight]
        Caption = 'Selecione o arquivo do projeto'
        TabOrder = 0
        OnClick = btnSelectProjectClick
        ExplicitLeft = 792
      end
      object edtProjectFilePath: TComboBox
        Left = 8
        Top = 30
        Width = 658
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        ExplicitWidth = 757
      end
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 74
    Width = 665
    Height = 584
    Align = alLeft
    TabOrder = 1
    ExplicitTop = 131
    ExplicitHeight = 639
    object pnlAppIcon: TPanel
      Left = 1
      Top = 1
      Width = 663
      Height = 158
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 1023
      object lblAppIconHint: TLabel
        Left = 8
        Top = 8
        Width = 93
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Caption = 'Application Icon'
      end
      object btnSelectProjectIcon: TButton
        Left = 129
        Top = 30
        Width = 213
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Select Icon File'
        TabOrder = 0
        OnClick = btnSelectProjectIconClick
      end
      object btnProcessProjectIcon: TButton
        Left = 129
        Top = 94
        Width = 211
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Set icons to Selected Project'
        TabOrder = 1
        OnClick = btnProcessProjectIconClick
      end
      object Panel9: TPanel
        Left = 8
        Top = 32
        Width = 115
        Height = 116
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        BorderWidth = 1
        BorderStyle = bsSingle
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        object imgProjectIcon: TImage
          Left = 2
          Top = 2
          Width = 107
          Height = 108
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Stretch = True
          ExplicitWidth = 108
        end
      end
      object btnGenerateProjectIconEverySize: TButton
        Left = 129
        Top = 61
        Width = 213
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Generate Files'
        TabOrder = 3
        OnClick = btnGenerateProjectIconEverySizeClick
      end
      object edtIconCornerSizePercent: TEdit
        Left = 350
        Top = 31
        Width = 78
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 4
        Text = '0'
      end
    end
    object pnlAppLaunch: TPanel
      Left = 1
      Top = 159
      Width = 663
      Height = 424
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 1
      ExplicitTop = 163
      ExplicitHeight = 479
      object lblAppLaunchImageHint: TLabel
        Left = 8
        Top = 8
        Width = 78
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Caption = 'Splash Image'
      end
      object lblLaunchImageBackColorHint: TLabel
        Left = 140
        Top = 64
        Width = 273
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Caption = 'Escolha uma cor de fundo para a composi'#231#227'o:'
      end
      object lblLaunchImageScaleBaseHeightHint: TLabel
        Left = 336
        Top = 83
        Width = 208
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Caption = 'A altura base da imagem ampliada:'
      end
      object lblBackColorHexCodeHint: TLabel
        Left = 336
        Top = 142
        Width = 238
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Caption = 'ou c'#243'digo hexadecimal da cor de fundo:'
      end
      object cmbProjectLaunchBackColor: TColorListBox
        Left = 140
        Top = 84
        Width = 189
        Height = 102
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        NoneColorColor = clWhite
        Selected = clWhite
        ItemHeight = 13
        TabOrder = 0
        OnClick = cmbProjectLaunchBackColorClick
      end
      object edtProjectLaunchBackColor: TEdit
        Left = 336
        Top = 161
        Width = 92
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 1
      end
      object Panel12: TPanel
        Left = 8
        Top = 32
        Width = 128
        Height = 192
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        BorderWidth = 1
        BorderStyle = bsSingle
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        object imgProjectLaunchImage: TImage
          Left = 2
          Top = 2
          Width = 120
          Height = 184
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Stretch = True
          ExplicitWidth = 121
          ExplicitHeight = 185
        end
      end
      object btnSelectProjectLaunchImage: TButton
        Left = 140
        Top = 32
        Width = 213
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Selecicone o arquivo'
        TabOrder = 3
        OnClick = btnSelectProjectLaunchImageClick
      end
      object btnGenerateProjectLaunchImageEverySize: TButton
        Left = 140
        Top = 196
        Width = 237
        Height = 77
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Gere v'#225'rios tamanhos diretamente no cat'#225'logo do projeto'
        TabOrder = 4
        WordWrap = True
        OnClick = btnGenerateProjectLaunchImageEverySizeClick
      end
      object btnProcessProjectLaunchImage: TButton
        Left = 140
        Top = 277
        Width = 237
        Height = 77
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Definir como a imagem de inicializa'#231#227'o do projeto'
        TabOrder = 5
        WordWrap = True
        OnClick = btnProcessProjectLaunchImageClick
      end
      object btnCombineLaunchImageByBackColor: TButton
        Left = 381
        Top = 196
        Width = 237
        Height = 77
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Ou sintetize a imagem de inicializa'#231#227'o com base na cor de fundo'
        TabOrder = 6
        WordWrap = True
        OnClick = btnCombineLaunchImageByBackColorClick
      end
      object edtScaleBaseHeight: TEdit
        Left = 336
        Top = 107
        Width = 79
        Height = 25
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 7
        Text = '960'
      end
    end
  end
  object Panel1: TPanel
    Left = 665
    Top = 74
    Width = 261
    Height = 584
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 984
    ExplicitTop = 256
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
  object opdSelectProjectIcon: TOpenPictureDialog
    Left = 60
    Top = 336
  end
  object opdSelectProjectLaunchImage: TOpenPictureDialog
    Left = 60
    Top = 392
  end
  object odSelectProject: TOpenDialog
    DefaultExt = '*.dproj'
    Filter = 'Delphi'#24037#31243#25991#20214'(*.dproj)|*.dproj'
    Left = 60
    Top = 449
  end
end
