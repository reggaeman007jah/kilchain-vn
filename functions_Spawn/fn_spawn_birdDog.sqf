// this will create a cesna type and have it loiiter over tinman 

// I_C_Plane_Civil_01_F
	
// // get indi player
// _dataStore = [];
// {
// 	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
// } forEach allPlayers;

// _cnt = count _dataStore;
// if (_cnt > 0) then {

// 	// an indifor player is alive 
// 	_player = _dataStore select 0;
// 	_origin = getPos _player;

// 	// spawn cesna somewhere away 
// 	// set waypoint on player pos  
// 	_anchorPos = _origin getPos [400, 0];
// 	_birdDog = [_anchorPos, 180, _class, civilian] call BIS_fnc_spawnVehicle;
// 	_group = _birdDog select 2;

// 	[_group, _anchorPos, 300, "LOITER", "AWARE", "YELLOW", "FULL"] call CBA_fnc_addWaypoint;

// } else {
// 	// no indifor player - use alternative position - maybe group leader of blufor 
// };





// while {NIGHTTIME} do {

// 	// check for Daytime - when day set new pos - then despawn 
// 	// if daytime then NIGHTTIME = false 

// 	sleep 300;
// };


// - new ------------------------------------------------------------------------------------
systemChat "BIRD DOG SPAWNED!!";

_dataStore = [];
{
	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
} forEach allPlayers;

_player = _dataStore select 0;
_origin = getPos _player;

// spawn cesna somewhere away 
// set waypoint on player pos  
_anchorPos = _origin getPos [900, 0];

_origin set [2, 500];

_birdDog = [_anchorPos, 180, "I_C_Plane_Civil_01_F", civilian] call BIS_fnc_spawnVehicle;
_group = _birdDog select 2;

[_group, _origin, 500, "LOITER", "AWARE", "YELLOW", "LIMITED"] call CBA_fnc_addWaypoint;

// waitUntil { RGG_isDay };

while { !RGG_isDay } do {
	systemChat "birdDog check - should be going to player pos";
	_origin = getPos _player;
	_origin set [2, 500];
	[_group, _origin, 500, "LOITER", "AWARE", "YELLOW", "LIMITED"] call CBA_fnc_addWaypoint;
	sleep 30;
};

// send away 
systemChat "is day - sending birddog away";
[_group, [0,0], 500, "LOITER", "AWARE", "YELLOW", "LIMITED"] call CBA_fnc_addWaypoint;





