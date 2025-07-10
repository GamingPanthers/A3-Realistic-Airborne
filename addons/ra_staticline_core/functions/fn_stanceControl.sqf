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
    };
    case "sit": {
        _unit setVariable ["RA_UnitStanding", false, true];
    };
    case "check": {
        _unit getVariable ["RA_UnitStanding", false]
    };
};

