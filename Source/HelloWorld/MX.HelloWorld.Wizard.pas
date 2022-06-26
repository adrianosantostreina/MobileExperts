unit MX.HelloWorld.Wizard;

interface

uses
  ToolsAPI,
  Vcl.Dialogs;

type
  TMXHelloWorldWizard = class(TNotifierObject, IOTAWizard, IOTAMenuWizard)

  protected
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    function GetMenuText: string;

    { Launch the AddIn }
    procedure Execute;
  end;

procedure RegisterHelloWorldWizard;

implementation

procedure RegisterHelloWorldWizard;
begin
  RegisterPackageWizard(TMXHelloWorldWizard.Create);
end;

{ TMXHelloWorldWizard }

procedure TMXHelloWorldWizard.Execute;
begin
  ShowMessage('Wizard created by Adriano Santos - Brazilian MVP');
end;

function TMXHelloWorldWizard.GetIDString: string;
begin
  Result := 'HelloWorld';
end;

function TMXHelloWorldWizard.GetMenuText: string;
begin
  Result := 'Mobile Experts';
end;

function TMXHelloWorldWizard.GetName: string;
begin
  Result := 'Hello World';
end;

function TMXHelloWorldWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

end.
