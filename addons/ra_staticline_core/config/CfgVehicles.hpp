class CfgVehicles {
    class AllVehicles;

    class Plane: AllVehicles {
        class ACE_SelfActions {
            class StaticLine {
                displayName = "Static Line";
                condition = "player in (crew _target)";
                statement = "";
                icon = "\ra_staticline_core\ui\UI_StaticLine.paa";

                class StandUp {
                    displayName = "Stand Up";
                    condition = "!(['check', player] call RA_fnc_stanceControl)";
                    statement = "['stand', player] call RA_fnc_stanceControl;";
                };

                class SitDown {
                    displayName = "Sit Down";
                    condition = "(['check', player] call RA_fnc_stanceControl) && !(['check', player] call RA_fnc_hookControl)";
                    statement = "['sit', player] call RA_fnc_stanceControl;";
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
