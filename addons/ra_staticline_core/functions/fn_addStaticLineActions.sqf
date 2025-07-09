/*
    Function: RA_fnc_addStaticLineActions
    Description: Returns child ACE actions under the "Static Line" menu.

    Params:
        _unit (Object): The player (caller)
        _target (Object): Usually also the player (self-interaction)

    Returns:
        Array — ACE interaction children
*/

params ["_unit", "_target"];

private _actions = [];

if (!["check", _unit] call RA_fnc_stanceControl) then {
    _actions pushBack [
        "RA_Stand",
        "Stand Up",
        "\ra_staticline_core\ui\UI_StandUp.paa",
        { ["stand", _unit] call RA_fnc_stanceControl },
        { true }
    ];
};

if (
    (["check", _unit] call RA_fnc_stanceControl) &&
    !(["check", _unit] call RA_fnc_hookControl)
) then {
    _actions pushBack [
        "RA_Sit",
        "Sit Down",
        "\ra_staticline_core\ui\UI_SitDown.paa",
        { ["sit", _unit] call RA_fnc_stanceControl },
        { true }
    ];
};

if (
    (["check", _unit] call RA_fnc_stanceControl) &&
    !(["check", _unit] call RA_fnc_hookControl)
) then {
    _actions pushBack [
        "RA_Hook",
        "Hook Up",
        "\ra_staticline_core\ui\UI_Hook.paa",
        { ["hook", _unit, vehicle _unit] call RA_fnc_hookControl },
        { true }
    ];
};

if (["check", _unit] call RA_fnc_hookControl) then {
    _actions pushBack [
        "RA_Unhook",
        "Unhook",
        "\ra_staticline_core\ui\UI_Unhook.paa",
        { ["unhook", _unit, vehicle _unit] call RA_fnc_hookControl },
        { true }
    ];
};

_actions
