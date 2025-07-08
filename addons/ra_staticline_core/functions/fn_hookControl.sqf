/*
    Function: RA_fnc_hookControl
    Manages hook state and jump action for static line.

    Modes:
        "hook" — set hooked true, add jump action
        "unhook" — set hooked false, remove jump action
        "check" — return if player is hooked

    Params:
        [MODE, UNIT, (optional) VEHICLE]

    Example:
        ["hook", player, vehicle player] call RA_fnc_hookControl;
        ["unhook", player, vehicle player] call RA_fnc_hookControl;
        ["check", player] call RA_fnc_hookControl; // returns bool
*/


params ["_mode", "_unit", "_vehicle"];

switch (_mode) do {
    case "hook": {
        _unit setVariable ["RA_UnitHooked", true, true];
        private _jump = _vehicle addAction [
            "<t>Static Line Jump</t>",
            {
                [_this select 0, _this select 1] execVM "\ra_staticline_core\functions\fn_staticJump.sqf";
            },
            [],
            0, true, true, "", "_target getCargoIndex player != -1 && ((getPosATL _target) select 2 > 100)"
        ];
        _unit setVariable ["RA_JumpAction", _jump, true];
    };

    case "unhook": {
        _unit setVariable ["RA_UnitHooked", false, true];
        private _jump = _unit getVariable ["RA_JumpAction", -1];
        if (!isNil "_vehicle" && {_jump != -1}) then {
            _vehicle removeAction _jump;
        };
    };

    case "check": {
        _unit getVariable ["RA_UnitHooked", false]
    };
};
