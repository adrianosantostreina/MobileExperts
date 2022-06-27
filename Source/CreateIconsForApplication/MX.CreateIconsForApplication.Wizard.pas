unit MX.CreateIconsForApplication.Wizard;

interface

uses
  ToolsApi,
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs;

type
  TMXCreateIconsForApplicationContextMenu = class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
  protected
    procedure AddMenu(const Project: IOTAProject; const IdentList: TStrings;
      const ProjectManagerMenuList: IInterfaceList; IsMultiSelect: Boolean);
  public
    class function New: IOTAProjectMenuItemCreatorNotifier;
  end;

  TMXCreateIconsForApplicationContextMenuItemMenu = class(TNotifierObject, IOTALocalMenu, IOTAProjectManagerMenu)
    protected
      { Returns the Caption to be used for this menu item }
      function GetCaption: string;
      { Returns the Checked state to be used for this menu item }
      function GetChecked: Boolean;
      { Returns the Enabled state to be used for this menu item }
      function GetEnabled: Boolean;
      { Returns the help context to be used for this menu item }
      function GetHelpContext: Integer;
      { Returns the Name for this menu item.  If blank, a name will be generated }
      function GetName: string;
      { Returns the parent menu for this menu item }
      function GetParent: string;
      { Returns the position of this menu item within the menu }
      function GetPosition: Integer;
      { Returns the verb associated with this menu item }
      function GetVerb: string;
      { Sets the Caption of the menu item to the specified value }
      procedure SetCaption(const Value: string);
      { Sets the Checked state of the menu item to the specified value }
      procedure SetChecked(Value: Boolean);
      { Sets the Enabled  state of the menu item to the specified value }
      procedure SetEnabled(Value: Boolean);
      { Sets the help context of the menu item to the specified value }
      procedure SetHelpContext(Value: Integer);
      { Sets the Name of the menu item to the specified value }
      procedure SetName(const Value: string);
      { Sets the Parent of the menu item to the specified value }
      procedure SetParent(const Value: string);
      { Sets the position of the menu item to the specified value }
      procedure SetPosition(Value: Integer);
      { Sets the verb associated with the menu item to the specified value }
      procedure SetVerb(const Value: string);

      { Indicates whether or not this menu item supports multi-selected items }
      function GetIsMultiSelectable: Boolean;
      { Sets this menu item's multi-selected state }
      procedure SetIsMultiSelectable(Value: Boolean);
      { Execute is called when the menu item is selected.  MenuContextList is a
        list of IOTAProjectMenuContext.  Each item in the list represents an item
        in the project manager that is selected }
      procedure Execute(const MenuContextList: IInterfaceList); overload;
      { PreExecute is called before the Execute method.  MenuContextList is a list
        of IOTAProjectMenuContext.  Each item in the list represents an item in
        the project manager that is selected }
      function PreExecute(const MenuContextList: IInterfaceList): Boolean;
      { PostExecute is called after the Execute method.  MenuContextList is a list
        of IOTAProjectMenuContext.  Each item in the list represents an item in
        the project manager that is selected }
      function PostExecute(const MenuContextList: IInterfaceList): Boolean;
    public
      class function New: IOTAProjectManagerMenu;
  end;

var
  Index : Integer = -1;

procedure RegisterCreateIconsForApplication;

implementation

uses
  MX.CreateIconsForApplication.Form;

procedure RegisterCreateIconsForApplication;
begin
  Index := (BorlandIDEServices as IOTAProjectManager)
    .AddMenuItemCreatorNotifier(TMXCreateIconsForApplicationContextMenu.New)
end;

{ TMXCreateIconsForApplication }

procedure TMXCreateIconsForApplicationContextMenu.AddMenu(const Project: IOTAProject;
  const IdentList: TStrings; const ProjectManagerMenuList: IInterfaceList;
  IsMultiSelect: Boolean);
begin
  if (IdentList.IndexOf(sProjectContainer)) < 0 then
    exit;

  ProjectManagerMenuList.Add(TMXCreateIconsForApplicationContextMenuItemMenu.New);
end;

class function TMXCreateIconsForApplicationContextMenu.New: IOTAProjectMenuItemCreatorNotifier;
begin
  Result := Self.Create;
end;

{ TMXCreateIconsForApplicationContextMenuItemMenu }

procedure TMXCreateIconsForApplicationContextMenuItemMenu.Execute(
  const MenuContextList: IInterfaceList);
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

function TMXCreateIconsForApplicationContextMenuItemMenu.GetCaption: string;
begin
  Result := 'Create Icons for Application...';
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.GetChecked: Boolean;
begin
  Result := False;
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.GetEnabled: Boolean;
begin
  Result := True;
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.GetHelpContext: Integer;
begin
  Result := 0;
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.GetIsMultiSelectable: Boolean;
begin
  Result := False;
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.GetName: string;
begin
  Result := Self.ClassName;
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.GetParent: string;
begin
  Result := EmptyStr;
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.GetPosition: Integer;
begin
  Result := pmmpExplore + 100;
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.GetVerb: string;
begin
  Result := 'CreateIconsforApplication';
end;

class function TMXCreateIconsForApplicationContextMenuItemMenu.New: IOTAProjectManagerMenu;
begin
  Result := Self.Create;
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.PostExecute(
  const MenuContextList: IInterfaceList): Boolean;
begin
  //
end;

function TMXCreateIconsForApplicationContextMenuItemMenu.PreExecute(
  const MenuContextList: IInterfaceList): Boolean;
begin
  //
end;

procedure TMXCreateIconsForApplicationContextMenuItemMenu.SetCaption(
  const Value: string);
begin

end;

procedure TMXCreateIconsForApplicationContextMenuItemMenu.SetChecked(
  Value: Boolean);
begin

end;

procedure TMXCreateIconsForApplicationContextMenuItemMenu.SetEnabled(
  Value: Boolean);
begin

end;

procedure TMXCreateIconsForApplicationContextMenuItemMenu.SetHelpContext(
  Value: Integer);
begin

end;

procedure TMXCreateIconsForApplicationContextMenuItemMenu.SetIsMultiSelectable(
  Value: Boolean);
begin

end;

procedure TMXCreateIconsForApplicationContextMenuItemMenu.SetName(
  const Value: string);
begin

end;

procedure TMXCreateIconsForApplicationContextMenuItemMenu.SetParent(
  const Value: string);
begin

end;

procedure TMXCreateIconsForApplicationContextMenuItemMenu.SetPosition(
  Value: Integer);
begin

end;

procedure TMXCreateIconsForApplicationContextMenuItemMenu.SetVerb(
  const Value: string);
begin

end;

initialization

finalization
  (BorlandIDEServices as IOTAProjectManager)
    .RemoveMenuItemCreatorNotifier(Index);

end.
