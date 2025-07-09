/*
    File: XEH_postInit.sqf
    Description: Registers ACE self interactions for Realistic Airborne.
    Shows actions only when player is in a valid aircraft.
*/

// ------------------------
// Valid Aircraft Definition (with Display Names)
// ------------------------
RA_validAircraft = [
    // Vanilla Arma 3
    "B_T_VTOL_01_vehicle_F",        // Blackfish (Vehicle Transport)
    "B_Heli_Transport_01_F",        // Huron
    "O_Heli_Transport_04_F",        // Taru (Unarmed)

    // CUP Vehicles
    "CUP_B_C130J_USMC",             // C-130J Super Hercules
    "CUP_B_CH47F_USA",              // CH-47F Chinook
    "CUP_B_MV22_USMC",              // MV-22 Osprey
    "CUP_B_C47_USA",                // C-47 Skytrain (WW2)
    "CUP_B_AN2_CDF",                // AN-2 Colt
    "CUP_C_C47_CIV",                // DC-3 / Civilian C-47
    "CUP_B_Mi17_CDF",               // Mi-17
    "CUP_O_Mi8_CHDKZ",              // Mi-8 (CHDKZ)

    // RHS USAF
    "RHS_C130J",                    // C-130J (RHS)
    "RHS_CH_47F",                   // CH-47F (RHS)
    "RHS_UH60M",                    // UH-60M Blackhawk
    "RHS_MELB_MH6M",                // MH-6 Little Bird

    // 3CB Factions
    "UK3CB_B_Merlin_HC3_ATAK",      // Merlin HC3
    "UK3CB_B_Wildcat_HMA2",         // Wildcat HMA2
    "UK3CB_B_C130J",                // C-130J (3CB)

    // Unsung Vietnam
    "vn_b_air_ch47_01_01",          // CH-47 (Unsung)
    "vn_b_air_c130_01_01",          // C-130 (Unsung)
    "vn_b_air_uh1c_02_01",          // UH-1 Huey (Cargo)

    // ADFRC
    "adf_c130j_australia",          // ADF C-130J Hercules
    "ADFRC_Merlin_HC3"              // ADF Realism Merlin
];
publicVariable "RA_validAircraft";

// ------------------------
// Interface Check
// ------------------------
if (!hasInterface) exitWith {};

// ------------------------
// Helper: Check if player is in valid aircraft
// ------------------------
RA_fnc_canJump = {
    private _veh = vehicle player;
    (_veh != player) && {[_veh] call RA_fnc_isValidAircraft}
};

// ------------------------
// ACE Self-Interaction Root Menu
// ------------------------
["RA_StaticLine",
    "ACE_SelfActions",
    "Static Line",
    { [player] call RA_fnc_canJump },
    {},
    "\ra_staticline_core\ui\UI_StaticLine.paa"
] call ace_interact_menu_fnc_addAction;

// ------------------------
// Stand Up
// ------------------------
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

// ------------------------
// Sit Down
// ------------------------
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

// ------------------------
// Hook Up
// ------------------------
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

// ------------------------
// Unhook
// ------------------------
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

// ------------------------
// Log
// ------------------------
["Realistic Airborne", "ACE Self Interactions loaded with valid aircraft restriction."] call BIS_fnc_log;
