/*
 * Author: GamingPanthers
 * Executes a static line jump sequence from an aircraft with ACE3 compatibility
 *
 * Arguments:
 * 0: Vehicle <OBJECT> - The aircraft the jumper is exiting
 * 1: Unit <OBJECT> - The jumper
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, player] call RA_fnc_staticJump;
 *
 * Public: No
 */

params [
    ["_vehicle", objNull, [objNull]],
    ["_unit", objNull, [objNull]]
];

// Validate parameters
if (isNull _vehicle || isNull _unit) exitWith {
    diag_log format ["[RA ERROR] Invalid parameters: vehicle=%1, unit=%2", _vehicle, _unit];
};

// ACE3 compatible parachute classnames
private _aceParachutes = [
    "ACE_NonSteerableParachute",
    "ACE_ReserveParachute"
];

// Extended parachute compatibility list
private _validParachutes = _aceParachutes + [
    // Vanilla Arma 3
    "B_Parachute",
    
    // CUP
    "CUP_B_ParachutePack",
    
    // RHS
    "rhsusf_b_parachute",
    
    // 3CB
    "UK3CB_BAF_B_Parachute",
    
    // Vietnam/Unsung
    "vn_b_pack_t10_01",
    "vn_b_pack_ba22_01",
    "vn_b_pack_ba18_01",
    "vn_i_pack_parachute_01",
    "vn_o_pack_parachute_01"
];

// Check for valid parachute
private _backpack = backpack _unit;
private _hasValidParachute = false;

if (_backpack != "") then {
    _hasValidParachute = (_backpack in _validParachutes) || 
                        (_backpack isKindOf "B_Parachute");
};

// Get mission setting for parachute requirement
private _parachuteRequired = missionNamespace getVariable ["RA_StaticEquipped", true];

// Validate parachute requirement
if (_parachuteRequired && !_hasValidParachute) exitWith {
    // Use ACE3 hint system if available
    private _message = localize "STR_RA_NoParachute"; // "You must have a static parachute equipped to jump."
    
    if (hasInterface && _unit == ACE_player) then {
        if (isClass (configFile >> "CfgPatches" >> "ace_common")) then {
            [_message, 2] call ace_common_fnc_displayText;
        } else {
            hint _message;
        };
    };
    
    // Play feedback sound
    if (hasInterface && _unit == ACE_player) then {
        playSound "FD_Start_F";
    };
    
    diag_log format ["[RA] Jump prevented for %1: No valid parachute equipped.", name _unit];
};

// Handle backpack removal for non-required scenarios
if (!_parachuteRequired && !_hasValidParachute && _backpack != "") then {
    // Store backpack contents for potential recovery
    private _backpackItems = backpackItems _unit;
    private _backpackMags = backpackMagazines _unit;
    
    // Store in unit's namespace for potential recovery
    _unit setVariable ["RA_StoredBackpack", [_backpack, _backpackItems, _backpackMags], true];
    
    removeBackpack _unit;
    diag_log format ["[RA] Removed backpack from %1 for static jump", name _unit];
};

// Pre-jump preparations
private _aircraftVelocity = velocity _vehicle;
private _aircraftDirection = direction _vehicle;
private _jumpHeight = getPosATL _vehicle select 2;

// Log jump initiation
diag_log format ["[RA] Static jump initiated: %1 from %2 at %3m", name _unit, typeOf _vehicle, _jumpHeight];

// Execute jump sequence
[_unit, _vehicle, _aircraftVelocity, _aircraftDirection, _hasValidParachute] spawn {
    params ["_unit", "_vehicle", "_vel", "_dir", "_hasChute"];
    
    // Unassign and eject
    unassignVehicle _unit;
    _unit action ["Eject", _vehicle];
    
    // Wait for unit to exit vehicle
    waitUntil { 
        sleep 0.1;
        vehicle _unit == _unit 
    };
    
    // Apply jump physics
    _unit setDir (_dir + 180); // Face away from aircraft
    _unit setVelocity _vel;
    
    // Brief delay for realistic jump sequence
    sleep 0.2;
    
    // Deploy parachute
    if (_hasChute) then {
        _unit action ["OpenParachute", _unit];
        
        // Ensure parachute inherits aircraft velocity
        sleep 0.1;
        if (vehicle _unit != _unit) then {
            (vehicle _unit) setVelocity _vel;
        };
        
        // ACE3 parachute specific handling
        if (backpack _unit in ["ACE_NonSteerableParachute", "ACE_ReserveParachute"]) then {
            // Add ACE3 specific parachute behavior if needed
            _unit setVariable ["ace_parachute_deployed", true, true];
        };
    } else {
        // Fallback parachute creation
        if (isClass (configFile >> "CfgFunctions" >> "RA" >> "fnc_createChute")) then {
            [_unit, _dir] call RA_fnc_createChute;
        } else {
            // Emergency parachute
            _unit addBackpack "B_Parachute";
            _unit action ["OpenParachute", _unit];
        };
    };
    
    // Reset hook and stance states
    if (isClass (configFile >> "CfgFunctions" >> "RA" >> "fnc_hookControl")) then {
        ["unhook", _unit] call RA_fnc_hookControl;
    };
    
    if (isClass (configFile >> "CfgFunctions" >> "RA" >> "fnc_stanceControl")) then {
        ["sit", _unit] call RA_fnc_stanceControl;
    };
    
    // Fire event for other systems
    ["RA_staticJumpCompleted", [_unit, _vehicle]] call CBA_fnc_globalEvent;
    
    diag_log format ["[RA] Static jump completed for %1", name _unit];
};

// Return success
true