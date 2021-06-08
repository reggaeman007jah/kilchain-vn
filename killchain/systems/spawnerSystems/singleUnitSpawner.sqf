
// this is used explusively by sideWinder Ops 
systemChat "running Disrupt and Evade Unit Spawner";
sleep 1;
systemChat "Scores:";
systemChat format ["Indifor: %1", RGG_indiforPoints];
systemChat format ["Opfor: %1", RGG_opforPoints];

sleep 5;

// _RGG_indiforPoints = 0;
// _RGG_opforPoints = 0;

_opfor = [
	"CUP_O_INS_Commander",
	"CUP_O_INS_Soldier_AR",
	"CUP_O_INS_Soldier_GL",
	"CUP_O_INS_Soldier_AT",
	"CUP_O_INS_Soldier_AK74",
	"CUP_O_INS_Soldier_AR",
	"CUP_O_INS_Soldier",
	"CUP_O_INS_Soldier_AK74",
	"O_G_Soldier_A_F",
	"O_G_Soldier_AR_F",
	"O_G_medic_F",
	"O_G_Soldier_lite_F",
	"O_G_Soldier_TL_F"
];

_indifor = [
	"CUP_I_UN_CDF_Officer_DST",
	"CUP_I_UN_CDF_Soldier_AAT_DST",
	"CUP_I_UN_CDF_Soldier_AMG_DST",
	"CUP_I_UN_CDF_Guard_DST",
	"CUP_I_UN_CDF_Soldier_MG_DST",
	"CUP_I_UN_CDF_Soldier_AR_DST",
	"CUP_I_UN_CDF_Soldier_DST",
	"CUP_I_UN_CDF_Soldier_Backpack_DST",
	"CUP_I_UN_CDF_Soldier_AT_DST",
	"CUP_I_UN_CDF_Soldier_SL_DST",
	"CUP_I_UN_CDF_Soldier_GL_DST",
	"CUP_I_UN_CDF_Soldier_Light_DST",
	"CUP_I_UN_CDF_Soldier_LAT_DST"
];
 
while {DISRUPTEVADE} do {

	systemChat "Scores:";
	systemChat format ["Indifor: %1", RGG_indiforPoints];
	systemChat format ["Opfor: %1", RGG_opforPoints];

	sleep 5;

	_allUnits = allUnits inAreaArray "sideWinder";
	_enemyCount = east countSide _allUnits;
	_indiCount = independent countSide _allUnits;

	if (_enemyCount < 70) then {

		while {_enemyCount < 70} do {
			_allUnits = allUnits inAreaArray "sideWinder";
			_enemyCount = east countSide _allUnits;
			systemChat format ["_enemyCount = %1", _enemyCount];
			_RGG_hub = getMarkerPos "sideWinder";

			// _pos = [_RGG_hub, 1, 500, 3, 0, 20, 0] call BIS_fnc_findSafePos;
			_pos = [_RGG_hub, 1, 500, 3, 0, 20, 0, 75] call RGGf_fnc_find_locationNoPlayers;
			
			// _missionPos = [_areaCenter, 150, 200, 10, 0, 1, 0, 50] call RGGf_fnc_find_locationNoPlayers; // last param is prox dist check 
			// _missionPos = [_areaCenter, 6000, 6500, 10, 0, 1, 0] call BIS_fnc_findSafePos;

			_randomUnit = selectRandom _opfor;
			_grp = createGroup [east, true];
			_unit = _grp createUnit [_randomUnit, _pos, [], 1, "none"]; 
			_unit setBehaviour "COMBAT";

			sleep 0.1;
		};
	};

	if (_indiCount < 30) then {

		while {_indiCount < 30} do {
			_allUnits = allUnits inAreaArray "sideWinder";
			_indiCount = independent countSide _allUnits;
			systemChat format ["_indiCount = %1", _indiCount];
			_RGG_hub = getMarkerPos "sideWinder";

			// _pos = [_RGG_hub, 1, 500, 3, 0, 20, 0] call BIS_fnc_findSafePos;
			_pos = [_RGG_hub, 1, 500, 3, 0, 20, 0, 75] call RGGf_fnc_find_locationNoPlayers;

			_randomUnit = selectRandom _indifor;
			_grp = createGroup [independent, true];
			_unit = _grp createUnit [_randomUnit, _pos, [], 1, "none"]; 
			_unit setBehaviour "COMBAT";

			sleep 0.1;
		};
	};

	systemchat "time to pause for 360";
	sleep 360; 
	systemChat "... SCORES ...";
	sleep 2;
	
	// main scores 
	_allUnits = allUnits inAreaArray "sideWinder";
	_newEnemyCount = east countSide _allUnits;
	_newIndiCount = independent countSide _allUnits;
	systemChat format ["indifor started with %1 units, then ended with %2 units", _indiCount,_newIndiCount];
	systemChat format ["opfor started with %1 units, then ended with %2 units", _enemyCount,_newEnemyCount];
	sleep 2;

	// losses 
	_indiLosses = _indiCount - _newIndiCount;
	_opforLosses = _enemyCount - _newEnemyCount;
	systemChat format ["indifor lost %1 units", _indiLosses];
	systemChat format ["opfor lost %1 units", _opforLosses];
	sleep 2;

	// percentage losses 
	_indiPercLoss = _indiLosses / (_indiCount / 100);
	_opforPercLoss = _opforLosses / (_enemyCount / 100);
	systemChat format ["indifor took %1 casualties", _indiPercLoss];
	systemChat format ["opfor took %1 casualties", _opforPercLoss];
	sleep 2;

	// calc win  
	if (_opforPercLoss >= _indiPercLoss) then {
		systemChat "indifor won this round";
		RGG_indiforPoints = RGG_indiforPoints +1;
	} else {
		systemChat "opfor won this round";
		RGG_opforPoints = RGG_opforPoints +1;
	};

	systemChat "restarting in 5 ...";
	sleep 5;
};

