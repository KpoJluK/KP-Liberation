/*
    KP LIBERATION MODULE INITIALIZATION

    File: initModule.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-06-02
    Last Update: 2018-08-04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    This module provides the KP player menu.
    The chosen settings in this dialog will be persistent for a player on all servers which run a mission who uses this dialog.
    It provides the following functionalities to the player:
        * Group Management
        * View Distances
        * Sound Settings

    Dependencies:
        * KP GUI system
*/

// Read the module globals
call compile preprocessFileLineNumbers "modules\99_plm\globals.sqf";

// Load settings, if available
private _settings = profileNamespace getVariable ["KP_PLM_Settings", []];
if !(_settings isEqualTo []) then {
    KPLIB_plm_viewFoot = _settings select 0;
    KPLIB_plm_viewVeh = _settings select 1;
    KPLIB_plm_viewAir = _settings select 2;
    KPLIB_plm_terrain = _settings select 3;
    KPLIB_plm_tpv = _settings select 4;
    KPLIB_plm_radio = _settings select 5;
    KPLIB_plm_soundVeh = _settings select 6;
};

// Add event handler
if (hasInterface) then {
    player addEventHandler ["GetInMan", {[] call KPLIB_fnc_plm_getInOut}];
    player addEventHandler ["GetOutMan", {[] call KPLIB_fnc_plm_getInOut}];
};

// Apply default/loaded values
[] call KPLIB_fnc_plm_apply;