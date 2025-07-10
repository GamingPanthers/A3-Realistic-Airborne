/*
    Function: RA_fnc_staticJump
    Executes a full static line jump sequence from an aircraft.

    Description:
        Prevents jumping if the unit does not have a valid static parachute.
        Handles eject, fall orientation, parachute deployment, and reset of hook/stance state.

    Params:
        _vehicle (Object) — The aircraft the jumper is exiting
        _unit (Object) — The jumper
*/

params ["_vehicle", "_unit"];

// Supported parachute classnames (backpacks or parachute units)
private _validParachutes = [
    // ACE3
    "ACE_NonSteerableParachute",
    "ACE_ReserveParachute",

    // Vanilla
    "B_Parachute",

    // CUP
    "CUP_B_ParachutePack",

    // RHS
    "rhsusf_b_parachute",

    // 3CB
    "UK3CB_BAF_B_Parachute",

    // Unsung / CDLCs / VN
    "vn_b_pack_t10_01","vn_b_pack_ba22_01","vn_b_pack_ba18_01",
    "vn_i_pack_parachute_01","vn_o_pack_parachute_01"
];

private _backpack = unitBackpack _unit;
private _hasParachute = !isNull _backpack && {
    (typeOf _backpack in _validParachutes) || (_backpack isKindOf "B_Parachute")
};

// Prevent jump if missing required chute
if (
    missionNamespace getVariable ["RA_StaticEquipped", true] &&
    !_hasParachute
) exitWith {
    [_unit, "You must have a static parachute equipped to jump."] remoteExec ["hintSilent", _unit];
    playSound "FD_Start_F"; // Feedback sound
    diag_log format ["[RA] Jump prevented for %1: No valid parachute equipped.", name _unit];
};

// Remove backpack if not equipped with parachute and not required
if (
    !missionNamespace getVariable ["RA_StaticEquipped", true] &&
    !_hasParachute &&
    !isNull _backpack
) then {
    // Store backpack contents if needed
    private _backpackItems = backpackItems _unit;
    removeBackpack _unit;
    diag_log format ["[RA] Removed backpack from %1 for static jump", name _unit];
    
    // Could add logic here to drop backpack items or store them
};

// Eject and deploy logic
unassignVehicle _unit;
_unit action ["Eject", _vehicle];

private _dir = direction _vehicle;
private _vel = velocity _vehicle;
waitUntil { vehicle _unit == _unit };

_unit setDir (_dir - 180);
_unit setVelocity _vel;
sleep 0.1;

if (_hasParachute) then {
    _unit action ["OpenParachute", _unit];
    // Ensure parachute gets aircraft velocity
    sleep 0.1;
    if (vehicle _unit != _unit) then {
        (vehicle _unit) setVelocity _vel;
    };
} else {
    [_unit, _dir] call RA_fnc_createChute;
};

// Reset hook + stance
["unhook", _unit] call RA_fnc_hookControl;
["sit", _unit] call RA_fnc_stanceControl;

diag_log format ["[RA] Static jump completed for %1", name _unit];