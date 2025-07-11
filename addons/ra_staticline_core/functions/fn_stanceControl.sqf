/*
    Function: RA_fnc_stanceControl
    Description: Handles stance logic for static line jumpers with animation memory.
    
    Author: GamingPanthers
    Version: 1.2

    Modes:
        "stand" — sets player standing true with stand-up animation
        "sit"   — sets player standing false with sit-down animation to original position
        "check" — returns if player is standing
        "reset" — resets to default sitting state
        "status" — returns current status as string
        "init"  — initializes stance system for unit

    Params:
        [MODE, UNIT]

    Returns:
        Boolean (for "check" mode) or Nothing

    Example:
        ["init", player] call RA_fnc_stanceControl;   // Initialize first
        ["stand", player] call RA_fnc_stanceControl;
        ["sit", player] call RA_fnc_stanceControl;
        ["check", player] call RA_fnc_stanceControl; // returns bool
*/

params ["_mode", "_unit"];

// Error checking
if (isNull _unit) exitWith {
    diag_log "[RA] Stance control: Unit is null";
    false
};

if (!alive _unit) exitWith {
    diag_log "[RA] Stance control: Unit is dead";
    false
};

switch (_mode) do {
    case "init": {
        // Initialize the stance system - call this when unit first boards aircraft
        private _currentAnimation = animationState _unit;
        
        // Store initial/default sitting animation
        if (vehicle _unit != _unit) then {
            // In vehicle - store current passenger animation
            _unit setVariable ["RA_OriginalSittingAnim", _currentAnimation, true];
            _unit setVariable ["RA_InVehicle", true, true];
        } else {
            // On foot - use default sitting animation
            _unit setVariable ["RA_OriginalSittingAnim", "AmovPsitMstpSnonWnonDnon", true];
            _unit setVariable ["RA_InVehicle", false, true];
        };
        
        // Set initial state
        _unit setVariable ["RA_UnitStanding", false, true];
        _unit setVariable ["RA_StanceIndicator", "SITTING", true];
        
        diag_log format ["[RA] Stance control: %1 initialized with original animation: %2", name _unit, _currentAnimation];
    };
    
    case "stand": {
        // Only proceed if currently sitting
        if (_unit getVariable ["RA_UnitStanding", false]) exitWith {
            diag_log format ["[RA] Stance control: %1 is already standing", name _unit];
        };
        
        // Store current animation before standing (in case it changed)
        private _currentAnim = animationState _unit;
        if (_currentAnim != "") then {
            _unit setVariable ["RA_OriginalSittingAnim", _currentAnim, true];
        };
        
        // Set standing state
        _unit setVariable ["RA_UnitStanding", true, true];
        
        // Perform stand-up animation
        if (vehicle _unit != _unit) then {
            // In vehicle - standing animation sequence
            private _vehicle = vehicle _unit;
            
            // First, transition animation (standing up motion)
            _unit switchMove "passenger_generic01_leanright";
            
            // Add slight delay for realism, then set final standing position
            [{
                params ["_unit"];
                if (alive _unit && _unit getVariable ["RA_UnitStanding", false]) then {
                    _unit switchMove "passenger_generic01_foldhands"; // Final standing position
                };
            }, [_unit], 1.5] call CBA_fnc_waitAndExecute;
            
        } else {
            // On foot - standing animation sequence
            // Transition from sitting to standing
            _unit playMove "AmovPsitMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon";
            
            // Set final standing position after animation completes
            [{
                params ["_unit"];
                if (alive _unit && _unit getVariable ["RA_UnitStanding", false]) then {
                    _unit switchMove "AmovPercMstpSnonWnonDnon";
                };
            }, [_unit], 2.0] call CBA_fnc_waitAndExecute;
        };
        
        // Add visual indicator
        _unit setVariable ["RA_StanceIndicator", "STANDING", true];
        
        diag_log format ["[RA] Stance control: %1 is standing up", name _unit];
    };
    
    case "sit": {
        // Only proceed if currently standing
        if (!(_unit getVariable ["RA_UnitStanding", false])) exitWith {
            diag_log format ["[RA] Stance control: %1 is already sitting", name _unit];
        };
        
        // Set sitting state
        _unit setVariable ["RA_UnitStanding", false, true];
        
        // Get original sitting animation
        private _originalSittingAnim = _unit getVariable ["RA_OriginalSittingAnim", ""];
        
        // Perform sit-down animation back to original position
        if (vehicle _unit != _unit) then {
            // In vehicle - sitting down animation sequence
            
            // First, transition animation (sitting down motion)
            _unit switchMove "passenger_generic01_leanright"; // Intermediate position
            
            // Then return to original sitting position
            [{
                params ["_unit", "_originalAnim"];
                if (alive _unit && !(_unit getVariable ["RA_UnitStanding", false])) then {
                    if (_originalAnim != "") then {
                        _unit switchMove _originalAnim;
                    } else {
                        _unit switchMove ""; // Default passenger animation
                    };
                };
            }, [_unit, _originalSittingAnim], 1.0] call CBA_fnc_waitAndExecute;
            
        } else {
            // On foot - sitting down animation sequence
            // Transition from standing to sitting
            _unit playMove "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon";
            
            // Set final sitting position (original position)
            [{
                params ["_unit", "_originalAnim"];
                if (alive _unit && !(_unit getVariable ["RA_UnitStanding", false])) then {
                    if (_originalAnim != "") then {
                        _unit switchMove _originalAnim;
                    } else {
                        _unit switchMove "AmovPsitMstpSnonWnonDnon"; // Default sitting
                    };
                };
            }, [_unit, _originalSittingAnim], 2.0] call CBA_fnc_waitAndExecute;
        };
        
        // Add visual indicator
        _unit setVariable ["RA_StanceIndicator", "SITTING", true];
        
        diag_log format ["[RA] Stance control: %1 is sitting down to original position: %2", name _unit, _originalSittingAnim];
    };
    
    case "check": {
        // Return standing state
        _unit getVariable ["RA_UnitStanding", false]
    };
    
    case "reset": {
        // Reset stance to default (sitting) with original animation
        _unit setVariable ["RA_UnitStanding", false, true];
        _unit setVariable ["RA_StanceIndicator", "SITTING", true];
        
        // Return to original sitting position if available
        private _originalSittingAnim = _unit getVariable ["RA_OriginalSittingAnim", ""];
        if (_originalSittingAnim != "") then {
            _unit switchMove _originalSittingAnim;
        };
        
        diag_log format ["[RA] Stance control: %1 stance reset to original sitting position", name _unit];
    };
    
    case "status": {
        // Return current status as string with animation info
        private _status = if (_unit getVariable ["RA_UnitStanding", false]) then { "STANDING" } else { "SITTING" };
        private _originalAnim = _unit getVariable ["RA_OriginalSittingAnim", "NONE"];
        format ["%1 (Original: %2)", _status, _originalAnim];
    };
    
    case "debug": {
        // Debug information
        private _standing = _unit getVariable ["RA_UnitStanding", false];
        private _indicator = _unit getVariable ["RA_StanceIndicator", "UNKNOWN"];
        private _originalAnim = _unit getVariable ["RA_OriginalSittingAnim", "NONE"];
        private _currentAnim = animationState _unit;
        private _inVehicle = _unit getVariable ["RA_InVehicle", false];
        
        systemChat format ["[DEBUG] %1 - Standing: %2, Indicator: %3, Current: %4, Original: %5, InVehicle: %6", 
            name _unit, _standing, _indicator, _currentAnim, _originalAnim, _inVehicle];
    };
    
    default {
        diag_log format ["[RA] Stance control: Unknown mode '%1'", _mode];
        false
    };
};