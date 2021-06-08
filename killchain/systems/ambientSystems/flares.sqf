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

_col = ["F_40mm_white","F_40mm_red"];
_flares = [1,2,3,4,5,6]; 

_height = [200,150,120];
_isFlares = selectRandom _flares;
_ranSleep = [2,5,10,20,30,60];

if (_isFlares > 0) then {
	_type = selectRandom _col;
	systemChat format ["colour: %1", _type];

	for "_i" from 1 to _isFlares do {
		systemChat format ["creating flares: %1", _type];
		_pos2d = [["Redzone"]] call BIS_fnc_randomPos;
		_hgt = selectRandom _height;
		_pos2d set [2,_hgt];
		_obj = _type createVehicle _pos2d;
		_obj setVelocity [0,0,-5];
		sleep 60; 
		_addSleep = selectRandom _ranSleep;
		sleep _addSleep;
	};
};

