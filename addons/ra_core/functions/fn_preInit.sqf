/*
    Function: Extended Event Handler: PreInit
    Description: Initializes Realistic Airborne mod before mission start

    Author: GamingPanthers
    Version: 1.0.1
*/

// Mod identification
diag_log "[RA] Realistic Airborne - PreInit starting...";

// Define valid aircraft types for static line jumping
RA_validAircraft = [
    // === VANILLA ARMA 3 ===
    // Transport Helicopters
    "B_Heli_Transport_01_F",           // UH-80 Ghost Hawk
    "B_Heli_Transport_01_camo_F",      // UH-80 Ghost Hawk (Camo)
    "I_Heli_Transport_02_F",           // CH-49 Mohawk
    "I_Heli_Transport_02_unarmed_F",   // CH-49 Mohawk (Unarmed)
    "O_Heli_Transport_04_F",           // Mi-290 Taru
    "O_Heli_Transport_04_bench_F",     // Mi-290 Taru (Bench)
    "O_Heli_Transport_04_covered_F",   // Mi-290 Taru (Transport)
    "O_Heli_Transport_04_medevac_F",   // Mi-290 Taru (Medical)
    
    // VTOL Aircraft
    "B_T_VTOL_01_infantry_F",          // V-44 X Blackfish (Infantry Transport)
    "O_T_VTOL_02_infantry_F",          // Y-32 Xi'an (Infantry Transport)
    
    // === ADFRC VEHICLES ===
    "adfrc_c130_inf",                  // C-130 Hercules
    "adfrc_chinook",                   // Chinook

    // === CUP VEHICLES ===
    // C-130 Hercules
    "CUP_B_C130J_GB",                  // C-130J Super Hercules (BAF)
    "CUP_B_C130J_USMC",                // C-130J Super Hercules (USMC)
    "CUP_I_C130J_AAF",                 // C-130J Super Hercules (AAF)
    "CUP_O_C130J_TKA",                 // C-130J Super Hercules (TKA)
    "CUP_B_C130J_Cargo_GB",            // C-130J Cargo
    "CUP_B_C130J_Cargo_USMC",
    
    // Transport Helicopters
    "CUP_B_CH47F_GB",                  // CH-47F Chinook (BAF)
    "CUP_B_CH47F_USA",                 // CH-47F Chinook (USA)
    "CUP_I_CH47F_AAF",                 // CH-47F Chinook (AAF)
    "CUP_B_UH1Y_MEV_USMC",             // UH-1Y Venom (MEDEVAC)
    "CUP_B_UH1Y_UNA_USMC",             // UH-1Y Venom (Unarmed)
    "CUP_B_MH60L_DAP_4x_US",           // MH-60L DAP
    "CUP_B_UH60M_US",                  // UH-60M Black Hawk
    "CUP_B_UH60M_Unarmed_US",          // UH-60M Black Hawk (Unarmed)
    
    // === RHS VEHICLES ===
    // CH-47 Chinook
    "RHS_CH_47F",                      // CH-47F Chinook
    "RHS_CH_47F_light",                // CH-47F Chinook (Light)
    "RHS_CH_47F_10",                   // CH-47F Chinook (Crew Chief)
    "rhsusf_ch47f_10",                 // CH-47F (Alternative)
    "rhsusf_ch47f_light",              // CH-47F Light
    
    // CH-53 Super Stallion
    "rhsusf_CH53E_USMC",               // CH-53E Super Stallion
    "rhsusf_CH53E_USMC_GAU21",         // CH-53E Super Stallion (GAU-21)
    "rhsusf_CH53E_USMC_rhs",           // CH-53E Super Stallion (RHS)
    
    // UH-60 Black Hawk
    "RHS_UH60M",                       // UH-60M Black Hawk
    "RHS_UH60M_d",                     // UH-60M Black Hawk (Desert)
    "RHS_UH60M_MEV",                   // UH-60M MEDEVAC
    "RHS_UH60M_MEV2",                  // UH-60M MEDEVAC (Alternative)
    "rhsusf_uh60m_mev",                // UH-60M MEV
    "rhsusf_uh60m_mev2",               // UH-60M MEV2
    
    // === 3CB BAF ===
    // Merlin
    "UK3CB_BAF_Merlin_HC3_18",         // Merlin HC3 (18 Seats)
    "UK3CB_BAF_Merlin_HC3_24",         // Merlin HC3 (24 Seats)
    "UK3CB_BAF_Merlin_HC3_32",         // Merlin HC3 (32 Seats)
    "UK3CB_BAF_Merlin_HC4_18",         // Merlin HC4 (18 Seats)
    "UK3CB_BAF_Merlin_HC4_32",         // Merlin HC4 (32 Seats)
    
    // Chinook
    "UK3CB_BAF_Chinook_HC1",           // Chinook HC1
    "UK3CB_BAF_Chinook_HC2",           // Chinook HC2
    "UK3CB_BAF_Chinook_HC6",           // Chinook HC6
    
    // Puma
    "UK3CB_BAF_Puma_HC1",              // Puma HC1
    "UK3CB_BAF_Puma_HC2",              // Puma HC2
    
    // === PROJECT OPFOR ===
    "LOP_TKA_Mi8MT",                   // Mi-8MT Hip
    "LOP_TKA_Mi8MTV3",                 // Mi-8MTV-3 Hip
    "LOP_UN_Mi8MT",                    // Mi-8MT Hip (UN)
    "LOP_ISTS_Mi8MT",                  // Mi-8MT Hip (ISTS)
    
    // === UNSUNG / VIETNAM ===
    "vn_b_air_ch47_01_01",             // CH-47A Chinook
    "vn_b_air_ch47_02_01",             // CH-47D Chinook
    "vn_b_air_ch34_01_01",             // CH-34 Choctaw
    "vn_b_air_uh1d_01_01",             // UH-1D Huey
    "vn_b_air_uh1d_02_01",             // UH-1D Huey (Slick)
    "vn_b_air_uh1d_03_06",             // UH-1D Huey (Transport)
    
    // === GLOBAL MOBILIZATION ===
    "gm_gc_air_mi2p",                  // Mi-2P Hoplite
    "gm_gc_air_mi2t",                  // Mi-2T Hoplite
    "gm_gc_air_mi2urn",                // Mi-2URP Hoplite
    "gm_pl_air_mi2p",                  // Mi-2P Hoplite (Poland)
    "gm_pl_air_mi2t",                  // Mi-2T Hoplite (Poland)

    // === USAF Mod ====
    "USAF_C17",                        // C-17 Globemaster III
    "USAF_C130J",                      // C-130J Super Hercules
    
    // === CUSTOM/MODDED AIRCRAFT ===
    // Add your custom aircraft classnames here
    // Example: "MyMod_CustomTransport_F"
    
    // === FALLBACK CLASSES ===
    // These are broad categories - use with caution as they may include combat aircraft
    "Helicopter_Base_H",               // Base helicopter class (very broad)
    "Plane_Base_F",                    // Base plane class (very broad)
    "VTOL_Base_F"                      // Base VTOL class (very broad)
];

// CBA Settings - Define mod settings
if (isServer) then {
    // Static parachute requirement setting
    [
        "RA_StaticEquipped",                                    // Setting name
        "CHECKBOX",                                             // Setting type
        ["Require Static Parachute", "Require players to have a static parachute equipped to jump"], // [Display name, tooltip]
        ["Realistic Airborne", "Jump Requirements"],           // [Category, Subcategory]
        true,                                                   // Default value
        true,                                                   // Global setting
        {
            // Code executed when setting changes
            params ["_value"];
            diag_log format ["[RA] Static parachute requirement changed to: %1", _value];
        }
    ] call CBA_settings_fnc_init;
    
    // Custom parachute class setting
    [
        "RA_ChuteClass",                                        // Setting name
        "EDITBOX",                                              // Setting type
        ["Custom Parachute Class", "Override parachute spawn class (leave blank for default ACE_NonSteerableParachute)"], // [Display name, tooltip]
        ["Realistic Airborne", "Equipment"],                   // [Category, Subcategory]
        "",                                                     // Default value
        true,                                                   // Global setting
        {
            // Code executed when setting changes
            params ["_value"];
            diag_log format ["[RA] Custom parachute class changed to: %1", _value];
        }
    ] call CBA_settings_fnc_init;
    
    // NVG friendly setting
    [
        "RA_NODsFriendly",                                      // Setting name
        "CHECKBOX",                                             // Setting type
        ["NVG Friendly", "Prevents NVG removal during reserve parachute deployment"], // [Display name, tooltip]
        ["Realistic Airborne", "Equipment"],                   // [Category, Subcategory]
        true,                                                   // Default value
        true,                                                   // Global setting
        {
            // Code executed when setting changes
            params ["_value"];
            diag_log format ["[RA] NVG friendly mode changed to: %1", _value];
        }
    ] call CBA_settings_fnc_init;
    
    // Minimum jump altitude setting
    [
        "RA_MinAltitude",                                       // Setting name
        "SLIDER",                                               // Setting type
        ["Minimum Jump Altitude", "Minimum altitude (AGL) required for static line jumps"], // [Display name, tooltip]
        ["Realistic Airborne", "Jump Requirements"],           // [Category, Subcategory]
        [50, 500, 100, 0],                                     // [Min, Max, Default, Decimal places]
        true,                                                   // Global setting
        {
            // Code executed when setting changes
            params ["_value"];
            diag_log format ["[RA] Minimum jump altitude changed to: %1m", _value];
        }
    ] call CBA_settings_fnc_init;
    
    // Maximum jump altitude setting
    [
        "RA_MaxAltitude",                                       // Setting name
        "SLIDER",                                               // Setting type
        ["Maximum Jump Altitude", "Maximum altitude (AGL) for static line jumps (0 = no limit)"], // [Display name, tooltip]
        ["Realistic Airborne", "Jump Requirements"],           // [Category, Subcategory]
        [0, 2000, 0, 0],                                       // [Min, Max, Default, Decimal places]
        true,                                                   // Global setting
        {
            // Code executed when setting changes
            params ["_value"];
            diag_log format ["[RA] Maximum jump altitude changed to: %1m", _value];
        }
    ] call CBA_settings_fnc_init;
    
    // Automatic equipment check
    [
        "RA_AutoEquipCheck",                                    // Setting name
        "CHECKBOX",                                             // Setting type
        ["Auto Equipment Check", "Automatically check for proper equipment when entering aircraft"], // [Display name, tooltip]
        ["Realistic Airborne", "Quality of Life"],             // [Category, Subcategory]
        true,                                                   // Default value
        true,                                                   // Global setting
        {
            // Code executed when setting changes
            params ["_value"];
            diag_log format ["[RA] Auto equipment check changed to: %1", _value];
        }
    ] call CBA_settings_fnc_init;
    
    // Debug mode setting
    [
        "RA_DebugMode",                                         // Setting name
        "CHECKBOX",                                             // Setting type
        ["Debug Mode", "Enable debug logging and hints"], // [Display name, tooltip]
        ["Realistic Airborne", "Developer"],                   // [Category, Subcategory]
        false,                                                  // Default value
        true,                                                   // Global setting
        {
            // Code executed when setting changes
            params ["_value"];
            diag_log format ["[RA] Debug mode changed to: %1", _value];
        }
    ] call CBA_settings_fnc_init;
};

// Initialize global variables
RA_debugMode = false;
RA_initialized = false;

// Function to check if aircraft is valid for static line operations
RA_fnc_isValidAircraft = {
    params ["_vehicle"];
    
    if (isNull _vehicle) exitWith { false };
    
    private _type = typeOf _vehicle;
    private _result = _type in RA_validAircraft;
    
    // Additional checks for inheritance
    if (!_result) then {
        _result = _vehicle isKindOf "Helicopter_Base_H" || _vehicle isKindOf "VTOL_Base_F";
    };
    
    if (missionNamespace getVariable ["RA_DebugMode", false]) then {
        diag_log format ["[RA] Aircraft validation: %1 (%2) -> %3", _type, _vehicle, _result];
    };
    
    _result
};

// Function to get minimum jump altitude
RA_fnc_getMinAltitude = {
    missionNamespace getVariable ["RA_MinAltitude", 100]
};

// Function to get maximum jump altitude
RA_fnc_getMaxAltitude = {
    missionNamespace getVariable ["RA_MaxAltitude", 0]
};

// Function to validate jump altitude
RA_fnc_validateAltitude = {
    params ["_vehicle"];
    
    private _altitude = (getPosATL _vehicle) select 2;
    private _minAlt = call RA_fnc_getMinAltitude;
    private _maxAlt = call RA_fnc_getMaxAltitude;
    
    private _result = _altitude >= _minAlt;
    
    if (_maxAlt > 0) then {
        _result = _result && (_altitude <= _maxAlt);
    };
    
    if (missionNamespace getVariable ["RA_DebugMode", false]) then {
        diag_log format ["[RA] Altitude validation: %1m (Min: %2, Max: %3) -> %4", 
            round _altitude, _minAlt, _maxAlt, _result];
    };
    
    _result
};

// Log completion
diag_log format ["[RA] Realistic Airborne PreInit complete - %1 aircraft types registered", count RA_validAircraft];
diag_log "[RA] Settings initialized via CBA";

// Set initialization flag
RA_initialized = true;
