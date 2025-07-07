/*
    Function: RA_fnc_stanceControl
    Handles stance logic for static line jumpers.

    Modes:
        "stand" — sets player standing true
        "sit"   — sets player standing false
        "check" — returns if player is standing (boolean)

    Params:
        _mode (String)  — Action mode: "stand", "sit", or "check"
        _unit (Object)  — Unit to apply stance logic to

    Example:
        ["stand", player] call RA_fnc_stanceControl;
        ["check", player] call RA_fnc_stanceControl; // returns bool
*/

params ["_mode", "_unit"];
switch (_mode) do {
    case "stand": { _unit setVariable ["RA_UnitStanding", true, true]; };
    case "sit":   { _unit setVariable ["RA_UnitStanding", false, true]; };
    case "check": { _unit getVariable ["RA_UnitStanding", false]; };
    default { diag_log format ["[RA] Unknown stanceControl mode: %1", _mode]; };
};