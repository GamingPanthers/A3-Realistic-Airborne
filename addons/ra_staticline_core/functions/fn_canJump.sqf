/*
    Function: RA_fnc_canJump
    Description: Returns true if the player is inside a valid aircraft at sufficient altitude.

    Params:
        _unit (Object): The unit (usually player)

    Returns:
        Boolean — true if in a valid aircraft at jump altitude
*/
params ["_unit"];

private _veh = vehicle _unit;
diag_log format ["[RA] canJump check: Vehicle = %1", typeOf _veh];

// Not in a vehicle
if (_veh isEqualTo _unit) exitWith {
    diag_log "[RA] canJump -> false (not in vehicle)";
    false
};

// Check if valid aircraft
private _validAircraft = [_veh] call RA_fnc_isValidAircraft;
if (!_validAircraft) exitWith {
    diag_log "[RA] canJump -> false (invalid aircraft)";
    false
};

// Check altitude (minimum 100m AGL)
private _altitude = (getPosATL _veh) select 2;
private _minAltitude = 100;
if (_altitude < _minAltitude) exitWith {
    diag_log format ["[RA] canJump -> false (altitude %1 < %2)", _altitude, _minAltitude];
    false
};

// Check if unit is passenger (not pilot/copilot)
private _isPilot = (_unit == driver _veh) || (_unit == gunner _veh);
if (_isPilot) exitWith {
    diag_log "[RA] canJump -> false (unit is pilot/gunner)";
    false
};

// All checks passed
diag_log format ["[RA] canJump -> true (altitude: %1m)", round _altitude];
true