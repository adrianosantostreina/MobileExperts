unit MX.Splash;

interface

uses
  ToolsApi,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics;

procedure AddSplash;

implementation

procedure AddSplash;
var
  bitmap: TBitmap;
begin
  bitmap := TBitmap.Create;
  try
    bitmap.LoadFromResourceName(HInstance, 'logo');
    SplashScreenServices.AddPluginBitmap(
      'Mobile Experts',
      bitmap.Handle,
      False,
      '',
      ''
    );

  finally
    bitmap.Free;
  end;
end;


end.
