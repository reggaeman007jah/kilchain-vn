/*
This function will create a small enemy base camp where opfor will spawn for as long as the camp is alive 

To-do:
Ensure that camps to not spawn near existing base locations 

create an item that kills the camp if destroyed 

notes:
myPlaces = selectBestPlaces [position player, 50, "meadow + 2*hills", 1, 5];
param 0 = the local base location that opfor will try to rush 

*/
systemChat "RUNNING - spawn_opforCamp";
// private ["_spawnPoint", "_campSize"];
private ["_spawnPoint", "_campType"];

_spawnPoint = param[0];
_campType = param[1];

systemChat "test debug....";
systemChat str _campType;
// _campSize = param[1];

// // finds a nice little wooded area not too far from created base 
// _rootPos = [_spawnPoint, 600, 1000, 3, 0] call BIS_fnc_findSafePos;
// _campSite = selectBestPlaces [_rootPos, 200, "forest", 1, 1];
// _campSitePos = ((_campSite select 0) select 0);

// // comment out this marker section when ready to ship 
// _campSiteMarker = createMarker ["_campSite", _campSitePos];
// _campSiteMarker setMarkerShape "ELLIPSE";
// _campSiteMarker setMarkerColor "ColorRed";
// _campSiteMarker setMarkerSize [15, 15];

// create camp site -----------------------------------------------------
_campItems = [];
_random5 = random 5;
_random3 = random 3;

// tents 
_tents = _random5 + 4;
for "_i" from 1 to _tents do {
	systemChat "Tent Created";
	_randomDir = random 359;
	_random30 = random 30;
	_spawnPos = _campSitePos getPos [_random30, _randomDir];
	_campItem = createVehicle ["Land_TentDome_F", _spawnPos];
	_campItem setDir _randomDir;
	_campItems pushback _campItem;
	sleep 1;
};

// barrels and other camp stuff 
for "_i" from 1 to 2 do {
	_randomDir = random 359;
	_random25 = random 25;
	_spawnPos = _campSitePos getPos [_random3, _randomDir];
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

// crates 
for "_i" from 1 to _random5 do {
	_randomDir = random 359;
	_random5 = random 5;
	_random25 = random 25;
	_spawnPos = _campSitePos getPos [_random5, _randomDir];
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

sleep 2;

systemChat format ["Camp Items: %1", _campItems];
_noOfCampItems = count _campItems;
systemChat format ["No. of Camp Items: %1", _noOfCampItems];

/*
now run check on a loop to see if sat-dish is alive - when not alive, delete all camp items 
send signel (somehow) to global array to delete this 

or - EH on the object!? Let's try this:
this addEventHandler ["Explosion", {
	params ["_vehicle", "_damage"];
}];
*/

// _satDish = "SatelliteAntenna_01_Sand_F" createVehicle _spawnPoint;
// _satDish addEventHandler ["Explosion", {
// 	params ["_vehicle", "_damage"];
// 	systemChat "dish was exploded";
// 	// we now here need to delete this option from the global array 
// }];



_satDish = "SatelliteAntenna_01_Sand_F" createVehicle _spawnPoint;
systemChat format ["ENEMY CAMP CREATED - %1", _campType];
_satDish setVariable ["baseTarget", [_campType, _campItems], TRUE]; 

_satDish addEventHandler ["Explosion", {
	params ["_vehicle", "_damage"];
	_baseData = _vehicle getVariable "baseTarget";
	_camp = _baseData select 0;
	_campItems = _baseData select 1;
	systemChat format ["debug - dish at %1 was destroyed", _camp];
	deleteVehicle _vehicle;
	// delete camp items 
	// private _myArray = [1, 2, 3, 4, 5];
	// { systemChat str _x } forEach _myArray;
	{
		deleteVehicle _x;
	} forEach _campItems;
	_noOfCampItems = count _campItems;
	systemChat format ["No. of Camp Items Left: %1", _noOfCampItems];
	// we now here need to delete this option from the global array 
	[_camp] call RGGl_fnc_localAttacks_manageDestroyedCamps;
}];



/*
or this:
this addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
}];

*/


// next we need to spawn in opfor, and send to nearest base (location of which is the first arg of the fnc)

/*
check if base is alive 
decde on a force size 
spawn units 
send them to near base location 
we should also check that no other main attack is happening 
so, a design decision here - should there be only one big attack on any base at any one time?
for now, yes!
Also, work out direction the camp is in relation the the base target, and include an intel item 
this intel item should state incoming enemy from x direction 
Consider also counting number of assaults from each camp, so the report can say 
"we are being attacked for the nth time from the south east"
also consider should each attack size increase until camp destroyed 
*/

// LOCALATTACK = true; // ensures no duplicate attacks, which would hurt perf 

// // for now, we will simply randomise the enemy strength 
// _enemyStrength = selectRandom [10, 20, 30];
// [_enemyStrength, _campSitePos] call RGGs_fnc_spawn_opforCampAttackers;

/*
rethink - we need a regular check to see which bases are active, and which camps are not detroyed

*/
