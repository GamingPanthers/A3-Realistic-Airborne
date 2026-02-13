/*
    Function: RA_fnc_createChute
    Description: Spawns a parachute and moves the jumper into it.
    Author: GamingPanthers
    Version: 1.0.3
*/

params ["_unit", "_dir", ["_velocity", [0,0,0]]];

private _chuteClass = missionNamespace getVariable ["RA_ChuteClass", "NonSteerable_Parachute_F"];
diag_log format ["[RA] Creating parachute: %1 for %2", _chuteClass, name _unit];

private _unitPos = getPosASL _unit;
private _createPos = _unitPos vectorAdd [0, 0, -2]; 

private _chute = createVehicle [_chuteClass, ASLToAGL _createPos, [], 0, "CAN_COLLIDE"];
if (isNull _chute) exitWith {
    diag_log format ["[RA] ERROR: Failed to create parachute of class %1", _chuteClass];
    objNull
};

_chute setDir (_dir - 180);
_unit assignAsDriver _chute;
_unit moveInDriver _chute;

sleep 0.1;

if (count _velocity == 3) then {
    _chute setVelocity _velocity;
} else {
    _chute setVelocity (velocity _unit);
};

// Add ACE reserve if available
if (!isNil "ace_parachute_fnc_addReserveParachute") then {
    [_unit, "ACE_ReserveParachute"] call ace_parachute_fnc_addReserveParachute;
} else {
    if (isNull (unitBackpack _unit)) then {
        _unit addBackpackGlobal "ACE_NonSteerableReserveParachute";
    };
};

_chute setVariable ["ace_parachute_canCut", true, true];
_chute setVariable ["ace_parachute_canReserve", true, true];
_chute setVariable ["RA_AutoDeployed", true, true];

_chute addEventHandler ["GetOut", {
    params ["_vehicle", "_role", "_unit", "_turret"];
    if (_vehicle getVariable ["RA_AutoDeployed", false]) then {
        playSound "RA_Landing";
        hintSilent format ["Successful landing! Altitude: %1m", round ((getPosATL _unit) select 2)];
        
        // Remove auto-added reserve parachute after landing
        if (backpack _unit in ["ACE_NonSteerableReserveParachute", "ACE_ReserveParachute"]) then {
            [{
                params ["_unit"];
                if (alive _unit && (getPosATL _unit) select 2 < 5) then {
                    removeBackpack _unit;
                };
            }, [_unit], 2] call CBA_fnc_waitAndExecute;
        };
    };
}];

// Damage protection
_unit allowDamage false;
[{
    params ["_unit"];
    _unit allowDamage true;
}, [_unit], 3] call CBA_fnc_waitAndExecute;

_chute