
/*
Create dish and bunker, close to eachother 
Spawn defensive opfor units - number based on amount of players near trigger zone 
Options:
- Spawn item within base for demo - Create watch system to track if item !alive 
- Have a backpck that can show opfor positions / deploy radar dish 
- need more ideas 

to-do:
- add voice system 
- to-do manage positions and ambient walking etc 

*/

systemChat "DEBUG - RUNNING: missions_destroyRadar";
huntLocalPlayers = false;

_areaCenter = _this select 0; // sat dish object from patrol point  

_assetsCamp = [
	"Land_Cargo_HQ_V4_F"
	// "Land_MobileRadar_01_radar_F"
];

// opfor infi 
_assetsInfi = [
	"O_R_Soldier_TL_F",
	"O_R_Soldier_AR_F",
	"O_R_medic_F",
	"O_R_Soldier_LAT_F",
	"O_R_Soldier_GL_F",
	"O_R_Soldier_AR_F",
	"O_R_Soldier_LAT_F"
];

// opfor RF 
// _assetsInfiRF = [
// 	"O_R_soldier_AR_ard_F",
// 	"O_R_Soldier_GL_ard_F",
// 	"O_R_soldier_M_ard_F",
// 	"O_R_soldier_AT_ard_F",
// 	"O_R_Soldier_AAT_ard_F",
// 	"O_R_Soldier_A_ard_F",
// 	"O_R_medic_ard_F"
// ];

// internal assetss 
_assets = [
	"Land_MultiScreenComputer_01_sand_F",
	"Land_Computer_01_sand_F",
	"Land_MultiScreenComputer_01_closed_black_F",
	"Land_PCSet_Intel_01_F",
	"Land_TripodScreen_01_large_F"
];

// light armour
_assetsMRAP = [
	"O_LSV_02_armed_F",
	"O_MRAP_02_F"
];

// mission pos 
// _missionPos = [_areaCenter, 6000, 6500, 10, 0, 1, 0] call BIS_fnc_findSafePos; // original 
_missionPos = [_areaCenter, 1000, 1200, 10, 0, 1, 0, 1000] call RGGf_fnc_find_locationNoPlayers; // last param is prox dist check 
// _missionPos = [_areaCenter, 6000, 6500, 10, 0, 1, 0] call BIS_fnc_findSafePos;
sleep 5;
// systemChat "creating marker";
// sleep 2;

// deleteMarker "KILLZONE";
_pos1 = createMarker ["KILLZONE", _missionPos];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
// _pos1 setMarkerAlpha 0.3;
_pos1 setMarkerSize [300, 300];
// add voice markers  

// call marker icon function  
// KILLZONE = true; // for marker system 
// [_missionPos, "hd_objective", "KILLZONE_Marker", "colorRed"] spawn RGGe_fnc_effects_markersSAD;

// hold - check/wait for player(s) near 
_anchorPos = getMarkerPos 'KILLZONE';
_activateCheck = true;
// systemChat "running _activateCheck";
// sleep 1;

while {_activateCheck} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 600) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt >= 1) then {
		systemChat "players are near - radar mission activated";
		_activateCheck = false;
	};

	sleep 10; // cycle frequency 
};

// create items 
// systemChat "debug - creating items";

_assetPos = [];
{
	_dist = random 30;
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

// for "_i" from 1 to 2 do {
// 	_rndtype = selectRandom [
// 		"O_MRAP_02_gmg_F",
// 		"O_LSV_02_armed_F",
// 		"O_MRAP_02_F"
// 	];

// 	_pos = [_missionPos, 0, 100] call BIS_fnc_findSafePos;
// 	_opforVic = [_pos, 180, _rndtype, east] call BIS_fnc_spawnVehicle;
// 	// _dir = random 359;
// 	// _opforVic setDir _dir; cc
// 	sleep 0.5;						
// };

// to-do check for fired weapon and move opfor towards pos 

// check for opfor alive 
// _RADARMISSION = true; 

// // add EH to check if destroyed 
// _building = _assetsCamp select 0;
// _buildingPos = getPos _building;
// _mybuilding = nearestbuilding _buildingPos;

// mybuilding addMissionEventHandler ["BuildingChanged", {
// 	params ["_previousObject", "_newObject", "_isRuin"];
// 	// if (_isRuin) then {
// 	// 	hint "WINNING WINNING";
// 	// };
// };];

//

_item1 = true;
_item2 = true;

_huntLocalPlayers = false;

_satDish = "SatelliteAntenna_01_Sand_F" createVehicle _missionPos;
_satDish addEventHandler ["Explosion", {
	params ["_vehicle", "_damage"];
	systemChat "item 1 destroyed";
	SPECOPSATTACKS = false;
	huntLocalPlayers = true;
	deleteVehicle _vehicle;
	_item1 = false;
	// _radar = _assetsCamp select 0;
	// _radarPos = getPos _radar;
	// deleteVehicle _radar;
	// _ruin = "Land_MobileRadar_01_radar_ruins_F" createVehicle _radarPos;
}];

// spawn pack in building
// B_RadioBag_01_hex_F

_basePos = _assetPos select 0; 
_pack = "Land_MultiScreenComputer_01_black_F" createVehicle _missionPos;
// _pack setPos [getPos _basePos select 0, getPos _basePos select 1, (getPos _basePos select 2) +4];

_pack addEventHandler ["Explosion", {
	params ["_vehicle", "_damage"];
	systemChat "item 2 destroyed";
	SPECOPSATTACKS = false;
	huntLocalPlayers = true;
	deleteVehicle _vehicle;
	_item2 = false;
	// _radar = _assetsCamp select 0;
	// _radarPos = getPos _radar;
	// deleteVehicle _radar;
	// _ruin = "Land_MobileRadar_01_radar_ruins_F" createVehicle _radarPos;
}];

//


// BIGBIRD_1 addEventHandler ["RopeBreak", {
// 	params ["_object1", "_rope", "_object2"];
// 	if (ROPEBREAK == false) then {
// 		if (typeOf _object2 == "B_MRAP_01_gmg_F") then {
// 			ROPEBREAK = true;
			
// 			systemChat "MRAP Deployed:"; 
// 			[_object2] execVM "eventHandlers\slingLoadMRAPCheck.sqf"; 
// 			Big_Lifter_2 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
// 			execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
// 		};	
// 	};
// }];

waitUntil { huntLocalPlayers };
sleep 2;
hint "hunting begins here";

while { huntLocalPlayers } do {
	// _unitsRedzone = allUnits inAreaArray "KILLZONE";
	// get overall numbers of troops in redzone 
	_unitsRedzone = allUnits inAreaArray "KILLZONE";
	systemChat "hunting cycle";
	// check indi and opfor numbers in redzone 
	_opforUnits = []; 
	_bluforUnits = [];
	{
		switch ((side _x)) do
		{
			case EAST: {_opforUnits pushBack _x};
			case WEST: {_bluforUnits pushBack _x};
		};
	} forEach _unitsRedzone;

	systemChat format ["_opforHunters: %1", _opforUnits];
	systemChat format ["_bluforHunted: %1", _bluforUnits];

	// find nearest player 
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 500) then {
			_dataStore pushback _x;
		};
	} forEach _bluforUnits;
	systemChat format ["_dataStore: %1", _dataStore];

	// make sure this only happens if players are near 
	_nearPlayers = count _dataStore;
	if (_nearPlayers >= 1) then {
		_rfTarget = _dataStore select 0;
		_rfTargetPos = getPos _rfTarget;
		{
			_x doMove _rfTargetPos;
		} forEach _opforUnits;
	};

	_cntOp = count _opforUnits;
	_cntBl = count _bluforUnits;
	if ((_cntOp == 0) or (_cntBl == 0)) then {
		huntLocalPlayers = false; // breakout 
	};

	sleep 30;
};

if ((!_item1) && (!_item2)) then {
	sleep 5;
	hint "WIIIIIIINER";	
	huntLocalPlayers = false; // breakout? i thinkn this is wrong - we wouldnt have this state at this stage..?
};

// cleanup section - deleteAll checks happen here - ensure no players near before deleting everything 
// _anchorPos = getMarkerPos 'KILLZONE'; // can delete? is this a duplicate?
// _deleteCheck = true;

// while {_deleteCheck} do {

// 	_dataStore = [];
// 	{
// 		_playerPos = getPos _x;
// 		_dist = _anchorPos distance _playerPos;

// 		if (_dist < 3000) then {
// 			_dataStore pushback _x;
// 			systemChat format ["debug - pushing back based on %1 value", _dist]
// 		};
// 	} forEach allPlayers;

// 	_cnt = count _dataStore;

// 	if (_cnt == 0) then {
// 		systemChat "there no players within 3km of obj - safe to delete";
// 		systemChat "mission now complete and can be deleted as no player proximity";
// 		[_anchorPos] call RGGd_fnc_Delete_AllWithinArea;
// 		_deleteCheck = false;
// 		// set up new mission 
// 		KILLZONE = false;
// 		deleteMarker "KILLZONE";

// 		sleep 10;

// 		// here we want to assign any reward or benefit to players as reward ...
// 	};

// 	sleep 5; // cycle frequency 
// };

