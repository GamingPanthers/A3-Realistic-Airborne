/*
    Function: RA_fnc_hookControl
    Manages hook state for static line operations.

    Modes:
        "hook"   — Marks unit as hooked
        "unhook" — Unmarks unit as hooked
        "check"  — Returns hook state as boolean

    Params:
        _mode (String): "hook", "unhook", or "check"
        _unit (Object): The player or unit being managed

    Example:
        ["hook", player] call RA_fnc_hookControl;
        ["check", player] call RA_fnc_hookControl; // returns true/false
*/

params ["_mode", "_unit"];

// Validate
if (isNull _unit) exitWith {
    diag_log "[RA] hookControl aborted: invalid unit.";
};

// Dispatch behavior
switch (toLower _mode) do {
    case "hook": {
        _unit setVariable ["RA_UnitHooked", true, true];
        diag_log format ["[RA] Unit %1 hooked.", name _unit];
    };

    case "unhook": {
        _unit setVariable ["RA_UnitHooked", false, true];
        diag_log format ["[RA] Unit %1 unhooked.", name _unit];
    };

    case "check": {
        private _hooked = _unit getVariable ["RA_UnitHooked", false];
        diag_log format ["[RA] Unit %1 hook check -> %2", name _unit, _hooked];
        _hooked
    };

    default {
        diag_log format ["[RA] Unknown hookControl mode: %1", _mode];
    };
};
