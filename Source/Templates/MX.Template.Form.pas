unit MX.Template.Form;

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

  Winapi.Messages,
  Winapi.Windows;

type
  TFrmTemplate = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTemplate: TFrmTemplate;

implementation

{$R *.dfm}

procedure TFrmTemplate.FormCreate(Sender: TObject);
begin
  {$IF CompilerVersion >= 32.0}
    (BorlandIDEServices as IOTAIDEThemingServices).RegisterFormClass(TFrmTemplate);
    (BorlandIDEServices as IOTAIDEThemingServices).ApplyTheme(Self);
  {$ENDIF}
end;

end.
