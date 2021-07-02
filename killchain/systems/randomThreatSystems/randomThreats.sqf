/*
From: initServer.sqf 

this will not run always, rather be triggered during one or both of the stage loops 
it takes next available point as anchor point 
does not run during endGame 

The _anchor is the next patrol point .. to avoid a boring train of incoming from roughly the same dir, we need 
to spead out other anchors from the base anchor, far enough away while not spawning under players (hopefully)
To do this, we want a t-shape .. so get heading from _anchor to defend-point  
Then work out 90 and 270 relative to the defend-point  
Then get two more anchors ... this is the idea, to be done anotehr time 
For now, just pick a random dir and dist from _anchor .. good enough for now 

spawn random groups of 3 or 4, on outer reaches of battlezone, and send them in 
*/

/*
15 June 2021 
To-do: ensure that these only get spawned if the overall opfor cap has not been reached - set CAP !!
*/

// testing change - made this happen from point 0 
if (patrolPointsTaken >= 0 ) then {
	// this will avoid base spawwning on mission start 
	// systemChat "debug - delete when tested - roamers activated";
	_anchor = _this select 0;
	_target = _this select 1; // currently do not use this 

	// get pos in battlezone outer edges 
	_randomEnemySpawnPos = [_anchor, 500, 600, 3, 0, 0, 0] call BIS_fnc_findSafePos; 

	// voice alerts 
	// [_randomEnemySpawnPos] execVM "killchain\systems\alertSystems\roamerAlerts.sqf";
	// 05 march 2021 - removing the above alert for now 
	// systemChat format ["enemy roamers spawned: %1", _randomEnemySpawnPos]; 


	// "CUP_O_TK_INS_Soldier_TL",
	// "CUP_O_TK_INS_Soldier_MG",
	// "CUP_O_TK_INS_Soldier_GL",
	// "CUP_O_TK_INS_Soldier_AT",
	// "CUP_O_TK_INS_Soldier",
	// "CUP_O_TK_INS_Soldier_MG",
	// "CUP_O_TK_INS_Soldier_AR",
	// "CUP_O_TK_INS_Sniper",
	// "CUP_O_TK_INS_Soldier_Enfield",
	// "CUP_O_TK_INS_Soldier_FNFAL",
	// "CUP_O_TK_INS_Soldier_GL",
	// "CUP_O_TK_INS_Soldier_AR",
	// "CUP_O_TK_INS_Soldier",
	// "CUP_O_TK_INS_Soldier_Enfield",
	// "CUP_O_TK_INS_Soldier_FNFAL",
	// "CUP_O_TK_INS_Soldier_TL",
	// "CUP_O_TK_INS_Soldier_AT",
	// "CUP_O_TK_INS_Soldier_AT",
	// "CUP_O_TK_INS_Soldier",
	// "CUP_O_TK_INS_Mechanic",
	// "CUP_O_TK_INS_Mechanic",
	// "CUP_O_TK_INS_Bomber",
	// "CUP_O_TK_INS_Bomber"
 
 		// "CUP_O_INS_Commander",
		// "CUP_O_INS_Soldier_AR",
		// "CUP_O_INS_Soldier_GL",
		// "CUP_O_INS_Soldier_AT",
		// "CUP_O_INS_Soldier_AK74",
		// "CUP_O_INS_Soldier_AR",
		// "CUP_O_INS_Soldier",
		// "CUP_O_INS_Soldier_AK74",
		// "CUP_O_INS_Commander",
		// "CUP_O_INS_Soldier_MG",
		// "CUP_O_INS_Soldier_MG",
		// "CUP_O_INS_Soldier_AT",
		// "CUP_O_INS_Soldier_AT",
		// "CUP_O_INS_Soldier_AR",
		// "CUP_O_INS_Soldier_AR",
		// "CUP_O_INS_Soldier_AK74"


	// vn_o_men_nva_01
	// vn_o_men_nva_02
	// vn_o_men_nva_03
	// vn_o_men_nva_04
	// vn_o_men_nva_05
	// vn_o_men_nva_06
	// vn_o_men_nva_07
	// vn_o_men_nva_08
	// vn_o_men_nva_09
	// vn_o_men_nva_10
	// vn_o_men_nva_11
	// vn_o_men_nva_12

	// create randoms 
	_opforClass = [
		"vn_o_men_nva_01",
		"vn_o_men_nva_02",
		"vn_o_men_nva_03",
		"vn_o_men_nva_04",
		"vn_o_men_nva_05",
		"vn_o_men_nva_06",
		"vn_o_men_nva_07",
		"vn_o_men_nva_08",
		"vn_o_men_nva_09",
		"vn_o_men_nva_10",
		"vn_o_men_nva_11",
		"vn_o_men_nva_12"
	];
	_opforGroup = createGroup [east, true];
	_opforTeam = [];
	_base = 15;
	_random = random 10;
	_size = _base + _random + patrolPointsTaken; 

	for "_i" from 1 to _size do {
		_unit = selectRandom _opforClass;
		_unit1 = _opforGroup createUnit [_unit, _randomEnemySpawnPos, [], 0.1, "none"];
		_opforTeam pushBack _unit1;
	};

	tinmanModule addCuratorEditableObjects [_opforTeam, true];
	bluforZeus addCuratorEditableObjects [_opforTeam, true];

	// idea - after spawn, have them roam around the objective area .. 
	_roam = true;
	while {_roam} do {
		
		if (count (units _opforGroup) > 0) then { 
			_randomMovePos = [["redzone"]] call BIS_fnc_randomPos;
			_opforGroup move _randomMovePos;
		} else {
			_roam = false;
		};

		sleep 300
	};


	// _dist = random 30;
	// _dir = random 359;
	// _unitDest = _target getPos [_dist, _dir];
	// _opforTeam doMove _unitDest;

	// _opforTeam setFormation "diamond";
	// why not work?
	// spawnedIndiUnit = spawnedIndiUnit + _groupSize;

	// TODO - WORK OUT HOW TO MAKE DIAMOND FORMATION
};

// note: changing this so the roamers do not hit the older point, but instead roam around obj causing chaos 