/*
    Function: RA_fnc_addStaticLineActions
    Description: Registers ACE3 self-interaction menu for Realistic Airborne.
*/

if (!hasInterface) exitWith {
    diag_log "[RA] Exiting fn_addStaticLineActions — no interface";
};


[] spawn {
    waitUntil {
        !isNull player &&
        { player == player } &&
        { !isNil "ace_interact_menu_fnc_addAction" }
    };

    diag_log "[RA] ACE interaction functions available. Proceeding.";

    // STATIC LINE MENU
    diag_log "[RA] Registering ACE interaction: Static Line menu.";
    ["RA_StaticLine",
        "ACE_SelfActions",
        "Static Line",
        { [player] call RA_fnc_canJump },
        {},
        "\ra_staticline_core\ui\UI_StaticLine.paa"
    ] call ace_interact_menu_fnc_addAction;

    // STAND UP
    diag_log "[RA] Registering ACE interaction: Stand Up.";
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

    // SIT DOWN
    diag_log "[RA] Registering ACE interaction: Sit Down.";
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

    // HOOK UP
    diag_log "[RA] Registering ACE interaction: Hook Up.";
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

    // UNHOOK
    diag_log "[RA] Registering ACE interaction: Unhook.";
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
