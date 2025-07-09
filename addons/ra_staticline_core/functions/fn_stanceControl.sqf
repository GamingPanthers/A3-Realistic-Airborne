/*
    Function: RA_fnc_stanceControl
    Handles stance logic for static line jumpers.

    Modes:
        "stand" — sets player standing true
        "sit"   — sets player standing false
        "check" — returns if player is standing

    Params:
        [MODE, PLAYER]

    Example:
        ["stand", player] call RA_fnc_stanceControl;
        ["check", player] call RA_fnc_stanceControl; // returns bool
*/

params ["_mode", "_unit"];

switch (_mode) do {
    case "stand": {
        _unit setVariable ["RA_UnitStanding", true, true];
        diag_log format ["[RA] Stance set to STAND for: %1", name _unit];
    };
    case "sit": {
        _unit setVariable ["RA_UnitStanding", false, true];
        diag_log format ["[RA] Stance set to SIT for: %1", name _unit];
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
