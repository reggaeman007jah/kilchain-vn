/*
This function will get a player on ground, select a random player, and play a sound on player to simulate jungle 
*/


sleep 5;

/*
To-do:
Ensure sounds only play when no enemy near - or is waster due to gunfire 
Ensure sounds do not repeat too often, so must sequence-loop instead of random loop 
Make certain sounds only happen at night 
*/

while {TRUE} do {

	// get players on ground  
	_playersOnGround = [] call RGGg_fnc_get_allPlayersOnGround;

	// select random sound 
	_sound = selectRandom ["night1", "night2", "night3", "night4", "night5", "night6", "night7", "night8", "night9", "night10", "night11", "night12", "night13", "night14", "night15", "night16", "night17", "night18", "night19", "night20", "night21"];

	// select random player on ground 
	// _randPlayer = selectRandom _playersOnGround; 
	_randPlayer = _playersOnGround select 0; // test only  

	// debug 
	systemChat format ["DEBUG - returning random on ground: %1", _randPlayer];

	// get pos of selected player 
	_randPlayerPos = getPos _randPlayer;
	_inArea = _randPlayerPos inArea "redzone"; // i.e. only works if player is in the AO 

	// determine whether enemies are near, and only continue if false   
	_enemyNear = [_randPlayerPos, 300, "EAST"] call RGGf_fnc_find_nearbyUnits; // here we check for opfor in a 300m radius 

	if ((_enemyNear == false) && (_inArea)) then {
		// play sound 
		// _randPlayer say3D [_sound, 25];	
		[_randPlayer, [_sound, 50, 1]] remoteExec ["say3d"];
	} else {
		systemChat "no jungle sounds as enemy is near";
	};

	// wait 
	sleep 90;
	_add = random 30;
	sleep _add;
};