/*
This function spawns opfor in the battlezone
*/



// ** imports 
// private ["_bluforFob", "_opforFob", "_initialOpforInfiPresence", "_initialopforVicPresence", "_battleZone"];
private ["_bluforCampLocation"];
// _bluforFob = param[0]; // blufor FOB pos / spawn
// _opforFob = param[1]; // opfor FOB pos / spawn
// _initialOpforInfiPresence = param[2]; // size of opfor infi force
// _initialopforVicPresence = param[3]; // size of opfor vic force
// _battleZone = param[4];
_bluforCampLocation = param[0]; // blufor Barracks
// ** imports 

_opforGrp = createGroup east;

// _initialOpforInfiPresence = _initialOpforInfiPresence * 10; // this adds a multiplier to the parsed value 
_initialOpforInfiPresence = 30; // hardcoded opfor force value for now 

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
	_pos = [_bluforCampLocation, 300, 600] call BIS_fnc_findSafePos; 
	_unit = _opforGrp createUnit [_rndtype, _pos, [], 1, "none"]; 
	_unit setBehaviour "COMBAT";
	_unit doMove _bluforCampLocation; 
	// spawnedOpforUnit = spawnedOpforUnit + 1; // maybe giood for scoring?
	sleep 0.5;						
};

