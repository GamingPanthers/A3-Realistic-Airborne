/*
    Function: RA_fnc_equipmentCheck
    Description: Checks player equipment and gives feedback.
    Author: GamingPanthers
    Version: 1.0.0
*/

params ["_unit"];
if (isNull _unit) exitWith {};

private _backpack = backpack _unit;
private _hasChute = (_backpack isKindOf "B_Parachute") || 
                   (_backpack in (missionNamespace getVariable ["RA_validParachutes", []]));

private _statusText = if (_hasChute) then {
    "<t color='#00ff00'>READY</t>"
} else {
    "<t color='#ff0000'>NO PARACHUTE</t>"
};

hint parseText format [
    "<t size='1.2' align='center'>Static Line Check</t><br/><br/>" +
    "Unit: %1<br/>" +
    "Status: %2<br/>",
    name _unit,
    _statusText
];

_hasChute