/*
This system runs the indifor-player-led gametype 
*/

// cycle-bools declared 
RFCHECK = false;
RFCHECK2 = false;

// key positions declared 
_initStartPos = _this select 0; // starting point for any new mission
_objPos = _this select 1; // objective point for any new mission 
systemChat format ["debug - Patrol Points Taken: %1", patrolPointsTaken];

// this was used to track side-missions and can be linked to prgression states, but as we don't have any side missions right now this is set to TRUE by default - we may bring these back in future, for now just ignore 
RGG_sideMissionCompleted = true;

// burning vics
[] spawn RGGa_fnc_ambient_burningVics;
// [] spawn RGGc_fnc_count_depleteSupplies; 
// systemChat "debug - have just spawned ambiVics";
/*
15 June 2021 
To-Do: decide how to better create ambient smokes and fires 
*/

// roamers - randoms created in the AO and sent around the area 
[_objPos, _initStartPos] execVM "killchain\systems\randomThreatSystems\randomThreats.sqf";


// ----- MARKERS -----
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
_objective1 setMarkerSize [550, 550];
sleep 0.1;
_objective1 setMarkerSize [1850, 1850];
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
_base setMarkerSize [30, 30];
_base setMarkerAlpha 0.5;
sleep 0.1;
_base setMarkerSize [40, 40];
_base setMarkerAlpha 0.6;
sleep 0.1;
_base setMarkerSize [60, 60];
_base setMarkerAlpha 0.7;

// add icon 
deleteMarker "attackPoint";  
_tempMarker = createMarker ["attackPoint", _objPos];
_tempMarker setMarkerType "hd_objective";
_tempMarker setMarkerColor "ColorRed";
_tempMarker setMarkerAlpha 0.3;
sleep 0.1;
_tempMarker setMarkerAlpha 0.4;
sleep 0.1;
_tempMarker setMarkerAlpha 0.5;
sleep 0.1;
_tempMarker setMarkerAlpha 0.6;
sleep 0.1;
_tempMarker setMarkerAlpha 0.7;
sleep 1;
_tempMarker setMarkerAlpha 0.1;
sleep 1;
_tempMarker setMarkerAlpha 0.7;
sleep 1;
_tempMarker setMarkerAlpha 0.1;
sleep 1;
_tempMarker setMarkerAlpha 0.7;
sleep 1;
_tempMarker setMarkerAlpha 0.1;
sleep 1;
_tempMarker setMarkerAlpha 0.7;

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
// systemChat "debug - markers done"; 


// ----- CAMPSITE STUFF -----
// new camp location and items 
_randomCampLocation = _objPos findEmptyPosition [1,100,"B_Quadbike_01_F"]; // find a space 
_RGG_CampItems = [];
_random5 = random 5;
_random3 = random 3;

// barrels and other camp stuff 
for "_i" from 1 to 3 do {
	_randomDir = random 359;
	_random25 = random 25;
	_spawnPos = _randomCampLocation getPos [_random3, _randomDir];
	_campItem = selectRandom [
		"Land_vn_o_shelter_03",
		"Land_vn_o_wallfoliage_01",
		"Land_vn_o_tower_02",
		"Land_vn_o_shelter_02",
		"Land_vn_o_platform_05",
		"Land_vn_o_prop_cong_cage_03",
		"Land_vn_camonetb_east"
	];
	_campItem2 = createVehicle [_campItem, _spawnPos];
	_campItem2 setDir _randomDir;
	_RGG_CampItems pushback _campItem2;
};

// crates 
// for "_i" from 1 to _random5 do {
// 	_randomDir = random 359;
// 	_random5 = random 5;
// 	_random25 = random 25;
// 	_spawnPos = _randomCampLocation getPos [_random5, _randomDir];
// 	_campItem = selectRandom [
// 		"Land_WoodenCrate_01_stack_x3_F",
// 		"Weapon_launch_O_Vorona_brown_F",
// 		"Box_T_East_Wps_F",
// 		"Box_East_AmmoOrd_F",
// 		"Box_East_WpsLaunch_F",
// 		"Land_CratesWooden_F",
// 		"Land_Pallet_MilBoxes_F",
// 		"Land_MetalBarrel_F",
// 		"Land_WaterTank_F"
// 	];
// 	_campItem2 = createVehicle [_campItem, _spawnPos];
// 	_campItem2 setDir _randomDir;
// 	_RGG_CampItems pushback _campItem2;
// };

// intel item 
// _randomDir = random 359;
// _random5 = random 5;
// _random25 = random 25;
// _spawnPos = _randomCampLocation getPos [_random5, _randomDir];
// _campItem = createVehicle ["SatelliteAntenna_01_Sand_F", _spawnPos];
// _campItem setDir _randomDir;
// _RGG_CampItems pushback _campItem;
/*
Taking this out until I can work out how to best manage ammo destroy actions to make that action critical to progression 
[_campItem] execVM "killchain\systems\intelSystems\enemyIntel.sqf";
*/

// systemChat "debug - Campsite made";

sleep 2;

// generate defending opfor 
_diffLevel = 2; // diff modifier i.e. number of iterations // tbc add patrolPoint accelerator 

for "_i" from 1 to _diffLevel do {
	_grp = createGroup [east, true];
	_rndOp1 = selectRandom [10, 15];
	systemchat format ["debug - 1st wave: %1", _rndOp1];

	for "_i" from 1 to _rndOp1 do {
		_rndtype = selectRandom [
			"vn_o_men_nva_01",
			"vn_o_men_nva_02",
			"vn_o_men_nva_03",
			"vn_o_men_nva_04",
			"vn_o_men_nva_05",
			"vn_o_men_nva_06",
			"vn_o_men_nva_07",
			"vn_o_men_nva_08",
			"vn_o_men_nva_09",
			"vn_o_men_nva_10",
			"vn_o_men_nva_11",
			"vn_o_men_nva_12"
		];
		_pos = [_objPos, 0, 30] call BIS_fnc_findSafePos; // was 30, now 80, now 150 hopefully for better dispertion // now back to 30
		_unit = _grp createUnit [_rndtype, _pos, [], 1, "none"]; 
		_unit setBehaviour "COMBAT";
		_unit doMove _initStartPos; 
		
		tinmanModule addCuratorEditableObjects [[_unit], true];
		bluforZeus addCuratorEditableObjects [[_unit], true];
		// spawnedOpforUnit = spawnedOpforUnit + 1;
		sleep 2;						
	};
};
systemChat "debug - opfor welcome party done";

sleep 1;

_opforClass = [
	"vn_o_men_nva_01",
	"vn_o_men_nva_02",
	"vn_o_men_nva_03",
	"vn_o_men_nva_04",
	"vn_o_men_nva_05",
	"vn_o_men_nva_06",
	"vn_o_men_nva_07",
	"vn_o_men_nva_08",
	"vn_o_men_nva_09",
	"vn_o_men_nva_10",
	"vn_o_men_nva_11",
	"vn_o_men_nva_12"
];

_rndOp1 = selectRandom [20];
_grp = createGroup [east, true];
systemchat format ["debug - opfor camp defence: %1", _rndOp1]; // debug 

for "_i" from 1 to _rndOp1 do {
	_rndtype = selectRandom _opforClass;
	_pos = [_objPos, 0, 40] call BIS_fnc_findSafePos;
	_unit = _grp createUnit [_rndtype, _pos, [], 30, "none"]; 
	_randomDir = selectRandom [270, 290, 01, 30, 90];
	_randomDist = random [5, 25, 50]; 
	_endPoint = _objPos getPos [_randomDist, _randomDir];
	_unit setBehaviour "COMBAT";
	_unit doMove _endPoint;
	
	tinmanModule addCuratorEditableObjects [[_unit], true];
	bluforZeus addCuratorEditableObjects [[_unit], true];
	// spawnedOpforUnit = spawnedOpforUnit +1;
 	sleep 1;									
};

// statics

_random = selectRandom [2,3,4,5];
for "_i" from 1 to _random do {
	[_objPos] execVM "killchain\systems\spawnerSystems\spawnEnemyStatics.sqf";  								
};

_random = selectRandom [0,1,2,3];
for "_i" from 1 to _random do {
	[_objPos] execVM "killchain\systems\spawnerSystems\spawnEnemyMortars.sqf";  								
};



// if (patrolPointsTaken > 1) then {
// 	_random = selectRandom [2,3];
// 	for "_i" from 1 to _random do {
// 		[_objPos] execVM "killchain\systems\spawnerSystems\spawnEnemyStatics.sqf";  								
// 	};
// };

// if (patrolPointsTaken > 2) then {
// 	_random = selectRandom [2,3];
// 	for "_i" from 1 to _random do {
// 		[_objPos] execVM "killchain\systems\spawnerSystems\spawnEnemyMortars.sqf";  								
// 	};
// };

systemChat "debug - opfor defenders done";

sleep 2;

// attack point stage -------------------------------------------------------------------------------
systemChat "RFCHECK starting";

RFCHECK = true; 

// [_initStartPos, _objPos] execVM "killChain\systems\insuranceSystems\indiforMovementAlt.sqf"; // this will push units to player pos and retreat them if no playher near
// this used to be on every cycle, we've now split this out into a separate file, in case we want to tweak this outside of the main RFCHECK loop 
// turning off for now to check if radio orders work 

while {RFCHECK} do {

	// cycle debug 
	systemChat "Cycle - RFCHECK";

	// flybys 
	[_objPos] execVM "killchain\systems\ambientSystems\randomFlybys.sqf";
	// execVM "killchain\systems\ambientSystems\flares.sqf";
	[_objPos] execVM "killchain\systems\ambientSystems\mortars.sqf";

	/*
	BIRDDOG TEMP 
	*/

	// _origin = getPos _player;
	// _origin set [2, 400];
	// [_group, _origin, 300, "LOITER", "AWARE", "YELLOW", "LIMITED"] call CBA_fnc_addWaypoint;

	/*
	BIRDDOG TEMP 
	*/

	/*
	15 June 2021 
	To-do: set up this count as a function!!!
	*/

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
	systemChat "RFCHECK1";
	systemChat format ["TOTAL INDI: %1", _indi];
	systemChat format ["TOTAL OPFOR: %1", _east];
	systemChat ".....";
	systemChat format ["REDZONE INDI: %1", _redzoneIndi];
	systemChat format ["REDZONE OPFR: %1", _redzoneOpfor];
	systemChat ".....";
	systemChat format ["CORE INDI:    %1", _coreIndi];
	systemChat format ["CORE OPFR:    %1", _coreOpfor];

	// format ["ARVN Units in AO: %1", _redzoneIndi] remoteExec ["systemChat", 0];
	
	// check if won point and if so, move to defend state 
	if ((_coreOpfor <= 2) && (_coreIndi >=3)) then {
		systemChat "LOGIC - POINT IS WON - indifor in core is 3+ and opfor is 3-";
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
	};

	sleep 120;
};

// at what stage should these initial defenders retreat?

// pop phase-change smoke 
_smoke = createVehicle ["G_40mm_smokeYELLOW", _objPos, [], 0, "none"]; 

if (!BESILENT) then {
	// voice broadcast - prepare for retalliation 
	execVM "media\sounds\thisIsCommand.sqf";
	sleep 2;
	execVM "media\sounds\prepare.sqf";
};

// change marker colour to signify change from attack to defend - consider changing marker type (image) here 
deleteMarker "attackPoint";
_tempMarker = createMarker ["attackPoint", _objPos];
_tempMarker setMarkerType "hd_objective";
_tempMarker setMarkerColor "ColorGreen";

sleep 3;

//---------------------------------------------------------------------------------------------------------
// Roamers 
// [_objPos, _initStartPos] execVM "killchain\systems\randomThreatSystems\randomThreats.sqf";
// systemChat "Roamers created";
/*
15 June 2021 - I have removed this ^^ as there should only really be one patrol per cycle - to be tested! 
*/
// note - is the above correct? should they be the other way round??
// TO DO - MAKE ROAMERSaLT ALWAYS GO TO PLAYER INDI 
// or, random point in redzone 

//---------------------------------------------------------------------------------------------------------
// QFR Here 
systemChat "debug - QRF initiated";

// point 1 rules 
// only one direction of attack 
// medium numbers, two waves 
// set a timer for progrssion regardless _objPos

// _mainAnchor = RGG_PatrolPoints select 1;
// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos; 

// this switch will determine the next available point - qrf comes from this direction 
private ["_mainAnchor"];
switch (patrolPointsTaken) do {
	case (0): { _mainAnchor = RGG_PatrolPoints select 1 };
	case (1): { _mainAnchor = RGG_PatrolPoints select 2 };
	case (2): { _mainAnchor = RGG_PatrolPoints select 3 };
	case (3): { _mainAnchor = RGG_PatrolPoints select 4 };
	case (4): { _mainAnchor = RGG_PatrolPoints select 5 };
	case (5): { _mainAnchor = RGG_PatrolPoints select 6 };
	default { systemChat "error Patrol Point switch" };
};
// from the above we know where the QRF anchor is - now we need to generate a new calc for each batch of QRF 
// each QRF team will either be on the anchor, or rel 290 or rel 110 - not quite rel East or West, 

// for each team, select random 3 - then switch the results 
_anchorSelection = selectRandom [1,2,3];
private ["_anchor1"];
switch (_anchorSelection) do {
	case (1): { _anchor1 = _mainAnchor };
	case (2): { _anchor1 = [_mainAnchor, 300, 240] call BIS_fnc_relPos };
	case (3): { _anchor1 = [_mainAnchor, 300, 130] call BIS_fnc_relPos };
	default { systemChat "error: _anchorSelection" };
};
_qrfAnchor = [_anchor1, 10, 150] call BIS_fnc_findSafePos; 
// this gives us one of three positions - roughly in line but could be ahead, ahead left or ahead right relative to last taken point 

// technicals 
// [_qrfAnchor, _objPos] execVM "killChain\systems\spawnerSystems\spawnTechnicals.sqf";
// systemChat "debug - Technical created";
// removed techs 

// unit creation 
for "_i" from 1 to 2 do {

	systemChat "debug - creating QRF here";

	_anchorSelection = selectRandom [1,2,3];
	private ["_anchor1"];
	switch (_anchorSelection) do {
		case (1): { _anchor1 = _mainAnchor };
		case (2): { _anchor1 = [_mainAnchor, 100, 240] call BIS_fnc_relPos };
		case (3): { _anchor1 = [_mainAnchor, 300, 130] call BIS_fnc_relPos };
		default { systemChat "error: _anchorSelection" };
	};
	_qrfAnchor = [_anchor1, 10, 150] call BIS_fnc_findSafePos;

	// delete when we know this works 
	deleteMarker "Point 1"; 
	_objective1 = createMarker ["Point 1", _qrfAnchor];
	_objective1 setMarkerShape "ELLIPSE";
	// _objective1 setMarkerColor "ColorRed";
	_objective1 setMarkerSize [50, 50];
	_objective1 setMarkerAlpha 0.1;

	for "_i" from 1 to 4 do {
		_opforGroup = createGroup [east, true];
		_anchor1a = [_anchor1, 1, 50, 3, 0] call BIS_fnc_findSafePos;
		_opforTeam = [];

		for "_i" from 1 to 5 do {
			_unit = selectRandom _opforClass;
			_unit1 = _opforGroup createUnit [_unit, _anchor1a, [], 0.1, "none"];
			_opforTeam pushBack _unit1;
		};
		tinmanModule addCuratorEditableObjects [_opforTeam, true];
		bluforZeus addCuratorEditableObjects [_opforTeam, true];
		sleep 0.7;

		// move orders 
		_ranDist = random 100;
		_ranDir = random 359;
		_unitDest = _objPos getPos [_ranDist, _ranDir];
		_opforTeam doMove _unitDest;
	};

	sleep 5;
};

// here we add more incoming if later on in mission 
if (patrolPointsTaken > 2) then {
	// unit creation 
	sleep 120;
	for "_i" from 1 to 2 do {
		for "_i" from 1 to 6 do {
			_opforGroup = createGroup [east, true];
			_anchor1a = [_qrfAnchor, 1, 50, 3, 0] call BIS_fnc_findSafePos;
			_opforTeam = [];

			for "_i" from 1 to 2 do {
				_unit = selectRandom _opforClass;
				_unit1 = _opforGroup createUnit [_unit, _qrfAnchor, [], 0.1, "none"];
				_opforTeam pushBack _unit1;
			};
			tinmanModule addCuratorEditableObjects [_opforTeam, true];
			bluforZeus addCuratorEditableObjects [_opforTeam, true];
			sleep 0.7;

			// move orders 
			_ranDist = random 100;
			_ranDir = random 359;
			_unitDest = _objPos getPos [_ranDist, _ranDir];
			_opforTeam doMove _unitDest;
		};
	};
};

// deleteMarker "Point 1"; // untested

// defend point stage -------------------------------------------------------------------------------
_cycles = 0;

systemChat "RFCHECK2 starting";

RFCHECK2 = true; 

while {RFCHECK2} do {

	/*
	BIRDDOG TEMP 
	*/

	_origin = getPos _player;
	_anchorPos = _origin getPos [400, 0];
	[_group, _origin, 300, "LOITER", "AWARE", "YELLOW", "LIMITED"] call CBA_fnc_addWaypoint;

	/*
	BIRDDOG TEMP 
	*/


	// flybys and flares (for their attack)
	[_objPos] execVM "killchain\systems\ambientSystems\randomFlybys.sqf";
	// execVM "killchain\systems\ambientSystems\flares.sqf";
		
	// total numbers 
	_indi = independent countSide allUnits;
	_east = east countSide allUnits;
	// RGGEAST = east countside allUnits; hint str RGGEAST;

	// get overall numbers of troops in redzone 
	_unitsRedzone = allUnits inAreaArray "redzone";

	// get overall numbers of troops in obj core area 
	_unitsCore = allUnits inAreaArray "missionCore";

	// check indi and opfor numbers in redzone 
	_redzoneIndi = 0;
	_redzoneOpfor = 0; 
	{
		switch ((side _x)) do
		{
			case EAST: {_redzoneOpfor = _redzoneOpfor + 1};
			case INDEPENDENT: {_redzoneIndi = _redzoneIndi + 1};
		};
	} forEach _unitsRedzone;

	// check indi and opfpr numbers in core  
	_coreIndi = 0;
	_coreOpfor = 0;
	{
		switch ((side _x)) do
		{
			case EAST: {_coreOpfor = _coreOpfor + 1};
			case INDEPENDENT: {_coreIndi = _coreIndi + 1};
		};
	} forEach _unitsCore;

	// debug stats 
	systemChat "RFCHECK2";
	systemChat format ["TOTAL INDI: %1", _indi];
	systemChat format ["TOTAL OPFOR: %1", _east];
	systemChat ".....";
	systemChat format ["REDZONE INDI: %1", _redzoneIndi];
	systemChat format ["REDZONE OPFR: %1", _redzoneOpfor];
	systemChat ".....";
	systemChat format ["CORE INDI:    %1", _coreIndi];
	systemChat format ["CORE OPFR:    %1", _coreOpfor];

	format ["ARVN Units in AO: %1", _redzoneIndi] remoteExec ["systemChat", 0];

	if ((_cycles >= 5) && (_coreIndi > 3) && (_redzoneOpfor < 5) && (_east < 20)) then {
		// progress mission based mainly on cycles but also needs indi on point and low numbers of opfor in redzone 
		RFCHECK2 = false;
		systemChat "(_cycles >= 5) && (_coreIndi > 3) && (_redzoneOpfor < 5)";
		systemChat "auto-cycle-push";
	} else {
		_cycles = _cycles + 1;
		systemChat format ["Defence Cycles: %1", _cycles];

		// // ORDER RF HERE IF NEEDED 
		// if ((_redzoneIndi <= 8) && (_indi < 20)) then {
		// 	systemChat "note _redzoneIndi <= 5 - RF ordered while in defend state ";
			
		// 	[_initStartPos, _objPos] execVM "killChain\systems\spawnerSystems\createIndiforRFUnits.sqf";
		// 	// _smoke = createVehicle ["G_40mm_smokeYELLOW", _initStartPos, [], 0, "none"]; // drop this from up high 
		// 	// removing, as this is also done in a different script - but here it will always be at the last taken patrol (origin) point  
		// 	// so might be popping yellow even if RF are coming from point one further back 

		// 	// voice broadcasts
		// 	// execVM "media\sounds\thisIsCommand.sqf";
		// 	// sleep 3;
		// 	// execVM "media\sounds\rfInbound.sqf";
		// };

		// OPFOR to push forward as a group if they took back control of point and there is no indifor on it 
		if ((_coreIndi < 1) && (_redzoneOpfor > 25) && (_coreOpfor > 20)) then {
			// hint "THEY ARE RUSHING! PREPARE YOUR DEFENSES!!";
			"NVA FORCES HAVE WON BACK THE PATROL POINT AND ARE NOW ADVANCING ONTO THE PREVIOUS POINT- YOU NEED TO STOP THEM NOW!" remoteExec ["hint", 0, true];	
			{
				_randomDir = selectRandom [270, 310, 00, 50, 90];
				_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
				_endPoint1 = _initStartPos getPos [_randomDist,_randomDir];
				sleep 2;
				_x setBehaviour "COMBAT";
				_x doMove _endPoint1;
			} forEach _unitsRedzone;
		};
		// this system is a proof of concept for a bigger more push/pull scenario 

		// STAGE WIN LOGIC 
		if ((_coreOpfor < 1) && (_coreIndi >=7) && (_redzoneOpfor < 10) && (_east < 10) && (RGG_sideMissionCompleted)) then {
			systemChat "(_coreOpfor < 1) && (_coreIndi >=7) && (_redzoneOpfor < 10) && (_east < 10)";
			systemChat "defence successful - take a breather... get heals and ammo, and get ready for next assault";
			systemChat "also - side mission done yay";
			// regroup, healup and get prizes
			RFCHECK2 = false;
		};
	};

	// // insurance move order while in attack mode 
	// systemChat "LOGIC - initiate insurance move order";
	// [_objPos] execVM "killChain\systems\insuranceSystems\indiforMovement.sqf";

	sleep 120;
};

// time for prizes and healing --------------------------------------------------------------------------------- 

// voice broadcast to formalise success
if (!BESILENT) then { 
	execVM "media\sounds\thisIsCommand.sqf";
	sleep 2;
	execVM "media\sounds\success.sqf";		
};

// delete existing camp 
// { deleteVehicle _x } forEach RGG_CampItems;
[_RGG_CampItems] execVM "killchain\systems\cleanUpSystems\deleteCampItems.sqf";


_RGG_CampItems = [];
// this should be removed only when no players are near 
// also means we can loot for intel 

// BASE REWARDS HERE :)

// create medic tent 
_buildLocation = _objPos findEmptyPosition [10,100,"B_Heli_Light_01_dynamicLoadout_F"]; 
_flrObj = "F_20mm_Red" createvehicle _buildLocation;
sleep 5;
_baseBuilding1 = createVehicle ["Land_vn_tent_mash_02_04", _buildLocation, [], 30, "none"]; 

// // marker for tent 
// _objective1 = createMarker ["_buildLocation", _buildLocation];
// _objective1 setMarkerShape "ELLIPSE";
// _objective1 setMarkerColor "ColorRed";
// _objective1 setMarkerSize [5, 5];
// sleep 1;

// // create ammo box 
// _fobPos = _buildLocation findEmptyPosition [10,100,"B_Heli_Light_01_dynamicLoadout_F"]; 
// _flrObj = "F_20mm_Red" createvehicle _fobPos;
// sleep 5;
// _fobPos1 = createVehicle ["vn_o_ammobox_full_08 (ammo1)", _fobPos]; 
// [ "AmmoboxInit", [_fobPos1, true, {true}] ] call BIS_fnc_arsenal;

// // marker for ammo 
// _objective1 = createMarker ["_fobPos", _fobPos];
// _objective1 setMarkerShape "ELLIPSE";
// _objective1 setMarkerColor "ColorRed";
// _objective1 setMarkerSize [5, 5];
// sleep 1;

// // create repair container 
// _repairPos = _buildLocation findEmptyPosition [10,100,"B_Heli_Light_01_dynamicLoadout_F"]; 
// _flrObj = "F_20mm_Red" createvehicle _repairPos;
// sleep 5;
// _repairPos1 = createVehicle ["B_Slingload_01_Repair_F", _repairPos]; //vehicle repair 
// // marker for repair 
// _objective1 = createMarker ["_repairPos", _repairPos];
// _objective1 setMarkerShape "ELLIPSE";
// _objective1 setMarkerColor "ColorRed";
// _objective1 setMarkerSize [10, 10];
// _objective1 setMarkerAlpha 0.2;
// sleep 0.6;

// create vics and vic rewards 
// _vicLocation = _buildLocation findEmptyPosition [10,100,"B_Heli_Light_01_dynamicLoadout_F"];
// _quaddy = createVehicle ["I_G_Quadbike_01_F", _vicLocation]; // quad
// sleep 1;
// _vic = selectRandom [
// 	"I_G_Offroad_01_armed_F", 
// 	"I_C_Offroad_02_LMG_F", 
// 	"I_C_Offroad_02_LMG_F", 
// 	"B_LSV_01_armed_F"
// ];
// _rewardSpawn = createVehicle [_vic, _vicLocation]; // reward vic 

// _vicLocation = _buildLocation findEmptyPosition [10,100,"B_Heli_Light_01_dynamicLoadout_F"];
// ["vn_b_wheeled_m151_mg_03", _vicLocation] call RGGv_fnc_vehicle_quickTransport;
// sleep 1;
// ["vn_b_wheeled_m151_mg_03", _vicLocation] call RGGv_fnc_vehicle_quickTransport;
// // marker for vics 
// _objective1 = createMarker ["_vicLocation", _vicLocation];
// _objective1 setMarkerShape "ELLIPSE";
// _objective1 setMarkerColor "ColorRed";
// _objective1 setMarkerSize [5, 5];


/*
NOTE - the above should be replaced with better spawn fnc for vics 
*/

// to do - choose better patrol vics 

// ------------------------------------------------------------------------------------------------------------------

// create win marker 
_float = diag_tickTime;
_stampToString = str _float;

_tempBase = createMarker [_stampToString, _objPos];
_tempBase setMarkerShape "ELLIPSE";
_tempBase setMarkerSize [30, 30];
_tempBase setMarkerAlpha 0.8;
_tempBase setMarkerColor "colorBlue";

/*
start of spawn removal 
*/
// // create respawn points 
// _bluforSpawn = _fobPos1 getPos [2,0];
// _indiSpawn = _objPos getPos [40,270];
// RGG_respawnStore pushBack [_bluforSpawn, _indiSpawn]; // sending to global array to enable deleting of older respawns 

// // define right name for spawn point  
// private ["_spawnPointName"];
// switch (patrolPointsTaken) do {
// 	case 0: { _spawnPointName = "ALPHA" };
// 	case 1: { _spawnPointName = "BRAVO" };
// 	case 2: { _spawnPointName = "CHARLIE" };
// 	case 3: { _spawnPointName = "DELTA" };
// 	case 4: { _spawnPointName = "ECHO" };
// 	case 5: { _spawnPointName = "FOXTROT" };
// 	default { systemChat "error: Patrol Point switch" };
// };
// [west, _bluforSpawn, _spawnPointName] call BIS_fnc_addRespawnPosition; // create blu resapwn
// // [independent, _indiSpawn, "GENERIC INDI RESPAWN POINT"] call BIS_fnc_addRespawnPosition; // create ind resapwn
/*
end of spawn removal 
*/

// _cnt = count RGG_respawnStore; // check if more than one, i.e. don't process this is we only have one (1st) point 
// if (_cnt >1) then {
// 	_removeSpawns = RGG_respawnStore select 0;
// 	_removeBluSpawn = _removeSpawns select 0;
// 	_removeIndSpawn = _removeSpawns select 1;
// 	[west, _removeBluSpawn] callBIS_fnc_removeRespawnPosition
// 	[independent, _removeIndSpawn] callBIS_fnc_removeRespawnPosition
// 	RGG_respawnStore deleteAt 0;
// };

// // NEW - adding checker for players 
// "You have two minutes to get 50m of the Patrol Point in order to hold progression..." remoteExec ["systemChat", 0, true];
// sleep 120;

// // PROXIMITY REGROUP SYSTEM 
// _pos1 = createMarker ["REGROUP", _objPos];
// _pos1 setMarkerShape "ELLIPSE";
// _pos1 setMarkerAlpha 0.3;
// _pos1 setMarkerSize [100, 100];

// _activateCheck = true;
// _anchorPos = getMarkerPos 'REGROUP';

// "progression / hold activated" remoteExec ["systemChat", 0, true];
// while {_activateCheck} do {
// 	sleep 10; // cycle frequency
// 	_dataStore = [];
// 	{
// 		_playerPos = getPos _x;
// 		_dist = _anchorPos distance _playerPos;

// 		if (_dist < 100) then {
// 			_dataStore pushback _x;
// 		};
// 	} forEach allPlayers;
// 	_cnt = count _dataStore;
// 	format ["Players near basecamp: %1", _cnt] remoteExec ["systemChat", 0];
// 	if (_cnt == 0) then {
// 		deleteMarker "REGROUP";
// 		_activateCheck = false;
// 		"progression / hold completed" remoteExec ["systemChat", 0, true];
// 		// format ["Debug - NOTE: _cnt == 0", _cnt] remoteExec ["systemChat", 0];
// 	};
// };



// NOW, PROGRESS PATROL 

// resume here ...
patrolPointsTaken = patrolPointsTaken +1;

// set up next obj 
_anchor = _objPos; // switcheroo 
// private ["_mainAnchor"]; // may not need this..?

// this switch repurposes the _objPos value with the next obj position 
switch (patrolPointsTaken) do {
	case 1: {
		_objPos = RGG_PatrolPoints select 1;
		systemChat "RUNNING PHASE 2";	
	};
	case 2: {
		_objPos = RGG_PatrolPoints select 2;
		systemChat "RUNNING PHASE 3";	
	};
	case 3: {
		_objPos = RGG_PatrolPoints select 3;
		systemChat "RUNNING PHASE 4 - FINAL";	
	};
	// case 4: {
	// 	_objPos = RGG_PatrolPoints select 4;
	// 	systemChat "RUNNING PHASE 5";	
	// };
	// case 5: {
	// 	_objPos = RGG_PatrolPoints select 5;
	// 	systemChat "RUNNING PHASE 6";	
	// };
	// case 6: {
	// 	_objPos = RGG_PatrolPoints select 6;
	// 	systemChat "RUNNING ENDGAME";	
	// };
	default {
		systemChat "error: Patrol Point switch";
	};
};




// catchall opfor move at end of cycle - might lead to pincer attacks unexpectedly ;)
_opfor = [];

{
	if ((side _x) == EAST) then {_opfor pushBack _x};
} forEach allUnits;

{
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_endPoint1 = _objPos getPos [_randomDist,_randomDir];
	sleep 2;
	_x setBehaviour "COMBAT";
	_x doMove _endPoint1;
} forEach _opfor;

// cleanup
{ deleteVehicle _x } forEach allDead;
systemChat "RUNNING CLEANUP - check works from Cycle Script ";


// determine whether another camp obj or final obj 
// if (patrolPointsTaken <= 5) then {
if (patrolPointsTaken <= 4) then {
	[_anchor, _objPos] execVM "killChain\mission\patrolCycleAlt.sqf";	 // here HERE DO THIS !!
} else {
	// 4th point is end point 
	// systemChat "triggering END STATE";
	// [_anchor, _objPos] execVM "killChain\mission\patrolFinalAlt.sqf";	
};

