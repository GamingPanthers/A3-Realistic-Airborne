/*
    Function: RA_fnc_canJump
    Description: Returns true if the player is inside a valid aircraft at sufficient altitude.
    
    Author: GamingPanthers
    Version: 1.1
    
    Params:
        _unit (Object): The unit (usually player)

    Returns:
        Boolean — true if in a valid aircraft at jump altitude
*/

params ["_unit"];

private _veh = vehicle _unit;
diag_log format ["[RA] canJump check: Unit = %1, Vehicle = %2", name _unit, typeOf _veh];

// Not in a vehicle
if (_veh isEqualTo _unit) exitWith {
    diag_log "[RA] canJump -> false (not in vehicle)";
    false
};

// Check if valid aircraft
private _validAircraft = [_veh] call RA_fnc_isValidAircraft;
if (!_validAircraft) exitWith {
    diag_log format ["[RA] canJump -> false (invalid aircraft: %1)", typeOf _veh];
    false
};

// Check altitude (use global variables with fallback)
private _altitude = (getPosATL _veh) select 2;
private _minAltitude = missionNamespace getVariable ["RA_MinAltitude", 100];
private _maxAltitude = missionNamespace getVariable ["RA_MaxAltitude", 3000];

if (_altitude < _minAltitude) exitWith {
    diag_log format ["[RA] canJump -> false (altitude %1 < minimum %2)", round _altitude, _minAltitude];
    false
};

if (_altitude > _maxAltitude) exitWith {
    diag_log format ["[RA] canJump -> false (altitude %1 > maximum %2)", round _altitude, _maxAltitude];
    false
};

// Check if unit is passenger (not pilot/copilot/gunner)
private _isPilot = (_unit == driver _veh) || (_unit == gunner _veh) || (_unit == commander _veh);
if (_isPilot) exitWith {
    diag_log "[RA] canJump -> false (unit is pilot/gunner/commander)";
    false
};

// Check if aircraft is moving (minimum speed for realistic jump)
private _speed = speed _veh;
private _minSpeed = 50; // 50 km/h minimum
if (_speed < _minSpeed) exitWith {
    diag_log format ["[RA] canJump -> false (speed %1 < minimum %2 km/h)", round _speed, _minSpeed];
    false
};

// Check if aircraft is in suitable orientation (not upside down, etc.)
private _pitch = ((vectorUp _veh) vectorCos (vectorUp _veh)) * 90;
private _roll = ((vectorDir _veh) vectorCos (vectorDir _veh)) * 90;
if (abs _pitch > 45 || abs _roll > 45) exitWith {
    diag_log format ["[RA] canJump -> false (unsafe orientation: pitch %1, roll %2)", round _pitch, round _roll];
    false
};

// Check if doors are open (if applicable)
private _doorsOpen = true;
if (_veh getVariable ["RA_RequireDoorsOpen", false]) then {
    _doorsOpen = _veh animationPhase "door_R" > 0.5 || _veh animationPhase "door_L" > 0.5;
    if (!_doorsOpen) exitWith {
        diag_log "[RA] canJump -> false (doors not open)";
        false
    };
};

// All checks passed
diag_log format ["[RA] canJump -> true (altitude: %1m, speed: %2 km/h)", round _altitude, round _speed];
true