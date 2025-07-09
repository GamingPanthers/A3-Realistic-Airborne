/*
    File: XEH_postInit.sqf
    Description: Registers ACE3 self-interaction menu for Realistic Airborne dynamically.
*/

// Aircraft whitelist
RA_validAircraft = [
    // Vanilla
    "B_T_VTOL_01_vehicle_F",        // Blackfish (Vehicle Transport)
    "B_Heli_Transport_01_F",        // Huron
    "O_Heli_Transport_04_F",        // Taru (Unarmed)

    // CUP
    "CUP_B_C130J_USMC",             // C-130J
    "CUP_B_CH47F_USA",              // CH-47F Chinook
    "CUP_B_MV22_USMC",              // MV-22 Osprey
    "CUP_B_C47_USA",                // C-47 Skytrain
    "CUP_B_AN2_CDF",                // AN-2
    "CUP_C_C47_CIV",                // Civilian C-47
    "CUP_B_Mi17_CDF",               // Mi-17
    "CUP_O_Mi8_CHDKZ",              // Mi-8

    // RHS
    "RHS_C130J",                    // C-130J
    "RHS_CH_47F",                   // CH-47F
    "RHS_UH60M",                    // UH-60M
    "RHS_MELB_MH6M",                // MH-6

    // 3CB
    "UK3CB_B_Merlin_HC3_ATAK",      // Merlin
    "UK3CB_B_Wildcat_HMA2",         // Wildcat
    "UK3CB_B_C130J",                // C-130J (3CB)

    // Unsung
    "vn_b_air_ch47_01_01",          // CH-47
    "vn_b_air_c130_01_01",          // C-130
    "vn_b_air_uh1c_02_01",          // UH-1

    // ADFRC
    "adf_c130j_australia",          // ADF C-130J
    "ADFRC_Merlin_HC3"              // ADFRC Merlin
];

if (!hasInterface) exitWith {};

// Helper: Can the player jump?
RA_fnc_canJump = {
    private _veh = vehicle player;
    diag_log format ["[RA] canJump check: Vehicle = %1", typeOf _veh];
    (_veh != player) && {[_veh] call RA_fnc_isValidAircraft}
};

// Add Static Line Root Menu
["RA_StaticLine",
    "ACE_SelfActions",
    "Static Line",
    {call RA_fnc_canJump},
    {},
    "
a_staticline_core\ui\UI_StaticLine.paa"
] call ace_interact_menu_fnc_addAction;

// Stand Up
["RA_Stand",
    ["ACE_SelfActions", "RA_StaticLine"],
    "Stand Up",
    {
        (call RA_fnc_canJump)
        && !(["check", player] call RA_fnc_stanceControl)
    },
    {
        ["stand", player] call RA_fnc_stanceControl;
    },
    "
a_staticline_core\ui\UI_StandUp.paa"
] call ace_interact_menu_fnc_addAction;

// Sit Down
["RA_Sit",
    ["ACE_SelfActions", "RA_StaticLine"],
    "Sit Down",
    {
        (call RA_fnc_canJump)
        && (["check", player] call RA_fnc_stanceControl)
        && !(["check", player] call RA_fnc_hookControl)
    },
    {
        ["sit", player] call RA_fnc_stanceControl;
    },
    "
a_staticline_core\ui\UI_SitDown.paa"
] call ace_interact_menu_fnc_addAction;

// Hook Up
["RA_Hook",
    ["ACE_SelfActions", "RA_StaticLine"],
    "Hook Up",
    {
        (call RA_fnc_canJump)
        && !(["check", player] call RA_fnc_hookControl)
        && (["check", player] call RA_fnc_stanceControl)
    },
    {
        ["hook", player, vehicle player] call RA_fnc_hookControl;
    },
    "
a_staticline_core\ui\UI_Hook.paa"
] call ace_interact_menu_fnc_addAction;

// Unhook
["RA_Unhook",
    ["ACE_SelfActions", "RA_StaticLine"],
    "Unhook",
    {
        (call RA_fnc_canJump)
        && (["check", player] call RA_fnc_hookControl)
    },
    {
        ["unhook", player, vehicle player] call RA_fnc_hookControl;
    },
    "
a_staticline_core\ui\UI_Unhook.paa"
] call ace_interact_menu_fnc_addAction;

["Realistic Airborne", "ACE3 interactions initialized."] call BIS_fnc_log;
