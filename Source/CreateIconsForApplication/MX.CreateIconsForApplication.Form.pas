unit MX.CreateIconsForApplication.Form;

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
  Winapi.Windows, Vcl.StdCtrls;

type
  TFrmCreateIconsForApplication = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    ListBox1: TListBox;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


procedure TFrmCreateIconsForApplication.FormShow(Sender: TObject);
var
  I : Integer;
begin
  {$IF CompilerVersion >= 32.0}
    (BorlandIDEServices as IOTAIDEThemingServices250).RegisterFormClass(TFrmCreateIconsForApplication);
    for I := 0 to Pred(ComponentCount) do
    begin
      (BorlandIDEServices as IOTAIDEThemingServices250).ApplyTheme(Components[I]);
    end;
  {$EndIF}
end;

end.
