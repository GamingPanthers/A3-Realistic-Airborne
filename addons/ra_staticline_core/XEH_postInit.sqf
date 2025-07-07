// XEH_postInit.sqf
diag_log "[RA] Executing XEH_postInit.sqf...";

RA_validAircraft = [
    "CUP_B_C130J_USMC",       // CUP C-130J
    "RHS_CH_47F",             // RHS Chinook
    "UK3CB_B_Merlin_HC3_ATAK",// 3CB Merlin
    "B_T_VTOL_01_vehicle_F",  // Vanilla Blackfish
    "B_Heli_Transport_01_F",  // Vanilla Ghosthawk
    "O_Heli_Transport_04_F"   // Vanilla Taru
];

// Register ACE interaction once ACE menus are ready
["ace_interact_menu_loaded", {
    params ["_unit", "_menuType"];

    diag_log format ["[RA] ACE menu loaded for unit: %1", _unit];
    if (!local _unit) exitWith { diag_log "[RA] Skipped non-local unit." };

    diag_log format ["[RA] Registering ACE Self-Actions for: %1", _unit];

    // Create top-level Static Line category
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Static Line", "\ra_staticline_core\ui\UI_StaticLine.paa"]] call ace_interact_menu_fnc_addActionToObject;

    // Stand Up
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Stand Up", "", {
        params ["_player"];
        ["stand", _player] call RA_fnc_stanceControl;
    }, {
        params ["_player"];
        !(["check", _player] call RA_fnc_stanceControl)
    }]] call ace_interact_menu_fnc_addActionToObject;

    // Sit Down
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Sit Down", "", {
        params ["_player"];
        ["sit", _player] call RA_fnc_stanceControl;
    }, {
        params ["_player"];
        (["check", _player] call RA_fnc_stanceControl) &&
        !(["check", _player] call RA_fnc_hookControl)
    }]] call ace_interact_menu_fnc_addActionToObject;

    // Hook Up
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Hook Up", "\ra_staticline_core\ui\UI_Hook.paa", {
        params ["_player"];
        ["hook", _player, vehicle _player] call RA_fnc_hookControl;
    }, {
        params ["_player"];
        (["check", _player] call RA_fnc_stanceControl) &&
        !(["check", _player] call RA_fnc_hookControl) &&
        (vehicle _player != _player)
    }]] call ace_interact_menu_fnc_addActionToObject;

    // Unhook
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Unhook", "\ra_staticline_core\ui\UI_Unhook.paa", {
        params ["_player"];
        ["unhook", _player, vehicle _player] call RA_fnc_hookControl;
    }, {
        params ["_player"];
        (["check", _player] call RA_fnc_hookControl)
    }]] call ace_interact_menu_fnc_addActionToObject;

    // Static Line Jump
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

    // Debug test
    ["ACE_SelfActions", _unit, ["RA_StaticLine", "Test Action", "", {
        hint "RA StaticLine interaction is working!";
    }]] call ace_interact_menu_fnc_addActionToObject;

}] call CBA_fnc_addEventHandler;
