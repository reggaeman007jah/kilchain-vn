// manages whether there should be any night attacks 

// requires spawn location 
_spawnPos = _this select 0;
_targetPos = _this select 1;

// need to check that tinman is in redzone and on group, otherwise no night ops 
_dataStore = [];
{
	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
} forEach allPlayers;

_cnt = count _dataStore;

if (_cnt == 1) then {
	// there is an indifor player in game  
	_commander = _dataStore select 0;
	_commPos = getPos _commander;

	_inRed = _commPos inArea "pathFinderBase";
	if (!_inRed) then {
		_alt = _commPos select 2;

		if (_alt < 2) then {
			// tinman is inredzone and on ground, so run night ops 
			systemChat "night ops running";

			// outcome
			_outcome = selectRandom [1,2,3,4,5];
			// _outcome = 4;

			_noAttack = false;
			_lightAttack = false;
			_mediumAttack = false;
			_mortarAttack = false;

			// determine outcome 
			switch (_outcome) do {
				case 1: { _noAttack = true }; // no attack tonight
				case 2: { _lightAttack = true }; // light attack
				case 3: { _mediumAttack = true }; // medium attack
				case 4: { _mortarAttack = true }; // mortar attack 
				case 5: { _noAttack = true }; // no attack tonight 
				default { systemChat "error: night attacks selector broken" }; // error 
			};

			if (_noAttack) then {
				// somehow create voices nearby 
				systemChat "no attack";
			};

			if (_lightAttack) then {
				// spawn in enemies at spawn pos, and send to Tinman
				[_spawnPos, _targetPos] spawn RGGs_fnc_spawn_vc;
				systemChat "spawning light VC attack";
			};

			if (_mediumAttack) then {
				// spawn in enemies at spawn pos, and send to Tinman 
				systemChat "spawning medium VC attack";
				[_spawnPos, _targetPos] spawn RGGs_fnc_spawn_vc;
				sleep 200;
				[_spawnPos, _targetPos] spawn RGGs_fnc_spawn_vc;
			};

			if (_mortarAttack) then {
				// create ambi-explosions nearby 
				systemChat "spawning arty hits nearby";
				[_targetPos] spawn RGGa_fnc_ambient_mortars;
			};

		} else {
			sleep 60;
			// re-run this 		
		};
	} else {
		systemChat "tinman is at base - no night ops";
	};
};






