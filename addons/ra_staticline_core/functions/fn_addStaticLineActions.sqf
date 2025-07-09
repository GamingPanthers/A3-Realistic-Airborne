/*
    Function: RA_fnc_addStaticLineActions
    Description: Adds child ACE actions under Static Line menu.
*/

params ["_target", "_player"];
private _actions = [];

_actions pushBack [
    "RA_Stand",
    "Stand Up",
    "\ra_staticline_core\ui\UI_StandUp.paa",
    {["stand", _player] call RA_fnc_stanceControl;},
    {(["check", _player] call RA_fnc_canJump) && !(["check", _player] call RA_fnc_stanceControl)}
];

_actions pushBack [
    "RA_Sit",
    "Sit Down",
    "\ra_staticline_core\ui\UI_SitDown.paa",
    {["sit", _player] call RA_fnc_stanceControl;},
    {
        (["check", _player] call RA_fnc_canJump)
        && (["check", _player] call RA_fnc_stanceControl)
        && !(["check", _player] call RA_fnc_hookControl)
    }
];

_actions pushBack [
    "RA_Hook",
    "Hook Up",
    "\ra_staticline_core\ui\UI_Hook.paa",
    {["hook", _player, vehicle _player] call RA_fnc_hookControl;},
    {
        (["check", _player] call RA_fnc_canJump)
        && !(["check", _player] call RA_fnc_hookControl)
        && (["check", _player] call RA_fnc_stanceControl)
    }
];

_actions pushBack [
    "RA_Unhook",
    "Unhook",
    "\ra_staticline_core\ui\UI_Unhook.paa",
    {["unhook", _player, vehicle _player] call RA_fnc_hookControl;},
    {
        (["check", _player] call RA_fnc_canJump)
        && (["check", _player] call RA_fnc_hookControl)
    }
];

_actions
