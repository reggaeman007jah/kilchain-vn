/*
From: initSServer.sqf 

Purpose: ambient spawner for effect only 

notes:
	B_Plane_CAS_01_dynamicLoadout_F
	[startPos, endPos, altitude, speedMode, classname, side] call BIS_fnc_ambientFlyby;
	always over RGG_patrol_obj
	player getPos [100,45];

	000 / 180 
	180 / 000
	090 / 270
	270 / 090

	get an origin by taking patrol point, then get pos east at 090 100m 
	then get pos west 270 from patrol point 

data:
	"B_Plane_CAS_01_dynamicLoadout_F", 
	"B_Heli_Transport_01_F", 
	"B_Heli_Transport_03_F", 
	"B_Heli_Light_01_dynamicLoadout_F"

Improvement ideas: 
	randomise the from / to direction 
	randomise how many in flight 
	add formations
	experiment with spawn gaps 
	decide on speed 
	decide if mixed or one class (if mixed, what are the other downstream requirements (ie no AH6 + jets))
	store pos at local so it does not crap-out if the obj changes 
	always have ambient flybys go relative to the next patrol obj
*/



_objPos = _this select 0; // starting point for any new mission

if ((flybyIsActive) && (RGG_isDay)) then {
	flybyIsActive = false;
	_height = selectRandom [50, 100, 200, 300, 500, 800]; // random height 
	_sleep = selectRandom [120, 180, 240, 300]; // determines how long between call of script  
	_number = selectRandom [1,2,3]; // determines how many ambients per spawn event 
	_type = selectRandom [
		"vn_b_air_f4c_at",
		"vn_b_air_f4b_usmc_at",
		"vn_b_air_f4b_navy_lrbmb"
	]; // 4 types, each batch is always the same type - you wont get a jet and an MH6 together 
	_startPos = _objPos getPos [5000, 90]; // starts east of the patrol point 
	_endPos = _objPos getPos [5000, 270]; // ends west of the patrol point 

	for "_i" from 1 to _number do {
		[_startPos, _endPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby;
		_slp = selectRandom [3,4,5,10,20];
		sleep _slp; // spacer sleep between each iteration to prevent spawn overlaps 	
	};
	
	sleep 500; // always this 
	sleep _sleep; // random sleep between spawn batches // test if moving this line solves the pos problem 
	flybyIsActive = true;
};



