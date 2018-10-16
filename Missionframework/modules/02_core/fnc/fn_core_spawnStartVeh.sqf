/*
    KPLIB_fnc_core_spawnStartVeh

    File: fn_core_spawnStartVeh.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2017-05-01
    Last Update: 2018-09-03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Spawning of the start vehicles like the little birds and rubber dinghies. Also spawns crew for the destroyer weapon systems.

    Parameter(s):
    NONE

    Returns:
    BOOL
*/

// Go through the available markers for the little bird spawn. Adapts to the amount of placed markers.
for [{_i=0}, {!isNil ("KPLIB_eden_littlebird_" + str _i)}, {_i = _i + 1}] do {
    // Get the spawn point grasscutter
    private _spawnPoint = missionNamespace getVariable ("KPLIB_eden_littlebird_" + str _i);

    // Current position for the spawn
    private _spawnPos = getPosATL _spawnPoint;

    // Spawn the vehicle at the spawn position with a slight height offset.
    [KPLIB_preset_addHeli, [_spawnPos select 0, _spawnPos select 1, (_spawnPos select 2) + 0.1], getDir _spawnPoint] call KPLIB_fnc_common_spawnVehicle;
};

// Spawn the boats and move them in the boat racks
for [{_i=0}, {!isNil ("KPLIB_eden_boat_" + str _i)}, {_i = _i + 1}] do {
    // Get the current rack
    _spawnPoint = missionNamespace getVariable ("KPLIB_eden_boat_" + str _i);

    // Spawn the boat
    private _boat = [KPLIB_preset_addBoat, KPLIB_zeroPos, getDir _spawnPoint, true] call KPLIB_fnc_common_spawnVehicle;

    // Move the boat to the rack
    _spawnPoint setVehicleCargo _boat;
};

// Spawn crew for the destroyer weapons, so they're available through the UAV terminal
for [{_i=0}, {!isNil ("KPLIB_eden_destroyer_w" + str _i)}, {_i = _i + 1}] do {
    // Get the current weapon
    private _weapon = missionNamespace getVariable ("KPLIB_eden_destroyer_w" + str _i);

    // Create crew
    createVehicleCrew _weapon;
};

true