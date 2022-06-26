unit MX.Register;

interface

uses
  ToolsApi,
  MX.HelloWorld.Wizard,
  MX.MainMenu.Wizard,
  MX.NewProject.Wizard,
  MX.CreateIconsForApplication.Wizard,
  MX.Splash;

procedure Register;

implementation

procedure Register;
begin
  AddSplash;
  RegisterHelloWorldWizard;
  RegisterMainMenuWizard;
  RegisterRepositoryWizard;
  RegisterCreateIconsForApplication;
end;

end.
