/*
 * Author: GamingPanthers
 * Controls unit stance for airborne operations while seated in aircraft
 * Provides immersive stance changes for hookup procedures and jump preparation
 *
 * Arguments:
 * 0: Mode <STRING> - "sit" (relaxed), "ready" (alert/standing), "reset"
 * 1: Unit <OBJECT> - The unit to control
 *
 * Return Value:
 * None
 *
 * Example:
 * ["sit", player] call RA_fnc_stanceControl;
 * ["ready", player] call RA_fnc_stanceControl;
 *
 * Public: No
 */

params [
    ["_mode", "", [""]],
    ["_unit", objNull, [objNull]]
];

// Validate parameters
if (_mode == "" || isNull _unit) exitWith {
    diag_log format ["[RA ERROR] Invalid stance control parameters: mode=%1, unit=%2", _mode, _unit];
};

// Only work on units inside vehicles (seated passengers)
if (vehicle _unit == _unit) exitWith {
    diag_log format ["[RA] Stance control skipped: %1 is not in a vehicle", name _unit];
};

// Handle different stance modes for seated passengers
switch (toLower _mode) do {
    case "sit": {
        // Relaxed sitting position - slouched/resting
        [_unit] spawn {
            params ["_unit"];
            
            // Use relaxed passenger animation
            _unit switchMove "passenger_generic01_foldhands";
            sleep 0.1;
            
            // Store stance state
            _unit setVariable ["RA_Stance", "sitting", true];
        };
        
        diag_log format ["[RA] Stance control: %1 is now in relaxed sitting position", name _unit];
    };
    
    case "ready";
    case "stand": {
        // Alert/ready position - upright and prepared
        [_unit] spawn {
            params ["_unit"];
            
            // Use alert passenger animation
            _unit switchMove "passenger_generic01_leanright";
            sleep 0.1;
            
            // Store stance state
            _unit setVariable ["RA_Stance", "ready", true];
        };
        
        diag_log format ["[RA] Stance control: %1 is now in alert/ready position", name _unit];
    };
    
    case "hookup": {
        // Special hookup position - reaching up to hook static line
        [_unit] spawn {
            params ["_unit"];
            
            // Use reaching/hookup animation
            _unit switchMove "passenger_generic01_leanout";
            sleep 0.1;
            
            // Store stance state
            _unit setVariable ["RA_Stance", "hookup", true];
        };
        
        diag_log format ["[RA] Stance control: %1 is hooking up static line", name _unit];
    };
    
    case "reset": {
        // Reset to default passenger animation
        _unit switchMove "";
        _unit setVariable ["RA_Stance", nil, true];
        
        diag_log format ["[RA] Stance control: %1 stance reset to default", name _unit];
    };
    
    default {
        diag_log format ["[RA ERROR] Unknown stance mode: %1 (valid: sit, ready, hookup, reset)", _mode];
    };
};

// Optional: Add sound effect for immersion
if (hasInterface && _unit == player) then {
    switch (toLower _mode) do {
        case "sit": {
            // Subtle movement sound
            playSound3D ["A3\Sounds_F\characters\movements\pf_movement_03.wss", _unit, false, getPosASL _unit, 1, 1, 10];
        };
        case "ready";
        case "hookup": {
            // Equipment adjustment sound
            playSound3D ["A3\Sounds_F\characters\movements\gear_01.wss", _unit, false, getPosASL _unit, 1, 1, 10];
        };
    };
};