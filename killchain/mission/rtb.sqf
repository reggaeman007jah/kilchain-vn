// get all remaining troops home safely 
// should have set places in FOB for groups to move to on ending 

// get all units and move them to Pathfinder
// mission ends when all live units are in base area 

// on return, you should get stats, as voice alerts 
// number of reinformcents called in 
// number of troops generated 
// number of enemy killed 
// number of heli crashes 
// etc 

hint "to do - get remaining troops RTB";

_initStartPos = getPos ammo1;
_indi = [];
_units = allUnits inAreaArray "objective 1";

{ if ((side _x) == INDEPENDENT) then {_indi pushBack _x} } forEach _units;

{
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];
	sleep 2;
	_x setBehaviour "AWARE";
	_x doMove _endPoint1;
} forEach _indi;
