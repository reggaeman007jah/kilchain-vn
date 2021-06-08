// this manages the spawning of indiFor troops for pickup on long range patrols 

/*
there is a lot of wet code here - consider making functions to issue move orders  
by parsing a location in here i can easily gen blufor platoons from anywhere, but for now they are only spawning at the perma-base 
maybe in future I can create FOBs which become remote spawn points 
it would be good to enable logic so that the AI manages whether to build a spawnerFob 

note - it would be nice to one day have a system that allows a single flag to be changed, to indicate the faction required 
then all classes are managed automatically - e.g. in the below spawners you would not quote classnames, rather, local variables

note - I am going to try to split this event into four groups 
Then, i can try to create some sort of structured attack and defence with these groups 
Then, if I can include the spawn iteration in this somewhere, I can use one script to create 1 2 3 or 4 batches 
I would also like to make the tent a command base, with radio dudes and officers, who are not part of the auto moves 
injured units would also wait here for healing

Each spawned team has:
1 rifleman
1 machine gunner 
1 grenadier 
1 medic 
1 marksman
*/

/*
vn_i_men_ranger_09
vn_i_men_ranger_07
vn_i_men_ranger_10
vn_i_men_ranger_14
vn_i_men_ranger_15
vn_i_men_ranger_12


*/

_classes = [
	"vn_i_men_army_01",
	"vn_i_men_army_02",
	"vn_i_men_army_03",
	"vn_i_men_army_04",
	"vn_i_men_army_05",
	"vn_i_men_army_06",
	"vn_i_men_army_07",
	"vn_i_men_army_08",
	"vn_i_men_army_09",
	"vn_i_men_army_10",
	"vn_i_men_army_11",
	"vn_i_men_army_12"
];

while {true} do {

	_indi = independent countSide allUnits;

	if (_indi < 23) then {
		_units = allUnits inAreaArray "pz2";
		_spawn = [18626.7,8381.79,0.155949];
		_unitCount1 = count _units;

		if (_unitCount1 == 0) then {
			_float = diag_tickTime;
			_stampToString = str _float;
			_stampToString = createGroup [independent, true];
			for "_i" from 1 to 4 do {
				_class = selectRandom _classes; 
				_class createUnit [_spawn, _stampToString]; 
				sleep 0.2;
			};

			_stampToString move [18602.7,8365.33];
			_stampToString setFormation "DIAMOND";
			
			systemChat "ARVN recon squaddies ready .............................................!";
		};	
	};

	sleep 20;
};






















// _numberOfCycles = _this select 1; // number of times we run this // 4 = 4 fire teams  
_numberOfCycles = 2; // placeholder var  
_area = 60; // distribution of units on spawn  // I am making this much smaller 
_timer = 0.3; // spawn cycle gap  

for "_i" from 1 to _numberOfCycles do {
	_indiGroup = createGroup [independent, true];
	// _pos = [_spawnPos, 2, _area] call BIS_fnc_findSafePos;
	_pos = _spawnPos;
	// _pos1 = _pos getPos [1,180];
	// _pos2 = _pos getPos [2,180];
	// _pos3 = _pos getPos [3,180];
	// _pos4 = _pos getPos [4,180];
	// _pos5 = _pos getPos [5,180];
	// the above might be used for better staging before move orders 
	_fireTeam = [];
	_unit1 = _indiGroup createUnit ["vn_i_men_ranger_09", _pos, [], 0.1, "none"]; 
	_unit2 = _indiGroup createUnit ["vn_i_men_ranger_07", _pos, [], 0.1, "none"]; 
	_unit3 = _indiGroup createUnit ["vn_i_men_ranger_10", _pos, [], 0.1, "none"]; 
	_unit4 = _indiGroup createUnit ["vn_i_men_ranger_14", _pos, [], 0.1, "none"]; 
	_unit5 = _indiGroup createUnit ["vn_i_men_ranger_15", _pos, [], 0.1, "none"]; 
	_unit6 = _indiGroup createUnit ["vn_i_men_ranger_12", _pos, [], 0.1, "none"]; 
	_unit7 = _indiGroup createUnit ["vn_i_men_ranger_15", _pos, [], 0.1, "none"]; 
	_unit8 = _indiGroup createUnit ["vn_i_men_ranger_12", _pos, [], 0.1, "none"]; 
	_unit9 = _indiGroup createUnit ["vn_i_men_ranger_15", _pos, [], 0.1, "none"]; 
	_unit10 = _indiGroup createUnit ["vn_i_men_ranger_12", _pos, [], 0.1, "none"]; 

	_fireTeam pushBack _unit1;
	_fireTeam pushBack _unit2;
	_fireTeam pushBack _unit3;
	_fireTeam pushBack _unit4;
	_fireTeam pushBack _unit5;
	_fireTeam pushBack _unit6;
	_fireTeam pushBack _unit7;
	_fireTeam pushBack _unit8;
	_fireTeam pushBack _unit9;
	_fireTeam pushBack _unit10;

	sleep _timer;
	
	// move orders 
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	// _unitDest = [_destPos, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _destPos getPos [_randomDist,_randomDir];
	_fireTeam doMove _endPoint1;
	
	// spawnedIndiUnit = spawnedIndiUnit +5;
};

/*
// rifleman
for "_i" from 1 to 6 do {
	// bluGroup = createGroup west;
	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
	_unit = _indiGroup createUnit ["I_soldier_F", _pos, [], 0.1, "none"]; 
	sleep _timer;

	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint1;
	spawnedIndiUnit = spawnedIndiUnit +1;
};

// HMG
for "_i" from 1 to 4 do {
	// bluGroup = createGroup west;
	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
	// _unit = bluGroup createUnit ["UK3CB_BAF_MGGPMG_MTP", _pos, [], 0.1, "none"]; 
	_unit = _indiGroup createUnit ["I_support_MG_F", _pos, [], 0.1, "none"]; 
	sleep _timer;
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint1;
	spawnedIndiUnit = spawnedIndiUnit +1;

};

// for "_i" from 1 to 2 do {
// 	bluGroup = createGroup west;
// 	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
// 	_unit = bluGroup createUnit ["UK3CB_BAF_LSW_MTP", _pos, [], 0.1, "none"]; 

// 	sleep _timer;
	
// 	_randomDir = selectRandom [270, 310, 00, 50, 90];
// 	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
// 	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];

// 	_unit setBehaviour "COMBAT";
// 	_unit doMove _endPoint1;
// };

// grenadier
for "_i" from 1 to 4 do {
	// bluGroup = createGroup west;
	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
	// find the old classname for 3cb 
	_unit = _indiGroup createUnit ["I_Soldier_GL_F", _pos, [], 0.1, "none"]; 
	sleep _timer;
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint1;
	spawnedIndiUnit = spawnedIndiUnit +1;

};

// marksman
for "_i" from 1 to 2 do {
	// bluGroup = createGroup west;
	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
	// _unit = bluGroup createUnit ["UK3CB_BAF_Marksman_MTP", _pos, [], 0.1, "none"]; 
	_unit = _indiGroup createUnit ["I_Soldier_M_F", _pos, [], 0.1, "none"]; 
	sleep _timer;
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint1;
	spawnedIndiUnit = spawnedIndiUnit +1;

};

// medic
for "_i" from 1 to 2 do {
	// bluGroup = createGroup west;
	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
	// find 3cb medic class
	_unit = _indiGroup createUnit ["I_medic_F", _pos, [], 0.1, "none"]; 
	sleep _timer;
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint1;
	spawnedIndiUnit = spawnedIndiUnit +1;

};

// for "_i" from 1 to 2 do {
// 	bluGroup = createGroup west;
// 	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
// 	_unit = bluGroup createUnit ["UK3CB_BAF_Sharpshooter_MTP", _pos, [], 0.1, "none"]; 

// 	sleep _timer;
	
// 	_randomDir = selectRandom [270, 310, 00, 50, 90];
// 	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
// 	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];

// 	_unit setBehaviour "COMBAT";
// 	_unit doMove _endPoint1;
// };

// for "_i" from 1 to 1 do {
// 	bluGroup = createGroup west;
// 	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
// 	_unit = bluGroup createUnit ["UK3CB_BAF_Engineer_MTP", _pos, [], 0.1, "none"]; 

// 	sleep _timer;
	
// 	_randomDir = selectRandom [270, 310, 00, 50, 90];
// 	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
// 	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];

// 	_unit setBehaviour "COMBAT";
// 	_unit doMove _endPoint1;
// };

// for "_i" from 1 to 1 do {
// 	bluGroup = createGroup west;
// 	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
// 	_unit = bluGroup createUnit ["UK3CB_BAF_Explosive_MTP", _pos, [], 0.1, "none"]; 

// 	sleep _timer;
	
// 	_randomDir = selectRandom [270, 310, 00, 50, 90];
// 	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
// 	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];

// 	_unit setBehaviour "COMBAT";
// 	_unit doMove _endPoint1;
// };

// officer
for "_i" from 1 to 1 do {
	// bluGroup = createGroup west;
	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
	// _unit = bluGroup createUnit ["UK3CB_BAF_Officer_MTP", _pos, [], 0.1, "none"]; 
	_unit = _indiGroup createUnit ["I_officer_F", _pos, [], 0.1, "none"]; 
	sleep _timer;
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint1;
	spawnedIndiUnit = spawnedIndiUnit +1;

};

// TL
for "_i" from 1 to 1 do {
	// bluGroup = createGroup west;
	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
	// _unit = bluGroup createUnit ["UK3CB_BAF_RO_MTP", _pos, [], 0.1, "none"]; 
	_unit = _indiGroup createUnit ["I_Soldier_TL_F", _pos, [], 0.1, "none"]; 
	sleep _timer;
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint1;
	spawnedIndiUnit = spawnedIndiUnit +1;

};

// systemChat "indi spawner complete";

// execVM "autoPatrolSystem\checkBluforRF.sqf";


