/*
This function will search for nearby units of a given faction, and return true or false 
Params: pos, radius and faction 
note, faction must be: WEST, EAST, INDI or CIVI 
*/

_pos = _this select 0;
_rad = _this select 1;
_faction = _this select 2;

// debug 
systemChat format ["DEBUG - _pos: %1", _pos];
systemChat format ["DEBUG - _rad: %1", _rad];
systemChat format ["DEBUG - _faction: %1", _faction];

// create marker from pos and radius 
// find all units in areaArray 
// count relevant faction given in params 
// return true or false if any found 

_objective1 = createMarker ["checkForUnits", _pos];
_objective1 setMarkerShape "ELLIPSE";
_objective1 setMarkerSize [_rad, _rad];

// debug 
_objective1 setMarkerAlpha 0.5;

// get all units in area 
_unitsInZone = allUnits inAreaArray "checkForUnits";

// debug 
_cnt = count _unitsInZone;
systemChat format ["DEBUG - _cnt = count _unitsInZone: %1", _cnt];


// count faction elements 
// private _east = "_east";
// private _west = "_west";
// private _indi = "_indi";
// private _civi = "_civi";
private ["_east","_west","_indi","_civi"];
_east = 0;
_west = 0;
_indi = 0;
_civi = 0;

switch (_faction) do {
	case "EAST": { 
		{
			switch ((side _x)) do
			{
				case EAST: {_east = _east + 1};
			};
		} forEach _unitsInZone;
	};
	case "WEST": { 
		{
			switch ((side _x)) do
			{
				case WEST: {_west = _west + 1};
			};
		} forEach _unitsInZone;
	};
	case "INDI": { 
		{
			switch ((side _x)) do
			{
				case INDEPENDENT: {_indi = _indi + 1};
			};
		} forEach _unitsInZone;
	};
	case "CIVI": { 
		{
			switch ((side _x)) do
			{
				case CIVILIAN: {_civi = _civi + 1};
			};
		} forEach _unitsInZone;
	};
	default { };
};

// then work out if the faction chosen is true or false 
// default result is always false 
private _unitsNear = "_unitsNear";
_unitsNear = false;

// debug 
systemChat format ["DEBUG - ss before second switch, _unitsNear is: %1", _unitsNear];
systemChat format ["DEBUG - ss found %1 EAST units nearby", _east];

switch (_faction) do {
	case "EAST": { 
		if (_east > 0) then {
			_unitsNear = true;
			// debug 
			systemChat format ["DEBUG - found %1 EAST units nearby", _east];
		};
	};
	case "WEST": { 
		if (_west > 0) then {
			_unitsNear = true;
		};
	};
	case "INDI": { 
		if (_indi > 0) then {
			_unitsNear = true;
		};
	};
	case "CIVI": { 
		if (_civi > 0) then {
			_unitsNear = true;
		};
	};
	default { };
};

// close 
deleteMarker "checkForUnits"; 

// debug 
systemChat format ["DEBUG - returning findNearbyUnits of %1 Faction: %2", _faction, _unitsNear];

// return 
_unitsNear