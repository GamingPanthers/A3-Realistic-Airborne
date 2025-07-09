class CfgVehicles {
    class AllVehicles;

    class Plane: AllVehicles {
        class ACE_SelfActions {
            class RA_StaticLine {
                displayName = "Static Line";
                icon = "\ra_staticline_core\ui\UI_StaticLine.paa";
                condition = "player in (crew _target)";
                statement = ""; // Root category, no statement needed

                class RA_StandUp {
                    displayName = "Stand Up";
                    condition = "!(['check', player] call RA_fnc_stanceControl)";
                    statement = "['stand', player] call RA_fnc_stanceControl;";
                };

                class RA_SitDown {
                    displayName = "Sit Down";
                    condition = "(['check', player] call RA_fnc_stanceControl) && !(['check', player] call RA_fnc_hookControl)";
                    statement = "['sit', player] call RA_fnc_stanceControl;";
                };

                class RA_HookUp {
                    displayName = "Hook Up";
                    icon = "\ra_staticline_core\ui\UI_Hook.paa";
                    condition = "!(['check', player] call RA_fnc_hookControl) && (['check', player] call RA_fnc_stanceControl)";
                    statement = "['hook', player, _target] call RA_fnc_hookControl;";
                };

                class RA_Unhook {
                    displayName = "Unhook";
                    icon = "\ra_staticline_core\ui\UI_Unhook.paa";
                    condition = "(['check', player] call RA_fnc_hookControl)";
                    statement = "['unhook', player, _target] call RA_fnc_hookControl;";
                };
            };
        };
    };
};
