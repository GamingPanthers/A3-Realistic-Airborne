class CfgVehicles {
    class CAManBase {
        class ACE_SelfActions {
            class RA_StaticLine {
                displayName = "Static Line";
                icon = "\ra_staticline_core\ui\UI_StaticLine.paa";
                condition = "(_this call RA_fnc_canJump)";
                statement = "";
                insertChildren = "_this call RA_fnc_addStaticLineActions";
            };
        };
    };
};
