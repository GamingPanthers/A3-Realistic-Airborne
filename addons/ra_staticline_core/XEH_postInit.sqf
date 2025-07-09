/*
    File: XEH_postInit.sqf
    Description: Defines aircraft whitelist and helper functions.
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

// Helper: Check if player is in valid aircraft
RA_fnc_canJump = {
    private _veh = vehicle player;
    (_veh != player) && {[_veh] call RA_fnc_isValidAircraft}
};

["Realistic Airborne", "ACE interaction initialized with aircraft validation."] call BIS_fnc_log;
