/*
    Function: RA_fnc_addStaticLineActions
    Description: Registers ACE3 self-interaction menu for Realistic Airborne.
*/
diag_log "[RA] fn_addStaticLineActions.sqf called";

if (!hasInterface) exitWith {};

[] spawn {
    // Wait for player and ACE to be fully initialized
    waitUntil {
        !isNull player &&
        { player == player } &&
        { !isNil "ace_interact_menu_fnc_addAction" }
    };
    sleep 0.2;

    diag_log "[RA] Registering ACE interaction: Static Line menu.";
    ["RA_StaticLine",
        "ACE_SelfActions",
        "Static Line",
        { [player] call RA_fnc_canJump },
        {},
        "\ra_staticline_core\ui\UI_StaticLine.paa"
    ] call ace_interact_menu_fnc_addAction;

    ["RA_Stand",
        ["ACE_SelfActions", "RA_StaticLine"],
        "Stand Up",
        {
            ([player] call RA_fnc_canJump)
            && !(["check", player] call RA_fnc_stanceControl)
        },
        {
            ["stand", player] call RA_fnc_stanceControl;
        },
        "\ra_staticline_core\ui\UI_StandUp.paa"
    ] call ace_interact_menu_fnc_addAction;

    ["RA_Sit",
        ["ACE_SelfActions", "RA_StaticLine"],
        "Sit Down",
        {
            ([player] call RA_fnc_canJump)
            && (["check", player] call RA_fnc_stanceControl)
            && !(["check", player] call RA_fnc_hookControl)
        },
        {
            ["sit", player] call RA_fnc_stanceControl;
        },
        "\ra_staticline_core\ui\UI_SitDown.paa"
    ] call ace_interact_menu_fnc_addAction;

    ["RA_Hook",
        ["ACE_SelfActions", "RA_StaticLine"],
        "Hook Up",
        {
            ([player] call RA_fnc_canJump)
            && !(["check", player] call RA_fnc_hookControl)
            && (["check", player] call RA_fnc_stanceControl)
        },
        {
            ["hook", player, vehicle player] call RA_fnc_hookControl;
        },
        "\ra_staticline_core\ui\UI_Hook.paa"
    ] call ace_interact_menu_fnc_addAction;

    ["RA_Unhook",
        ["ACE_SelfActions", "RA_StaticLine"],
        "Unhook",
        {
            ([player] call RA_fnc_canJump)
            && (["check", player] call RA_fnc_hookControl)
        },
        {
            ["unhook", player, vehicle player] call RA_fnc_hookControl;
        },
        "\ra_staticline_core\ui\UI_Unhook.paa"
    ] call ace_interact_menu_fnc_addAction;

    diag_log "[RA] All ACE self-interaction actions registered.";
};
