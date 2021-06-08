
systemChat "insurance move order";
_objPos = _this select 0; // objective point 

_indi = [];

{
	if ((side _x) == INDEPENDENT) then {_indi pushBack _x};
} forEach allUnits;

// consider adding a distance check here, sending to a new array 

{
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_unitDest = [_objPos, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
	sleep 2;
	_x setBehaviour "COMBAT";
	_x doMove _endPoint1;
} forEach _indi;



// [_objPos] execVM "killChain\systems\insuranceSystems\indiforMovement.sqf";


