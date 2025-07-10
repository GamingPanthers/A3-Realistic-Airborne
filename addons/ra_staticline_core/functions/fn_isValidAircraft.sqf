<<<<<<< HEAD
=======
/*
    Function: RA_fnc_isValidAircraft
    Checks if a vehicle is valid for static line jump.

    Params:
        _vehicle (Object): The aircraft to check

    Returns:
        Boolean — true if aircraft is valid
*/

params ["_vehicle"];

// Ensure RA_validAircraft is defined
if (isNil "RA_validAircraft") exitWith {
    diag_log "[RA] Warning: RA_validAircraft is undefined. isValidAircraft returning false.";
    false
};

private _vehicleType = toLower (typeOf _vehicle);
private _validTypes = RA_validAircraft apply { toLower _x };

private _isValid = _vehicleType in _validTypes;
diag_log format ["[RA] isValidAircraft: %1 -> %2", _vehicleType, _isValid];

_isValid
>>>>>>> parent of 9e0d7b2 (more self action trouble shooting)
