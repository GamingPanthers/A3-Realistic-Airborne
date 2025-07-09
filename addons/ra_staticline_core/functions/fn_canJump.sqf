/*
    Function: RA_fnc_canJump
    Description: Returns true if the player is inside a valid aircraft.

    Params:
        _unit (Object): The unit (usually player)

    Returns:
        Boolean — true if in a valid aircraft
*/

params ["_unit"];

private _veh = vehicle _unit;
private _vehType = typeOf _veh;

// Must be in vehicle (not on foot)
if (_veh isEqualTo _unit) exitWith {
    diag_log format ["[RA] canJump: %1 is on foot, cannot jump.", name _unit];
    false
};

// Check if valid aircraft
private _result = [_veh] call RA_fnc_isValidAircraft;
diag_log format ["[RA] canJump: %1 in %2 -> %3", name _unit, _vehType, _result];

_result
