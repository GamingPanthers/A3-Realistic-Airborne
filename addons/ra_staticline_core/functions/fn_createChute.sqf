/*
    Function: RA_fnc_createChute
    Spawns a parachute and moves the jumper into it.

    Description:
        Used when a jumper does not have a valid parachute equipped.
        Deploys either a custom class or defaults to NonSteerable_Parachute_F.
        Automatically moves unit into the chute and adds ACE reserve parachute.

    Params:
        _unit (Object) — The jumper
        _dir (Number) — Aircraft direction

    Example:
        [_unit, _dir] call RA_fnc_createChute;
*/

params ["_unit", "_dir"];

private _chuteClass = missionNamespace getVariable ["RA_ChuteClass", ""];

if (_chuteClass isEqualTo "") then {
    _chuteClass = "NonSteerable_Parachute_F";
    diag_log "[RA] No custom chute set. Defaulting to NonSteerable_Parachute_F.";
} else {
    diag_log format ["[RA] Custom chute class used: %1", _chuteClass];
};

private _chute = createVehicle [_chuteClass, getPosATL _unit, [], 0, "CAN_COLLIDE"];
_chute setDir (_dir - 180);
_chute setVelocity (velocity _unit);

_unit assignAsDriver _chute;
_unit moveInDriver _chute;

// Add reserve parachute (ACE)
if !(backpack _unit isEqualTo "ACE_NonSteerableReserveParachute") then {
    _unit addBackpackGlobal "ACE_NonSteerableReserveParachute";
    diag_log format ["[RA] Reserve parachute added to: %1", name _unit];
};

_chute setVariable ["ace_parachute_canCut", true, true];
diag_log format ["[RA] Parachute deployed for %1 using class %2", name _unit, _chuteClass];
