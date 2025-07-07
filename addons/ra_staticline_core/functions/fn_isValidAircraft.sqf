/*
    Function: RA_fnc_isValidAircraft
    Checks if a vehicle is valid for static line jump.

    Params:
        _vehicle (Object): The aircraft to check

    Returns:
        Boolean — true if aircraft is valid
*/

params ["_vehicle"];
private _valid = RA_validAircraft apply { toLower _x };
toLower typeOf _vehicle in _valid;