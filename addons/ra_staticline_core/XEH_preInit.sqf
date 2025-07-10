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

[
    "RA_ChuteClass",
    "EDITBOX",
    ["Custom Chute Classname", "Optional deployed chute classname. Leave empty for vanilla NonSteerable_Parachute_F."],
    ["Realistic Airborne", "Settings"],
    "",
    1,
    {}
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
