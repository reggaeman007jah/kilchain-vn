// requires pos  

// _anchor = _this select 0; 
_target = _this select 0;

_boom = [
	"ammo_Bomb_SDB",
	"BombCluster_02_Ammo_F",
	"Cluster_155mm_AMOS",
	"ammo_Missile_HARM",
	"R_80mm_HE"
];

// direction 
_ranDir = random 359;
_splash = _target getPos [300, _ranDir];
_hits = selectRandom [10, 12, 14, 16, 18, 20];
_gap = selectRandom [60, 90, 120];
_ord = selectRandom _boom;

sleep _gap;

for "_i" from 1 to _hits do {
	_space = selectRandom [2,3,4,5];
	_dir = random 359;
	_dist = selectRandom [1,10,20];
	_impact = _splash getPos [_dist,_dir];
	_exp = _ord createVehicle _impact;
	sleep _space; 	
};

sleep _gap;

_splash = _target getPos [200, _ranDir];

for "_i" from 1 to _hits do {
	_space = selectRandom [2,3,4,5];
	_dir = random 359;
	_dist = selectRandom [1,10,20];
	_impact = _splash getPos [_dist,_dir];
	_exp = _ord createVehicle _impact;
	sleep _space; 	
};

sleep _gap;

_splash = _target getPos [100, _ranDir];

for "_i" from 1 to _hits do {
	_space = selectRandom [2,3,4,5];
	_dir = random 359;
	_dist = selectRandom [1,10,20];
	_impact = _splash getPos [_dist,_dir];
	_exp = _ord createVehicle _impact;
	sleep _space; 	
};



// _ranDist = selectRandom [50,100,150,200];
// _splash = _anchor getPos [_ranDist,_ranDir];
// _hits = selectRandom [10, 12, 14, 16, 18, 20];

// _ord = selectRandom _boom;
// for "_i" from 1 to _hits do {
// 	_space = selectRandom [2,3,4,5,6,7,8,9];
// 	_dir = random 359;
// 	_dist = selectRandom [1,10,20];
// 	_impact = _splash getPos [_dist,_dir];
// 	_exp = _ord createVehicle _impact;
// 	sleep _space; 	
// };

// sleep 60;

// // get pos nearer to tinman 
// _target getPos [200, _ranDir];

// for "_i" from 1 to _hits do {
// 	_space = selectRandom [2,3,4,5,6,7,8,9];
// 	_dir = random 359;
// 	_dist = selectRandom [1,10,20];
// 	_impact = _target getPos [_dist,_dir];
// 	_exp = _ord createVehicle _impact;
// 	sleep _space; 	
// };


// sleep 60;

// // get pos nearer to tinman 
// _target getPos [50, _ranDir];

// for "_i" from 1 to _hits do {
// 	_space = selectRandom [2,3,4,5,6,7,8,9];
// 	_dir = random 359;
// 	_dist = selectRandom [1,10,20];
// 	_impact = _target getPos [_dist,_dir];
// 	_exp = _ord createVehicle _impact;
// 	sleep _space; 	
// };


