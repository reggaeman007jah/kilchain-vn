// allows for changing of day and night times 
// https://community.bistudio.com/wiki/BIS_fnc_sunriseSunsetTime
// https://community.bistudio.com/wiki/setTimeMultiplier

// test one - can you get dawn and dusk times on screen?
// test two - can you change speed using setTimeMul 
// test three - can you set different time speeds?

// _sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime; // get sunrise/sunset time for the current date

// _dawn = _sunriseSunsetTime select 0;
// _dusk = _sunriseSunsetTime select 1;

// systemChat "testing time manager";
// systemChat format ["dawn: %1", _dawn];
// systemChat format ["dusk: %1", _dusk];
// systemChat format ["current time: %1", date];

// setTimeMultiplier 30;

// _setDawn = 5;
// _setDusk = 18;

// while {true} do {
// 	_hour = date select 3;
// 	systemChat format ["_setDawn: %1", _setDawn];
// 	systemChat format ["_setDusk: %1", _setDusk];
// 	systemChat format ["hour: %1", _hour];
// 	if (_hour >= _setDawn) then {
// 		systemChat "is day";
// 		setTimeMultiplier 25;
// 		// systemChat format ["setTimeMultiplier: %1", setTimeMultiplier];
// 	} else {
// 		systemChat "is night";
// 		setTimeMultiplier 55;
// 		// systemChat format ["setTimeMultiplier: %1", setTimeMultiplier];
// 	};
// 	// systemChat format ["current time hour: %1", date select 3];
// 	sleep 10;
// };

// init time setting 
// if (((date select 3) > 4) && ((date select 3) < 19)) then {
// 	setTimeMultiplier 20;
// 	systemChat "init speed setting is 20";
// } else {
// 	setTimeMultiplier 55;
// 	systemChat "init speed setting is 55";
// };
// come back to this!

// --------------------------------------------------------
// note - always ensure you start the mission in the day! -
// --------------------------------------------------------

// trigger time for night
waitUntil { (date select 3) == 18 };
systemChat "it is 6pm, time for near-real-time dusk speed";
setTimeMultiplier 15;

waitUntil { (date select 3) == 19 };
systemChat "it is 7pm, time for near-real-time dusk speed";
setTimeMultiplier 2;

waitUntil { (date select 4) == 15 };
systemChat "it is 7:30pm, time for fast night speed";
setTimeMultiplier 60;
RGG_isDay = false;
publicVariable "RGG_isDay";
// spawn RGGs_fnc_spawn_birdDog;
remoteExec ["RGGs_fnc_spawn_birdDog", 2];
execVM "killchain\systems\ambientSystems\flares.sqf";
// here we create the possibility of a VC night attack - this will always run, but won't always yeild enemies 

// get indi player
_dataStore = [];
{
	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
} forEach allPlayers;
_cnt = count _dataStore;

if (_cnt > 0) then {
	// commander is considered alive
	systemChat "Tinman is alive";
	_commander = _dataStore select 0;
	_commPos = getPos _commander;
	_spawnPos = [_commPos, 400, 400, 10, 0, 1, 0, 400] call RGGf_fnc_find_locationNoPlayers;
	// [_spawnPos, _commPos] remoteExec ["RGGs_fnc_spawn_opforNightOps", 2];
	[_spawnPos, _commPos] spawn RGGs_fnc_spawn_opforNightOps;
};

// trigger time for day 
waitUntil { (date select 3) == 5 };
systemChat "it is 5am, time for slow dawn-break";
setTimeMultiplier 2;

waitUntil { (date select 4) == 25 };
systemChat "it is 5:30am, time for slow day speed";
setTimeMultiplier 23;
RGG_isDay = true;
publicVariable "RGG_isDay";

// 2:25 per hour at this speed 
// 14 hours at day speed 
// 34 mins per daylight cycle 

remoteExec ["RGGa_fnc_ambient_timeManager", 2]; // rerun this fnc on server only  


// while {true} do {
// 	_dawn = _sunriseSunsetTime select 0;
// 	_dusk = _sunriseSunsetTime select 1;
// 	_hour = date select 3;
// 	systemChat format ["dawn: %1", _dawn];
// 	systemChat format ["dusk: %1", _dusk];
// 	systemChat format ["hour: %1", _hour];
// 	if (_hour > _dawn) then {
// 		systemChat "is day";
// 		// systemChat format ["setTimeMultiplier: %1", setTimeMultiplier];
// 	} else {
// 		systemChat "is night";
// 		// systemChat format ["setTimeMultiplier: %1", setTimeMultiplier];
// 	};
// 	// systemChat format ["current time hour: %1", date select 3];
// 	sleep 10;
// };

