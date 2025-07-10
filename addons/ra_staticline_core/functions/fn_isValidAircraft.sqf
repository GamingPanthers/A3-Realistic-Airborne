/*
    Function: RA_fnc_isValidAircraft
    Description: Checks if the vehicle is in the valid aircraft whitelist.
*/

params ["_veh"];
private _type = typeOf _veh;
private _result = _type in RA_validAircraft;

diag_log format ["[RA] isValidAircraft check: %1 -> %2", _type, _result];
_result
