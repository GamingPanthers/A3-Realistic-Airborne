/*
    Function: RA_fnc_createChute
    Description: Spawns a parachute and moves the jumper into it.
    
    Author: GamingPanthers
    Version: 1.0.2
    
    Used when a jumper does not have a valid parachute equipped.
    Deploys either a custom class or defaults to NonSteerable_Parachute_F.
    Automatically moves unit into the chute and adds ACE reserve parachute.

    Params:
        _unit (Object) — The jumper
        _dir (Number) — Aircraft direction
        _velocity (Array) — Initial velocity vector

    Returns:
        Object — The created parachute

    Example:
        [_unit, _dir, _velocity] call RA_fnc_createChute;
*/

params ["_unit", "_dir", ["_velocity", [0,0,0]]];

private _chuteClass = missionNamespace getVariable ["RA_ChuteClass", "NonSteerable_Parachute_F"];
diag_log format ["[RA] Creating parachute: %1 for %2", _chuteClass, name _unit];

// Get unit position and create chute slightly behind to avoid collision
private _unitPos = getPosASL _unit;
private _createPos = _unitPos vectorAdd [0, 0, -2]; // 2m below unit

private _chute = createVehicle [_chuteClass, ASLToAGL _createPos, [], 0, "CAN_COLLIDE"];
if (isNull _chute) exitWith {
    diag_log format ["[RA] ERROR: Failed to create parachute of class %1", _chuteClass];
    objNull
};

// Set parachute orientation (opposite to aircraft direction)
_chute setDir (_dir - 180);

// Move unit into parachute
_unit assignAsDriver _chute;
_unit moveInDriver _chute;

// Small delay to ensure proper vehicle assignment
sleep 0.1;

// Set velocity to match aircraft
if (count _velocity == 3) then {
    _chute setVelocity _velocity;
} else {
    _chute setVelocity (velocity _unit);
};

// Add reserve parachute if ACE3 is available
if (!isNil "ace_parachute_fnc_addReserveParachute") then {
    [_unit, "ACE_ReserveParachute"] call ace_parachute_fnc_addReserveParachute;
} else {
    // Fallback for non-ACE3 environments
    if (isNull (unitBackpack _unit)) then {
        _unit addBackpackGlobal "ACE_NonSteerableReserveParachute";
    };
};

// Set ACE3 parachute properties
_chute setVariable ["ace_parachute_canCut", true, true];
_chute setVariable ["ace_parachute_canReserve", true, true];
_chute setVariable ["RA_AutoDeployed", true, true];

// Add event handler for parachute landing
_chute addEventHandler ["GetOut", {
    params ["_vehicle", "_role", "_unit", "_turret"];
    
    if (_vehicle getVariable ["RA_AutoDeployed", false]) then {
        // Play landing sound
        playSound "RA_Landing";
        
        // FIXED: Use proper hint syntax
        private _message = format ["Successful landing! Altitude: %1m", round ((getPosATL _unit) select 2)];
        hintSilent _message;
        
        // Remove auto-added reserve parachute
        if (backpack _unit in ["ACE_NonSteerableReserveParachute", "ACE_ReserveParachute"]) then {
            [{
                params ["_unit"];
                if (alive _unit && (getPosATL _unit) select 2 < 5) then {
                    removeBackpack _unit;
                };
            }, [_unit], 2] call CBA_fnc_waitAndExecute;
        };
        
        diag_log format ["[RA] Auto-deployed parachute landing completed for %1", name _unit];
    };
}];

// Add damage protection during deployment
_unit allowDamage false;
[{
    params ["_unit"];
    _unit allowDamage true;
}, [_unit], 3] call CBA_fnc_waitAndExecute;

diag_log format ["[RA] Parachute %1 created and deployed for %2", typeOf _chute, name _unit];

_chute