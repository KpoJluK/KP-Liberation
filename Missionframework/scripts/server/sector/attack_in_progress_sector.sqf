params [ "_sector" ];
private [ "_attacktime", "_ownership", "_grp", "_squad_type" ];

sleep 5;

_ownership = [ markerpos _sector ] call KPLIB_fnc_getSectorOwnership;
if ( _ownership != KPLIB_side_enemy ) exitWith {};

_squad_type = blufor_squad_inf_light;
if ( _sector in KPLIB_sectors_military ) then {
    _squad_type = blufor_squad_inf;
};

if ( KPLIB_blufor_defenders ) then {
    _grp = creategroup [KPLIB_side_friendly, true];
    {
        [_x, markerPos _sector, _grp] call KPLIB_fnc_createManagedUnit;
    } foreach _squad_type;
    sleep 3;
    _grp setBehaviour "COMBAT";
};

sleep 60;

_ownership = [ markerpos _sector ] call KPLIB_fnc_getSectorOwnership;
if ( _ownership == KPLIB_side_friendly ) exitWith {
    if ( KPLIB_blufor_defenders ) then {
        {
            if ( alive _x ) then { deleteVehicle _x };
        } foreach units _grp;
    };
};

[_sector, 1] remoteExec ["remote_call_sector"];
_attacktime = KPLIB_vulnerability_timer;

while { _attacktime > 0 && ( _ownership == KPLIB_side_enemy || _ownership == KPLIB_side_resistance ) } do {
    _ownership = [markerpos _sector] call KPLIB_fnc_getSectorOwnership;
    _attacktime = _attacktime - 1;
    sleep 1;
};

waitUntil {
    sleep 1;
    [markerpos _sector] call KPLIB_fnc_getSectorOwnership != KPLIB_side_resistance;
};

if ( KPLIB_endgame == 0 ) then {
    if ( _attacktime <= 1 && ( [markerpos _sector] call KPLIB_fnc_getSectorOwnership == KPLIB_side_enemy ) ) then {
        KPLIB_sectors_player = KPLIB_sectors_player - [ _sector ];
        publicVariable "KPLIB_sectors_player";
        [_sector, 2] remoteExec ["remote_call_sector"];
        reset_battlegroups_ai = true;
        [] spawn KPLIB_fnc_doSave;
        stats_sectors_lost = stats_sectors_lost + 1;
        {
            if (_sector in _x) exitWith {
                if ((count (_x select 3)) == 3) then {
                    {
                        detach _x;
                        deleteVehicle _x;
                    } forEach (attachedObjects ((nearestObjects [((_x select 3) select 0), [KPLIB_small_storage_building], 10]) select 0));

                    deleteVehicle ((nearestObjects [((_x select 3) select 0), [KPLIB_small_storage_building], 10]) select 0);
                };
                KPLIB_production = KPLIB_production - [_x];
            };
        } forEach KPLIB_production;
    } else {
        [_sector, 3] remoteExec ["remote_call_sector"];
        {[_x] spawn prisonner_ai;} foreach (((markerpos _sector) nearEntities ["Man", KPLIB_capture_size * 0.8]) select {side group _x == KPLIB_side_enemy});
    };
};

sleep 60;

if ( KPLIB_blufor_defenders ) then {
    {
        if ( alive _x ) then { deleteVehicle _x };
    } foreach units _grp;
};