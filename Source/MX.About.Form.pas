unit MX.About.Form;

interface

uses
  ToolsApi,
  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows;

type
  TFrmAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

procedure TFrmAbout.FormShow(Sender: TObject);
var
  I : Integer;
begin
  {$IF CompilerVersion >= 32.0}
    (BorlandIDEServices as IOTAIDEThemingServices250).RegisterFormClass(TFrmAbout);

    for I := 0 to Pred(ComponentCount) do
    begin
      (BorlandIDEServices as IOTAIDEThemingServices250).ApplyTheme(Components[I]);
    end;
  {$EndIF}
end;

end.
