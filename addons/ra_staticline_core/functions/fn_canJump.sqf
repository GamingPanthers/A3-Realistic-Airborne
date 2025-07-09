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

// Must be in vehicle (not on foot)
if (_veh isEqualTo _unit) exitWith { false };

// Must be valid aircraft
[_veh] call RA_fnc_isValidAircraft
