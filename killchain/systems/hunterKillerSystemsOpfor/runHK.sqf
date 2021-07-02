/*

This system will gen specops to constantly harass players 
they will spawn in near a player, and come directly for that player 
one player at a time 

.....

select player on the ground 

select position to spawn in specops - where no players are near 

send specops to player on a cycle 

disable fire until firedUpon 

get them close before opening up 

.....

Notes:
I removed stealth behaviour to keep things fast 

To-do:
Check dist between HK team and target player - if over x, and if no players nearby, then delete squad and re-run 
Check if target is dead, and if so, re-route HK to another target 



Runs HK system for a fire team dropped into the AO 

Takes name of hunting group the only param 
*/

// _hunterGroup = _this select 0;
// systemChat format ["running runHK, received: %1", _hunterGroup];

// // confirm position of hunter leader 
// _groupLeader = leader _hunterGroup;
// _hunterPos = getPos _groupLeader;


// find nearest enemy to populate the function 
// get group name of that nearest enemy 

// _hunted = objnull;
// _distance = 1000000;
// _hostiles = allUnits select {side _x == east};
// {
//  if (_hunter distance _x < _distance) then {
//   _hunted =_x;
//   _distance = _hunter distance _x;
// };
// } forEach _hostiles;
// _hunted;

// _opforCount1 = 0;
// _blueforCount1 = 0;
// _units = allUnits inAreaArray "Objective 1";
// _unitCount1 = count _units;
// {
// 	switch ((side _x)) do
// 	{
// 		case EAST: {_opforCount1 = _opforCount1 + 1};
// 		case WEST: {_blueforCount1 = _blueforCount1 + 1};
// 	};
// } forEach allGroups;


// TEST_opforGroups = []; // empty array to store opfor group IDs / names 
// TEST_groups = allGroups; // gets all known game groups 
// _numberOfGroups = count TEST_groups; // counts all known game groups 
// systemChat format ["there are %1 groups in the game", _numberOfGroups]; // info 

// // now extract only opfor groups and put into storage array 
// {
// 	switch ((side _x)) do
// 	{
// 		case EAST: {TEST_opforGroups pushBack _x};
// 		case WEST: {};
// 	};
// } forEach TEST_groups;
// systemChat format ["opfor groups in redzone: %1", TEST_opforGroups]; // debug lists all opfor groups 

// RGG_distanceStore = []; // storage to manage distance data 


// process each opfor group 
// {
// 	_leader = leader _x; // get group leader 
// 	_leaderPos = getPos _leader; 
// 	_dist = _leaderPos distance _hunterPos; // get distance between hunter and hunted 
// 	systemChat format ["opfor group distance: %1", _dist]; // debug info 
// 	RGG_distanceStore pushBack _dist;
// } forEach TEST_opforGroups;
// debug text 
// systemChat format ["RGG_distanceStore: %1", RGG_distanceStore]; // debug lists all opfor groups 
// // debug sleep 
// sleep 4;

// now to try to only keep the closest one 
// _cnt = count RGG_distanceStore;

// _min = selectMin RGG_distanceStore; // this gives us the minimum value, but not the array position 
// systemChat format ["_min = selectMin RGG_distanceStore: %1", _min]; // debug lists all opfor groups 
// // debug sleep 
// // sleep 4;

// {
// 	systemChat "cycle";
// 	_leader = leader _x; // get group leader 
// 	_leaderPos = getPos _leader; 
// 	_dist = _leaderPos distance _hunterPos; // get distance between hunter and hunted 
// 	if (_dist == _min) then {
// 		systemChat format ["winning group and distance is: %1 %2", _x, _dist]; // debug lists all opfor groups 
// 		_stalking = [_hunterGroup, _x] spawn BIS_fnc_stalk;
// 		systemChat format ["stalking group: %1 %2 away", _x, _dist]; // debug lists all opfor groups 
// 		RGG_distanceStore = [];
// 		TEST_opforGroups = [];
// 	};
// } forEach TEST_opforGroups;



// {
// 	if (_x == _min) then {
// 		_closest = RGG_distanceStore select _min;
// 		systemChat format ["opfor group smallest distance: %1", _closest];
// 	} else {
		
// 	};
// } forEach RGG_distanceStore;


// _closest = RGG_distanceStore select _min;
// systemChat format ["opfor group smallest distance: %1", _closest];


// _hunter = player;
// _hostiles = allUnits select {side _x == east};
// _nearestEnemy = [_hostiles , [_hunter], { _input0 distance _x }, "ASCEND", { canMove _x }] call BIS_fnc_sortBy;
// _huntedGroup = group (_nearestEnemy select 0);
// _huntedGroup

// sleep 2;
// _stalked = TEST_opforGroups select _min;
// _stalking = [_hunterGroup, _stalked] spawn BIS_fnc_stalk;

// // _arr sort true;

// // select lowest dist 
// _nearestEnemyDist = selectMin 

// _min = selectMin [1,2,3,4,5]; //1

_delay = _this select 0; // how long before triggering script - nice to not trigger immediately for main mission for example ... 

sleep _delay;

_specOps = [
	"vn_o_men_vc_01",
	"vn_o_men_vc_06",
	"vn_o_men_vc_10",
	"vn_o_men_vc_12",
	"vn_o_men_vc_13"
];

SPECOPSATTACKS = true;

while {SPECOPSATTACKS} do {

	// select player on the ground 
	// get all players 
	_dataStore = [];
	{
		_playerPos = getPos _x;

		if ((_playerPos select 2) < 2) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;

	_dataStore2 = [];
	{
		_dist = ammo1 distance _x;
		_dist2 = ammoTruck1 distance _x;
		if (_dist > 300) then {
			_dataStore2 pushback _x;
		};
		if (_dist2 > 300) then {
			_dataStore2 pushback _x;
		};

	} forEach _dataStore;

	_cnt = count _dataStore2;

	if (_cnt > 0) then {

		// choose a player at random 
		_ranTarget = selectRandom _dataStore2;
		systemChat format ["specops dataStore for player targets: %1", _ranTarget];

		sleep 10;

		// select position to spawn in specops - where no players are near 
		_targetPos = getPos _ranTarget;
		_spawnPos = [_targetPos, 400, 400, 10, 0, 1, 0, 400] call RGGf_fnc_find_locationNoPlayers;

		_opGroup = createGroup [east, true];
		{
			_dist = random 5;
			_dir = random 359;
			_pos = _spawnPos getPos [_dist, _dir];
			_unit = _opGroup createUnit [_x, _pos, [], 0.1, "none"]; 
			_unit setCombatMode "GREEN";
			tinmanModule addCuratorEditableObjects [[_unit], true];
			bluforZeus addCuratorEditableObjects [[_unit], true];
			sleep 0.2;
		} forEach _specOps;
		
		// _cnt = count _opGroup;

		_hunt = true;
		while {_hunt} do {
			_target = getPos _ranTarget;
			_opGroup move _target;

			// debug markers 
			_leader = leader _opGroup;
			_leaderPos = getPos _leader;
			_stampToString = str _opGroup;
			// deleteMarker _stampToString;
			// _tempMarker = createMarker [_stampToString, _leaderPos];
			// _tempMarker setMarkerType "o_inf";

			// the below line shows HK markers - comment in for debug or to help players see invcoming, comment out to create more terror
			// [_leaderPos, "o_inf", _stampToString, 20] spawn RGGe_fnc_effects_fadeMarkers;

			// _pos = _this select 0; // position  
			// _type = _this select 1; // marker className 
			// _name = _this select 2; // unique marker name 
			// _duration = _this select 3; // time to live before fading  



			// systemChat "OPFOR KILLERS MOVING";
			if (count (units _opGroup) < 1) then { 
				_hunt = false;
				systemChat "re-running opfor HK"; 
				sleep 120;
			};
			// - need to check if player was killed too, so they can move to next target 
			// - need to check if distance is too far away, to remove and reset team 
			// _cnt = count _opGroup;
			// if (_cnt ==0) then {
			// 	_hunt = false;
			// };
			sleep 30;
		};

	};

	// send specops to player on a cycle 

	// disable fire until firedUpon 

	// get them close before opening up 

	// .....
	sleep 30;
};









// // -----------------------------------------------------------------------------------------
// systemChat "Loading HK System v2...";
// _hunterGroup = _this select 0; // the group of the hunter team passed in 
// systemChat format ["running runHK, received: %1", _hunterGroup];
// // confirm position of hunter leader 
// _groupLeader = leader _hunterGroup;
// _hunterPos = getPos _groupLeader;
// // -----------------------------------------------------------------------------------------

// _allGroups = allGroups; // get all game groups 
// _stalking = []; // this holds data related to stalking 
// systemChat format ["all game groups: %1", _allGroups]; // debug lists all opfor groups 
// _opforGroups = []; // to hold all opfor groups 
// // _hunters = []; // to hold single hunter group 
// _targetGroup = []; // will hold closest (target) group 

// // collate all opfor groups
// {
// 	switch ((side _x)) do {
// 		case EAST: {
// 			_unitCount = count units _x;
// 			if (_unitCount > 0) then {
// 				_opforGroups pushBack _x;
// 				systemChat format ["SWITCH OPFOR: %1", _x];
// 				systemChat format ["Groupsize: %1", _unitCount];
// 			} else {
// 				deleteGroup _x;
// 			};
// 		};
// 	};
// } forEach _allGroups;

// // simple debug message 
// systemChat format ["opfor groups: %1", _opforGroups]; // debug lists all opfor groups 
// systemChat ".....";
// systemChat format ["hunter group: %1", _hunterGroup]; // debug lists hunter group 

// // -----------------------------------------------------------------------------------------

// // get hunter group and leader - do once 
// // _hunter = _hunterGroup select 0; 
// _hunterLeader = leader _hunterGroup; 
// _hunterLeaderPos = getPos _hunterLeader;

// // -----------------------------------------------------------------------------------------

// // now find nearest group 
// _enemyGroupDistances = [3000]; // limiter distance value 
// _cnt = count _opforGroups;
// _cycle = 1;
// // systemChat format ["There are %1 opfor groups", _cnt]; // debug info 

// // catch situation where no enemy - TBD
// // if (_cnt == 0) exitwith {}; 
// if (_cnt == 0) then {
// 	// wait and re-try
// 	sleep 120;
// 	systemChat "re-trying HK MRAP Check";
// 	[_hunterGroup] execVM "killchain\systems\hunterKillerSystems\runHK.sqf";
// } else {
// 	// process all known opfor groups to grab the one nearest to hunter group
// 	{
// 		_leader = leader _x; // get group leader 
// 		_leaderPos = getPos _leader; // get pos of leader 
// 		_dist = _leaderPos distance _hunterLeaderPos; // get distance between hunter and hunted 
// 		systemChat format ["Iteration %1", _cycle]; // debug info - iteraration
// 		systemChat format ["opfor group %1 distance: %2", _x, _dist]; // debug info 
// 		_enemyGroupDistances pushBack _dist;
// 		_cnt = count _enemyGroupDistances;
// 		systemChat format ["_enemyGroupDistances array count is: %1", _cnt]; // debug info 
// 		// -----------------------
// 		_pos0 = _enemyGroupDistances select 0;
// 		_pos1 = _enemyGroupDistances select 1;
// 		systemChat format ["_pos0: %1", _pos0]; // debug info 
// 		systemChat format ["_pos1: %1", _pos1]; // debug info 
// 		// -----------------------
// 		if (_pos1 < _pos0) then {
// 			_enemyGroupDistances deleteAt 0;
// 			_targetGroup deleteAt 0;
// 			_targetGroup pushBack _x;
// 			systemChat format ["_pos1 %1 is less than _pos0 %2", _pos1, _pos0]; // debug info 
// 		} else {
// 			systemChat format ["_pos1 %1 is greater than or equal to _pos0 %2", _pos1, _pos0]; // debug info 
// 			systemChat "too far away";
// 			_enemyGroupDistances deleteAt 1;
// 		};
// 		// sleep 3;
// 		systemChat format ["_targetGroup is currently %1", _targetGroup]; // debug info
// 		systemChat "cycling";
// 		_cycle = _cycle + 1;
// 		sleep 0.2;
// 	} forEach _opforGroups;

// 	// -----------------------------------------------------------------------------------------

// 	// get markers for targets - DEBUG ONLY
// 	// {
// 	// 	_leader = leader _x; // get group leader 
// 	// 	_leaderPos = getPos _leader; // get pos of leader 
// 	// 	_name = str _x;
// 	// 	deleteMarker _name;
// 	// 	_marker = createMarker [_name, _leaderPos];
// 	// 	_name setMarkerShape "rectangle";
// 	// 	_name setMarkerSize [5,5];
// 	// 	_name setMarkerColor "colorred";
// 	// 	_name setMarkerText _name;
// 	// } forEach _opforGroups;

// 	systemChat format ["target group is %1, and is %2 m away", _targetGroup, _enemyGroupDistances]; // debug info 
// 	systemChat format ["hunter group is %1", _hunterGroup]; // debug info 

// 	// -----------------------------------------------------------------------------------------
// 	_target = _targetGroup select 0;
// 	_targetDist = _enemyGroupDistances select 0;
// 	_unitCount = count units _target;
// 	_leader = leader _target; // get group leader 
// 	_leaderPos = getPos _leader; // get pos of leader 

// 	_hkUnitCount = count units _hunterGroup;

// 	if (_unitCount >= 1) then {
// 		systemChat format ["calling HK order on group %1, %2 away, size: %3", _target, _targetDist, _unitCount]; // debug info 
// 		_hunterGroup move _leaderPos;
// 	} else {
// 		systemChat "error - found empty group - deleting empty group - retrying";
// 		deleteGroup _target;
// 		sleep 10;
// 		if (_hkUnitCount > 0) then {
// 			[_hunterGroup] execVM "killchain\systems\hunterKillerSystems\runHK.sqf"; // re-run 
// 			systemChat "IMPORTANT - RERUN OF HK SYSTEM - DOES THIS WORK?";
// 		};
// 	};

// 	_HKACTIVE = true;

// 	while {_HKACTIVE} do {
// 		systemChat "running _HKACTIVE";
// 		_target = _targetGroup select 0;
// 		_targetDist = _enemyGroupDistances select 0;
// 		_unitCount = count units _target;
// 		_leader = leader _target; // get group leader 
// 		_leaderPos = getPos _leader; // get pos of leader 

// 		systemChat format ["TARGET COUNT: %1", _unitCount]; // debug info 

// 		if (_unitCount == 0) then {
// 			// deleteGroup _target; // this should be done anyway 
// 			hint "SUCCCESS ALL TANGOS DOWN";
// 			_HKACTIVE = false;
// 			// [] execVM "hkSystemv2\runHK.sqf";
// 			systemChat "re-running HK systems";
// 			[_hunterGroup] execVM "killChain\systems\hunterKillerSystems\runHK.sqf";
// 			systemChat "IMPORTANT 2 - RERUN OF HK SYSTEM - DOES THIS WORK?";
// 		} else {
// 			_hunterGroup move _leaderPos;
// 			systemChat format ["STILL HUNTING: %1", _target]; // debug info 
// 			systemChat format ["TARGET COUNT: %1", _unitCount]; // debug info 
// 		};

// 		// if (_hkUnitCount == 0) then {
// 		// 	_HKACTIVE = false;
// 		// 	systemChat "HK Team is DEAD";
// 		// };
// 		if (isNull _hunterGroup) then {
// 			_HKACTIVE = false;
// 			systemChat "HK Team is DEAD";
// 			hint "HK Team is DEAD";
// 		};
// 		// should kill loop if HK team are dead 

// 		sleep 30;
// 		systemChat format ["HKACTIVE CHECK - Group: %1", _hunterGroup];
// 	};

// };





