/*
From: autoPatrolSystem/autoPatrolSystem.sqf 
*/

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

	_unit1 = _indiGroup createUnit ["vn_i_men_ranger_09", _pos, [], 0.1, "none"]; 
	_unit2 = _indiGroup createUnit ["vn_i_men_ranger_07", _pos, [], 0.1, "none"]; 
	_unit3 = _indiGroup createUnit ["vn_i_men_ranger_10", _pos, [], 0.1, "none"]; 
	_unit4 = _indiGroup createUnit ["vn_i_men_ranger_14", _pos, [], 0.1, "none"]; 
	_unit5 = _indiGroup createUnit ["vn_i_men_ranger_15", _pos, [], 0.1, "none"]; 
	_unit6 = _indiGroup createUnit ["vn_i_men_ranger_12", _pos, [], 0.1, "none"]; 

old 
			_unit1 = _indiGroup createUnit ["I_G_Soldier_SL_F", _pos, [], 0.1, "none"]; 
			_unit2 = _indiGroup createUnit ["I_G_Soldier_AR_F", _pos, [], 0.1, "none"]; 
			_unit3 = _indiGroup createUnit ["I_G_Soldier_GL_F", _pos, [], 0.1, "none"]; 
			_unit4 = _indiGroup createUnit ["I_G_Soldier_LAT2_F", _pos, [], 0.1, "none"]; 
			_unit5 = _indiGroup createUnit ["I_G_Soldier_M_F", _pos, [], 0.1, "none"]; 
			_unit6 = _indiGroup createUnit ["I_G_Soldier_F", _pos, [], 0.1, "none"]; 
			_unit7 = _indiGroup createUnit ["I_G_Soldier_F", _pos, [], 0.1, "none"]; 
			_unit7 = _indiGroup createUnit ["I_G_medic_F", _pos, [], 0.1, "none"]; 

*/

sleep 2;
systemChat "running createIndiforRfUnits.sqf here";

_spawnPos = _this select 0; // given position where we want to spawn RF
_destPos = _this select 1; // where RF are sent to 

_numberOfCycles = 2; // placeholder var - 3 groups of 5 
_area = 60; // distribution of units on spawn  
_timer = 0.3; // spawn cycle gap  

/*
Here we need to:
	first, check how many points we have, as if 0, then rf will always just happen
	get pos of preferred spawn point 
	create a marker to enable check of opfor 
	if opfor found, find next ideal point - the one before 
	exit and re-run with new preferred point (i.e. we might fail again although unlikely)
	if no opfor found, then go ahead as per normal 
*/

if (patrolPointsTaken > 1) then {
	deleteMarker "rfZone"; // does this need to go somewhere else?
	_rfZone = createMarker ["rfZone", _spawnPos];
	_rfZone setMarkerShape "ELLIPSE";
	_rfZone setMarkerColor "ColorRed";
	_rfZone setMarkerSize [50, 50];
	_rfZone setMarkerAlpha 0.2;
	
	// get overall numbers of troops in rf area 
	_unitsCore = allUnits inAreaArray "rfZone";

	// check indi and opfpr numbers in core  
	_coreIndi = 0;
	_coreOpfor = 0;
	{
		switch ((side _x)) do
		{
			case EAST: {_coreOpfor = _coreOpfor + 1};
			case INDEPENDENT: {_coreIndi = _coreIndi + 1};
		};
	} forEach _unitsCore;

	if (_coreOpfor > 5) then {
		systemChat "cannot use this spawn area as it is occupied by opfor troops";
		systemChat "DEBUG - check that RF is spawning at the base prior";
		// how to make this more obvious to players?

		private ["_mainAnchor"];
		switch (patrolPointsTaken) do {
			// case (1): {
			// 	_mainAnchor = RGG_PatrolPoints select 0;
			// };
			case (2): {
				_mainAnchor = RGG_PatrolPoints select 0;
			};
			case (3): {
				_mainAnchor = RGG_PatrolPoints select 1;
			};
			case (4): {
				_mainAnchor = RGG_PatrolPoints select 2;
			};
			case (5): {
				_mainAnchor = RGG_PatrolPoints select 3;
			};
			case (6): {
				_mainAnchor = RGG_PatrolPoints select 4;
			};
			default {
				systemChat "error: RF switch - point not correct";
			};
		};
		
		// check overall indifor units before kicking this off more than once 
		// only issue RF is overall indiFor units in game is under 25 
		_indi = independent countSide allUnits;
		if (_indi < 15) then {	
			[_mainAnchor, _destPos] execVM "killChain\systems\spawnerSystems\createIndiforRFUnits.sqf";
		} else {
			systemChat "no RF .. you have enough indifor in game already";
		};
		
		// this should re-run this script with a spawn pos that is one previous 
	} else {
		// deliver RF as per expected 
		
		_smoke = createVehicle ["G_40mm_smokeYELLOW", _spawnPos, [], 0, "none"]; // drop this from up high?
		// voice broadcasts
		execVM "media\sounds\thisIsCommand.sqf";
		sleep 3;
		execVM "media\sounds\rfInbound.sqf";
		
		for "_i" from 1 to _numberOfCycles do {
			_indiGroup = createGroup [independent, true];
			_pos = [_spawnPos, 20, _area] call BIS_fnc_findSafePos;
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
	};
} else {
	// this means that RF will just happen as planned, from FOB Pathfinder 
	// note this is duplication as the same coe is uded in the above block - so ..
	// we need to use a function here !!
	// also - this check should ensure we don't overload idifor numbers in earlier stages - untested!
	_smoke = createVehicle ["G_40mm_smokeYELLOW", _spawnPos, [], 0, "none"]; // drop this from up high?
	// voice broadcasts


	_indi = independent countSide allUnits;
	if (_indi < 15) then {

		execVM "media\sounds\thisIsCommand.sqf";
		sleep 3;
		execVM "media\sounds\rfInbound.sqf";

		for "_i" from 1 to _numberOfCycles do {
			_indiGroup = createGroup [independent, true];
			_pos = [_spawnPos, 20, _area] call BIS_fnc_findSafePos;
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
			// systemChat str _fireTeam;

			sleep _timer;
			// move orders 
			_randomDir = selectRandom [270, 310, 00, 50, 90];
			_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
			// _unitDest = [_destPos, 5, 20] call BIS_fnc_findSafePos;
			_endPoint1 = _destPos getPos [_randomDist,_randomDir];
			_fireTeam doMove _endPoint1;
			
			// spawnedIndiUnit = spawnedIndiUnit +5;
		};
	} else {
		systemChat "no RF .. you have enough indifor in game already";
	};
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