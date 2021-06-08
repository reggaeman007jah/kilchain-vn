// now using as new map can freeze movcement 
systemChat "insurance move order";
_objPos = _this select 0; // objective point 

_opfor = [];

{
	if ((side _x) == east) then {_opfor pushBack _x};
} forEach allUnits;

{
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_endPoint1 = _objPos getPos [_randomDist,_randomDir];
	sleep 2;
	_x setBehaviour "COMBAT";
	_x doMove _endPoint1;
} forEach _opfor;