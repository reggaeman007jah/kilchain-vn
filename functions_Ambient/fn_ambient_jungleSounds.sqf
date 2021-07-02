/*
This function will get a player on ground, select a random player, and play a sound on player to simulate jungle 
*/


sleep 5;

/*
To-do:
Ensure sounds only play when no enemy near - or is wasted due to gunfire 
Ensure sounds do not repeat too often, so must sequence-loop instead of random loop 
Make certain sounds only happen at night 
*/

while {TRUE} do {

	// get players on ground  
	_playersOnGround = [] call RGGg_fnc_get_allPlayersOnGround;

	_cnt = count _playersOnGround;

	if (_cnt > 0) then {

		// select random sound 
		_sound = selectRandom [
			"night1", 
			"night2", 
			"night3", 
			"night4", 
			"night5", 
			"night6", 
			"night7", 
			"night8", 
			"night9", 
			"night10", 
			"night11", 
			"night12", 
			"night13", 
			"night14", 
			"night15", 
			"night16", 
			"night17", 
			"night18", 
			"night19", 
			"night20", 
			"night21"
		];

		_path = selectRandom [
			"media\jungleNight\night1.ogg", 
			"media\jungleNight\night2.ogg", 
			"media\jungleNight\night3.ogg", 
			"media\jungleNight\night4.ogg", 
			"media\jungleNight\night5.ogg", 
			"media\jungleNight\night6.ogg", 
			"media\jungleNight\night7.ogg", 
			"media\jungleNight\night8.ogg", 
			"media\jungleNight\night9.ogg", 
			"media\jungleNight\night10.ogg", 
			"media\jungleNight\night11.ogg", 
			"media\jungleNight\night12.ogg", 
			"media\jungleNight\night13.ogg", 
			"media\jungleNight\night14.ogg", 
			"media\jungleNight\night15.ogg", 
			"media\jungleNight\night16.ogg", 
			"media\jungleNight\night17.ogg", 
			"media\jungleNight\night18.ogg", 
			"media\jungleNight\night19.ogg", 
			"media\jungleNight\night20.ogg", 
			"media\jungleNight\night21.ogg"
		];

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
			systemChat "playing sound now";
			// play sound 
			// _randPlayer say3D [_sound, 25];	
			// [_randPlayer, [_sound, 50, 1]] remoteExec ["say3d"];
			// the above eminates sound from player - this is not good.
			// determine where sound should eminate from 
			_dir = random 359; // any direction 
			_dis = random 10; // 1-40m away 
			_alt = 10 + (random 5); // always in the air, between 10-15m up - not good for Lions though right lol 
			_pos = _randPlayerPos getPos [_dis,_dir];
			_pos set [2,_alt];
			systemChat format ["_pos = %1", _pos];
			systemChat format ["_randPlayerPos = %1", _randPlayerPos];
			// playSound3D [filename, soundSource, isInside, soundPosition, volume, soundPitch, distance, offset]
			// playSound3D [getMissionPath "mySound.ogg", player]; // to play a mission directory sound
			playSound3D [getMissionPath "\media\jungleNight\night1.ogg", player, false, _pos, 1, 1, 50]; // does not work currently and no idea why 
		} else {
			systemChat "no jungle sounds as enemy is near or not in AO";
		};

		// wait 
		sleep 90;
		_add = random 30;
		sleep _add;
	} else {
		sleep 60;
	};
};