/*
This function manages creation of opfor camp
*/

// ** imports 
private ["_opforCampLocation"];
_opforCampLocation = param[0]; // opfor camp spawn point 
// ** imports 

_campItems = []; // to hold all camp items if we need to track them for deletion (although consider full destroy command for this also)
// _randomCampLocation = _opforCampLocation findEmptyPosition [1,50,"B_Heli_Light_01_dynamicLoadout_F"];
_random5 = random 5;
_random3 = random 3;

// tents 
for "_i" from 1 to _random5 do {
	_randomDir = random 359;
	_random30 = random 30;
	_spawnPos = _opforCampLocation getPos [_random30, _randomDir];
	_campItem = createVehicle ["Land_TentDome_F", _spawnPos];
	_campItem setDir _randomDir;
	_campItems pushback _campItem;
};

_random5 = random 5; // yes, we run this again 
// barrels and other camp stuff 
for "_i" from 1 to _random5 do {
	_randomDir = random 359;
	_random25 = random 25;
	_spawnPos = _opforCampLocation getPos [_random3, _randomDir];
	_campItem = selectRandom [
		"Land_BarrelSand_F",
		"Land_BarrelSand_F",
		"Land_BarrelSand_grey_F",
		"Land_BarrelWater_grey_F",
		"Land_TransferSwitch_01_F",
		"Land_TentDome_F",
		"Land_RotorCoversBag_01_F",
		"Land_MetalBarrel_F",
		"Land_WaterTank_F"
	];
	// _spawnPos = _randomCampLocation getPos [_random25, _randomDir];
	_campItem2 = createVehicle [_campItem, _spawnPos];
	_campItem2 setDir _randomDir;
	_campItems pushback _campItem2;
};

_random5 = random 5; // and yes, we run this again 
// crates 
for "_i" from 1 to _random5 do {
	_randomDir = random 359;
	_random5 = random 5;
	_random25 = random 25;
	_spawnPos = _opforCampLocation getPos [_random5, _randomDir];
	_campItem = selectRandom [
		"Land_WoodenCrate_01_stack_x3_F",
		"Weapon_launch_O_Vorona_brown_F",
		"Box_T_East_Wps_F",
		"Box_East_AmmoOrd_F",
		"Box_East_WpsLaunch_F",
		"Land_CratesWooden_F",
		"Land_Pallet_MilBoxes_F",
		"Land_MetalBarrel_F",
		"Land_WaterTank_F"
	];
	// _spawnPos = _randomCampLocation getPos [_random25, _randomDir];
	_campItem2 = createVehicle [_campItem, _spawnPos];
	_campItem2 setDir _randomDir;
	_campItems pushback _campItem2;
};

// ** exports 
[_opforCampLocation] call RGG_fnc_3_spawn_opforUnits;
// [_campItems] call RGG_fnc_x_cleanupCheck_opforCamp;
// ** exports 

/*
Notes:

Opfor Base Classes:
B_Heli_Light_01_dynamicLoadout_F
Land_TentDome_F
"Land_BarrelSand_F",
"Land_BarrelSand_F",
"Land_BarrelSand_grey_F",
"Land_BarrelWater_grey_F",
"Land_TransferSwitch_01_F",
"Land_RotorCoversBag_01_F",
"Land_MetalBarrel_F",
"Land_WaterTank_F"
"Land_WoodenCrate_01_stack_x3_F",
"Weapon_launch_O_Vorona_brown_F",
"Box_T_East_Wps_F",
"Box_East_AmmoOrd_F",
"Box_East_WpsLaunch_F",
"Land_CratesWooden_F",
"Land_Pallet_MilBoxes_F",
*/