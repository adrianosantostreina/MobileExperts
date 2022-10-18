unit MX.NewProject.Wizard;

interface

uses
  ToolsApi,
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  MX.NewProject.Form,
  Vcl.Dialogs;

type
  TMXNewRepositoryWizard = class(TNotifierObject, IOTAWizard, IOTAProjectWizard, IOTARepositoryWizard)
    protected
      function GetIDString: string;
      function GetName: string;
      function GetState: TWizardState;

      { Launch the AddIn }
      procedure Execute;

      function GetAuthor: string;
      function GetComment: string;
      function GetPage: string;
      { Handle to an Icon }
      function GetGlyph: Cardinal;
    public
      class function New: IOTAWizard;
  end;


procedure RegisterRepositoryWizard;

implementation


procedure RegisterRepositoryWizard;
begin
  RegisterPackageWizard(TMXNewRepositoryWizard.New);
end;

{ TMXNewRepositoryWizard }

procedure TMXNewRepositoryWizard.Execute;
var
  FrmNewProject : TFrmNewProject;
begin
  FrmNewProject := TFrmNewProject.Create(nil);
  try
    FrmNewProject.ShowModal;
  finally
    FrmNewProject.Free;
  end;
end;

function TMXNewRepositoryWizard.GetAuthor: string;
begin
  Result := 'Adriano Santos';
end;

function TMXNewRepositoryWizard.GetComment: string;
begin
  Result := 'New Mobile Project with Custom Features';
end;

function TMXNewRepositoryWizard.GetGlyph: Cardinal;
begin
  Result := 0;
end;

function TMXNewRepositoryWizard.GetIDString: string;
begin
  Result := Self.ClassName;
end;

function TMXNewRepositoryWizard.GetName: string;
begin
  Result := 'New Project...';
end;

function TMXNewRepositoryWizard.GetPage: string;
begin
  Result := 'Mobile Experts';
end;

function TMXNewRepositoryWizard.GetState: TWizardState;
begin
  Result := [];
end;

class function TMXNewRepositoryWizard.New: IOTAWizard;
begin
  Result := Self.Create;
end;

end.
