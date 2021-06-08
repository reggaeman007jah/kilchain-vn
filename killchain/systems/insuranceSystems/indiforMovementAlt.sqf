systemChat "alt insurance move order";
_initStartPos = _this select 0; // origin point 
_objPos = _this select 1; // obj point 

while {TRUE} do {

	if (RFCHECK) then {
				
		_units = allUnits inAreaArray "Redzone";

		_indi = [];
		{
			if ((side _x) == INDEPENDENT) then {_indi pushBack _x};
		} forEach _units;

		// get indi player 
		_dataStore = [];
		{
			if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
		} forEach allPlayers;

		// build in a count - if zero then what do?
		_cnt = count _dataStore;

		if (_cnt > 0) then {
			// commander is considered alive
			_commander = _dataStore select 0;
			_commPos = getPos _commander;

			_distCheck = _initStartPos distance _commPos;
			if (_distCheck > 1500) then {
				// player is alive nbut out of the redzone, retreat indi 
				{
					_randomDir = selectRandom [270, 310, 00, 50, 90];
					_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
					_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];
					_x setBehaviour "COMBAT";
					_x doMove _initStartPos;
					sleep 2;
				} forEach _indi;
			} else {
				// player is in the fight, move to his/her pos 
				{
					// get a pos 30m towards objective from player pos  
					// _moveDir = _commPos getRelDir 
					_reldirX = _commPos getDir _objPos;
					_relDir = floor _relDirX;
					_forwardPos = _commPos getPos [50, _relDir];
					
					// loose circle 
					_randomDir = random 359;
					_randomDist = selectRandom [5, 10, 15, 20, 25];

					_endPoint1 = _forwardPos getPos [_randomDist,_randomDir];

					_x setBehaviour "COMBAT";
					_x doMove _endPoint1;

					sleep 0.7; // keeping the peel movement quick hopefully without killing perf 
				} forEach _indi;
			};
		} else {
			// this avoids an error when, say, indifor commander is injured (errors have been seen, hence this new if/else/else system)
			{
				_randomDir = selectRandom [270, 310, 00, 50, 90];
				_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
				// _unitDest = [_objPos, 5, 20] call BIS_fnc_findSafePos;
				_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];
				sleep 2;
				_x setBehaviour "COMBAT";
				_x doMove _initStartPos;
			} forEach _indi;
		};

		sleep 20;
	};

	if (RFCHECK2) then {
		
		_units = allUnits inAreaArray "Redzone";

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

			_distCheck = _initStartPos distance _commPos;

			if (_distCheck > 1500) then {
				// player is out of the zone, retreat indi 
				{
					_randomDir = selectRandom [270, 310, 00, 50, 90];
					_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
					_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];					
					_x setBehaviour "COMBAT";
					_x doMove _initStartPos;
					sleep 2;
				} forEach _indi;
			} else {
				// player is in the fight, move to his/her pos 
				{
					// get a pos 50m around player pos  
					// _moveDir = _commPos getRelDir 
					// _reldirX = _commPos getDir _objPos;
					// _relDir = floor _relDirX;
					// _forwardPos = _commPos getPos [20, _relDir];
					
					// loose circle but this time all around player, not in front 
					_randomDir = random 359;
					_randomDist = selectRandom [5, 10, 15, 20, 25];

					_endPoint1 = _commPos getPos [_randomDist,_randomDir];
					
					_x setBehaviour "COMBAT";
					_x doMove _endPoint1;

					sleep 0.7; // keeping the peel movement quick hopefully without killing perf
				} forEach _indi;
			};
		} else {
			// this avoids an error when, say, indifor commander is injured (errors have been seen, hence this new if/else/else system)
			{
				_randomDir = selectRandom [270, 310, 00, 50, 90];
				_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
				// _unitDest = [_objPos, 5, 20] call BIS_fnc_findSafePos;
				_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];
				_x setBehaviour "COMBAT";
				_x doMove _initStartPos;
				sleep 2;
			} forEach _indi;
		};	
		
		sleep 20;
	};

	sleep 1;
};

// _units = allUnits inAreaArray "Redzone";

// _indi = [];
// {
// 	if ((side _x) == INDEPENDENT) then {_indi pushBack _x};
// } forEach _units;

// // indi needs to be in redzone for this to take effect !!!

// // check if player in redzone 
// _dataStore = [];
// {
// 	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
// } forEach allPlayers;

// // _cnt = count _dataStore;
// // we need to build redundancy here, but for now lets assume there is an indifor player here, and has not disconnected 

// // if (_cnt == 1) then {
// // 	systemChat "INDIFOR PLAYER COMMAND SYSTEM ACTIVATED";
// // 	RGG_IndiPlayerSystem = true;
// // } else {
// // 	systemChat "STANDARD AI COMMAND SYSTEM ACTIVATED";
// // };

// _commander = _dataStore select 0;
// _commPos = getPos _commander;

// _distCheck = _initStartPos distance _commPos;

// if (_distCheck > 1500) then {
// 	// player is out of the zone, retreat indi 
// 	{
// 		_randomDir = selectRandom [270, 310, 00, 50, 90];
// 		_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 		// _unitDest = [_objPos, 5, 20] call BIS_fnc_findSafePos;
// 		_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];
// 		sleep 2;
// 		_x setBehaviour "COMBAT";
// 		_x doMove _initStartPos;
// 	} forEach _indi;
// } else {
// 	// player is in the fight, move to his/her pos 
// 	{
// 		_randomDir = selectRandom [270, 310, 00, 50, 90];
// 		_randomDist = selectRandom [5, 10, 20];
// 		// _unitDest = [_objPos, 5, 20] call BIS_fnc_findSafePos;
// 		_endPoint1 = _commPos getPos [_randomDist,_randomDir];
// 		sleep 2;
// 		_x setBehaviour "COMBAT";
// 		_x doMove _endPoint1;
// 	} forEach _indi;
// };




