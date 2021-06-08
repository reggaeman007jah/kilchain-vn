/*
we want random mortar effects around but not over current obj point  
-get obj point 
-get pos away from that 
-when have pos, then find out if any players are near - if yes, re-try 
*/

// only run this is one of the cycles is running - so call this as part of the cycleRun

_anchor = _this select 0; // takes mission obj

_boom = [
	"ammo_Bomb_SDB",
	"BombCluster_02_Ammo_F",
	"Cluster_155mm_AMOS",
	"ammo_Missile_HARM",
	"R_80mm_HE",
	"Bo_GBU12_LGB"
];

// _boom = [
// 	"Bo_GBU12_LGB"
// ];

_ranDir = random 359;
_ranDist = selectRandom [350,400,450,500];
_splash = _anchor getPos [_ranDist,_ranDir];
_hits = selectRandom [0,0,0,0,1,2,3,4];
// _hits = selectRandom [2,3,4];

if (_hits > 0) then {
	_space = selectRandom [2,3,4,5];
	_ord = selectRandom _boom;
	for "_i" from 1 to _hits do {
		_dir = random 359;
		_dist = selectRandom [1,10,20,50];
		_impact = _splash getPos [_dist,_dir];
		_exp = _ord createVehicle _impact;
		sleep _space; 	
	};
};


// _dataStore = [];
// {
// 	_safeDist = _splash distance_x;
// 	if (_safeDist > 100) then {
// 		_dataStore pushBackUnique _anchor;
// 	};
// } forEach allPlayers;

// _cnt = count _dataStore;
// if (_cnt > 0) then {

// 	_pos = _dataStore select 0;
// 	_ord = selectRandom _boom;
// 	 _prj = _ord createVehicle _pos;

// 	_num = selectRandom [1,2,3,4];
// 	_space = selectRandom [2,3,4,5,6,7,8,20,30];

// 	for "_i" from 1 to _num do {

// 		sleep _space; 	
// 	};
// };



