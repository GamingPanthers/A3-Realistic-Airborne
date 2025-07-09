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

diag_log format ["[RA] addStaticLineActions called for unit: %1", name _unit];

private _actions = [];

if (!["check", _unit] call RA_fnc_stanceControl) then {
    diag_log "[RA] Adding 'Stand Up' option.";
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
    diag_log "[RA] Adding 'Sit Down' option.";
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
    diag_log "[RA] Adding 'Hook Up' option.";
    _actions pushBack [
        "RA_Hook",
        "Hook Up",
        "\ra_staticline_core\ui\UI_Hook.paa",
        { ["hook", _unit, vehicle _unit] call RA_fnc_hookControl },
        { true }
    ];
};

if (["check", _unit] call RA_fnc_hookControl) then {
    diag_log "[RA] Adding 'Unhook' option.";
    _actions pushBack [
        "RA_Unhook",
        "Unhook",
        "\ra_staticline_core\ui\UI_Unhook.paa",
        { ["unhook", _unit, vehicle _unit] call RA_fnc_hookControl },
        { true }
    ];
};

diag_log format ["[RA] addStaticLineActions finished. %1 actions registered.", count _actions];

_actions
