unit MX.CreateIconsForApplication.Form;

interface

uses
  ToolsApi,

  System.Classes,
  System.SysUtils,
  System.Variants,
  System.Types,
  System.Math,

  Winapi.GDIPOBJ,
  Winapi.GDIPAPI,
  Winapi.Windows,
  Winapi.GDIPUTIL,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  FMX.Graphics,
  FMX.Types,

  Winapi.Messages,
  uFuncCommon_Copy,
  uOrangeUISmartSDKDeployment,

  Vcl.ExtCtrls,
  Vcl.ExtDlgs,

  MX.Template.Form, Vcl.FileCtrl;

type
  TFrmCreateIconsForApplication = class(TFrmTemplate)
    pnlAppIcon: TPanel;
    lblAppIconHint: TLabel;
    btnSelectProjectIcon: TButton;
    btnProcessProjectIcon: TButton;
    Panel9: TPanel;
    imgProjectIcon: TImage;
    btnGenerateProjectIconEverySize: TButton;
    edtIconCornerSizePercent: TEdit;
    pnlAppLaunch: TPanel;
    lblAppLaunchImageHint: TLabel;
    lblLaunchImageBackColorHint: TLabel;
    lblLaunchImageScaleBaseHeightHint: TLabel;
    lblBackColorHexCodeHint: TLabel;
    cmbProjectLaunchBackColor: TColorListBox;
    edtProjectLaunchBackColor: TEdit;
    Panel12: TPanel;
    imgProjectLaunchImage: TImage;
    btnSelectProjectLaunchImage: TButton;
    btnGenerateProjectLaunchImageEverySize: TButton;
    btnProcessProjectLaunchImage: TButton;
    btnCombineLaunchImageByBackColor: TButton;
    edtScaleBaseHeight: TEdit;
    pnlTop: TPanel;
    lblCurrentProject: TLabel;
    btnSelectProject: TButton;
    edtProjectFilePath: TComboBox;
    opdSelectProjectIcon: TOpenPictureDialog;
    opdSelectProjectLaunchImage: TOpenPictureDialog;
    odSelectProject: TOpenDialog;
    pnlTools: TPanel;
    pnlLeft: TPanel;
    Panel1: TPanel;
    procedure btnCombineLaunchImageByBackColorClick(Sender: TObject);
    procedure btnGenerateProjectIconEverySizeClick(Sender: TObject);
    procedure btnGenerateProjectLaunchImageEverySizeClick(Sender: TObject);
    procedure btnProcessProjectIconClick(Sender: TObject);
    procedure btnProcessProjectLaunchImageClick(Sender: TObject);
    procedure btnSelectProjectClick(Sender: TObject);
    procedure btnSelectProjectIconClick(Sender: TObject);
    procedure btnSelectProjectLaunchImageClick(Sender: TObject);
    procedure cmbProjectLaunchBackColorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    private
      { Private declarations }
      FProjectLaunchImageFileName : String;
      FProjectIconFileName        : String;
      FProjectConfig              : TProjectConfig;
      FCurrentConfigFileName      : String;
      FFilename                   : String;
    public
      { Public declarations }
      function FileName(AFilename: String): TFrmCreateIconsForApplication;
  end;

procedure SizePicture(APictureFilePath: String;
  AWidth, AHeight: Integer;
  ASaveDir: String;
  DevideChar: String;
  AFileName: String = '';
  ACornerSizePercent: Double = 0);

procedure CombineSizePictureByBackColor(
  AMiddlePictureFilePath: String;
  ABackColor: TColor;
  AMiddlePictureStretchScaleBaseHeight: Integer;
  AWidth, AHeight: Integer;
  ASaveDir: String;
  DevideChar: String;
  AFileName: String = '');

implementation

{$R *.dfm}

procedure SizePicture(APictureFilePath: String;
  AWidth, AHeight: Integer;
  ASaveDir: String;
  DevideChar: String;
  AFileName: String = '';
  ACornerSizePercent: Double = 0);
var
  ASrcBitmap:    TBitmap;
  ADestBitmap:   TBitmap;
  ATempFileName: String;
  ASavedBitmap:  TBitmap;
begin
  ATempFileName := AFileName;
  if ATempFileName = '' then
  begin
    ATempFileName := IntToStr(AWidth) + DevideChar + IntToStr(AHeight) + '.png';
  end;
  ASrcBitmap   := TBitmap.Create();
  ADestBitmap  := TBitmap.Create(AWidth, AHeight);
  ASavedBitmap := TBitmap.Create(AWidth, AHeight);
  ASavedBitmap.Canvas.BeginScene();
  try
    ASavedBitmap.Canvas.Clear(0);
    ASrcBitmap.LoadFromFile(APictureFilePath);
    if BiggerDouble(ACornerSizePercent, 0) then
    begin
      ADestBitmap.Canvas.BeginScene();
      ADestBitmap.Canvas.Clear(0);
      ADestBitmap.Canvas.DrawBitmap(
        ASrcBitmap,
        RectF(0, 0, ASrcBitmap.Width, ASrcBitmap.Height),
        RectF(0, 0, ADestBitmap.Width, ADestBitmap.Height),
        1
        );
      ADestBitmap.Canvas.EndScene();

      if ACornerSizePercent < 1 then
      begin
        ACornerSizePercent := ACornerSizePercent * ADestBitmap.Width;
      end;
      ASavedBitmap.Canvas.Fill.Bitmap.Bitmap := ADestBitmap;
      ASavedBitmap.Canvas.Fill.Kind          := TBrushKind.Bitmap;
      ASavedBitmap.Canvas.FillRect(RectF(0, 0, ADestBitmap.Width,
        ADestBitmap.Height),
        ACornerSizePercent,
        ACornerSizePercent,
        [TCorner.TopLeft, TCorner.TopRight, TCorner.BottomLeft,
        TCorner.BottomRight],
        1
        );
    end
    else
    begin
      ASavedBitmap.Canvas.DrawBitmap(
        ASrcBitmap,
        RectF(0, 0, ASrcBitmap.Width, ASrcBitmap.Height),
        RectF(0, 0, ASavedBitmap.Width, ASavedBitmap.Height),
        1
        );
    end;
    ASavedBitmap.Canvas.EndScene;
    if ExtractFileName(ASaveDir) = '' then
    begin
      ASavedBitmap.SaveToFile(ASaveDir + ATempFileName);
    end
    else
    begin
      System.SysUtils.ForceDirectories(ExtractFilePath(ASaveDir));
      ASavedBitmap.SaveToFile(ASaveDir);
    end;

  finally
    ASrcBitmap.Free;
    ADestBitmap.Free;
    ASavedBitmap.Free;
  end;
end;

procedure CombineSizePictureByBackColor(
  AMiddlePictureFilePath: String;
  ABackColor: TColor;
  AMiddlePictureStretchScaleBaseHeight: Integer;
  AWidth, AHeight: Integer;
  ASaveDir: String;
  DevideChar: String;
  AFileName: String = '');
var
  ASrcBitmap:                 TGPBitmap;
  ADestBitmap:                TGPBitmap;
  ADestBitmapGraphics:        TGPGraphics;
  ImgGUID:                    TGUID;
  AGPBackColor:               TColor;
  ALeft, ATop:                Integer;
  AMiddlePictureStretchScale: Double;
  ATempFileName:              String;
begin
  AMiddlePictureStretchScale := AHeight / AMiddlePictureStretchScaleBaseHeight;
  ATempFileName              := AFileName;
  if ATempFileName = '' then
  begin
    ATempFileName := IntToStr(AWidth) + DevideChar + IntToStr(AHeight) + '.png';
  end;
  ASrcBitmap          := TGPBitmap.Create(AMiddlePictureFilePath);
  ADestBitmap         := TGPBitmap.Create(AWidth, AHeight);
  ADestBitmapGraphics := TGPGraphics.Create(ADestBitmap);
  try
    AGPBackColor := ColorRefToARGB(ABackColor);
    ADestBitmapGraphics.Clear(AGPBackColor);
    ALeft := Ceil(ADestBitmap.GetWidth - ASrcBitmap.GetWidth *
      AMiddlePictureStretchScale) div 2;
    ATop := Ceil(ADestBitmap.GetHeight - ASrcBitmap.GetHeight *
      AMiddlePictureStretchScale) div 2;
    ADestBitmapGraphics.DrawImage(
      ASrcBitmap,
      MakeRect(ALeft,
      ATop,
      ASrcBitmap.GetWidth * AMiddlePictureStretchScale,
      ASrcBitmap.GetHeight * AMiddlePictureStretchScale),
      0, 0, ASrcBitmap.GetWidth, ASrcBitmap.GetHeight,
      TUnit.UnitPixel
      );
    // x
    if GetEncoderClsid('image/png', ImgGUID) <> -1 then
    begin
      if ExtractFileName(ASaveDir) = '' then
      begin
        if ADestBitmap.Save(ASaveDir + ATempFileName,
          // IntToStr(AWidth)+DevideChar+IntToStr(AHeight)+'.png',
          ImgGUID) <> Status.Ok then
        begin
          DoDeployConfigLog(nil, 'Generate image fail');
        end;
      end
      else
      begin
        System.SysUtils.ForceDirectories(ExtractFilePath(ASaveDir));
        if Not(ADestBitmap.Save(ASaveDir, ImgGUID) = Status.Ok) then
        begin
          DoDeployConfigLog(nil, 'Generate image fail');
        end;
      end;
    end;
  finally
    ASrcBitmap.Free;
    ADestBitmap.Free;
    ADestBitmapGraphics.Free;
  end;
end;

procedure TFrmCreateIconsForApplication.btnCombineLaunchImageByBackColorClick(
  Sender: TObject);
var
  ASaveDir:         String;
  ABackColor:       TColor;
  AScaleBaseHeight: Integer;
begin
  if Self.edtProjectLaunchBackColor.Text = '' then
  begin
    ShowMessage('Please select color first');
    Exit;
  end;
  // ARGB->0BGR
  ABackColor := StrToInt('$' + Copy(Self.edtProjectLaunchBackColor.Text, 1 + 2,
    2))
    + StrToInt('$' + Copy(Self.edtProjectLaunchBackColor.Text, 1 + 4, 2)) shl 8
    + StrToInt('$' + Copy(Self.edtProjectLaunchBackColor.Text, 1 + 6,
    2)) shl 16;
  AScaleBaseHeight := StrToInt(Self.edtScaleBaseHeight.Text);
  if FileExists(Self.edtProjectFilePath.Text) and
    FileExists(FProjectLaunchImageFileName) then
  begin
    ASaveDir := ExtractFilePath(Self.edtProjectFilePath.Text);
    SizePicture(FProjectLaunchImageFileName, 426, 320, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 470, 320, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 640, 480, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 960, 720, ASaveDir, 'x');
    // IOS
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 320, 480, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 640, 960, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 640, 1136, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 750, 1334, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1242, 2208, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1242, 2208, ASaveDir, 'x', '1242x2208 - light-2x.png');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1242, 2208, ASaveDir, 'x', '1242x2208 - dark-2x.png');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2208, 1242, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2208, 1242, ASaveDir, 'x', '2208x1242 - light-2x.png');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2208, 1242, ASaveDir, 'x', '2208x1242 - dark-2x.png');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2048, 1536, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2048, 1496, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1536, 2048, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1496, 2048, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1536, 2008, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1024, 768, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1024, 748, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 768, 1024, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 768, 1004, ASaveDir, 'x');
    // 10.3
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1136, 640, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1334, 750, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 828, 1792, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1792, 828, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1125, 2436, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2436, 1125, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1242, 2688, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1242, 2688, ASaveDir, 'x', '1242x2688 - light-3x.png');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1242, 2688, ASaveDir, 'x', '1242x2688 - dark-3x.png');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2688, 1242, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1668, 2224, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2224, 1668, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 1668, 2388, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2388, 1668, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2048, 2732, ASaveDir, 'x');
    CombineSizePictureByBackColor(FProjectLaunchImageFileName, ABackColor,
      AScaleBaseHeight, 2732, 2048, ASaveDir, 'x');

  end
  else
  begin
    ShowMessage('Project file or image file is not exist');
  end;
end;



procedure TFrmCreateIconsForApplication.btnGenerateProjectIconEverySizeClick(
  Sender: TObject);
var
  ASaveDir:            String;
  AGetuiPushSDKResDir: String;
  ACornerSizePercent:  Double;
begin
  if FileExists(Self.edtProjectFilePath.Text) and
    FileExists(FProjectIconFileName) then
  begin
    ACornerSizePercent := 0;
    TryStrToFloat(Self.edtIconCornerSizePercent.Text, ACornerSizePercent);
    ASaveDir := ExtractFilePath(Self.edtProjectFilePath.Text);
    SizePicture(FProjectIconFileName, 24, 24, ASaveDir, '_', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 36, 36, ASaveDir, '_', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 48, 48, ASaveDir, '_', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 72, 72, ASaveDir, '_', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 96, 96, ASaveDir, '_', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 28, 28, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 29, 29, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 32, 32, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 36, 36, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 40, 40, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 48, 48, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 50, 50, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 57, 57, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 58, 58, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 60, 60, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 72, 72, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 76, 76, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 80, 80, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 83, 83, ASaveDir, 'x', '83.5x83.5.png',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 87, 87, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 96, 96, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 100, 100, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 108, 108, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 114, 114, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 120, 120, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 144, 144, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 152, 152, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 180, 180, ASaveDir, 'x', '',
      ACornerSizePercent);
    // 10.3 83.5
    SizePicture(FProjectIconFileName, 83, 83, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 167, 167, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 192, 192, ASaveDir, 'x', '',
      ACornerSizePercent);
    SizePicture(FProjectIconFileName, 1024, 1024, ASaveDir, 'x', '',
      ACornerSizePercent);
    AGetuiPushSDKResDir := ASaveDir + 'GetuiPushSDK\Android_2_10_2\res\';
    // Gere um ícone de push para a versão 2.10.2
    SizePicture(FProjectIconFileName, 96, 96, AGetuiPushSDKResDir +
      'drawable-hdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 36, 36, AGetuiPushSDKResDir +
      'drawable-hdpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 48, 48, AGetuiPushSDKResDir +
      'drawable-ldpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 18, 18, AGetuiPushSDKResDir +
      'drawable-ldpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 64, 64, AGetuiPushSDKResDir +
      'drawable-mdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 24, 24, AGetuiPushSDKResDir +
      'drawable-mdpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 128, 128, AGetuiPushSDKResDir +
      'drawable-xhdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 48, 48, AGetuiPushSDKResDir +
      'drawable-xhdpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 192, 192, AGetuiPushSDKResDir +
      'drawable-xxhdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 72, 72, AGetuiPushSDKResDir +
      'drawable-xxhdpi\push_small.png', 'x', '', ACornerSizePercent);
    AGetuiPushSDKResDir := ASaveDir + 'GetuiPushSDK\Android_4_3_2\res\';
    // Gerar um ícone de push para a versão 2.10.5
    SizePicture(FProjectIconFileName, 96, 96, AGetuiPushSDKResDir +
      'drawable-hdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 36, 36, AGetuiPushSDKResDir +
      'drawable-hdpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 48, 48, AGetuiPushSDKResDir +
      'drawable-ldpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 18, 18, AGetuiPushSDKResDir +
      'drawable-ldpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 64, 64, AGetuiPushSDKResDir +
      'drawable-mdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 24, 24, AGetuiPushSDKResDir +
      'drawable-mdpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 128, 128, AGetuiPushSDKResDir +
      'drawable-xhdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 48, 48, AGetuiPushSDKResDir +
      'drawable-xhdpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 192, 192, AGetuiPushSDKResDir +
      'drawable-xxhdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 72, 72, AGetuiPushSDKResDir +
      'drawable-xxhdpi\push_small.png', 'x', '', ACornerSizePercent);

    AGetuiPushSDKResDir := ASaveDir + 'GetuiPushSDK\Android_2_13_0_0\res\';
    // Gere um ícone de push para a versão 2.10.2
    SizePicture(FProjectIconFileName, 96, 96, AGetuiPushSDKResDir +
      'drawable-hdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 36, 36, AGetuiPushSDKResDir +
      'drawable-hdpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 48, 48, AGetuiPushSDKResDir +
      'drawable-ldpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 18, 18, AGetuiPushSDKResDir +
      'drawable-ldpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 64, 64, AGetuiPushSDKResDir +
      'drawable-mdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 24, 24, AGetuiPushSDKResDir +
      'drawable-mdpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 128, 128, AGetuiPushSDKResDir +
      'drawable-xhdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 48, 48, AGetuiPushSDKResDir +
      'drawable-xhdpi\push_small.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 192, 192, AGetuiPushSDKResDir +
      'drawable-xxhdpi\push.png', 'x', '', ACornerSizePercent);
    SizePicture(FProjectIconFileName, 72, 72, AGetuiPushSDKResDir +
      'drawable-xxhdpi\push_small.png', 'x', '', ACornerSizePercent);
  end
  else
  begin
    ShowMessage('Arquivo de projeto ou arquivo de imagem não existe');
  end;

end;

procedure
  TFrmCreateIconsForApplication.btnGenerateProjectLaunchImageEverySizeClick(
  Sender: TObject);
var
  ASaveDir: String;
begin
  if FileExists(Self.edtProjectFilePath.Text) and
    FileExists(FProjectLaunchImageFileName) then
  begin
    ASaveDir := ExtractFilePath(Self.edtProjectFilePath.Text);
    // Android, deve usar 9patch e renomear
    SizePicture(FProjectLaunchImageFileName, 426, 320, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 470, 320, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 640, 480, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 960, 720, ASaveDir, 'x');
    // IOS
    SizePicture(FProjectLaunchImageFileName, 320, 480, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 640, 960, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 640, 1136, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 750, 1334, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1242, 2208, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1242, 2208, ASaveDir, 'x',
      '1242x2208 - light-2x.png');
    SizePicture(FProjectLaunchImageFileName, 1242, 2208, ASaveDir,
      '1242x2208 - dark-2x.png');
    SizePicture(FProjectLaunchImageFileName, 2208, 1242, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 2048, 1536, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 2048, 1496, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1536, 2048, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1496, 2048, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1536, 2008, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1024, 768, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1024, 748, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 768, 1024, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 768, 1004, ASaveDir, 'x');
    // 10.3
    SizePicture(FProjectLaunchImageFileName, 1136, 640, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1334, 750, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 828, 1792, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1792, 828, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1125, 2436, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 2436, 1125, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1242, 2688, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1242, 2688, ASaveDir, 'x',
      '1242x2688 - light-3x.png');
    SizePicture(FProjectLaunchImageFileName, 1242, 2688, ASaveDir, 'x',
      '1242x2688 - dark-3x.png');
    SizePicture(FProjectLaunchImageFileName, 2688, 1242, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1668, 2224, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 2224, 1668, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 1668, 2388, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 2388, 1668, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 2048, 2732, ASaveDir, 'x');
    SizePicture(FProjectLaunchImageFileName, 2732, 2048, ASaveDir, 'x');
  end
  else
  begin
    ShowMessage('Project file or immage file is not exist');
  end;
end;

procedure TFrmCreateIconsForApplication.btnProcessProjectIconClick(Sender:
  TObject);
begin
  Self.FProjectConfig.SaveProjectIconToProject(Self.edtProjectFilePath.Text);
end;

procedure TFrmCreateIconsForApplication.btnProcessProjectLaunchImageClick(
    Sender: TObject);
begin
  Self.FProjectConfig.SaveProjectLaunchImageToProject(Self.edtProjectFilePath.Text);
end;

procedure TFrmCreateIconsForApplication.btnSelectProjectClick(Sender: TObject);
begin
  if Self.odSelectProject.Execute(Handle) then
    Self.edtProjectFilePath.Text := Self.odSelectProject.FileName;

  if not Assigned(Self.FProjectConfig) then
    FProjectConfig:=TProjectConfig.Create;
end;

procedure TFrmCreateIconsForApplication.btnSelectProjectIconClick(Sender:
  TObject);
begin
  if Self.opdSelectProjectIcon.Execute(Handle) then
  begin
    Self.imgProjectIcon.Picture.LoadFromFile
      (Self.opdSelectProjectIcon.FileName);
    FProjectIconFileName := Self.opdSelectProjectIcon.FileName;
  end;
end;

procedure TFrmCreateIconsForApplication.btnSelectProjectLaunchImageClick(
  Sender: TObject);
begin
  if Self.opdSelectProjectLaunchImage.Execute(Handle) then
  begin
    Self.imgProjectLaunchImage.Picture.LoadFromFile
      (Self.opdSelectProjectLaunchImage.FileName);
    FProjectLaunchImageFileName := Self.opdSelectProjectLaunchImage.FileName;
  end;
end;

procedure TFrmCreateIconsForApplication.cmbProjectLaunchBackColorClick(Sender:
  TObject);
var
  ABackColor: TColor;
  AColorStr:  String;
begin
  ABackColor := Self.cmbProjectLaunchBackColor.Selected;
  // 0BGR
  AColorStr := 'FF'
    + IntToHex(Byte(ABackColor), 2)
    + IntToHex((ABackColor and $0000FF00) shr 8, 2)
    + IntToHex((ABackColor and $00FF0000) shr 16, 2);

  Self.edtProjectLaunchBackColor.Text := AColorStr;
end;

function TFrmCreateIconsForApplication.FileName(AFilename: String): TFrmCreateIconsForApplication;
begin
  Result := Self;
  FFileName := AFilename.Trim;
  edtProjectFilePath.Text := AFilename.Trim;
end;

procedure TFrmCreateIconsForApplication.FormClose(Sender: TObject; var Action:
    TCloseAction);
begin
  if Assigned(Self.FProjectConfig) then
    Self.FProjectConfig.Free;
end;

procedure TFrmCreateIconsForApplication.FormCreate(Sender: TObject);
var
  Project : IOTAProject;
begin
  inherited;
  {$IF CompilerVersion >= 32.0}
    (BorlandIDEServices as IOTAIDEThemingServices).RegisterFormClass(TFrmCreateIconsForApplication);
    (BorlandIDEServices as IOTAIDEThemingServices).ApplyTheme(Self);
  {$ENDIF}

  Project := GetActiveProject;

  if ((UpperCase(Project.ApplicationType).Equals('APPLICATION')) or
      (UpperCase(Project.ApplicationType).Equals('CONSOLE')) or
      (UpperCase(Project.ApplicationType).Equals('LIBRARY'))
     )
  then edtProjectFilePath.Text := Project.FileName
  else edtProjectFilePath.Text := EmptyStr;
end;

end.
