// this is used explusively by sideWinder Ops 

while {DISRUPTEVADE} do {

	_allUnits = allUnits inAreaArray "sideWinder";

	_opfor = [];
	_blufor = [];

	{if ((side _x) == east) then {_opfor pushBack _x}} forEach _allUnits;
	{if ((side _x) == independent) then {_blufor pushBack _x}} forEach _allUnits;

	// _randomMovePos = [["sideWinder"]] call BIS_fnc_randomPos;
	
	{
		_randomMovePos = [["sideWinder"]] call BIS_fnc_randomPos;
		_x doMove _randomMovePos;
		sleep 0.1;		
	} forEach _opfor;

	{
		_randomMovePos = [["sideWinder"]] call BIS_fnc_randomPos;
		_x doMove _randomMovePos;
		sleep 0.1;		
	} forEach _blufor;

	{ deleteVehicle _x } forEach allDead;
	
	sleep 60;
};