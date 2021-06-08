/*
An outer regions patrol has encountered a larger enemy force and need support 
This is a time-limited one-off situation, i.e. not a killchain mission

Mission trigger will gen a position far away - i.e. no easy RF 
Get support in this area quickly - either run CAS around surrounded forces, or drop off players to support 

to-do:
Sort out correct classes for mission 
decide when to change patrol stances to auto - done 
smoke on arrival - check whether any player is near to trigger - done
set up bigger marker to declare - in voice - how many opfor are "in the wire"

notes:
make it so that fire can be in full effect on close prox, or totally quiet - and if quiet, either kicks off on landing full scale, or remains quiet 
so, three outcomes here 
To win, you need to repell all incoming opfor?

*/
systemChat "DEBUG - RUNNING: missions_LRRP";

_areaCenter = _this select 0; // currently FOB Pathfinder, but could also be a patrol point, or anything else 
_welcomeParty = selectRandom [1,2,3]; // decides what is happening on approach to area and how players are welcomed 

// the welcome party switch will determine if the ambush happens on landing, on approach, or whether opfor are way further out as heli approaches 
private "_actDist";
switch (_welcomeParty) do {
	case 1: { _actDist = 20 }; // waits for landing before ambush - so sets activation var to small - needs a z value here 
	case 2: { _actDist = 80 }; // triggers an attack on close approach - so sets activation var to medium
	case 3: { _actDist = 120 }; // triggers an attack on long approach - so sets activation var to large 
	default { systemChat "Switch Error _actDist" };
};

// patrol ambience 
_assets = [
	"B_A_LSV_01_light_F",
	"B_A_MRAP_03_gmg_F",
	"Box_IND_AmmoVeh_F",
	"Box_EAF_Equip_F",
	"I_EAF_supplyCrate_F",
	"SatelliteAntenna_01_Sand_F"
];

// objective pos cc
// _missionPos = [5108,20058,0]; // hand picked location(s) for debug / testing 

_missionPos = [_areaCenter, 4200, 5500, 10, 0, 1, 0] call BIS_fnc_findSafePos;

deleteMarker "BATTLEZONE";
_pos1 = createMarker ["BATTLEZONE", _missionPos];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerAlpha 0.3;
_pos1 setMarkerSize [250, 250];
// replace this with voice markers  

// add marker icon here 
LRRP = true; // for marker system 
[_missionPos, "hd_pickup", "LRRP_Marker", "colorBlue"] spawn RGGe_fnc_effects_markers;

// find location for opfor comms base - need to destroy this base in order to stop RF 
_opforBase = [_missionPos, 750, 1000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

// hold - check for player near 
// deleteAll checks here - ensure no players near 
_anchorPos = getMarkerPos 'BATTLEZONE';
_activateCheck = true;
while {_activateCheck} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 2500) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt >= 1) then {
		systemChat "players are near - LZ mission activated";
		_activateCheck = false;
	} else {
		_activateCheck = true;
		systemChat "players are not near - do not delete LZ Mission";
	};

	sleep 20; // cycle frequency 
};

// create items 
{
	_dist = random 30;
	_dir = random 359;
	_thingPos = _missionPos getPos [_dist, _dir];
	_thing = _x createVehicle _thingPos;
	_thing setDir _dir;
} forEach _assets;

// create blufor units 
for "_i" from 1 to 20 do {
	_group = createGroup west;
	_unit = _group createUnit ["B_A_Soldier_A_F", _missionPos, [], 0.1, "none"]; 
	_randomMovePos = [ ["BATTLEZONE"] ] call BIS_fnc_randomPos;
	_unit doMove _randomMovePos;
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;
	_unit setUnitCombatMode "BLUE";
	_unit setCaptive true;
	sleep 1;
};

// freeze blufor unit behaviour 
_allUnits = allUnits inAreaArray "BATTLEZONE";
{
	_x disableAI "MOVE";
} forEach _allUnits;

// create welecome party 
_size = selectRandom [15,20,25,30];
for "_i" from 1 to _size do {
	_group = createGroup east;
	_dist = selectRandom [150, 160, 170, 180, 190, 200];
	_dir = random 359;
	_spawnPos = _missionPos getPos [_dist, _dir];	
	_unit = _group createUnit ["O_G_Soldier_A_F", _spawnPos, [], 0.1, "none"]; 
	_unit setCaptive true;
	_unit setUnitPos "DOWN";
	sleep 0.1;
};

// smoke trigger 
SMOKEOUT = false;
_trgSmk = createTrigger ["EmptyDetector", _missionPos];
_trgSmk setTriggerArea [2000, 2000, 0, false];
_trgSmk setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trgSmk setTriggerStatements ["this", "SMOKEOUT = true", "systemChat 'no player near'"];

// proximity pause 
waitUntil { SMOKEOUT };
_smoke = createVehicle ['G_40mm_smokeYELLOW', _missionPos, [], 0, 'none'];

// attack trigger 
attackNow = false;
_trg = createTrigger ["EmptyDetector", _missionPos];
_trg setTriggerArea [_actDist, _actDist, 0, false];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements ["this", "
	_allUnitsX = allUnits inAreaArray 'BATTLEZONE';
	{
		_x enableAI 'MOVE';
		_x setBehaviour 'COMBAT';
		_x setCaptive false;
		_x setUnitPos 'AUTO';
	} forEach _allUnitsX;
	attackNow = true;
", "systemChat 'no player near'"];

waitUntil { attackNow };
// I do this ^^ as for some reason, having two forEach loops was not working within the trigger statement 

// push opfor to rush the LZ, set up blufor into a defensive perimiter 
_allUnitsX = allUnits inAreaArray 'BATTLEZONE';
_opfor = [];
_blufor = [];
{
	if ((side _x) == EAST) then {
		_opfor pushBack _x;
	}; 
	if ((side _x) == WEST) then {
		_blufor pushBack _x;
	}; 
} forEach _allUnitsX;

{
	_randomDir = random 359;
	_randomDist = selectRandom [10, 15, 20];
	_endPoint1 = _missionPos getPos [_randomDist,_randomDir];
	_x doMove _endPoint1;
} forEach _opfor;

sleep 5;

{
	_randomDir = random 359;
	_randomDist = selectRandom [20, 25, 30, 35];
	_endPoint1 = _missionPos getPos [_randomDist,_randomDir];
	_x doMove _endPoint1;
} forEach _blufor;

// deleteAll checks here - ensure no players near 
_anchorPos = getMarkerPos 'BATTLEZONE';
_deleteCheck = true;
while {_deleteCheck} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 500) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt == 0) then {
		systemChat "no players near - safe to delete";
		[_anchorPos] call RGGd_fnc_Delete_AllWithinArea;
		_deleteCheck = false;
	} else {
		_deleteCheck = true;
		systemChat "players are near - do not delete";
	};

	sleep 20; // cycle frequency 
};

// set up new mission 
LRRP = false;
deleteMarker "BATTLEZONE";

sleep 10;

systemChat "STARTING NEW MISSION"; // add voice here 
_pos = getPos ammo1; // Pathfinder
[_pos] spawn RGGm_fnc_mission_supportLRRP;
