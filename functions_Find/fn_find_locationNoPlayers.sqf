/*
This function will be given an anchor location, and distance away from anchor, and return a safeZone position 
that does not have players within a set distance (also a param)

This effectively runs BIS_fnc_findSafePos then runs an additional player prox check - if players are near, it re-runs ..
if no players near, it returns the pos  

https://community.bistudio.com/wiki/BIS_fnc_findSafePos
[center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos] call BIS_fnc_findSafePos
_missionPos = [_areaCenter, 6000, 6500, 10, 0, 1, 0] call BIS_fnc_findSafePos; example 

*/

_anchor = _this select 0;
_minDist = _this select 1;
_maxDist = _this select 2;
_objDist = _this select 3;
_waterMode = _this select 4;
_maxGrad = _this select 5;
_shoreMode = _this select 6;
_plrMinProx = _this select 7; // e.g. 1000m 

private "_missionPos";

_success = false;
while {!_success} do {
	_missionPos = [_anchor, _minDist, _maxDist, _objDist, _waterMode, _maxGrad, _shoreMode] call BIS_fnc_findSafePos;

	_dataStore = [];
	{
		_playerPos = getPos _x; // get each player pos 
		_dist = _missionPos distance _playerPos; // check how far away each player is from result of findSafePos 

		if (_dist < _plrMinProx) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;
	// here we pushBack any players who fall under the prox check (e.g. within 1km)

	_cnt = count _dataStore; // if this is 1 or more, then the position found is of no use / if 0 then we use it 

	if (_cnt == 0) then {
		// again, if no players are near - use this pos
		_success = true; // breaks out of checkLoop 
	};

	// sleep 5; 
};

systemChat format ["FNC RETURN - locationNoPlayers: %1", _missionPos];
_missionPos;



