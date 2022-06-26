unit MX.MainMenu.Wizard;

interface

uses
  ToolsApi,
  System.SysConst,
  System.Classes,
  Vcl.Dialogs,
  Vcl.Menus;

type
  TMXMainMenuWizard = class(TNotifierObject, IOTAWizard)
  private
    procedure createMenu;
    function CreateSubMenu(AParent: TMenuItem; ACaption: string;
      AName: string; AOnClick: TNotifyEvent): TMenuItem;
    procedure About(Sender: TObject);

    procedure OnClickCreateIconsForApplication(Sender: TObject);
  protected
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;

    { Launch the AddIn }
    procedure Execute;
  public
    constructor Create;
  end;

procedure RegisterMainMenuWizard;

implementation

uses
  MX.CreateIconsForApplication.Form;

procedure RegisterMainMenuWizard;
begin
  RegisterPackageWizard(TMXMainMenuWizard.Create);
end;

{ TMXMainMenuWizard }

procedure TMXMainMenuWizard.About(Sender: TObject);
begin
  ShowMessage('Mobile Experts was created by Adriano Santos - Brazilian MVP');
end;

constructor TMXMainMenuWizard.Create;
begin
  createMenu;
end;

procedure TMXMainMenuWizard.createMenu;
var
  LMainMenuDelphi:   TMainMenu;
  LMenuName:         string;
  itemMobileExperts: TMenuItem;
begin
  LMainMenuDelphi := (BorlandIDEServices as INTAServices).MainMenu;
  LMenuName       := 'imMobileExperts';

  if LMainMenuDelphi.FindComponent(LMenuName) <> nil then
    LMainMenuDelphi.FindComponent(LMenuName).Free;

  itemMobileExperts         := TMenuItem.Create(LMainMenuDelphi);
  itemMobileExperts.Name    := LMenuName;
  itemMobileExperts.Caption := 'Mobile Experts';

  LMainMenuDelphi.Items.Add(itemMobileExperts);


  CreateSubMenu(itemMobileExperts, 'Create Icons for Mobile Project...', 'imCreateIcons', OnClickCreateIconsForApplication);
  CreateSubMenu(itemMobileExperts, 'Update Project to This Delphi...', 'imUpdateProject', nil);
  CreateSubMenu(itemMobileExperts, '-', 'imDiv10', nil);
  CreateSubMenu(itemMobileExperts, 'About Mobile Experts', 'imAbout', About);
end;

function TMXMainMenuWizard.CreateSubMenu(AParent: TMenuItem; ACaption,
  AName: string; AOnClick: TNotifyEvent): TMenuItem;
begin
  Result         := TMenuItem.Create(AParent);
  Result.Caption := ACaption;
  Result.Name    := AName;
  Result.OnClick := AOnClick;

  AParent.Add(Result);
end;

procedure TMXMainMenuWizard.Execute;
begin

end;

function TMXMainMenuWizard.GetIDString: string;
begin
  Result := Self.ClassName;
end;

function TMXMainMenuWizard.GetName: string;
begin
  Result := Self.ClassName;
end;

function TMXMainMenuWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TMXMainMenuWizard.OnClickCreateIconsForApplication(Sender: TObject);
var
  FrmCreateIconsForApplication : TFrmCreateIconsForApplication;
begin
  FrmCreateIconsForApplication := TFrmCreateIconsForApplication.Create(nil);
  try
    FrmCreateIconsForApplication.ShowModal;
  finally
    FrmCreateIconsForApplication.Free;
  end;
end;

end.
