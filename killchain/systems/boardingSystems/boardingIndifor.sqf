/* 
this script will be triggered when players land in a specific PZ
it will check:
- is it the correct heli type (named asset)?
- how many spaces should it have?
- how many spaces does it actually have?

It will then:
- generate (nearby) reinforcement assets, and have them board the heli 
- it will generate only the number needed, no more, and no less 
- number of RF will be dictated by overall indifor numbers, but will always be a full batch 
*/

// get heli type 
// we will use specific named assets for now - 

// crewCount = ["B_Heli_Transport_01_F", true] call BIS_fnc_crewCount;
// _list = fullCrew Chickenhawk1;
// systemChat format ["fullCrew of heli is: %1", _list];

// sleep 1;

// _cargo = [Chickenhawk1] spawn RGGc_fnc_count_heliSeats;
// systemChat format ["cargo check returns: %1", _cargo];
systemChat "boarding check activated";
// _boarding = true;
_passed = _this select 0;
systemChat format ["passed: %1", _passed];
sleep 1;

_pilot = _passed select 0;

_heli = vehicle _pilot;

_freeCargoPositions = _heli emptyPositions "cargo";
systemChat format ["_freeCargoPositions: %1", _freeCargoPositions];

[_freeCargoPositions, _heli] execVM "killchain\systems\boardingSystems\boardUnits.sqf"; 
CANBOARD = false;
sleep 60;
systemChat "boarding check re-activated";
CANBOARD = true;

// // spawn units 
// _spawn = [18631.7,8384.17,0.136719];
// _float = diag_tickTime;
// _stampToString = str _float;
// _stampToString = createGroup [independent, true];
// _stampToString setFormation "DIAMOND";


// for "_i" from 1 to _freeCargoPositions do {
// 	// if (_boarding) then {
// 		_unit = _stampToString createUnit ["vn_b_men_lrrp_08", _spawn, [], 0.1, "none"]; 
// 		_unit assignAsCargo Chickenhawk1;
// 		[_unit] orderGetIn true;
// 		sleep 2;
// 	// };
// };

// _stampToString move [19981.9,6542.16,0];

// if (CANBOARD) then {
// 	execVM "killchain\systems\boardingSystems\boardingIndifor.sqf";
// };

// for "_i" from 1 to 1 do {
// 	// bluGroup = createGroup west;
// 	_pos = [_spawnPos, 0, _area] call BIS_fnc_findSafePos;
// 	// _unit = bluGroup createUnit ["UK3CB_BAF_Officer_MTP", _pos, [], 0.1, "none"]; 
// 	_unit = _indiGroup createUnit ["I_officer_F", _pos, [], 0.1, "none"]; 
// 	sleep _timer;
// 	_randomDir = selectRandom [270, 310, 00, 50, 90];
// 	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
// 	_unitDest = [RGG_patrol_obj, 5, 20] call BIS_fnc_findSafePos;
// 	_endPoint1 = _unitDest getPos [_randomDist,_randomDir];
// 	_unit setBehaviour "COMBAT";
// 	_unit doMove _endPoint1;
// 	spawnedIndiUnit = spawnedIndiUnit +1;

// };








	// _units = allUnits inAreaArray "pz1";
	// _spawn = [19985.7,6514.54,0];
	// _unitCount1 = count _units;

	// if (_unitCount1 == 0) then {
	// 	_float = diag_tickTime;
	// 	_stampToString = str _float;
	// 	_stampToString = createGroup [west, true];
	// 	for "_i" from 1 to 1 do { 
	// 		"vn_b_men_lrrp_08" createUnit [_spawn, _stampToString]; 
	// 		sleep 0.1;
	// 	};
	// 	for "_i" from 1 to 1 do { 
	// 		"vn_b_men_lrrp_05" createUnit [_spawn, _stampToString]; 
	// 		sleep 0.1;
	// 	};
	// 	for "_i" from 1 to 1 do { 
	// 		"vn_b_men_lrrp_02" createUnit [_spawn, _stampToString]; 
	// 		sleep 0.1;
	// 	};
	// 	for "_i" from 1 to 1 do { 
	// 		"vn_b_men_lrrp_01" createUnit [_spawn, _stampToString];  
	// 		sleep 0.1;
	// 	};

	// 	_stampToString move [19981.9,6542.16,0];
	// 	_stampToString setFormation "DIAMOND";
		
	// 	systemChat "recon squaddies ready .............................................!";
	// };





// {
// 	if ((_x select 3) == true) then {
// 		// systemChat format ["Turret True: %1", _x];
// 		systemChat "test ok";
// 	};
// } forEach _list;

// {
// 	systemChat format ["unit: %1", _x select 0];
// 	systemChat format ["role: %1", _x select 1];
// 	systemChat format ["cargoIndex: %1", _x select 2];
// 	systemChat format ["turretPath: %1", _x select 3];
// 	systemChat format ["personTurret: %1", _x select 4];
// 	systemChat " ----- ";
// 	sleep 4;
// } forEach _list;

// {
// 	if (_x select 2 >= 0) then {
// 		systemChat " ----- ";
// 		systemChat "roles that are designated person turrets:";
// 		systemChat format ["unit: %1", _x select 0];
// 		systemChat format ["role: %1", _x select 1];
// 		systemChat format ["cargoIndex: %1", _x select 2];
// 		systemChat format ["turretPath: %1", _x select 3];
// 		systemChat format ["personTurret: %1", _x select 4];
// 		systemChat " ----- ";
// 	};
// 	sleep 2;
// } forEach _list;




/*
If you check a huey 1D with pilot / co-pilot / door gunner and crew chief (gunner), they all have a cargo index of -1 
Also, none of them are person turrets 
But, three of the four (excluding pilot here) have turret indexes 0 1 and 2 
*/