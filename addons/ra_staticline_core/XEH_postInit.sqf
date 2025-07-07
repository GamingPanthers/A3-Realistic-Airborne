diag_log "[RA] >>> Executing XEH_postInit.sqf...";

// Aircraft allowed for static line jumps
RA_validAircraft = [
    "CUP_B_C130J_USMC",
    "RHS_CH_47F",
    "UK3CB_B_Merlin_HC3_ATAK",
    "B_T_VTOL_01_vehicle_F",
    "B_Heli_Transport_01_F",
    "O_Heli_Transport_04_F"
];
diag_log format ["[RA] >>> Valid aircraft list registered: %1", RA_validAircraft];

// Attach ACE interactions after player loadout is done
["cba_loadoutComplete", {
    params ["_unit"];
    diag_log format ["[RA] >>> cba_loadoutComplete event fired for: %1", _unit];

    if (!local _unit) exitWith {
        diag_log format ["[RA] >>> Skipping non-local unit: %1", _unit];
    };

    diag_log format ["[RA] >>> Assigning ACE interactions to: %1", name _unit];

    // Main Static Line category
    ["ACE_SelfActions", 0, ["RA_StaticLine", "Static Line", "\ra_staticline_core\ui\UI_StaticLine.paa"], _unit]
        call ace_interact_menu_fnc_addAction;

    // Stand Up
    ["ACE_SelfActions", 0, ["RA_StaticLine", "Stand Up", "", {
        params ["_player"];
        diag_log format ["[RA] >>> [Stand Up] executed by %1", name _player];
        ["stand", _player] call RA_fnc_stanceControl;
    }, {
        params ["_player"];
        private _result = !(["check", _player] call RA_fnc_stanceControl);
        diag_log format ["[RA] >>> [Stand Up] condition for %1: %2", name _player, _result];
        _result
    }], _unit] call ace_interact_menu_fnc_addAction;

    // Sit Down
    ["ACE_SelfActions", 0, ["RA_StaticLine", "Sit Down", "", {
        params ["_player"];
        diag_log format ["[RA] >>> [Sit Down] executed by %1", name _player];
        ["sit", _player] call RA_fnc_stanceControl;
    }, {
        params ["_player"];
        private _result = (["check", _player] call RA_fnc_stanceControl) && !(["check", _player] call RA_fnc_hookControl);
        diag_log format ["[RA] >>> [Sit Down] condition for %1: %2", name _player, _result];
        _result
    }], _unit] call ace_interact_menu_fnc_addAction;

    // Hook Up
    ["ACE_SelfActions", 0, ["RA_StaticLine", "Hook Up", "\ra_staticline_core\ui\UI_Hook.paa", {
        params ["_player"];
        diag_log format ["[RA] >>> [Hook Up] executed by %1", name _player];
        ["hook", _player, vehicle _player] call RA_fnc_hookControl;
    }, {
        params ["_player"];
        private _result = (["check", _player] call RA_fnc_stanceControl) &&
            !(["check", _player] call RA_fnc_hookControl) &&
            (vehicle _player != _player);
        diag_log format ["[RA] >>> [Hook Up] condition for %1: %2", name _player, _result];
        _result
    }], _unit] call ace_interact_menu_fnc_addAction;

    // Unhook
    ["ACE_SelfActions", 0, ["RA_StaticLine", "Unhook", "\ra_staticline_core\ui\UI_Unhook.paa", {
        params ["_player"];
        diag_log format ["[RA] >>> [Unhook] executed by %1", name _player];
        ["unhook", _player, vehicle _player] call RA_fnc_hookControl;
    }, {
        params ["_player"];
        private _result = ["check", _player] call RA_fnc_hookControl;
        diag_log format ["[RA] >>> [Unhook] condition for %1: %2", name _player, _result];
        _result
    }], _unit] call ace_interact_menu_fnc_addAction;

    // Static Line Jump
    ["ACE_SelfActions", 0, ["RA_StaticLine", "Static Line Jump", "\ra_staticline_core\ui\UI_StaticLine.paa", {
        params ["_player"];
        diag_log format ["[RA] >>> [Jump] executed by %1", name _player];
        [_player, vehicle _player] call RA_fnc_staticJump;
    }, {
        params ["_player"];
        private _result = (vehicle _player != _player) &&
            (["check", _player] call RA_fnc_hookControl) &&
            (["check", _player] call RA_fnc_stanceControl) &&
            ((getPosATL vehicle _player) select 2 > 100);
        diag_log format ["[RA] >>> [Jump] condition for %1: %2", name _player, _result];
        _result
    }], _unit] call ace_interact_menu_fnc_addAction;

    // Test
    ["ACE_SelfActions", 0, ["RA_StaticLine", "Test Hint", "", {
        hint "RA StaticLine loaded.";
        diag_log "[RA] >>> Test hint triggered.";
    }], _unit] call ace_interact_menu_fnc_addAction;

    diag_log format ["[RA] >>> All ACE interactions added for %1", name _unit];

}] call CBA_fnc_addPlayerEventHandler;

diag_log "[RA] <<< XEH_postInit complete.";
