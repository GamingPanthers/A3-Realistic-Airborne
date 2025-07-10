/*
    Function: RA_fnc_staticJump
    Executes a full static line jump sequence from an aircraft.

    Description:
        Handles logic for ejecting the unit, orienting their fall,
        and determining whether to open the equipped parachute or spawn one manually.
        Also resets the hook/stance status post-jump.

    Params:
        _vehicle (Object) — The aircraft the jumper is exiting
        _unit (Object) — The jumper

    Example:
        [_vehicle, player] execVM "\ra_staticline_core\functions\fn_staticJump.sqf";
*/

params ["_vehicle", "_unit"];

// Fetch whitelist from config
private _parachutes = getArray (configFile >> "CfgRA" >> "StaticLine" >> "ParachuteWhitelist" >> "RA_validParachutes");
private _backpack = unitBackpack _unit;

if (
    !missionNamespace getVariable ["RA_StaticEquipped", true] &&
    !((_backpack isKindOf "B_Parachute") || (typeOf _backpack in _parachutes)) &&
    !(isNull _backpack)
) then {
    [_unit] call bocr_main_fnc_actionOnChest;
};

unassignVehicle _unit;
_unit action ["Eject", _vehicle];

private _dir = direction _vehicle;
private _vel = velocity _vehicle;

waitUntil { vehicle _unit == _unit };

_unit setDir (_dir - 180);
_unit setVelocity _vel;

sleep 0.1;

if (
    missionNamespace getVariable ["RA_StaticEquipped", true] ||
    ((_backpack isKindOf "B_Parachute") || (typeOf _backpack in _parachutes))
) then {
    _unit action ["OpenParachute", _unit];
    (vehicle _unit) setVelocity _vel;
} else {
    [_unit, _dir] call RA_fnc_createChute;
};

["unhook", _unit, _vehicle] call RA_fnc_hookControl;
["sit", _unit] call RA_fnc_stanceControl;
