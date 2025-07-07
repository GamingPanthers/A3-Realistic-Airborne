/*
    File: XEH_preInit.sqf
    Description: Registers CBA settings for Realistic Airborne
*/

[
    "RA_StaticEquipped",         // Variable
    "CHECKBOX",                  // Type
    ["Require Static Parachute Equipped", "Require players to be equipped with static chute before jumping?"], // Display name + Tooltip
    ["Realistic Airborne", "Settings"],  // Category
    true,                        // Default value
    1,                           // Global setting (1 = synced in MP)
    {},                          // Code on change
    true                         // Requires restart
    
] call CBA_fnc_addSetting;

[
    "RA_ChuteClass",
    "EDITBOX",
    ["Custom Chute Classname", "Optional deployed chute classname. Leave empty for vanilla NonSteerable_Parachute_F."],
    ["Realistic Airborne", "Settings"],
    "",
    1,
    {},
    false
] call CBA_fnc_addSetting;

[
    "RA_NODsFriendly",
    "CHECKBOX",
    ["Allow NODs With Reserve", "If false, NVGs will be removed during reserve chute deployment."],
    ["Realistic Airborne", "Settings"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;
