/*
    File: XEH_postInit.sqf
    Description: Registers ACE self interactions for Realistic Airborne.
    Note: Future expansions (HALO, HAHO, Jumpmaster, AI) can be cleanly added.
*/

if (!hasInterface) exitWith {};

// Check if player is in valid air vehicle
RA_fnc_canJump = {
    private _veh = vehicle player;
    _veh isKindOf "Air"
};

// Add ACE Self Interaction - Static Line Menu
["RA_StaticLine",
    "ACE_SelfActions",
    "Static Line",
    {
        [player] call RA_fnc_canJump
    },
    {},
    "\ra_staticline_core\ui\UI_StaticLine.paa"
] call ace_interact_menu_fnc_addAction;

// Stand Up Option
["RA_Stand",
    ["ACE_SelfActions", "RA_StaticLine"],
    "Stand Up",
    {
        !(["check", player] call RA_fnc_stanceControl)
    },
    {
        ["stand", player] call RA_fnc_stanceControl;
    },
    "\ra_staticline_core\ui\UI_StandUp.paa"
] call ace_interact_menu_fnc_addAction;

// Sit Down Option
["RA_Sit",
    ["ACE_SelfActions", "RA_StaticLine"],
    "Sit Down",
    {
        (["check", player] call RA_fnc_stanceControl)
        && !(["check", player] call RA_fnc_hookControl)
    },
    {
        ["sit", player] call RA_fnc_stanceControl;
    },
    "\ra_staticline_core\ui\UI_SitDown.paa"
] call ace_interact_menu_fnc_addAction;

// Hook Up Option
["RA_Hook",
    ["ACE_SelfActions", "RA_StaticLine"],
    "Hook Up",
    {
        !(["check", player] call RA_fnc_hookControl)
        && (["check", player] call RA_fnc_stanceControl)
    },
    {
        ["hook", player, vehicle player] call RA_fnc_hookControl;
    },
    "\ra_staticline_core\ui\UI_Hook.paa"
] call ace_interact_menu_fnc_addAction;

// Unhook Option
["RA_Unhook",
    ["ACE_SelfActions", "RA_StaticLine"],
    "Unhook",
    {
        ["check", player] call RA_fnc_hookControl
    },
    {
        ["unhook", player, vehicle player] call RA_fnc_hookControl;
    },
    "\ra_staticline_core\ui\UI_Unhook.paa"
] call ace_interact_menu_fnc_addAction;

// Log confirmation
["Realistic Airborne", "ACE interactions initialized."] call BIS_fnc_log;
