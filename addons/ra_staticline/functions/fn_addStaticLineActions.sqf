/*
    Function: RA_fnc_addStaticLineActions
    Description: Registers ACE3 self-interaction menu for Realistic Airborne.
    Author: GamingPanthers
    Version: 1.0.3
*/

if (!hasInterface) exitWith {
    diag_log "[RA] Exiting fn_addStaticLineActions — no interface";
};

[] spawn {
    // Wait for ACE3 and player with timeout
    private _timeout = time + 30;
    waitUntil {
        sleep 0.1;
        (!isNull player && {player == player} && {!isNil "ace_interact_menu_fnc_createAction"}) || (time > _timeout)
    };
    
    if (isNil "ace_interact_menu_fnc_createAction") exitWith {
        diag_log "[RA] ERROR: ACE3 interaction menu not available after timeout";
    };

    diag_log "[RA] ACE interaction functions available. Proceeding with menu registration.";

    // STATIC LINE MENU (Main Parent Action)
    private _staticLineAction = [
        "RA_StaticLine",
        "Static Line",
        "z\ra\addons\ra_core\ui\UI_StaticLine.paa",
        {},
        { [player] call RA_fnc_canJump }
    ] call ace_interact_menu_fnc_createAction;
    
    [player, 1, ["ACE_SelfActions"], _staticLineAction] call ace_interact_menu_fnc_addActionToObject;

    // STAND UP ACTION
    private _standUpAction = [
        "RA_Stand",
        "Stand Up",
        "z\ra\addons\ra_core\ui\UI_StandUp.paa",
        {
            ["stand", player] call RA_fnc_stanceControl;
            playSound "RA_StandUp";
            hintSilent "Standing up and ready!";
        },
        {
            ([player] call RA_fnc_canJump) &&
            !(["check", player] call RA_fnc_stanceControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _standUpAction] call ace_interact_menu_fnc_addActionToObject;

    // SIT DOWN ACTION
    private _sitDownAction = [
        "RA_Sit",
        "Sit Down",
        "z\ra\addons\ra_core\ui\UI_SitDown.paa",
        {
            ["sit", player] call RA_fnc_stanceControl;
            // Auto-unhook when sitting
            if (["check", player] call RA_fnc_hookControl) then {
                ["unhook", player, objectParent player] call RA_fnc_hookControl;
            };
            hintSilent "Sitting down and relaxing.";
        },
        {
            ([player] call RA_fnc_canJump) &&
            (["check", player] call RA_fnc_stanceControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _sitDownAction] call ace_interact_menu_fnc_addActionToObject;

    // HOOK UP ACTION
    private _hookUpAction = [
        "RA_Hook",
        "Hook Up",
        "z\ra\addons\ra_core\ui\UI_Hook.paa",
        {
            ["hook", player, objectParent player] call RA_fnc_hookControl;
            playSound "RA_HookUp";
            hintSilent "Hooked up and ready to jump!";
        },
        {
            ([player] call RA_fnc_canJump) &&
            !(["check", player] call RA_fnc_hookControl) &&
            (["check", player] call RA_fnc_stanceControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _hookUpAction] call ace_interact_menu_fnc_addActionToObject;

    // UNHOOK ACTION
    private _unhookAction = [
        "RA_Unhook",
        "Unhook",
        "z\ra\addons\ra_core\ui\UI_Unhook.paa",
        {
            ["unhook", player, objectParent player] call RA_fnc_hookControl;
            hintSilent "Unhooked and secured.";
        },
        {
            ([player] call RA_fnc_canJump) &&
            (["check", player] call RA_fnc_hookControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _unhookAction] call ace_interact_menu_fnc_addActionToObject;

    // EQUIPMENT CHECK ACTION
    private _equipCheckAction = [
        "RA_EquipCheck",
        "Equipment Check",
        "z\ra\addons\ra_core\ui\UI_Check.paa",
        {
            [player] call RA_fnc_equipmentCheck;
        },
        {
            ([player] call RA_fnc_canJump)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _equipCheckAction] call ace_interact_menu_fnc_addActionToObject;

    // STATIC LINE JUMP ACTION
    private _jumpAction = [
        "RA_Jump",
        "Static Line Jump",
        "z\ra\addons\ra_core\ui\UI_Jump.paa",
        {
            [objectParent player, player] call RA_fnc_staticJump;
        },
        {
            ([player] call RA_fnc_canJump) &&
            (["check", player] call RA_fnc_stanceControl) &&
            (["check", player] call RA_fnc_hookControl)
        }
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ["ACE_SelfActions", "RA_StaticLine"], _jumpAction] call ace_interact_menu_fnc_addActionToObject;

    diag_log "[RA] All ACE self-interaction actions registered successfully.";
};