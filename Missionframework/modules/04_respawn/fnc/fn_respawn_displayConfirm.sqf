#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_respawn_displayConfirm

    File: fn_respawn_displayConfirm.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-09-12
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Handles respawn confirmation

    Parameter(s):
        _display - Respawn display [DISPLAY, defaults to nil]

    Returns:
        Function reached the end [BOOL]
*/
params [
    ["_display", nil, [displayNull]]
];

private _respawnItem = (_display getVariable "KPLIB_selRespawn");
private _respawnPos = [(_respawnItem select 1)] call KPLIB_fnc_common_getPos;

private _respawnLoadout = (_display getVariable "KPLIB_selLoadout");

private _buildingPos = [_respawnPos, 0, 30] call BIS_fnc_findSafePos;

// Spawn the player at selected position
[[(_buildingPos select 0), (_buildingPos select 1), 0], _respawnLoadout] call KPLIB_fnc_respawn_spawnPlayer;

true
