unit MX.NewProject.Form;

interface

uses
  ToolsAPI,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows,

  MX.Template.Form;

type
  TFrmNewProject = class(TFrmTemplate)
    Panel1: TPanel;
    Image1: TImage;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrmNewProject.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmNewProject.FormCreate(Sender: TObject);
begin
  inherited;
  {$IF CompilerVersion >= 32.0}
    (BorlandIDEServices as IOTAIDEThemingServices).RegisterFormClass(TFrmNewProject);
    (BorlandIDEServices as IOTAIDEThemingServices).ApplyTheme(Self);
  {$ENDIF}
end;

end.
