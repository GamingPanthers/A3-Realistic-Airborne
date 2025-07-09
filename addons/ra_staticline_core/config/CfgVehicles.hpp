class CfgVehicles {
    class Plane_Base_F;
    class YourPlane : Plane_Base_F {
        class ACE_Actions {
            class ACE_MainActions {
                selection = "";
                distance = 3;
                condition = "true";
                statement = "";

                class RA_StaticLineHook {
                    displayName = "Hook Up Jumper";
                    condition = "player in crew _target";
                    statement = "['hook', player, _target] call RA_fnc_hookControl;";
                    icon = "\ra_staticline_core\ui\UI_Hook.paa";
                };
            };
        };
    };
};
