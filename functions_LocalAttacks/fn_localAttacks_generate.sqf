/*
This function generates attack on local base 
comes from: [_campPos, _targetPos, _target] call RGGs_fnc_LocalAttacks_generate; 
received two args, pos of camp and target 
*/

params [_campPos, _targetPos, _target];

// create enemy at _campPos 
// send to _targetPos 
// inform players of _target activity 

_opforGrp = createGroup east;
_initialOpforInfiPresence = selectRandom [10, 20, 30];
systemChat format ["Enemy is attacking %1 with a force size of %2", _target, _initialOpforInfiPresence];

for "_i" from 1 to _initialOpforInfiPresence do {
	_rndtype = selectRandom [
		"O_G_Soldier_A_F",
		"O_G_Soldier_AR_F",
		"O_G_medic_F",
		"O_G_engineer_F",
		"O_G_Soldier_exp_F",
		"O_G_Soldier_GL_F",
		"O_G_Soldier_M_F",
		"O_G_officer_F",
		"O_G_Soldier_F",
		"O_G_Soldier_LAT_F",
		"O_G_Soldier_LAT2_F",
		"O_G_Soldier_lite_F",
		"O_G_Sharpshooter_F",
		"O_G_Soldier_SL_F",
		"O_G_Soldier_TL_F",
		"O_G_Offroad_01_armed_F"
	];
	_pos = [_campPos, 5, 50] call BIS_fnc_findSafePos; 
	_unit = _opforGrp createUnit [_rndtype, _pos, [], 1, "none"]; 
	_unit setBehaviour "COMBAT";
	_unit doMove _targetPos; 
	// spawnedOpforUnit = spawnedOpforUnit + 1; // maybe giood for scoring?
	_timer = selectRandom [0.5, 1, 2, 3, 5];
	sleep _timer;						
};
