/*
This will take a random position over the objective, and create a falling flare 
It should only happen at night ideally, but maybe day is fine also 
*/

/*
_obj = "F_40mm_white" createVehicle ((player) ModelToWorld [20,150,100]);
_obj setVelocity [0,0,-5;]
*/

// get random position within area 
// as you already have an area to work in, just use that - "Redzone"
// so every phase cycle, run this script 
// 50% chance no flare - 50% chance flare
// if flare then could be white or red, not both 
// if flare then 1 2 or three 
// [whitelist, blacklist, code] call BIS_fnc_randomPos



// _indi = [];
// {
// 	if ((side _x) == INDEPENDENT) then {_indi pushBack _x};
// } forEach _units;

// systemChat format ["_indi: %1", _indi];

// get indi player
_dataStore = [];
{
	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
} forEach allPlayers;

_commander = _dataStore select 0;
// _commPos = getPos _commander;
// add a count, so if cnt 0, then no flares! 
_cnt = count _dataStore;
if (_cnt == 1) then {
	while { !RGG_isDay } do {

		systemChat "flares ...";
		_flares = [4,5,6]; 
		_isFlares = selectRandom _flares;
		_ranSleep = [2,5,10,20];
		_col = ["F_40mm_white","F_40mm_red"];
		_height = [300, 250, 200, 150];

		for "_i" from 1 to _isFlares do {
			_commPos = getPos _commander;
			_dir = random 359;
			_dist = random 80;
			_type = selectRandom _col;
			_hgt = selectRandom _height;
			_spawnPos = _commPos getPos [_dist,_dir];
			_spawnPos set [2,_hgt];
			_obj = _type createVehicle _spawnPos;
			_obj setVelocity [0,0,-4];
			sleep 2,
		};

		sleep 20; 
		_addSleep = selectRandom _ranSleep;
		sleep _addSleep;
	};

	systemChat "------- is day now - no flares ...";
	
} else {
	systemChat "No Tinman, No Flares";
	// choose random other player 
	// get players on ground  
	// _playersOnGround = [] call RGGg_fnc_get_allPlayersOnGround;
	// _chosen = selectRandom _playersOnGround;
};


// if (_isFlares > 0) then {
// 	_type = selectRandom _col;
// 	// systemChat format ["colour: %1", _type];

// 	for "_i" from 1 to _isFlares do {
// 		systemChat format ["creating flares: %1", _type];
// 		// _pos2d = [["Redzone"]] call BIS_fnc_randomPos;
// 		_hgt = selectRandom _height;
// 		_commPos set [2,_hgt];
// 		_obj = _type createVehicle _commPos;
// 		_obj setVelocity [0,0,-5];
// 		sleep 60; 
// 		_addSleep = selectRandom _ranSleep;
// 		sleep _addSleep;
// 	};
// };