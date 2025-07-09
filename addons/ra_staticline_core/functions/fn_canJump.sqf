/*
    Function: RA_fnc_canJump
    Description: Returns true if the player is inside a valid aircraft.

    Params:
        _unit (Object): The unit (usually player)

    Returns:
        Boolean — true if in a valid aircraft
*/
params ["_unit"];
diag_log format ["[RA] Parachute equipped setting = %1", missionNamespace getVariable ["RA_StaticEquipped", true]];

private _veh = vehicle _unit;
diag_log format ["[RA] canJump check: Vehicle = %1", typeOf _veh];

if (_veh isEqualTo _unit) exitWith {
    diag_log "[RA] canJump -> false (not in vehicle)";
    false
};

private _valid = [_veh] call RA_fnc_isValidAircraft;
diag_log format ["[RA] canJump -> %1", _valid];
_valid
