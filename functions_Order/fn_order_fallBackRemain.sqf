// loop order, fall back and follow player pos 

systemChat "ARVN Units are falling back to protect TINMAN";
{playSound "fallbackremain"} remoteExec ["call",-2];
// _initStartPos = _this select 0; // origin point 
// _objPos = _this select 1; // obj point 

FALLBACKREMAIN = true;

while {FALLBACKREMAIN} do {

	systemchat "debug - FBR cycle";
	
	_units = allUnits inAreaArray "Redzone";

	_movePos = getMarkerPos 'REDZONE'; // objective
	
	_indi = [];
	{
		if ((side _x) == INDEPENDENT) then {_indi pushBack _x};
	} forEach _units;

	// get indi player
	_dataStore = [];
	{
		if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
	} forEach allPlayers;
	// note - do we really need to check for this every cycle?

	// build in a count - if zero then what do?
	_cnt = count _dataStore;

	if (_cnt > 0) then {
		// commander is considered alive
		_commander = _dataStore select 0;
		_commPos = getPos _commander;

		_inRed = _commPos inArea "redzone";

		if (_inRed) then {
			// player is in the fight, move to his/her pos 
			{
				// loose circle around player
				_randomDir = random 359;
				_randomDist = selectRandom [5, 10, 15, 20];
				_endPoint1 = _commPos getPos [_randomDist,_randomDir];
				
				_x setBehaviour "COMBAT";
				_x doMove _endPoint1;

				sleep 0.7; // keeping the peel movement quick hopefully without killing perf
			} forEach _indi;
		} else {
			// player is out of the zone, retreat indi 
			{
				_randomDir = selectRandom [270, 310, 00, 50, 90];
				_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
				_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];					
				_x setBehaviour "COMBAT";
				_x doMove _initStartPos;
				sleep 2;
			} forEach _indi;
		};
	} else {
		// this avoids an error when, say, indifor commander is injured (errors have been seen, hence this new if/else/else system)
		// {
		// 	_randomDir = selectRandom [270, 310, 00, 50, 90];
		// 	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
		// 	// _unitDest = [_objPos, 5, 20] call BIS_fnc_findSafePos;
		// 	_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];
		// 	_x setBehaviour "COMBAT";
		// 	_x doMove _initStartPos;
		// 	sleep 2;
		// } forEach _indi;
		FALLBACKREMAIN = false;
	};	
	
	sleep 20;
};



