/*
    Function: RA_fnc_stanceControl
    Description: Handles stance logic for static line jumpers with animation memory.
    Author: GamingPanthers
    Version: 1.0.3
*/

params ["_mode", "_unit"];

if (isNull _unit || !alive _unit) exitWith { false };

switch (_mode) do {
    case "init": {
        private _currentAnimation = animationState _unit;
        
        // OPTIMIZED: objectParent check
        if (!isNull objectParent _unit) then {
            _unit setVariable ["RA_OriginalSittingAnim", _currentAnimation, true];
            _unit setVariable ["RA_InVehicle", true, true];
        } else {
            _unit setVariable ["RA_OriginalSittingAnim", "AmovPsitMstpSnonWnonDnon", true];
            _unit setVariable ["RA_InVehicle", false, true];
        };
        
        _unit setVariable ["RA_UnitStanding", false, true];
        _unit setVariable ["RA_StanceIndicator", "SITTING", true];
    };

    case "stand": {
        if (_unit getVariable ["RA_UnitStanding", false]) exitWith {};
        
        private _currentAnim = animationState _unit;
        if (_currentAnim != "") then {
            _unit setVariable ["RA_OriginalSittingAnim", _currentAnim, true];
        };
        
        _unit setVariable ["RA_UnitStanding", true, true];
        
        if (!isNull objectParent _unit) then {
            _unit switchMove "passenger_generic01_leanright";
            [_unit] spawn {
                params ["_unit"];
                sleep 1.5;
                if (alive _unit && _unit getVariable ["RA_UnitStanding", false]) then {
                    _unit switchMove "passenger_generic01_foldhands";
                };
            };
        } else {
            _unit playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon";
            [_unit] spawn {
                params ["_unit"];
                sleep 2.0;
                if (alive _unit && _unit getVariable ["RA_UnitStanding", false]) then {
                    _unit switchMove "AmovPercMstpSnonWnonDnon";
                };
            };
        };
        
        _unit setVariable ["RA_StanceIndicator", "STANDING", true];
    };

    case "sit": {
        if (!(_unit getVariable ["RA_UnitStanding", false])) exitWith {};
        
        _unit setVariable ["RA_UnitStanding", false, true];
        private _originalSittingAnim = _unit getVariable ["RA_OriginalSittingAnim", ""];
        
        if (!isNull objectParent _unit) then {
            _unit switchMove "passenger_generic01_leanright";
            [_unit, _originalSittingAnim] spawn {
                params ["_unit", "_originalAnim"];
                sleep 1.0;
                if (alive _unit && !(_unit getVariable ["RA_UnitStanding", false])) then {
                    if (_originalAnim != "") then {
                        _unit switchMove _originalAnim;
                    } else {
                        _unit switchMove "";
                    };
                };
            };
        } else {
            _unit playMove "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon";
            [_unit, _originalSittingAnim] spawn {
                params ["_unit", "_originalAnim"];
                sleep 2.0;
                if (alive _unit && !(_unit getVariable ["RA_UnitStanding", false])) then {
                    if (_originalAnim != "") then {
                        _unit switchMove _originalAnim;
                    } else {
                        _unit switchMove "AmovPsitMstpSnonWnonDnon";
                    };
                };
            };
        };
        
        _unit setVariable ["RA_StanceIndicator", "SITTING", true];
    };

    case "check": {
        _unit getVariable ["RA_UnitStanding", false]
    };

    case "reset": {
        _unit setVariable ["RA_UnitStanding", false, true];
        _unit setVariable ["RA_StanceIndicator", "SITTING", true];
        
        private _originalSittingAnim = _unit getVariable ["RA_OriginalSittingAnim", ""];
        if (_originalSittingAnim != "") then {
            _unit switchMove _originalSittingAnim;
        };
    };

    case "status": {
        // OPTIMIZED: Replaced if/then/else with select
        private _status = ["SITTING", "STANDING"] select (_unit getVariable ["RA_UnitStanding", false]);
        private _originalAnim = _unit getVariable ["RA_OriginalSittingAnim", "NONE"];
        format ["%1 (Original: %2)", _status, _originalAnim];
    };

    default { false };
};