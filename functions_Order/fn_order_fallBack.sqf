// one off order - move to player location 

// systemChat "debug - running fallback.sqf";
"ARVN Units are falling back to Tinman" remoteExec ["systemChat", 0, true];
{playSound "fallback"} remoteExec ["call",0];

FALLBACKREMAIN = false; // in case was running 

_units = allUnits inAreaArray "Redzone";

_indi = [];
{
	if ((side _x) == INDEPENDENT) then {_indi pushBack _x};
} forEach _units;

// systemChat format ["_indi: %1", _indi];

// get indi player
_dataStore = [];
{
	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
} forEach allPlayers;

_commander = _dataStore select 0;
_commPos = getPos _commander;
// systemChat format ["_commander: %1", _commander];
// systemChat format ["_commPos: %1", _commPos];

{
	// loose circle but this time all around player, not in front 
	_randomDir = random 359;
	_randomDist = selectRandom [5, 10, 15];

	_endPoint1 = _commPos getPos [_randomDist,_randomDir];
	
	_x setBehaviour "COMBAT";
	_x doMove _endPoint1;

	// systemChat format ["move order: %1", _endPoint1];

	sleep 0.7; // keeping the peel movement quick hopefully without killing perf
} forEach _indi;


