/*
    Function: RA_fnc_addStaticLineActions
    Description: Registers ACE3 self-interaction menu for Realistic Airborne.
    
    Author: GamingPanthers
    Version: 1.1
*/

if (!hasInterface) exitWith {
    diag_log "[RA] Exiting fn_addStaticLineActions — no interface";
};

[] spawn {
    // Wait for ACE3 and player with timeout
    private _timeout = time + 30;
    waitUntil {
        sleep 0.1;
        (!isNull player && 
            {player == player} && 
            {!isNil "ace_interact_menu_fnc_createAction"}) ||
        (time > _timeout)
    };
    
    if (isNil "ace_interact_menu_fnc_createAction") exitWith {
        diag_log "[RA] ERROR: ACE3 interaction menu not available after timeout";
    };

    diag_log "[RA] ACE interaction functions available. Proceeding with menu registration.";

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

    // STAND UP ACTION
    diag_log "[RA] Registering ACE interaction: Stand Up.";
    private _standUpAction = [
        "RA_Stand",                                         // Action ID
        "Stand Up",                                         // Display name
        "\ra_staticline_core\ui\UI_StandUp.paa",           // Icon
        {                                                   // Code
            ["stand", player] call RA_fnc_stanceControl;
            playSound "RA_StandUp";
            [player, "Standing up and ready!"] remoteExec ["hintSilent", player];
            diag_log format ["[RA] Player %1 stood up", name player];
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump) &&
            !(["check", player] call RA_fnc_stanceControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _standUpAction] call ace_interact_menu_fnc_addActionToObject;

    // SIT DOWN ACTION
    diag_log "[RA] Registering ACE interaction: Sit Down.";
    private _sitDownAction = [
        "RA_Sit",                                           // Action ID
        "Sit Down",                                         // Display name
        "\ra_staticline_core\ui\UI_SitDown.paa",           // Icon
        {                                                   // Code
            ["sit", player] call RA_fnc_stanceControl;
            // Auto-unhook when sitting
            if (["check", player] call RA_fnc_hookControl) then {
                ["unhook", player, vehicle player] call RA_fnc_hookControl;
            };
            [player, "Sitting down and relaxing."] remoteExec ["hintSilent", player];
            diag_log format ["[RA] Player %1 sat down", name player];
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump) &&
            (["check", player] call RA_fnc_stanceControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _sitDownAction] call ace_interact_menu_fnc_addActionToObject;

    // HOOK UP ACTION
    diag_log "[RA] Registering ACE interaction: Hook Up.";
    private _hookUpAction = [
        "RA_Hook",                                          // Action ID
        "Hook Up",                                          // Display name
        "\ra_staticline_core\ui\UI_Hook.paa",              // Icon
        {                                                   // Code
            ["hook", player, vehicle player] call RA_fnc_hookControl;
            playSound "RA_HookUp";
            [player, "Hooked up and ready to jump!"] remoteExec ["hintSilent", player];
            diag_log format ["[RA] Player %1 hooked up", name player];
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump) &&
            !(["check", player] call RA_fnc_hookControl) &&
            (["check", player] call RA_fnc_stanceControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _hookUpAction] call ace_interact_menu_fnc_addActionToObject;

    // UNHOOK ACTION
    diag_log "[RA] Registering ACE interaction: Unhook.";
    private _unhookAction = [
        "RA_Unhook",                                        // Action ID
        "Unhook",                                           // Display name
        "\ra_staticline_core\ui\UI_Unhook.paa",            // Icon
        {                                                   // Code
            ["unhook", player, vehicle player] call RA_fnc_hookControl;
            [player, "Unhooked and secured."] remoteExec ["hintSilent", player];
            diag_log format ["[RA] Player %1 unhooked", name player];
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump) &&
            (["check", player] call RA_fnc_hookControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _unhookAction] call ace_interact_menu_fnc_addActionToObject;

    // EQUIPMENT CHECK ACTION
    diag_log "[RA] Registering ACE interaction: Equipment Check.";
    private _equipCheckAction = [
        "RA_EquipCheck",                                    // Action ID
        "Equipment Check",                                  // Display name
        "\ra_staticline_core\ui\UI_Check.paa",             // Icon
        {                                                   // Code
            [player] call RA_fnc_equipmentCheck;
        },
        {                                                   // Condition
            ([player] call RA_fnc_canJump)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _equipCheckAction] call ace_interact_menu_fnc_addActionToObject;

    // STATIC LINE JUMP ACTION (Final Action)
    diag_log "[RA] Registering ACE interaction: Static Line Jump.";
    private _jumpAction = [
        "RA_Jump",                                          // Action ID
        "Static Line Jump",                                 // Display name
        "\ra_staticline_core\ui\UI_Jump.paa",              // Icon
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

    diag_log "[RA] All ACE self-interaction actions registered successfully.";
};