/*
    Function: RA_fnc_hookControl
    Description: Manages hook state and jump action for static line.
    Author: GamingPanthers
    Version: 1.0.3
*/

params ["_mode", "_unit", ["_vehicle", objNull]];

switch (_mode) do {
    case "hook": {
        _unit setVariable ["RA_UnitHooked", true, true];
        
        if (isNull _vehicle) then {
            _vehicle = objectParent _unit;
        };
        
        // Remove existing action if present
        private _existingAction = _unit getVariable ["RA_JumpAction", -1];
        if (_existingAction != -1) then {
            _vehicle removeAction _existingAction;
        };
        
        private _jumpAction = _vehicle addAction [
            "<t color='#00FF00'>Static Line Jump</t>",
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                [_target, _caller] call RA_fnc_staticJump;
            },
            [],
            10, 
            true, 
            true, 
            "", 
            "
                _target getCargoIndex _this != -1 && 
                ((getPosATL _target) select 2 > 100) && 
                (_this getVariable ['RA_UnitHooked', false]) &&
                (_this getVariable ['RA_UnitStanding', false])
            "
        ];
        
        _unit setVariable ["RA_JumpAction", _jumpAction, true];
        _unit setVariable ["RA_JumpActionVehicle", _vehicle, true];
    };

    case "unhook": {
        _unit setVariable ["RA_UnitHooked", false, true];
        
        private _jumpAction = _unit getVariable ["RA_JumpAction", -1];
        private _actionVehicle = _unit getVariable ["RA_JumpActionVehicle", objNull];
        
        if (isNull _actionVehicle && !isNull _vehicle) then {
            _actionVehicle = _vehicle;
        };
        
        if (_jumpAction != -1 && !isNull _actionVehicle) then {
            _actionVehicle removeAction _jumpAction;
        };
        
        _unit setVariable ["RA_JumpAction", nil, true];
        _unit setVariable ["RA_JumpActionVehicle", nil, true];
    };

    case "check": {
        _unit getVariable ["RA_UnitHooked", false]
    };

    default { false };
};