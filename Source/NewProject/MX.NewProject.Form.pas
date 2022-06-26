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
  Winapi.Windows;

type
  TFrmNewProject = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

procedure TFrmNewProject.FormShow(Sender: TObject);
var
  I : Integer;
begin
  {$IF CompilerVersion >= 32.0}
    (BorlandIDEServices as IOTAIDEThemingServices260).RegisterFormClass(TFrmNewProject);
    for I := 0 to Pred(ComponentCount) do
    begin
      (BorlandIDEServices as IOTAIDEThemingServices260).ApplyTheme(Components[I]);
    end;
  {$EndIF}
end;

end.
