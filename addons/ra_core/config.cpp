#include "script_version.hpp"

// Patches Config
class CfgPatches {
    class ra_core {
        name = "Realistic Airborne";
        author = "GamingPanthers";
        units[] = {};
        weapons[] = {};
        requiredVersion = 2.00;
        requiredAddons[] = {
            // Core Arma 3
            "A3_Functions_F",
            "A3_Data_F",
            "A3_Characters_F",
            "A3_Air_F",
            "A3_Air_F_Heli",
            "A3_Air_F_Beta",
            
            // ACE3 Core
            "ace_main",
            "ace_common",
            "ace_parachute",
            
            // CBA
            "cba_main",
            "cba_events"
        };
        skipWhenMissingDependencies = 1;
        version = "1.0.0";
        versionStr = "1.0.0";
        versionAr[] = {1,0,0};
    };
};

class CfgFunctions {
    class ra_core {
        class core {
            file = "addons\ra_core\functions";
            class init {
                preInit = 1;
                postInit = 1;
            };
        };
    };
};

class Extended_PreInit_EventHandlers {
    class ra_core {
        init = "call ra_fnc_preInit";
    };
};

class Extended_PostInit_EventHandlers {
    class ra_core {
        init = "call ra_fnc_postInit";
    };
};
