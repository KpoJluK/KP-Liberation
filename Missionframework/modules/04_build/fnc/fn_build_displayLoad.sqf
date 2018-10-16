#include "..\ui\defines.hpp"
#include "script_components.hpp"
/*
    KPLIB_fnc_build_displayLoad

    File: fn_build_displayLoad.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-09-09
    Last Update: 2018-10-08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Handle build display load

    Parameter(s):
        0: DISPLAY - Build display

    Returns:
    NOTHING
*/
params [["_display", nil, [displayNull]]];

// Add Item selection handler
private _itemsList = _display displayCtrl KPLIB_IDC_BUILD_ITEM_LIST;
_itemsList ctrlAddEventHandler ["LBSelChanged", {
    params ["_control", "_selectedIndex"];

    private _mode = LGVAR(buildMode);

    if(_selectedIndex == -1) exitWith {
        LSVAR("buildItem", []);
    };

    private _buildList = KPLIB_preset_buildLists select _mode;
    private _selectedItem = _buildList select _selectedIndex;

    LSVAR("buildItem", _selectedItem);
}];

// Add build confirmation handler
private _confirmButton = _display displayCtrl KPLIB_IDC_BUILD_CONFIRM;
_confirmButton ctrlAddEventHandler ["buttonClick", {

    // TODO implement build queue handling (resource check etc.)
    systemChat "buildConfirm: Resource check not implemented yet!";
    {
        private _dirAndUp = [vectorDir _x, vectorUp _x];
        private _pos = getPos _x;
        private _class = typeOf _x;

        deleteVehicle _x;

        [[[_class, _pos, 0, true], _dirAndUp], {
            private _obj = (_this select 0) call KPLIB_fnc_common_spawnVehicle;
            _obj setVectorDirAndUp (_this select 1);
        }] remoteExecCall ["call", 2];
        //_obj setVectorDirAndUp _dirAndUp;

    } forEach LGVAR(buildQueue);
}];

// Add tab change handler
{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["buttonClick", {
        _this call KPLIB_fnc_build_displayTabClick;
    }];
} forEach KPLIB_BUILD_TABS_IDCS_ARRAY;

// Hide vignette, show hud
private _vignette = _display displayCtrl 1202;
_vignette ctrlShow false;
showHUD true;

LSVAR("display", _display);
LGVAR_D(buildMode, 0) call KPLIB_fnc_build_displaySetMode;

/* Seems to be buggy on triple screen, disable for now
 setMousePosition LGVAR(mousePos); */
