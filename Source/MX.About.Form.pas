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
  Winapi.Windows,

  MX.Template.Form;

type
  TFrmAbout = class(TFrmTemplate)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

procedure TFrmAbout.FormCreate(Sender: TObject);
begin
  inherited;
  {$IF CompilerVersion >= 32.0}
    (BorlandIDEServices as IOTAIDEThemingServices).RegisterFormClass(TFrmAbout);
    (BorlandIDEServices as IOTAIDEThemingServices).ApplyTheme(Self);
  {$ENDIF}
end;

end.
