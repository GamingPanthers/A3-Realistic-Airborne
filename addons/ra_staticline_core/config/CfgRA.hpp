class CfgRA {
    class StaticLine {
        // Aircraft allowed for static line jump
        class AircraftWhitelist {
            RA_validAircraft[] = {
                // Vanilla
                "B_T_VTOL_01_infantry_F",        // Blackfish (Infantry Transport)
                "B_Heli_Transport_01_F",         // Huron

                // CUP
                "CUP_B_C130J_USMC",              // C-130J
                "CUP_B_CH47F_USA",               // CH-47F Chinook
                "CUP_B_MV22_USMC",               // MV-22 Osprey

                // RHS
                "RHS_C130J",
                "RHS_CH_47F",

                // ADFRC
                "adf_c130j_australia",
                "ADFRC_Merlin_HC3"
            };
        };

        // Parachute classes recognized as "equipped"
        class ParachuteWhitelist {
            RA_validParachutes[] = {
                "B_Parachute",                      // Vanilla
                "Steerable_Parachute_F",            // Steerable chute
                "CUP_B_ParachutePack",              // CUP Static Line chute
                "RHSUSF_B_BACKPACK_StaticLine"      // RHS Static Line chute (if used)
            };
        };
    };
};
