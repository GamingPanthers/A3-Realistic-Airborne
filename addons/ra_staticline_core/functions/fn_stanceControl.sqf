/*
    Function: RA_fnc_stanceControl
    Handles stance logic for static line jumpers.

    Modes:
        "stand" — Sets stance to standing (pre-jump position)
        "sit"   — Sets stance to seated (default/idle in aircraft)
        "check" — Returns whether the unit is currently standing

    Params:
        _mode (String): "stand", "sit", or "check"
        _unit (Object): The player/unit to process

    Example:
        ["stand", player] call RA_fnc_stanceControl;
        ["check", player] call RA_fnc_stanceControl; // returns bool
*/

params ["_mode", "_unit"];

// Basic safety check
if (isNull _unit) exitWith {
    diag_log "[RA] stanceControl aborted: invalid unit.";
};

switch (toLower _mode) do {
    case "stand": {
        _unit setVariable ["RA_UnitStanding", true, true];
        diag_log format ["[RA] Stance set to STAND for %1", name _unit];
    };

    case "sit": {
        _unit setVariable ["RA_UnitStanding", false, true];
        diag_log format ["[RA] Stance set to SIT for %1", name _unit];
    };

    case "check": {
        private _isStanding = _unit getVariable ["RA_UnitStanding", false];
        diag_log format ["[RA] Stance check for %1: %2", name _unit, _isStanding];
        _isStanding
    };

    default {
        diag_log format ["[RA] Unknown stance mode '%1' for %2", _mode, name _unit];
    };
};
