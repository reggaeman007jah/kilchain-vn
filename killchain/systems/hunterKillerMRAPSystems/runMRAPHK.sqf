
systemChat "running runMRAPHK.sqf";
sleep 1;

_hunterGroup = _this select 0; // mrap
systemChat format ["dropping off group: %1", _hunterGroup];

// sleep 1;

_commander = commander _hunterGroup;
systemChat format ["Group Commander is %1", _commander];
_group = group _commander;

// sleep 1;

// [_group] execVM "killChain\systems\hunterKillerMRAPSystems\checkForTargetsMRAP.sqf";
// systemChat format ["sending this: %1", _group];

// -----------------------------------------------------------------------------------------
// systemChat "Loading HK System v2...";
// _hunterGroup = _this select 0; // the group of the hunter team passed in 
// systemChat format ["running runHK, received: %1", _hunterGroup];
// confirm position of hunter leader 
_groupLeader = leader _hunterGroup;
_hunterPos = getPos _groupLeader;
// -----------------------------------------------------------------------------------------

_allGroups = allGroups; // get all game groups 
_stalking = []; // this holds data related to stalking 
// systemChat format ["all game groups: %1", _allGroups]; // debug lists all opfor groups 
_opforGroups = []; // to hold all opfor groups 
// _hunters = []; // to hold single hunter group 
_targetGroup = []; // will hold closest (target) group 

// collate all opfor groups
{
	switch ((side _x)) do {
		case EAST: {
			_unitCount = count units _x;
			if (_unitCount > 0) then {
				_opforGroups pushBack _x;
				systemChat format ["SWITCH OPFOR: %1", _x];
				systemChat format ["Groupsize: %1", _unitCount];
				sleep 0.2;
			} else {
				deleteGroup _x;
			};
		};
	};
} forEach _allGroups;

// simple debug message 
systemChat format ["opfor groups: %1", _opforGroups]; // debug lists all opfor groups 
systemChat ".....";
systemChat format ["hunter group: %1", _hunterGroup]; // debug lists hunter group 

// -----------------------------------------------------------------------------------------

// get hunter group and leader - do once 
// _hunter = _hunterGroup select 0; 
_hunterLeader = leader _hunterGroup; 
_hunterLeaderPos = getPos _hunterLeader;

// -----------------------------------------------------------------------------------------

// now find nearest group 
_enemyGroupDistances = [3000]; // limiter distance value 
_cnt = count _opforGroups;
_cycle = 1;
// systemChat format ["There are %1 opfor groups", _cnt]; // debug info 

// catch situation where no enemy - TBD
// if (_cnt == 0) exitwith {}; 
if (_cnt == 0) then {
	// wait and re-try
	sleep 120;
	systemChat "re-trying HK MRAP Check";
	[_hunterGroup] execVM "killchain\systems\hunterKillerMRAPSystems\runMRAPHK.sqf";
} else {
	// process all known opfor groups to grab the one nearest to hunter group
	{
		_leader = leader _x; // get group leader 
		_leaderPos = getPos _leader; // get pos of leader 
		_dist = _leaderPos distance _hunterLeaderPos; // get distance between hunter and hunted 
		systemChat format ["Iteration %1", _cycle]; // debug info - iteraration
		systemChat format ["opfor group %1 distance: %2", _x, _dist]; // debug info 
		_enemyGroupDistances pushBack _dist;
		_cnt = count _enemyGroupDistances;
		systemChat format ["_enemyGroupDistances array count is: %1", _cnt]; // debug info 
		// -----------------------
		_pos0 = _enemyGroupDistances select 0;
		_pos1 = _enemyGroupDistances select 1;
		systemChat format ["_pos0: %1", _pos0]; // debug info 
		systemChat format ["_pos1: %1", _pos1]; // debug info 
		// -----------------------
		if (_pos1 < _pos0) then {
			_enemyGroupDistances deleteAt 0;
			_targetGroup deleteAt 0;
			_targetGroup pushBack _x;
			systemChat format ["_pos1 %1 is less than _pos0 %2", _pos1, _pos0]; // debug info 
		} else {
			systemChat format ["_pos1 %1 is greater than or equal to _pos0 %2", _pos1, _pos0]; // debug info 
			systemChat "too far away";
			_enemyGroupDistances deleteAt 1;
		};
		// sleep 3;
		systemChat format ["_targetGroup is currently %1", _targetGroup]; // debug info
		systemChat "cycling";
		_cycle = _cycle + 1;
		sleep 0.2;
	} forEach _opforGroups;

	// -----------------------------------------------------------------------------------------

	// get markers for targets - DEBUG ONLY
	// {
	// 	_leader = leader _x; // get group leader 
	// 	_leaderPos = getPos _leader; // get pos of leader 
	// 	_name = str _x;
	// 	deleteMarker _name;
	// 	_marker = createMarker [_name, _leaderPos];
	// 	_name setMarkerShape "rectangle";
	// 	_name setMarkerSize [5,5];
	// 	_name setMarkerColor "colorred";
	// 	_name setMarkerText _name;
	// } forEach _opforGroups;

	systemChat format ["target group is %1, and is %2 m away", _targetGroup, _enemyGroupDistances]; // debug info 
	systemChat format ["hunter group is %1", _hunterGroup]; // debug info 
	sleep 2;

	// -----------------------------------------------------------------------------------------
	_target = _targetGroup select 0;
	_targetDist = _enemyGroupDistances select 0;
	_unitCount = count units _target;
	_leader = leader _target; // get group leader 
	_leaderPos = getPos _leader; // get pos of leader 

	_hkUnitCount = count units _hunterGroup;

	if (_unitCount >= 1) then {
		systemChat format ["calling HK order on group %1, %2 away, size: %3", _target, _targetDist, _unitCount]; // debug info 
		_hunterGroup move _leaderPos;
	} else {
		systemChat "error - found empty group - deleting empty group - retrying";
		deleteGroup _target;
		sleep 2;
		if (_hkUnitCount > 0) then {
			[_hunterGroup] execVM "killchain\systems\hunterKillerSystems\runHK.sqf"; // re-run 
			systemChat "IMPORTANT - RERUN OF HK SYSTEM - DOES THIS WORK? - IMPORTANT";
		};
	};

	_HKACTIVE = true;

	while {_HKACTIVE} do {
		systemChat "running _HKACTIVE";
		_target = _targetGroup select 0;
		_targetDist = _enemyGroupDistances select 0;
		_unitCount = count units _target;
		_leader = leader _target; // get group leader 
		_leaderPos = getPos _leader; // get pos of leader 

		systemChat format ["TARGET COUNT: %1", _unitCount]; // debug info 

		if (_unitCount == 0) then {
			// deleteGroup _target; // this should be done anyway 
			hint "SUCCCESS ALL TANGOS DOWN";
			_HKACTIVE = false;
			// [] execVM "hkSystemv2\runHK.sqf";
			systemChat "re-running HK systems";
			[_hunterGroup] execVM "killChain\systems\hunterKillerSystems\runHK.sqf";
			systemChat "IMPORTANT - RERUN OF HK SYSTEM - DOES THIS WORK?";
		} else {
			_hunterGroup move _leaderPos;
			systemChat format ["STILL HUNTING: %1", _target]; // debug info 
			systemChat format ["TARGET COUNT: %1", _unitCount]; // debug info 
		};

		// if (_hkUnitCount == 0) then {
		// 	_HKACTIVE = false;
		// 	systemChat "HK Team is DEAD";
		// };
		if (isNull _hunterGroup) then {
			_HKACTIVE = false;
			systemChat "HK Team is DEAD";
			// hint "HK Team is DEAD";
		};
		// should kill loop if HK team are dead 

		sleep 30;
		systemChat format ["HKACTIVE CHECK - Group: %1", _hunterGroup];
	};

};





