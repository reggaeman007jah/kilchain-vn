/*
Summary:
This will be a reasonably major side-project, designed specifically for CAS operations  

Backstory:
An indiFor patrol will be created, with some static assets etc, perhaps vics with no fuel etc ..
Then, enemy is spawned in around the patrol, and sent in to overrun them 
CAS is needed to repell the atackers and keep the patrol safe 

Logic:
On prox to the mission, patrol will pop green smoke on their location, and reds in the enemy direction 
This will repeat at intervals 
When area is clear, look for blue smoke 
Mission repeats with new objective 

Commencement:
Mission is triggered from main airbase. We need refuel and rearm facilities at MAB as well as in-field at patrol position location
in-field rearm will be truck - opfor have RPGs, so may not survive 
On mission start, you'll get voice activated grids - no map markers 
Go to area, look for smoke .. then start hunting 

Duration:
Can vary .. maybe keep a watch on active opfor, and keep that level maintained in small groups for x duration 
Also, consider multiplier for number of raptors in area 

To-do:
Make trigger system at MAB 
	Office-based system as with main mission - this will need its own mission bool 
Make patrol creation system 
	Choose units and vics, remove fuel, set out defences and movement within defensive area
Make location creation system 
	Choose location at random, using safezone and noPlayerNear
Make opfor spawner and move system 
	Make system to bring in opfor from varying distances, and in different sizes 
Make counter system 
	Count indiFor and opFor numbers regularly - relay this in systemchat for now 
Make prox-detector system 
	Initiate mission on prox, close down when mission either won or lost (numbers)
Make smoke system 
	Ensure that smokes are used on ground regularly, and reflect useful things 
		e.g. green for patrol location, orange is enemy far away in that direction, red is enemy in that direction but close, blue is area clear 

*/


systemChat "DEBUG - RUNNING: missions_raptorOps";

_areaCenter = _this select 0; // MAB  

// indifor infi 
_indiforUnits = [
	"I_Soldier_SL_F",
	"I_soldier_F",
	"I_Soldier_LAT_F",
	"I_Soldier_M_F",
	"I_Soldier_TL_F",
	"I_Soldier_AR_F",
	"I_Soldier_A_F",
	"I_medic_F"
];

// indifor vics 
_indiforVics = [
	"I_Truck_02_box_F",
	"I_Truck_02_ammo_F"
];
// "I_MRAP_03_gmg_F"

// opfor infi 
_opforUnits = [
	"O_G_Soldier_SL_F",
	"O_G_Soldier_AR_F",
	"O_G_Soldier_GL_F",
	"O_G_Soldier_LAT2_F",
	"O_G_Soldier_M_F",
	"O_G_Soldier_F",
	"O_G_Soldier_F",
	"O_G_medic_F"
];

// opfor vics 
_opforVics = [
	
];

// mission pos 
_missionPos = [_areaCenter, 4000, 8000, 10, 0, 1, 0] call BIS_fnc_findSafePos;

deleteMarker "RAPTOROPS";
_pos1 = createMarker ["RAPTOROPS", _missionPos];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerAlpha 0.2;
_pos1 setMarkerSize [3000, 3000];
// replace this with voice markers  

// add marker icon here 
RAPTOROPS = true; // for marker system 
[_missionPos, "hd_objective", "RAPTOROPS_Marker", "colorRed"] spawn RGGe_fnc_effects_markersRaptor;

// hold - check for player near 
// deleteAll checks here - ensure no players near 
_anchorPos = getMarkerPos 'RAPTOROPS';
_activateCheck = true;
while {_activateCheck} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 3500) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt >= 1) then {
		systemChat "players are near - raptor mission activated";
		_activateCheck = false;
	};

	sleep 10; // cycle frequency 
};

// create items 
// systemChat "debug - creating items";
// _assetPos = [];
// {
// 	_dist = random 100;
// 	_dir = random 359;
// 	_thingPos = _missionPos getPos [_dist, _dir];
// 	_thing = _x createVehicle _thingPos;
// 	_thing setDir _dir;
// 	_assetPos pushBack _thingPos;
// 	sleep 0.5;
// } forEach _assetsCamp;

sleep 1;
// create indifor units 
systemChat "debug - creating indifor units";
_indGroup = createGroup [independent, true];
{
	_dist = random 100;
	_dir = random 359;
	_thingPos = _missionPos getPos [_dist, _dir];

	_unit = _indGroup createUnit [_x, _thingPos, [], 0.1, "none"]; 
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;
	_unit setDir _dir;

	sleep 0.1;
} forEach _indiforUnits;

// indiFor patrol vics (no fuel)
systemChat "debug - creating indifor vics";
{
	_dist = random 10;
	_dir = random 359;
	_thingPos = _missionPos getPos [_dist, _dir];
	_pos = [_thingPos, 0, 20] call BIS_fnc_findSafePos;
	_indiVic = [_pos, _dir, _x, independent] call BIS_fnc_spawnVehicle;
	_indiVic params ["_vehicle", "_crew", "_group"];
	_vehicle setFuel 0;
	sleep 5;
} forEach _indiforVics;

_pilots = 0;
{
	_pos = getPos _x;
	if ((_pos select 2) > 5) then {
		_pilots = _pilots + 1;
	};
} forEach allPlayers;
systemChat format ["there are %1 pilots in the mission", _pilots];

// diff accumulator
_grpSize = 10;
_grpMultiplier = _grpSize * _pilots;

// close 
_dist = 500;
_dir = random 359;
_closeSpawnX = _missionPos getPos [_dist, _dir];
_closeSpawn = [_closeSpawnX, 1, 1000, 10, 0, 1, 0] call BIS_fnc_findSafePos;
deleteMarker "_closeSpawn";
_pos1 = createMarker ["_closeSpawn", _closeSpawn];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerSize [50, 50];

// medium 
_dist = 1000;
_dir = random 359;
_mediumSpawnX = _missionPos getPos [_dist, _dir];
_mediumSpawn = [_mediumSpawnX, 1, 1000, 10, 0, 1, 0] call BIS_fnc_findSafePos;
deleteMarker "_mediumSpawn";
_pos1 = createMarker ["_mediumSpawn", _mediumSpawn];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerSize [50, 50];

// far 
_dist = 1800;
_dir = random 359;
_farSpawnX = _missionPos getPos [_dist, _dir];
_farSpawn = [_farSpawnX, 1, 1000, 10, 0, 1, 0] call BIS_fnc_findSafePos;
deleteMarker "_farSpawn";
_pos1 = createMarker ["_farSpawn", _farSpawn];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerSize [50, 50];

// very far 
_dist = 2500;
_dir = random 359;
_veryFarSpawnX = _missionPos getPos [_dist, _dir];
_veryFarSpawn = [_veryFarSpawnX, 1, 1000, 10, 0, 1, 0] call BIS_fnc_findSafePos;
deleteMarker "_veryFarSpawn";
_pos1 = createMarker ["_veryFarSpawn", _veryFarSpawn];
_pos1 setMarkerShape "ELLIPSE";
_pos1 setMarkerColor "ColorRed";
_pos1 setMarkerSize [50, 50];

// create 4 opfor groups, once at each pos ^^ 

// close 
_opGroup1 = createGroup [east, true];
for "_i" from 1 to _grpMultiplier do {
	_unit = selectRandom _opforUnits;
	_dist = random 5;
	_dir = random 359;
	_pos = _closeSpawn getPos [_dist, _dir];
	_unit = _opGroup1 createUnit [_unit, _pos, [], 0.1, "none"]; 
	systemChat "creating opfor unit _closeSpawn";
	_unit doMove _missionPos;
	sleep 0.5;
};

// medium 
_opGroup2 = createGroup [east, true];
for "_i" from 1 to _grpMultiplier do {
	_unit = selectRandom _opforUnits;
	_dist = random 5;
	_dir = random 359;
	_pos = _mediumSpawn getPos [_dist, _dir];
	_unit = _opGroup2 createUnit [_unit, _pos, [], 0.1, "none"]; 
	systemChat "creating opfor unit _mediumSpawn";
	_unit doMove _missionPos;
	sleep 0.5;
};

// far 
_opGroup3 = createGroup [east, true];
for "_i" from 1 to _grpMultiplier do {
	_unit = selectRandom _opforUnits;
	_dist = random 5;
	_dir = random 359;
	_pos = _farSpawn getPos [_dist, _dir];
	_unit = _opGroup3 createUnit [_unit, _pos, [], 0.1, "none"]; 
	systemChat "creating opfor unit _farSpawn";
	_unit doMove _missionPos;
	sleep 0.5;
};

// very far 
_opGroup4 = createGroup [east, true];
for "_i" from 1 to _grpMultiplier do {
	_unit = selectRandom _opforUnits;
	_dist = random 5;
	_dir = random 359;
	_pos = _veryFarSpawn getPos [_dist, _dir];
	_unit = _opGroup4 createUnit [_unit, _pos, [], 0.1, "none"]; 
	systemChat "creating opfor unit _veryFarSpawn";
	_unit doMove _missionPos;
	sleep 0.5;
};

// cycle-check 
_raptorOps = true; 
while {_raptorOps} do {

	// get players in air - use this as your guide to enemy spawns 
	// 1-2 player = 3 locations, 1 close 1 medium and 1 far 
	// 3+ players = 8 locations, 2 close 2 medium 2 far and 2 very far 
	// 1-2 players = max enemy 40 at any one time 
	// 3+ players = max enemy 60 at any one time 
	// when decided on spawn points and numbers, run a check for both sides - can be a win/lose state = if indifor patrol is killed, this is fail 

	// cycle smoke 
	_smoke = createVehicle ['G_40mm_smokeGREEN', _missionPos, [], 0, 'none']; 

	// NOTE - smokes to indicate direction and prox of enemy 

	// gets all known game groups and filter to store only opfor 
	_groups = allGroups;  
	private _RGG_opforGroups = []; // empty array to store opfor group IDs 
	{
		switch ((side _x)) do {
			case EAST: { _RGG_opforGroups pushBackUnique _x };
		};
	} forEach _groups;
	_cnt = count _RGG_opforGroups;
	systemChat format ["there are %1 opfor groups", _cnt];

	// extract opfor group positions
	_opforGroupPos = []; 
	{
		_leader = leader _x;
		_leaderPos = getPos _leader;
		_opforGroupPos pushBack _leaderPos;
	} forEach _RGG_opforGroups;

	// generate smoke indicators based on direction and distance 
	{
		_heading = _missionPos getDir _x;
		_distance = _missionPos distance _x;
		if (_distance < 500) then {
			// red smoke 
			_smokePos = _missionPos getPos [200,_heading];
			_smoke = createVehicle ['G_40mm_smokeRED', _smokePos, [], 0, 'none']; 
		} else {
			// orange smoke 
			_smokePos = _missionPos getPos [200,_heading];
			_smoke = createVehicle ['G_40mm_smokeORANGE', _smokePos, [], 0, 'none']; 
		};
		sleep 10;
		_sleepMore = random 30;
		sleep _sleepMore;
	} forEach _opforGroupPos;

	// get overall numbers of troops in redzone 
	_unitsRedzone = allUnits inAreaArray "RAPTOROPS";

	// check indi and opfor numbers in redzone 
	_redzoneIndifor = 0;
	_redzoneOpfor = 0; 
	{
		switch ((side _x)) do
		{
			case independent: {_redzoneIndifor = _redzoneIndifor + 1};
			case EAST: {_redzoneOpfor = _redzoneOpfor + 1};
		};
	} forEach _unitsRedzone;

	// STAGE WIN LOGIC 
	if ((_redzoneOpfor < 3) && (_redzoneIndifor > 5)) then {
		hint "mission won";
		_raptorOps = false;
	};

	if ((_redzoneOpfor > 1) && (_redzoneIndifor < 1)) then {
		hint "mission lost";
		_raptorOps = false;
	};

	// debug stats 
	systemChat format ["REDZONE INDI: %1", _redzoneIndifor];
	systemChat format ["REDZONE EAST: %1", _redzoneOpfor];

	sleep 90;
};

if (_raptorOps == false) then {
	systemChat "START NEW ???";
	// to-do - delete patrol assets when noPlayersNear 
};

