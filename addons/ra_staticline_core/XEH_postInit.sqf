/*
    File: XEH_postInit.sqf
    Description: Handles post-initialization logic and sets up ACE self-interactions.
*/

diag_log "[RA] >>> Executing XEH_postInit.sqf...";

// --- Define valid aircraft for static line jumps
RA_validAircraft = [
    "CUP_B_C130J_USMC",
    "RHS_CH_47F",
    "UK3CB_B_Merlin_HC3_ATAK",
    "B_T_VTOL_01_vehicle_F",
    "B_Heli_Transport_01_F",
    "O_Heli_Transport_04_F"
];
diag_log format ["[RA] >>> Valid aircraft list registered: %1", RA_validAircraft];

// --- Attach ACE self-interaction on loadout complete
["cba_loadoutComplete", {
    params ["_unit"];
    if (!local _unit) exitWith {
        diag_log format ["[RA] Skipping non-local unit: %1", _unit];
    };

    diag_log format ["[RA] Registering ACE interactions for: %1", name _unit];

    // Static Line category
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Static Line", "\ra_staticline_core\ui\UI_StaticLine.paa"]] call ace_interact_menu_fnc_addActionToObject;

    // --- Stand Up
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Stand Up", "", {
        params ["_player"];
        ["stand", _player] call RA_fnc_stanceControl;
    }, {
        params ["_player"];
        !(["check", _player] call RA_fnc_stanceControl)
    }]] call ace_interact_menu_fnc_addActionToObject;

    // --- Sit Down
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Sit Down", "", {
        params ["_player"];
        ["sit", _player] call RA_fnc_stanceControl;
    }, {
        params ["_player"];
        (["check", _player] call RA_fnc_stanceControl) &&
        !(["check", _player] call RA_fnc_hookControl)
    }]] call ace_interact_menu_fnc_addActionToObject;

    // --- Hook Up
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Hook Up", "\ra_staticline_core\ui\UI_Hook.paa", {
        params ["_player"];
        ["hook", _player, vehicle _player] call RA_fnc_hookControl;
    }, {
        params ["_player"];
        (["check", _player] call RA_fnc_stanceControl) &&
        !(["check", _player] call RA_fnc_hookControl) &&
        (vehicle _player != _player)
    }]] call ace_interact_menu_fnc_addActionToObject;

    // --- Unhook
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Unhook", "\ra_staticline_core\ui\UI_Unhook.paa", {
        params ["_player"];
        ["unhook", _player, vehicle _player] call RA_fnc_hookControl;
    }, {
        params ["_player"];
        ["check", _player] call RA_fnc_hookControl
    }]] call ace_interact_menu_fnc_addActionToObject;

    // --- Static Line Jump
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Static Line Jump", "\ra_staticline_core\ui\UI_StaticLine.paa", {
        params ["_player"];
        [_player, vehicle _player] call RA_fnc_staticJump;
    }, {
        params ["_player"];
        (vehicle _player != _player) &&
        (["check", _player] call RA_fnc_hookControl) &&
        (["check", _player] call RA_fnc_stanceControl) &&
        ((getPosATL vehicle _player) select 2 > 100)
    }]] call ace_interact_menu_fnc_addActionToObject;

    diag_log format ["[RA] ACE interactions registered for %1", name _unit];

}] call CBA_fnc_addPlayerEventHandler;

diag_log "[RA] <<< XEH_postInit complete.";
