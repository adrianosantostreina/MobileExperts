unit Unit1;

interface

uses
  ToolsApi,
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Vcl.Dialogs;

type
  TMXNewRepositoryWizard = class(TNotifierObject, IOTAWizard, IOTAProjectWizard, IOTARepositoryWizard)
    protected
      function GetIDString: string;
      function GetName: string;
      function GetState: TWizardState;

      { Launch the AddIn }
      procedure Execute;
    public

  end;


implementation

end.
