

hint "DEBUG - FINAL STAGE";

_initStartPos = _this select 0; // starting point 
_objPos = _this select 1; // objective point 

// Base 
_testCrate = "B_Slingload_01_Ammo_F" createVehicle _objPos; // make sure this is big and flat, to accomodate a base footprint 
[_testCrate, "B_Slingload_01_Ammo_F"] spawn RGGb_fnc_build_bluforBarracks;

/*
There are issues with the creation of the base in MP .. so we must give it time to build up before progressing the script 
*/

sleep 60; 

// OBJ - patrol stage objective 
deleteMarker "Redzone"; 
_objective1 = createMarker ["Redzone", _objPos];
_objective1 setMarkerShape "ELLIPSE";
_objective1 setMarkerColor "ColorRed";
_objective1 setMarkerSize [100, 100];
_objective1 setMarkerAlpha 0.2;
sleep 0.1;
_objective1 setMarkerSize [120, 120];
_objective1 setMarkerAlpha 0.3;
sleep 0.1;
_objective1 setMarkerSize [130, 130];
_objective1 setMarkerAlpha 0.4;
sleep 0.1;
_objective1 setMarkerSize [140, 140];
_objective1 setMarkerAlpha 0.5;
sleep 0.1;
_objective1 setMarkerSize [150, 150];
_objective1 setMarkerAlpha 0.6;
sleep 0.1;
_objective1 setMarkerSize [250, 250];
sleep 0.1;
_objective1 setMarkerSize [450, 450];
sleep 3;

// Patrol Stage Core 
deleteMarker "missionCore"; 
_base = createMarker ["missionCore", _objPos];
_base setMarkerShape "ELLIPSE";
_base setMarkerColor "ColorRed";
_base setMarkerSize [10, 10];
_base setMarkerAlpha 0.3;
sleep 0.1;
_base setMarkerSize [20, 20];
_base setMarkerAlpha 0.4;
sleep 0.1;
_base setMarkerSize [30,30];
_base setMarkerAlpha 0.5;
sleep 0.1;
_base setMarkerSize [40, 40];
_base setMarkerAlpha 0.6;
sleep 0.1;
_base setMarkerSize [50, 50];
_base setMarkerAlpha 0.7;
sleep 1;

// add icon 
deleteMarker "attackPoint"; 
_tempMarker = createMarker ["attackPoint", _objPos];
_tempMarker setMarkerType "hd_objective";
_tempMarker setMarkerColor "ColorRed";

sleep 0.5;

// generate path marker/lines between marker points 
// generate random number and make into string 
_float = diag_tickTime;
_float2 = random 10000;
_uniqueStamp = [_float, _float2];
_stampToString = str _uniqueStamp;
// calculate line data 
_reldirX = _initStartPos getDir _objPos;
_relDir = floor _relDirX;
_distX = _initStartPos distance _objPos;
_dist = floor _distX;
_dist2 = _dist / 2;
_testPos = _initStartPos getPos [_dist2, _relDirX];

// create line map element 
_lineTest = createMarker [_stampToString, _testPos];
_lineTest setMarkerShape "RECTANGLE";
_lineTest setMarkerColor "ColorBlack";
_lineTest setMarkerDir _reldirX;
_lineTest setMarkerSize [2, _dist2];
// to enable a colour change when the chain breaks, these lines need to be pushed back into an array 

// classes 
_endGameVics = [
	"O_R_APC_Wheeled_02_rcws_v2_F",
	"O_R_MRAP_02_hmg_F",
	"O_R_MRAP_02_gmg_F",
	"O_R_MBT_04_cannon_F"
];

_endGameTargetClasses = [
	"O_R_Truck_03_fuel_F",
	"O_R_Truck_03_repair_F",
	"O_R_Truck_02_Ammo_F",
	"O_R_Truck_02_F",
	"O_R_Truck_02_cargo_F",
	"O_R_Truck_03_ammo_F",
	"O_R_Radar_System_02_F"
];

_endGameTurrets = [
	"O_R_Static_AT_F",
	"O_R_SAM_System_04_F",
	"O_R_Mortar_01_F",
	"O_R_GMG_01_A_F",
	"O_R_GMG_01_F",
	"O_R_HMG_01_high_F"
];

_assaultSquad = [
	"O_R_Soldier_SL_F",
	"O_R_RadioOperator_F",
	"O_R_Soldier_LAT_F",
	"O_R_soldier_M_F",
	"O_R_Soldier_TL_F",
	"O_R_Soldier_AR_F",
	"O_R_Soldier_A_F",
	"O_R_medic_F"
];

sleep 2;

// generate defending opfor 
_diffLevel = 2; // diff modifier i.e. number of iterations 

for "_i" from 1 to _diffLevel do {
	_grp = createGroup [east, true];
	_rndOp1 = selectRandom [0, 3, 4, 5, 6];
	systemchat format ["1st wave: %1", _rndOp1];

	for "_i" from 1 to _rndOp1 do {
		_rndtype = selectRandom _assaultSquad;
		_pos = [_objPos, 50, 80] call BIS_fnc_findSafePos; // was 30, now 80, now 150 hopefully for better dispertion // now back to 30
		_unit = _grp createUnit [_rndtype, _pos, [], 1, "none"]; 
		_unit setBehaviour "COMBAT";
		_unit doMove _initStartPos; 
		// spawnedOpforUnit = spawnedOpforUnit + 1;
		sleep 1;						
	};
};

sleep 1;

_rndOp1 = 24;
_grp = createGroup [east, true];

for "_i" from 1 to _rndOp1 do {
	_rndtype = selectRandom _assaultSquad;
	_pos = [_objPos, 100, 150] call BIS_fnc_findSafePos;
	_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
	_randomDir = selectRandom [270, 290, 01, 30, 90];
	_randomDist = random [5, 25, 50]; 
	_endPoint = _objPos getPos [_randomDist, _randomDir];
	_unit setBehaviour "COMBAT";
 	sleep 1;									
};

sleep 2;

for "_i" from 1 to 3 do {
	// create vics 	
	_pos = [_objPos, 100, 150] call BIS_fnc_findSafePos;
	_vic = selectRandom	_endGameVics;	
	_opforVic = [_pos, 180, _vic, east] call BIS_fnc_spawnVehicle;	
	sleep 1;			
};

sleep 2;

for "_i" from 1 to 8 do {
	// create trucks 
	// todo - change direction
	_pos = [_objPos, 100, 150] call BIS_fnc_findSafePos;
	_vic = selectRandom	_endGameTargetClasses;	
	_opforVic = [_pos, 180, _vic, east] call BIS_fnc_spawnVehicle;
	sleep 1;								
};

for "_i" from 1 to 4 do {
	[_objPos] execVM "killchain\systems\spawnerSystems\spawnEnemyStatics.sqf";  								
};

for "_i" from 1 to 4 do {
	[_objPos] execVM "killchain\systems\spawnerSystems\spawnEnemyMortars.sqf";  								
};

// attack point stage -------------------------------------------------------------------------------
systemChat "RFCHECK starting";

RFCHECK = true; 

while {RFCHECK} do {

	// flybys 
	[_objPos] execVM "killchain\systems\ambientSystems\randomFlybys.sqf";

	// total numbers 
	_indi = independent countSide allUnits;
	_east = east countSide allUnits;

	// get overall numbers of troops in redzone 
	_unitsRedzone = allUnits inAreaArray "redzone";
	
	// get overall numbers of troops in obj core area 
	_unitsCore = allUnits inAreaArray "missionCore";

	// Redzone stats 
	_redzoneIndi = 0;
	_redzoneOpfor = 0;
	{
		switch ((side _x)) do
		{
			case INDEPENDENT: {_redzoneIndi = _redzoneIndi + 1};
			case EAST: {_redzoneOpfor = _redzoneOpfor + 1};
		};
	} forEach _unitsRedzone;

	// Core stats 
	_coreIndi = 0;
	_coreOpfor = 0;
	{
		switch ((side _x)) do
		{
			case INDEPENDENT: {_coreIndi = _coreIndi + 1};
			case EAST: {_coreOpfor = _coreOpfor + 1};
		};
	} forEach _unitsCore;

	// debug stats 
	systemChat "RFCHECK1 - FINAL STAGE";
	systemChat format ["TOTAL INDI: %1", _indi];
	systemChat format ["TOTAL OPFOR: %1", _east];
	systemChat ".....";
	systemChat format ["REDZONE INDI: %1", _redzoneIndi];
	systemChat format ["REDZONE OPFR: %1", _redzoneOpfor];
	systemChat ".....";
	systemChat format ["CORE INDI:    %1", _coreIndi];
	systemChat format ["CORE OPFR:    %1", _coreOpfor];

	// rf check 
	if (_redzoneIndi <= 10) then {
		// this will check before churning out new reinforcement units 
		[_initStartPos, _objPos] execVM "killChain\systems\reinforcementSystems\indiforRf.sqf";
	};

	// check if won point - must kill all in core to win 
	if ((_coreOpfor < 1) && (_coreIndi >=3)) then {
		systemChat "LOGIC - (_coreOpfor < 1) && (_coreIndi >=3)";
		// move indi units to a rough defensive position around the center point - note will also attrack any opfor strags 
		{
			_dir = random 360;
			_dist = selectRandom [14, 16, 18, 20, 22, 24, 30]; 
			_defendPoint = _objPos getPos [_dist, _dir]; // moves units into a rough 360 defensive circle
			_x setBehaviour "COMBAT";
			_x doMove _defendPoint;
			sleep 1;
		} forEach _unitsCore;
		RFCHECK = false;
	} else {
		// insurance move order while in attack mode 
		systemChat "LOGIC - initiate insurance move order";
		[_objPos] execVM "killChain\systems\insuranceSystems\indiforMovement.sqf";
	};

	sleep 60;
};

// consider using a cycle system to track how long this has been running 
// i.e. a timer - if too long, then paradrop more opfor in 

/*
here we now want to bring in final QRF wave - BUT send them directly to player positions 

create wave 1 from random direction - send into player pos (HK system)
wait 2 mins, bring second wave in, then same again - 3 in total 
include mil-technicals 
*/


// pop phase-change smoke to celebrate 
_smoke = createVehicle ["G_40mm_smokeYELLOW", _objPos, [], 0, "none"]; // drop this from up high 
_smoke = createVehicle ["G_40mm_smokeRed", _objPos, [], 0, "none"]; // drop this from up high 
_smoke = createVehicle ["G_40mm_smokeBlue", _objPos, [], 0, "none"]; // drop this from up high 
deleteMarker "attackPoint";
deleteMarker "Point 1"; 

// time for prizes and healing 

if (!BESILENT) then {
	// voice broadcast to formalise success 
	execVM "media\sounds\thisIsCommand.sqf";
	sleep 2;
	execVM "media\sounds\success.sqf";		
};

// cleanup
[_objPos] execVM "killchain\systems\cleanUpSystems\cleanUp.sqf";

// win marker 
_float = diag_tickTime;
_stampToString = str _float;
_tempBase = createMarker [_stampToString, _objPos];
_tempBase setMarkerShape "ELLIPSE";
_tempBase setMarkerSize [30, 30];
_tempBase setMarkerAlpha 0.8;
_tempBase setMarkerColor "colorBlue";

// init Point 1 Obj  
[] execVM "killChain\mission\rtb.sqf";
hint "R-T-B";
