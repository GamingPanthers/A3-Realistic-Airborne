/*
    Function: RA_fnc_isValidAircraft
    Description: Checks if vehicle is a valid aircraft for static line jumping.
    
    Author: GamingPanthers
    Version: 1.0.1

    Params:
        _vehicle (Object) — Vehicle to check

    Returns:
        Boolean — true if valid for static line jumping

    Example:
        [_vehicle] call RA_fnc_isValidAircraft;
*/

params ["_vehicle"];

// Null check
if (isNull _vehicle) exitWith {
    diag_log "[RA] isValidAircraft: Vehicle is null";
    false
};

// Ensure RA_validAircraft is defined
if (isNil "RA_validAircraft") then {
    diag_log "[RA] Warning: RA_validAircraft is undefined. Initializing with defaults.";
    RA_validAircraft = [
        // Default aircraft if list is missing
        "B_Heli_Transport_01_F",
        "B_Heli_Transport_03_F",
        "O_Heli_Transport_04_F",
        "I_Heli_Transport_02_F",
        "C_Plane_Civil_01_F"
    ];
};

private _vehicleType = toLower (typeOf _vehicle);
private _validTypes = RA_validAircraft apply { toLower _x };

// Check exact type match
private _isValid = _vehicleType in _validTypes;

// If not exact match, check inheritance
if (!_isValid) then {
    // Check if it's a helicopter or plane
    private _isHelicopter = _vehicle isKindOf "Helicopter_Base_F" || _vehicle isKindOf "Helicopter_Base_H";
    private _isPlane = _vehicle isKindOf "Plane_Base_F" || _vehicle isKindOf "Plane_Fighter_01_Base_F";
    
    if (_isHelicopter || _isPlane) then {
        // Check if it has cargo capacity
        private _cargoSeats = [_vehicle, true] call BIS_fnc_crewCount;
        private _totalSeats = [_vehicle, false] call BIS_fnc_crewCount;
        private _passengerSeats = _totalSeats - _cargoSeats;
        
        if (_passengerSeats > 0) then {
            _isValid = true;
            diag_log format ["[RA] isValidAircraft: %1 validated by inheritance (passengers: %2)", _vehicleType, _passengerSeats];
        };
    };
};

// Check for mission-specific overrides
private _missionOverride = _vehicle getVariable ["RA_StaticLineCapable", nil];
if (!isNil "_missionOverride") then {
    _isValid = _missionOverride;
    diag_log format ["[RA] isValidAircraft: %1 override set to %2", _vehicleType, _isValid];
};

// Additional safety checks for valid aircraft
if (_isValid) then {
    // Check if aircraft is functional
    if (!alive _vehicle || !canMove _vehicle) then {
        _isValid = false;
        diag_log format ["[RA] isValidAircraft: %1 is not functional", _vehicleType];
    };
    
    // Check if aircraft has minimum altitude capability
    private _maxAltitude = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "altFullForce");
    if (_maxAltitude > 0 && _maxAltitude < 1000) then {
        _isValid = false;
        diag_log format ["[RA] isValidAircraft: %1 insufficient altitude capability (%2m)", _vehicleType, _maxAltitude];
    };
};

diag_log format ["[RA] isValidAircraft: %1 -> %2", _vehicleType, _isValid];

_isValid