/*
This function generates a random medevac mission 

To-do:
This is nowhere near finished!!

*/

// gen random pos 
// gen units + injured units 
// gen marker 
systemChat "DEBUG - RUNNING: missions_extractDamagedTank";

_areaCenter = [7000,8000];
_extractPos = [_areaCenter, 10, 3000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

_medevacPos = createMarker ["EXTRACT", _extractPos];
_medevacPos setMarkerShape "ELLIPSE";
_medevacPos setMarkerColor "ColorRed";
_medevacPos setMarkerSize [50, 50];
// _barracksDZ setMarkerAlpha 0.5;

_medevacPos1 = createMarker ["PZ", _extractPos];
_medevacPos1 setMarkerShape "ELLIPSE";
_medevacPos1 setMarkerColor "ColorRed";
_medevacPos1 setMarkerSize [5, 5];

// _indiGroup = createGroup independent;
for "_i" from 1 to 10 do {
	_indiGroup = createGroup independent;
	_unit = _indiGroup createUnit ["I_soldier_F", _extractPos, [], 0.1, "none"]; 
	_randomMovePos = [ ["EXTRACT"] ] call BIS_fnc_randomPos;
	_unit doMove _randomMovePos;
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;
	sleep 2;
};

_tank = "I_LT_01_cannon_F" createVehicle _extractPos;
_tank setDamage 0.5;

sleep 10;

[_extractPos] call RGG_fnc_3_spawn_opforUnits;