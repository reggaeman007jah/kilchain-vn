
/*
drop off units, they go to nearest player and act as meatsheild 
*/

// -----------------------------------------------------------------------------------------
systemChat "Loading CPD System ...";

_cpdGroup = _this select 0; // the cpd group that was delivered 
_heli = _this select 1; // delivery heli 
systemChat format ["debug - running runCPD, deploying: %1", _cpdGroup];
format ["debug - running runCPD, deploying: %1", _cpdGroup] remoteExec ["systemChat", 0]; // does this work??

// _groupLeader = leader _cpdGroup; // leader of cpd group 
// _cpdLeaderPos = getPos _groupLeader; // pos of cpd group leader 
_heliPos = getPos _heli; // get anchor for calcs 
// _dataStore = [1000]; // initial 1km value 
// _candidate = []; // container for winning / closest player 

// _cnt = count allPlayers;

// if (_cnt > 1) then {

_anchor = _heli getRelPos [10,0];
_cpd1 = createMarker ["cpd1", _anchor];
_cpd1 setMarkerShape "ELLIPSE";
_cpd1 setMarkerColor "ColorRed";
_cpd1 setMarkerSize [20, 20];
_cpd1 setMarkerAlpha 0.8;
sleep 8;

/*
we want to know if there are more than 1 player on server - if only one, then select 0 to apply CPD to player, if more than one ...
... then apply select 1 to essentially ignore the player and have the nearest player to marker receive AI team 
*/

_playersInGame = count allPlayers;

private ["_owner"];

if (_playersInGame == 1) then {
	_owner = 0;
} else {
	_owner = 1;
};

// apply team to player here 
private _markerPos = getMarkerPos "cpd1";
private _playerList = allPlayers apply { [_markerPos distanceSqr _x, _x] };
_playerList sort true;
private _closestPlayer = (_playerList select _owner) param [1, objNull];
// dedmen ^^ https://forums.bohemia.net/forums/topic/222709-get-closest-player-to-marker/

systemChat format ["SP debug - winning player is: %1", _closestPlayer];
format ["MP debug - winning player is: %1", _closestPlayer] remoteExec ["systemChat", 0];
sleep 3;

"MP debug - calling protectPlayer" remoteExec ["systemChat", 0, true];
[_closestPlayer, _cpdGroup] execVM "killchain\systems\cpdSystems\protectPlayer.sqf";
deleteMarker "cpd1"; 
// } else {
// 	systemChat "you on your own mate .. no CPD options here";
// };

// i think this might tag any copilot = so make sure when cpd is deployed .. only pilot in heli 




// -----------------------------------------------------------------------------------------

/*
get all players 
find nearest player that is not in heli 
link group dropped off to the nearest player 

while player is alive, they will be 50m in front 
if player dies, find next nearest player and allocate group to that player 

cycle position every 20 seconds 

*/









// not done!



/*


_allGroups = allGroups; // get all game groups 
_stalking = []; // this holds data related to stalking 
systemChat format ["all game groups: %1", _allGroups]; // debug lists all opfor groups 
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
if (_cnt == 0) exitwith {}; 

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
	sleep 10;
	if (_hkUnitCount > 0) then {
		[_hunterGroup] execVM "killchain\systems\hunterKillerSystems\runHK.sqf"; // re-run 
		systemChat "IMPORTANT - RERUN OF HK SYSTEM - DOES THIS WORK?";
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
		systemChat "IMPORTANT 2 - RERUN OF HK SYSTEM - DOES THIS WORK?";
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
		hint "HK Team is DEAD";
	};
	// should kill loop if HK team are dead 

	sleep 30;
	systemChat format ["HKACTIVE CHECK - Group: %1", _hunterGroup];
};
