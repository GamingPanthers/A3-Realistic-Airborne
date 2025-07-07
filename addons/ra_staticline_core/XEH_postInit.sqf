diag_log "[RA] Executing XEH_postInit.sqf...";

RA_validAircraft = [
    "CUP_B_C130J_USMC", "RHS_CH_47F", "UK3CB_B_Merlin_HC3_ATAK",
    "B_T_VTOL_01_vehicle_F", "B_Heli_Transport_01_F", "O_Heli_Transport_04_F"
];

["ace_interact_menu_loaded", {
    diag_log "[RA] ACE menu loaded event triggered.";

    params ["_unit"];
    if (!local _unit) exitWith { diag_log "[RA] Unit not local, aborting interaction assignment."; };

    diag_log format ["[RA] Adding self interaction to unit: %1", _unit];

    ["ACE_SelfActions", _unit, ["RA_Test", "Test Action", "", {
        hint "RA StaticLine loaded.";
    }]] call ace_interact_menu_fnc_addActionToObject;

}] call CBA_fnc_addEventHandler;
