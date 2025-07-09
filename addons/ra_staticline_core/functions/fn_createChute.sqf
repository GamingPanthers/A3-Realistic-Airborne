/*
    Function: RA_fnc_createChute
    Spawns a parachute and moves the jumper into it.

    Description:
        Used when a jumper does not have a valid parachute equipped.
        Deploys either a custom class or defaults to ACE_NonSteerableParachute.
        Automatically moves unit into the chute and adds ACE reserve parachute.

    Params:
        _unit (Object) — The jumper
        _dir (Number) — Aircraft direction

    Example:
        [_unit, _dir] call RA_fnc_createChute;
*/

params ["_unit", "_dir"];

// Validate unit
if (isNull _unit || {!alive _unit}) exitWith {
    diag_log "[RA] createChute aborted: Invalid or dead unit.";
};

// Determine chute class
private _chuteClass = missionNamespace getVariable ["RA_ChuteClass", ""];
if (_chuteClass isEqualTo "") then {
    _chuteClass = "ACE_NonSteerableParachute";
    diag_log "[RA] No custom chute set. Using default ACE_NonSteerableParachute.";
} else {
    diag_log format ["[RA] Using custom chute class: %1", _chuteClass];
};

// Create parachute object
private _pos = getPosATL _unit;
private _chute = createVehicle [_chuteClass, _pos, [], 0, "CAN_COLLIDE"];
_chute setDir (_dir - 180);
_chute setVelocity (velocity _unit);

// Assign jumper to chute
_unit allowDamage false;  // Optional safety on insert
_unit assignAsDriver _chute;
_unit moveInDriver _chute;
_unit allowDamage true;

// Add ACE reserve parachute if not already
if !(backpack _unit isEqualTo "ACE_ReserveParachute") then {
    removeBackpackGlobal _unit;
    _unit addBackpackGlobal "ACE_ReserveParachute";
    diag_log format ["[RA] Reserve parachute added to: %1", name _unit];
};

// Set parachute cuttable (ACE3 behavior)
_chute setVariable ["ace_parachute_canCut", true, true];

diag_log format ["[RA] Parachute deployed for %1 with class %2", name _unit, _chuteClass];
