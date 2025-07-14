/*
    Function: RA_fnc_hookControl
    Description: Manages hook state and jump action for static line.
    
    Author: GamingPanthers
    Version: 1.0.1

    Modes:
        "hook" — set hooked true, add jump action
        "unhook" — set hooked false, remove jump action
        "check" — return if player is hooked

    Params:
        [MODE, UNIT, (optional) VEHICLE]

    Returns:
        Boolean (for "check" mode) or Nothing

    Example:
        ["hook", player, vehicle player] call RA_fnc_hookControl;
        ["unhook", player, vehicle player] call RA_fnc_hookControl;
        ["check", player] call RA_fnc_hookControl; // returns bool
*/

params ["_mode", "_unit", ["_vehicle", objNull]];

switch (_mode) do {
    case "hook": {
        // Set hooked state
        _unit setVariable ["RA_UnitHooked", true, true];
        
        // Get vehicle if not provided
        if (isNull _vehicle) then {
            _vehicle = vehicle _unit;
        };
        
        // Remove existing jump action if any
        private _existingAction = _unit getVariable ["RA_JumpAction", -1];
        if (_existingAction != -1) then {
            _vehicle removeAction _existingAction;
        };
        
        // Add new jump action
        private _jumpAction = _vehicle addAction [
            "<t color='#00FF00'>Static Line Jump</t>",
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                [_target, _caller] call RA_fnc_staticJump;
            },
            [],
            10, // High priority
            true, // Show window
            true, // Hide on use
            "", // Shortcut
            "
                _target getCargoIndex _this != -1 && 
                ((getPosATL _target) select 2 > 100) && 
                (_this getVariable ['RA_UnitHooked', false]) &&
                (_this getVariable ['RA_UnitStanding', false])
            " // Condition
        ];
        
        // Store action ID for cleanup
        _unit setVariable ["RA_JumpAction", _jumpAction, true];
        _unit setVariable ["RA_JumpActionVehicle", _vehicle, true];
        
        diag_log format ["[RA] Hook control: %1 hooked up to %2 (Action ID: %3)", name _unit, typeOf _vehicle, _jumpAction];
    };

    case "unhook": {
        // Set unhooked state
        _unit setVariable ["RA_UnitHooked", false, true];
        
        // Get stored action and vehicle
        private _jumpAction = _unit getVariable ["RA_JumpAction", -1];
        private _actionVehicle = _unit getVariable ["RA_JumpActionVehicle", objNull];
        
        // Use provided vehicle as fallback
        if (isNull _actionVehicle && !isNull _vehicle) then {
            _actionVehicle = _vehicle;
        };
        
        // Remove jump action
        if (_jumpAction != -1 && !isNull _actionVehicle) then {
            _actionVehicle removeAction _jumpAction;
            diag_log format ["[RA] Hook control: Removed jump action %1 from %2", _jumpAction, typeOf _actionVehicle];
        };
        
        // Clear stored variables
        _unit setVariable ["RA_JumpAction", nil, true];
        _unit setVariable ["RA_JumpActionVehicle", nil, true];
        
        diag_log format ["[RA] Hook control: %1 unhooked", name _unit];
    };

    case "check": {
        // Return hook state
        _unit getVariable ["RA_UnitHooked", false]
    };
    
    default {
        diag_log format ["[RA] Hook control: Unknown mode '%1'", _mode];
        false
    };
};