/*
    Function: RA_fnc_createChute
    Spawns a parachute and moves the jumper into it.

    Description:
        Used when a jumper does not have a valid parachute equipped.
        Deploys either a custom class (CBA setting) or defaults to NonSteerable_Parachute_F.
        Moves unit into chute and adds ACE reserve parachute.

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
};

private _chute = createVehicle [_chuteClass, getPos _unit, [], 0, "CAN_COLLIDE"];
_chute setDir (_dir - 180);
_chute setVelocity (velocity _unit);

_unit assignAsDriver _chute;
_unit moveInDriver _chute;

if (isClass (configFile >> "CfgVehicles" >> "ACE_NonSteerableReserveParachute")) then {
    _unit addBackpackGlobal "ACE_NonSteerableReserveParachute";
};

_chute setVariable ["ace_parachute_canCut", true, true];
