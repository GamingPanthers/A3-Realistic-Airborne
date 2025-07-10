RA_validAircraft = [
    "B_T_VTOL_01_infantry_F",
    "B_Heli_Transport_01_F",
    "O_Heli_Transport_04_F",
    "CUP_B_C130J_USMC",
    "CUP_B_CH47F_USA",
    "CUP_B_MV22_USMC",
    "CUP_B_C47_USA",
    "CUP_B_AN2_CDF",
    "CUP_C_C47_CIV",
    "CUP_B_Mi17_CDF",
    "CUP_O_Mi8_CHDKZ",
    "RHS_C130J",
    "RHS_CH_47F",
    "RHS_UH60M",
    "RHS_MELB_MH6M",
    "UK3CB_B_Merlin_HC3_ATAK",
    "UK3CB_B_Wildcat_HMA2",
    "UK3CB_B_C130J",
    "vn_b_air_ch47_01_01",
    "vn_b_air_c130_01_01",
    "vn_b_air_uh1c_02_01",
    "adf_c130j_australia",
    "ADFRC_Merlin_HC3"
];
diag_log "[RA] Aircraft whitelist initialized.";

// Call the ACE action registration
["ace_interact_menu_ready", {
    diag_log "[RA] ace_interact_menu_ready triggered";
    [] call RA_fnc_addStaticLineActions;
}] call CBA_fnc_addEventHandler;

