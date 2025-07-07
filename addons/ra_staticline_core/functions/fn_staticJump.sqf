/*
    Function: RA_fnc_staticJump
    Executes a full static line jump sequence from an aircraft.

    Description:
        Handles logic for ejecting the unit, orienting their fall,
        and determining whether to open the equipped parachute or spawn one manually.
        Also resets the hook/stance status post-jump.

    Params:
        _unit (Object) — The jumper
        _vehicle (Object) — The aircraft the jumper is exiting

    Example:
        [player, vehicle player] call RA_fnc_staticJump;
*/

params ["_unit", "_vehicle"];

private _parachutes = [
    "vn_b_pack_t10_01",
    "vn_b_pack_ba22_01",
    "vn_b_pack_ba18_01",
    "vn_i_pack_parachute_01",
    "vn_o_pack_parachute_01"
];

private _backpack = unitBackpack _unit;
private _staticRequired = missionNamespace getVariable ["RA_StaticEquipped", true];

// Check for valid parachute
if (
    _staticRequired &&
    !((_backpack isKindOf "B_Parachute") || (typeOf _backpack in _parachutes))
) exitWith {
    _unit createDiaryRecord ["Diary", ["Parachute", "You do not have the required static chute equipped"]];
    hint "Static chute required!";
};

// Eject logic
unassignVehicle _unit;
_unit action ["Eject", _vehicle];

private _dir = direction _vehicle;
private _vel = velocity _vehicle;

// Wait until ejected
waitUntil { vehicle _unit == _unit };

// Set orientation and momentum
_unit setDir (_dir - 180);
_unit setVelocity _vel;
sleep 0.1;

// Deploy chute
if (
    !_staticRequired ||
    ((_backpack isKindOf "B_Parachute") || (typeOf _backpack in _parachutes))
) then {
    _unit action ["OpenParachute", _unit];
    (vehicle _unit) setVelocity _vel;
} else {
    [_unit, _dir] call RA_fnc_createChute;
};

// Reset state
["unhook", _unit, _vehicle] call RA_fnc_hookControl;
["sit", _unit] call RA_fnc_stanceControl;
