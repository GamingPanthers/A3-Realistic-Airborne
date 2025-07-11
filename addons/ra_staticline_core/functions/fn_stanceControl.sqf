/*
    Function: RA_fnc_stanceControl
    Description: Handles stance logic for static line jumpers.
    
    Author: GamingPanthers
    Version: 1.1

    Modes:
        "stand" — sets player standing true
        "sit"   — sets player standing false
        "check" — returns if player is standing

    Params:
        [MODE, UNIT]

    Returns:
        Boolean (for "check" mode) or Nothing

    Example:
        ["stand", player] call RA_fnc_stanceControl;
        ["sit", player] call RA_fnc_stanceControl;
        ["check", player] call RA_fnc_stanceControl; // returns bool
*/

params ["_mode", "_unit"];

switch (_mode) do {
    case "stand": {
        // Set standing state
        _unit setVariable ["RA_UnitStanding", true, true];
        
        // Visual feedback - force standing animation if possible
        if (vehicle _unit != _unit) then {
            // In vehicle - limited animation options
            _unit switchMove "passenger_genric01_leanright"; //stands up.
        } else {
            // On foot - full animation control
            _unit playMove "AmovPercMstpSnonWnonDnon";
        };
        
        // Add visual indicator
        _unit setVariable ["RA_StanceIndicator", "STANDING", true];
        
        diag_log format ["[RA] Stance control: %1 is now standing", name _unit];
    };
    
    case "sit": {
        // Set sitting state
        _unit setVariable ["RA_UnitStanding", false, true];
        
        // Visual feedback - force sitting animation if possible
        if (vehicle _unit != _unit) then {
            // In vehicle - use vehicle-specific sitting
            _unit switchMove "";
        } else {
            // On foot - sitting animation
            _unit playMove "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon";
        };
        
        // Add visual indicator
        _unit setVariable ["RA_StanceIndicator", "SITTING", true];
        
        diag_log format ["[RA] Stance control: %1 is now sitting", name _unit];
    };
    
    case "check": {
        // Return standing state
        _unit getVariable ["RA_UnitStanding", false]
    };
    
    case "reset": {
        // Reset stance to default (sitting)
        _unit setVariable ["RA_UnitStanding", false, true];
        _unit setVariable ["RA_StanceIndicator", "SITTING", true];
        
        diag_log format ["[RA] Stance control: %1 stance reset to sitting", name _unit];
    };
    
    case "status": {
        // Return current status as string
        if (_unit getVariable ["RA_UnitStanding", false]) then {
            "STANDING"
        } else {
            "SITTING"
        };
    };
    
    default {
        diag_log format ["[RA] Stance control: Unknown mode '%1'", _mode];
        false
    };
};