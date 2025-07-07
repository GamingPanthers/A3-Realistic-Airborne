class Extended_PreInit_EventHandlers {
    class realistic_airborne_preInit {
        init = "call compile preprocessFileLineNumbers '\ra_staticline_core\XEH_preInit.sqf'";
    };
};

class Extended_PostInit_EventHandlers {
    class realistic_airborne_postInit {
        init = "call compile preprocessFileLineNumbers '\ra_staticline_core\XEH_postInit.sqf'";
    };
};
