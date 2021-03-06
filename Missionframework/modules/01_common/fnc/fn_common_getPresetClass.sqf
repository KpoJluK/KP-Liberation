/*
    KPLIB_fnc_common_getPresetClass

    File: fn_common_getPresetClass.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-12-08
    Last Update: 2019-06-09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Gets class or array of given type from preset.

    Parameter(s):
        _type       - Preset type name                                          [STRING, defaults to ""]
        _side       - Preset side                                               [SIDE, defaults to KPLIB_preset_sideE]
        _isArray    - Array of classnames (true) or single classname (false)    [BOOL, defaults to false]

    Returns:
        Classname from preset [STRING]
*/
params [
    ["_type", "", [""]],
    ["_side", KPLIB_preset_sideE, [sideEmpty]],
    ["_isArray", false, [false]]
];

// Determine classname side
private _sideSuffix = switch (_side) do {
    case KPLIB_preset_sideF: {"F"};
    case KPLIB_preset_sideR: {"R"};
    case KPLIB_preset_sideC: {"C"};
    default {"E"};
};

private _classNamesVar = format ["KPLIB_preset_%1%2", _type, _sideSuffix];

if (_isArray) then {
    _classNamesVar = format ["KPLIB_preset_%1Pl%2", _type, _sideSuffix];
};

private _classNames = missionNamespace getVariable [_classNamesVar, nil];

// Exit if there are no classnames of given type in preset
if (isNil "_classNames") exitWith {
    [format["Could not find preset variable '%1'", _classNamesVar], "COMMON", true] call KPLIB_fnc_common_log;
    ""
};

// Return classname(s)
_classNames
