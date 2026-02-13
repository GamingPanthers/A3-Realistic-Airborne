/*
    Function: RA_fnc_isValidAircraft
    Description: Checks if vehicle is a valid aircraft for static line jumping.
    Author: GamingPanthers
    Version: 1.0.3
*/

params ["_vehicle"];

if (isNull _vehicle) exitWith { false };

// Default list fallback
if (isNil "RA_validAircraft") then {
    RA_validAircraft = [
        "B_Heli_Transport_01_F",
        "B_Heli_Transport_03_F",
        "O_Heli_Transport_04_F",
        "I_Heli_Transport_02_F",
        "C_Plane_Civil_01_F"
    ];
};

private _vehicleType = toLower (typeOf _vehicle);
private _validTypes = RA_validAircraft apply { toLower _x };

private _isValid = _vehicleType in _validTypes;

// Inheritance check
if (!_isValid) then {
    if (_vehicle isKindOf "Helicopter_Base_F" || _vehicle isKindOf "Helicopter_Base_H" || _vehicle isKindOf "Plane") then {
        private _cargoSeats = [_vehicle, true] call BIS_fnc_crewCount;
        private _totalSeats = [_vehicle, false] call BIS_fnc_crewCount;
        
        if ((_totalSeats - _cargoSeats) > 0) then {
            _isValid = true;
        };
    };
};

// Mission override
private _missionOverride = _vehicle getVariable ["RA_StaticLineCapable", nil];
if (!isNil "_missionOverride") then {
    _isValid = _missionOverride;
};

// Safety checks
if (_isValid) then {
    if (!alive _vehicle || !canMove _vehicle) then {
        _isValid = false;
    };
    
    // Check altitude capability (OPTIMIZED: used configOf)
    private _maxAltitude = getNumber (configOf _vehicle >> "altFullForce");
    if (_maxAltitude > 0 && _maxAltitude < 1000) then {
        _isValid = false;
    };
};

_isValid