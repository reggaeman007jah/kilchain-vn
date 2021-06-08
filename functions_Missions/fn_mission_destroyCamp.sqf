/*
This will gen a one-off opfor group, to enable players to seek and destroy a small enemy camp
If won, you get to see enemy locations .. but need a player at least by the radio 
while player is there, there will be attempts - somehow - to take the radio point back 

To do:

*/

systemChat "DEBUG - RUNNING: missions_destroyCamp";

_areaCenter = _this select 0; // current patrol point

// 
_assetsCamp = [
	"Land_BagBunker_01_large_green_F",
	"CamoNet_ghex_big_F",
	"Land_MedicalTent_01_CSAT_greenhex_generic_outer_F"
];

// opfor infi 
_assetsInfi = [
	"O_R_Soldier_SL_ard_F",
	"O_R_RadioOperator_ard_F",
	"O_R_Soldier_LAT_ard_F",
	"O_R_soldier_M_ard_F",
	"O_R_Soldier_TL_ard_F",
	"O_R_soldier_AR_ard_F",
	"O_R_Soldier_A_ard_F",
	"O_R_medic_ard_F",
	"O_R_Soldier_SL_ard_F",
	"O_R_soldier_AR_ard_F",
	"O_R_Soldier_GL_ard_F",
	"O_R_soldier_M_ard_F",
	"O_R_soldier_AT_ard_F",
	"O_R_Soldier_AAT_ard_F",
	"O_R_Soldier_A_ard_F",
	"O_R_medic_ard_F"
];

// light armour - not used here 
_assetsMRAP = [
	"O_R_Truck_03_fuel_ard_F",
	"O_R_Truck_02_fuel_ard_F",
	"O_R_Truck_02_ard_F",
	"O_R_Truck_02_MRL_ard_F"
];

// mission pos 
_missionPos = [_areaCenter, 800, 1000, 10, 0, 1, 0] call BIS_fnc_findSafePos;

deleteMarker "enemyCamp";
_pos1 = createMarker ["enemyCamp", _missionPos];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerAlpha 0.3;
_pos1 setMarkerSize [2000, 2000];
// replace this with voice markers  

// add marker icon here 
DESTROYCAMP = true; // for marker system 
[_missionPos, "hd_objective", "enemyCamp_Marker", "colorRed"] spawn RGGe_fnc_effects_markersSAD;

// hold - check for player near 
// deleteAll checks here - ensure no players near 
_anchorPos = getMarkerPos 'enemyCamp';
_activateCheck = true;

// no need to check for prox, spawn anyway 
// while {_activateCheck} do {
// 	_dataStore = [];
// 	{
// 		_playerPos = getPos _x;
// 		_dist = _anchorPos distance _playerPos;

// 		if (_dist < 2500) then {
// 			_dataStore pushback _x;
// 		};
// 	} forEach allPlayers;

// 	_cnt = count _dataStore;

// 	if (_cnt >= 1) then {
// 		systemChat "players are near - SAD mission activated";
// 		_activateCheck = false;
// 	} else {
// 		_activateCheck = true;
// 		systemChat "players are not near - do not delete SAD Misison";
// 	};

// 	sleep 20; // cycle frequency 
// };

// create items 
systemChat "debug - creating items";
_assetPos = [];
{
	_dist = random 100;
	_dir = random 359;
	_thingPos = _missionPos getPos [_dist, _dir];
	_thing = _x createVehicle _thingPos;
	_thing setDir _dir;
	_assetPos pushBack _thingPos;
	sleep 0.5;
} forEach _assetsCamp;

// RF anchor 
_opforSpawnPos = _assetPos select 0;
// _opforSpawnPos = getPos _opforBase;

sleep 2;
// create units 
systemChat "debug - creating units";
_opGroup = createGroup [east, true];
{
	_dist = random 100;
	_dir = random 359;
	_thingPos = _missionPos getPos [_dist, _dir];

	_unit = _opGroup createUnit [_x, _thingPos, [], 0.1, "none"]; 
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;
	_unit setDir _dir;

	sleep 0.1;
} forEach _assetsInfi;
// to-do manage positions and ambient walking etc 

// add diff levels based on near players 
_dataStore = [];
{
	_playerPos = getPos _x;
	_dist = _anchorPos distance _playerPos;

	if (_dist < 1500) then {
		_dataStore pushback _x;
	};
} forEach allPlayers;

_nearPlayers = count _dataStore;

_medDiff = false;
_hardDiff = false;
if (_nearPlayers < 4) then {
	// medium diff 
	_medDiff = true;
} else {
	// hard diff 
	_hardDiff = true;
};

if (_medDiff) then {
	// 4 mraps 
	for "_i" from 1 to 4 do {
		_rndtype = selectRandom [
			"O_R_APC_Wheeled_02_rcws_v2_ard_F",
			"O_R_APC_Tracked_02_medical_ard_F",
			"O_R_APC_Tracked_02_cannon_ard_F",
			"O_R_Truck_03_fuel_ard_F",
			"O_R_Truck_02_fuel_ard_F",
			"O_R_Truck_02_ard_F",
			"O_R_Truck_02_MRL_ard_F"
		];

		_pos = [_missionPos, 0, 100] call BIS_fnc_findSafePos;
		_opforVic = [_pos, 180, _rndtype, east] call BIS_fnc_spawnVehicle;
		// _dir = random 359;
		// _opforVic setDir _dir; cc
		sleep 0.5;						
	};
};

if (_hardDiff) then {
	// 2 mraps and 2 tanks 
	for "_i" from 1 to 2 do {
		_rndtype = selectRandom [
			"O_R_APC_Wheeled_02_rcws_v2_ard_F",
			"O_R_APC_Tracked_02_medical_ard_F",
			"O_R_APC_Tracked_02_cannon_ard_F",
			"O_R_Truck_03_fuel_ard_F",
			"O_R_Truck_02_fuel_ard_F",
			"O_R_Truck_02_ard_F",
			"O_R_Truck_02_MRL_ard_F"
		];
		_pos = [_missionPos, 0, 100] call BIS_fnc_findSafePos;
		_opforVic = [_pos, 180, _rndtype, east] call BIS_fnc_spawnVehicle;
		// _dir = random 359;
		// _opforVic setDir _dir;
		sleep 0.5;						
	};
	for "_i" from 1 to 2 do {
		_rndtype = selectRandom [
			"O_R_MBT_04_command_ard_F",
			"O_R_MBT_04_cannon_ard_F",
			"O_R_MBT_02_cannon_ard_F"
		];
		_pos = [_missionPos, 0, 100] call BIS_fnc_findSafePos;
		_opforVic = [_pos, 180, _rndtype, east] call BIS_fnc_spawnVehicle;
		// _dir = random 359;
		// _opforVic setDir _dir;
		sleep 0.5;						
	};
};

// to-do check for fired weapon and move opfor towards pos 

// check for opfor alive 
_SADMISSION = true; 

while {_SADMISSION} do {
		
	// get overall numbers of troops in redzone 
	_unitsRedzone = allUnits inAreaArray "KILLZONE";

	// check indi and opfor numbers in redzone 
	_redzoneBlufor = 0;
	_redzoneOpfor = 0; 
	{
		switch ((side _x)) do
		{
			case WEST: {_redzoneBlufor = _redzoneBlufor + 1};
			case EAST: {_redzoneOpfor = _redzoneOpfor + 1};
		};
	} forEach _unitsRedzone;

	// mid-point opfor RF 
	if ((_redzoneOpfor < 10) && (_redzoneBlufor > 1)) then {
		hint "opfor RF inbound";
		// find nearest player 
		_dataStore = [];
		{
			_playerPos = getPos _x;
			_dist = _anchorPos distance _playerPos;

			if (_dist < 1500) then {
				_dataStore pushback _x;
			};
		} forEach allPlayers;

		// make sure only happens if players are near 
		_nearPlayers = count _dataStore;
		if (_nearPlayers >= 1) then {
			_rfTarget = _dataStore select 0;
			_rfTargetPos = getPos _rfTarget;

			_opGroup = createGroup [east, true];
			{
				_unit = _opGroup createUnit [_x, _opforSpawnPos, [], 0.1, "none"]; 
				systemChat "creating RF unit here";
				systemChat str _opforSpawnPos;
				_unit doMove _rfTargetPos;
				systemChat "moving to player pos:";
				systemChat str _rfTargetPos;
				sleep 10;
			} forEach _assetsInfiRF;
		};
	};

	// STAGE WIN LOGIC 
	if ((_redzoneOpfor < 3) && (_redzoneBlufor > 1)) then {
		hint "mission won";
		// regroup, healup and get prizes
		_SADMISSION = false;
	};

	// debug stats 
	systemChat format ["REDZONE WEST: %1", _redzoneBlufor];
	systemChat format ["REDZONE EAST: %1", _redzoneOpfor];

	sleep 10;
};

// deleteAll checks here - ensure no players near 
_anchorPos = getMarkerPos 'KILLZONE'; // can delete? is duplicate?
_deleteCheck = true;
while {_deleteCheck} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 3000) then {
			_dataStore pushback _x;
			systemChat format ["debug - pushing back based on %1 value", _dist]
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt == 0) then {
		systemChat "there no players within 200m of obj - safe to delete";
		systemChat "mission now dead through no player proximity";
		[_anchorPos] call RGGd_fnc_Delete_AllWithinArea;
		_deleteCheck = false;
		// set up new mission 
		KILLZONE = false;
		deleteMarker "KILLZONE";

		sleep 10;

		systemChat "STARTING NEW KILLZONE MISSION"; // add voice here 
		_pos = getPos ammo1; // Pathfinder
		[_pos] spawn RGGm_fnc_mission_seekAndDestroy;
	} else {
		_deleteCheck = true;
		systemChat "players are near - do not delete KILLZONE mission";
	};

	sleep 5; // cycle frequency 
};




