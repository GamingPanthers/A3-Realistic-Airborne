/*
    File: XEH_preInit.sqf
    Description: Pre-initialization for Realistic Airborne CBA settings.
*/

// Require static parachute equipped (default: true for realism)
[
    "RA_StaticEquipped",
    "CHECKBOX",
    ["Require Static Parachute Equipped", "Require players to be equipped with static chute before jumping?"],
    ["Realistic Airborne", "Settings"],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

// Allow Night Vision Gear when reserve deployed (default: true)
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

// Optional override for parachute class to spawn (default: ACE NonSteerable)
[
    "RA_ChuteClass",
    "EDITBOX",
    ["Custom Chute Classname", "Optional deployed chute classname. Leave empty for ACE_NonSteerableParachute."],
    ["Realistic Airborne", "Settings"],
    "ACE_NonSteerableParachute",
    1,
    {}
] call CBA_fnc_addSetting;