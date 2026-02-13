/*
    Function: RA_fnc_staticJump
    Description: Executes a static line jump sequence.
    Author: GamingPanthers
    Version: 1.0.3
*/

params [
    ["_vehicle", objNull, [objNull]],
    ["_unit", objNull, [objNull]]
];

if (isNull _vehicle || isNull _unit) exitWith {
    diag_log format ["[RA ERROR] Invalid parameters: vehicle=%1, unit=%2", _vehicle, _unit];
};

private _validParachutes = [
    "ACE_NonSteerableParachute", "ACE_ReserveParachute",
    "B_Parachute", "CUP_B_ParachutePack",
    "rhsusf_b_parachute", "UK3CB_BAF_B_Parachute",
    "vn_b_pack_t10_01", "vn_b_pack_ba22_01"
];

private _backpack = backpack _unit;
private _hasValidParachute = false;
if (_backpack != "") then {
    _hasValidParachute = (_backpack in _validParachutes) || (_backpack isKindOf "B_Parachute");
};

private _parachuteRequired = missionNamespace getVariable ["RA_StaticEquipped", true];

if (_parachuteRequired && !_hasValidParachute) exitWith {
    private _message = localize "STR_RA_NoParachute"; 
    if (_message == "") then { _message = "You must have a static parachute equipped to jump."; };
    
    if (hasInterface && _unit == player) then {
        hint _message;
        playSound "FD_Start_F";
    };
};

// Handle backpack removal
if (!_parachuteRequired && !_hasValidParachute && _backpack != "") then {
    _unit setVariable ["RA_StoredBackpack", [_backpack, backpackItems _unit, backpackMagazines _unit], true];
    removeBackpack _unit;
};

private _aircraftVelocity = velocity _vehicle;
private _aircraftDirection = direction _vehicle;

[_unit, _vehicle, _aircraftVelocity, _aircraftDirection, _hasValidParachute] spawn {
    params ["_unit", "_vehicle", "_vel", "_dir", "_hasChute"];

    unassignVehicle _unit;
    _unit action ["Eject", _vehicle];
    
    // OPTIMIZED: Wait until objectParent is null
    waitUntil { sleep 0.1; isNull objectParent _unit };
    
    _unit setDir (_dir + 180);
    _unit setVelocity _vel;
    
    sleep 0.2;

    if (_hasChute) then {
        _unit action ["OpenParachute", _unit];
        sleep 0.1;
        // OPTIMIZED: check objectParent instead of vehicle == unit
        if (!isNull objectParent _unit) then {
            (objectParent _unit) setVelocity _vel;
        };
        
        if (backpack _unit in ["ACE_NonSteerableParachute", "ACE_ReserveParachute"]) then {
            _unit setVariable ["ace_parachute_deployed", true, true];
        };
    } else {
        // Fallback or create chute
        if (isClass (configFile >> "CfgFunctions" >> "RA" >> "staticline" >> "createChute")) then {
             [_unit, _dir] call RA_fnc_createChute;
        } else {
            _unit addBackpack "B_Parachute";
            _unit action ["OpenParachute", _unit];
        };
    };
    
    // Reset states
    ["unhook", _unit] call RA_fnc_hookControl;
    ["sit", _unit] call RA_fnc_stanceControl;
    
    if (!isNil "CBA_fnc_globalEvent") then {
        ["RA_staticJumpCompleted", [_unit, _vehicle]] call CBA_fnc_globalEvent;
    };
};

true