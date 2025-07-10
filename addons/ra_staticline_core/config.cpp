// Include HPP Files
#include "config\CfgFunctions.hpp"
#include "config\CfgVehicles.hpp"
#include "config\CfgEventHandlers.hpp"
#include "config\CfgRA.hpp"

// Patches Config
class CfgPatches {
    class RA_Airborne {
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
            
            // ACE3 Core (optional but recommended)
            "ace_main",
            "ace_common",
            "ace_parachute",
            
            // CBA (if using CBA events)
            "cba_main",
            "cba_events"
        };
        skipWhenMissingDependencies = 1;
        version = "1.0.0";
        versionStr = "1.0.0";
        versionAr[] = {1,0,0};
    };
};
