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
        { !isNil "ace_interact_menu_fnc_createAction" }
    };

    diag_log "[RA] ACE interaction functions available. Proceeding.";

    // STATIC LINE MENU (Main Parent Action)
    diag_log "[RA] Registering ACE interaction: Static Line menu.";
    private _staticLineAction = [
        "RA_StaticLine",                                    // Action ID
        "Static Line",                                      // Display name
        "\ra_staticline_core\ui\UI_StaticLine.paa",        // Icon
        {},                                                 // Code (empty for parent)
        { [player] call RA_fnc_canJump }                   // Condition
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions"], _staticLineAction] call ace_interact_menu_fnc_addActionToObject;

    // STAND UP
    diag_log "[RA] Registering ACE interaction: Stand Up.";
    private _standUpAction = [
        "RA_Stand",                                         // Action ID
        "Stand Up",                                         // Display name
        "\ra_staticline_core\ui\UI_StandUp.paa",           // Icon
        {                                                   // Code
            ["stand", player] call RA_fnc_stanceControl;
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump) &&
            !(["check", player] call RA_fnc_stanceControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _standUpAction] call ace_interact_menu_fnc_addActionToObject;

    // SIT DOWN
    diag_log "[RA] Registering ACE interaction: Sit Down.";
    private _sitDownAction = [
        "RA_Sit",                                           // Action ID
        "Sit Down",                                         // Display name
        "\ra_staticline_core\ui\UI_SitDown.paa",           // Icon
        {                                                   // Code
            ["sit", player] call RA_fnc_stanceControl;
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump) &&
            (["check", player] call RA_fnc_stanceControl) &&
            !(["check", player] call RA_fnc_hookControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _sitDownAction] call ace_interact_menu_fnc_addActionToObject;

    // HOOK UP
    diag_log "[RA] Registering ACE interaction: Hook Up.";
    private _hookUpAction = [
        "RA_Hook",                                          // Action ID
        "Hook Up",                                          // Display name
        "\ra_staticline_core\ui\UI_Hook.paa",              // Icon
        {                                                   // Code
            ["hook", player, vehicle player] call RA_fnc_hookControl;
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump) &&
            !(["check", player] call RA_fnc_hookControl) &&
            (["check", player] call RA_fnc_stanceControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _hookUpAction] call ace_interact_menu_fnc_addActionToObject;

    // UNHOOK
    diag_log "[RA] Registering ACE interaction: Unhook.";
    private _unhookAction = [
        "RA_Unhook",                                        // Action ID
        "Unhook",                                           // Display name
        "\ra_staticline_core\ui\UI_Unhook.paa",            // Icon
        {                                                   // Code
            ["unhook", player, vehicle player] call RA_fnc_hookControl;
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump) &&
            (["check", player] call RA_fnc_hookControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _unhookAction] call ace_interact_menu_fnc_addActionToObject;

    // STATIC LINE JUMP (Final Action)
    diag_log "[RA] Registering ACE interaction: Static Line Jump.";
    private _jumpAction = [
        "RA_Jump",                                          // Action ID
        "Static Line Jump",                                 // Display name
        "\ra_staticline_core\ui\UI_Jump.paa",              // Icon (create this if needed)
        {                                                   // Code
            [vehicle player, player] call RA_fnc_staticJump;
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump) &&
            (["check", player] call RA_fnc_stanceControl) &&
            (["check", player] call RA_fnc_hookControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _jumpAction] call ace_interact_menu_fnc_addActionToObject;

    diag_log "[RA] All ACE self-interaction actions registered.";
};