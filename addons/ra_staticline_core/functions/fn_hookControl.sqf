/*
    Function: RA_fnc_hookControl
    Manages hook state and jump action for static line.

    Modes:
        "hook" — set hooked true
        "unhook" — set hooked false
        "check" — return if player is hooked

    Params:
        [MODE, UNIT]

    Example:
        ["hook", player] call RA_fnc_hookControl;
        ["unhook", player] call RA_fnc_hookControl;
        ["check", player] call RA_fnc_hookControl; // returns bool
*/

params ["_mode", "_unit"];

switch (_mode) do {
    case "hook": {
        _unit setVariable ["RA_UnitHooked", true, true];
    };
    case "unhook": {
        _unit setVariable ["RA_UnitHooked", false, true];
    };
    case "check": {
        _unit getVariable ["RA_UnitHooked", false];
    };
};
