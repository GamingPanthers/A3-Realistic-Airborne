/*
    Function: RA_fnc_canJump
    Description: Returns true if the player is inside a valid aircraft at sufficient altitude.
    Author: GamingPanthers
    Version: 1.0.3
*/

params ["_unit"];
private _veh = objectParent _unit;

// Not in a vehicle
if (isNull _veh) exitWith {
    false
};

// Check if valid aircraft
if (!([_veh] call RA_fnc_isValidAircraft)) exitWith {
    false
};

// Check altitude
private _altitude = (getPosATL _veh) select 2;
private _minAltitude = missionNamespace getVariable ["RA_MinAltitude", 100];
private _maxAltitude = missionNamespace getVariable ["RA_MaxAltitude", 3000];

if (_altitude < _minAltitude || _altitude > _maxAltitude) exitWith {
    false
};

// Check if unit is passenger (not pilot/copilot/gunner)
private _isPilot = (_unit == driver _veh) || (_unit == gunner _veh) || (_unit == commander _veh);
if (_isPilot) exitWith {
    false
};

// Check if aircraft is moving (minimum 50 km/h)
private _speed = speed _veh;
if (_speed < 50) exitWith {
    false
};

// Check orientation (pitch/roll < 45 degrees)
private _pitch = ((vectorUp _veh) vectorCos (vectorUp _veh)) * 90;
private _roll = ((vectorDir _veh) vectorCos (vectorDir _veh)) * 90;
if (abs _pitch > 45 || abs _roll > 45) exitWith {
    false
};

// Check doors
private _doorsOpen = true;
if (_veh getVariable ["RA_RequireDoorsOpen", false]) then {
    _doorsOpen = (_veh animationPhase "door_R" > 0.5) || (_veh animationPhase "door_L" > 0.5);
};

if (!_doorsOpen) exitWith { false };

true