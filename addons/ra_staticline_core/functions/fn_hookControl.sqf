/*
    Function: RA_fnc_hookControl
    Manages hook state for static line jumpers.

    Modes:
        "hook"   – sets unit as hooked
        "unhook" – unsets hooked state
        "check"  – returns hooked state (bool)

    Params:
        [MODE, UNIT, (optional) VEHICLE]

    Example:
        ["hook", player] call RA_fnc_hookControl;
        ["check", player] call RA_fnc_hookControl;
*/

params ["_mode", "_unit", ["_vehicle", objNull]];
switch (_mode) do {
    case "hook":   { _unit setVariable ["RA_UnitHooked", true, true]; };
    case "unhook": { _unit setVariable ["RA_UnitHooked", false, true]; };
    case "check":  { _unit getVariable ["RA_UnitHooked", false]; };
};