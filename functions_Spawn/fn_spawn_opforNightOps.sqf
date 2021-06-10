// manages whether there should be any night attacks 
systemChat "night ops running";

// requires spawn location 
_spawnPos = _this select 0;
_targetPos = _this select 1;

// outcome
// _outcome = selectRandom [1,2,3,4,5];
_outcome = 4;

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

