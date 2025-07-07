class CfgVehicles {
    class All;
    class AllVehicles : All {};
    class Land : AllVehicles {};
    class Air : Land {
        class ACE_SelfActions {
            class RA_StaticLine {
                displayName = "Static Line";
                icon = "\ra_staticline_core\ui\UI_StaticLine.paa";
                condition = "player in (crew _target) && {[_target] call RA_fnc_isValidAircraft}";
                statement = "";
                modifierFunction = "";

                class StandUp {
                    displayName = "Stand Up";
                    condition = "!(['check', player] call RA_fnc_stanceControl)";
                    statement = "['stand', player] call RA_fnc_stanceControl;";
                    icon = "";
                };

                class SitDown {
                    displayName = "Sit Down";
                    condition = "(['check', player] call RA_fnc_stanceControl) && !(['check', player] call RA_fnc_hookControl)";
                    statement = "['sit', player] call RA_fnc_stanceControl;";
                    icon = "";
                };

                class HookUp {
                    displayName = "Hook Up";
                    condition = "!(['check', player] call RA_fnc_hookControl) && (['check', player] call RA_fnc_stanceControl)";
                    statement = "['hook', player, _target] call RA_fnc_hookControl;";
                    icon = "\ra_staticline_core\ui\UI_Hook.paa";
                };

                class Unhook {
                    displayName = "Unhook";
                    condition = "(['check', player] call RA_fnc_hookControl)";
                    statement = "['unhook', player, _target] call RA_fnc_hookControl;";
                    icon = "\ra_staticline_core\ui\UI_Unhook.paa";
                };
            };
        };
    };
};
