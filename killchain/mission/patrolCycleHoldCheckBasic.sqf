// here we keep checking whether the player is near the deployment target - LZ Genesis 
// we spawn everything first, opfor 
// we want to wait until player is near, but probably in the air, so when near-ish, we send qrf to Genesis 
// we want indifor inserted before indifor troops are created 
// [_initStartPos, _objPos] execVM "killChain\systems\spawnerSystems\createIndiforUnitsAlt.sqf";
// once player is on ground, qrf will be moving in, so important to get indifor units deployed ASAP 
// indifor units are limited - only can be 28 at any one time 
// rf will not move in automatically - but it is important that numbers are communicated regularly 
// rf will spawn only when numbers are low - a cycleCheck will take place, they will also spawn in batches of two, enabling two pilots to pick up at the same time 
// they will be lifted in groups of 4, allowing for smaller hueys 
// to-do - find out why players in heli messes up seat allocations 
// so cycleCheck is - if 22 or more, no units,  if 21 or less, spawn two batches of 4 and alert that this has happened maybe - or maybe send indi player message 
// also, limted batches of RF to 20 to start with, so 10 cycles of two batches each - once reached, no more, make do 
// so initially, there will need to be lots of lifts - one player will be busy - inital drop should be players of both factions into Genesis followed by (if one pilot) 8 lifts of 4 per heli 
// this btw is the init code for VA - 0 = ["AmmoboxInit",[this,true]] spawn BIS_fnc_arsenal;

// ID player on a loop, and progress when landed  
// _initStartPos = _this select 0; // starting point for any new mission
_objPos = _this select 0; // objective point for any new mission 

_checkCycle = true;

while {_checkCycle} do {
	
	_dataStore = [];
	{
		if ((side _x) == WEST) then { _dataStore pushback _x }
	} forEach allPlayers;

	_player = _dataStore select 0;
	_playerPos = getPos _player;

	_lzPos = getMarkerPos 'LZ_Zeus';

	_activateCheck = _lzPos distance _playerPos;

	if ((_activateCheck) < 150) then {
		hint "lets go";
		"Blufor Team is now at LZ Zeus - Patrol is live" remoteExec ["systemChat", 0, true];	

		// activate spawning of indifor troops 
		// execVM "killchain\systems\spawnerSystems\createIndiforUnitsRemote.sqf";
		// removed - too basic and needed older pickup system 
		[_lzPos, _objPos] execVM "killChain\mission\patrolCycle.sqf";
		_checkCycle = false;
	};

	sleep 10;
};