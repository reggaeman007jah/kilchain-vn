/*
This function regularly checks the base supplies of all blufor FOBs

Notes:
This function is triggered by a rope break EH, from dropping one of the three available supply crates 
The EH sends this function _object2 which is a simple parse of the object that was dropped, as well as the specific _className of the item 

Barracks_DZ = marker name 
_playerIsInside = player inArea _myTrigger;
Each helipad has an invisible marker 
When a box is dropped and this script is run, we need to check ... is the box resting in any of the helipad arrays (i.e. dropzones)? 
If so, then apply a score to that base depending on the item dropped, then sink the block.
So, the creation of any base should enable creation of a global marker - both for visual purposes, but a second invisible dropzone marker for this system (small circle)
Think about validation ... what happens when you miss your target?
If after dropping, item is 'not' in dropzone after a few seconds ... inform pilot to try again 

To-do:
ID all live bases 
Get supply scores 
Adjust supply scores 
test if this can be run as a switch, with nested switch 

notes from old scripts:
athiraMilBaseVirtualUnits = athiraMilBaseVirtualUnits + _deployedUnits;
publicVariable "athiraMilBaseVirtualUnits";
systemChat format ["Athira Mil-Base now has %1 virtual units", athiraMilBaseVirtualUnits];
*/

// Barracks -------------------------------------------------------------------------------------------
systemChat "RUNNING - count_bluforBaseSupplies";
params ["_object2", "_className"];

_object2 = _this select 0;
_className = _this Select 1;

_seedPos = getPos _object2;

// systemChat "bluforBaseSupplies.sqf running";
// systemChat format["_object2 = %1", _object2];

if (_seedPos inArea "Barracks_DZ") then {
	systemChat "Well done, Barracks supplies dropped successfully";
	sleep 10;

	switch (_className) do {
		case "I_supplyCrate_F": { 
			RGG_Barracks_Food = RGG_Barracks_Food + 10;
			publicVariable "RGG_Barracks_Food";
			systemChat format ["Barracks now has %1 Food", RGG_Barracks_Food]; // needs voice 
		};
		case "CargoNet_01_barrels_F": { 
			RGG_Barracks_Fuel = RGG_Barracks_Fuel + 10;
			publicVariable "RGG_Barracks_Fuel";
			systemChat format ["Barracks now has %1 Fuel", RGG_Barracks_Fuel]; // needs voice 
		};
		case "I_CargoNet_01_ammo_F": { 
			RGG_Barracks_Ammo = RGG_Barracks_Ammo + 10;
			publicVariable "RGG_Barracks_Ammo";
			systemChat format ["Barracks now has %1 Ammo", RGG_Barracks_Ammo]; // needs voice 
		};
		default { 
			systemChat "error - nothing deployed";
		};
	};

	// [_object2] spawn RGGb_fnc_build_blockSinker;
	systemChat "activating RGGe_fnc_effects_blockSinker";
	[_object2] spawn RGGe_fnc_effects_blockSinker;
};

// Medical ------------------------------------------------------------------------------------------
if (_seedPos inArea "Medical_DZ") then {
	systemChat "Well done, Medical supplies dropped successfully";
	sleep 10;

	switch (_className) do {
		case "I_supplyCrate_F": { 
			RGG_Medical_Food = RGG_Medical_Food + 10;
			publicVariable "RGG_Medical_Food";
			systemChat format ["Med-Base now has %1 Food", RGG_Medical_Food];
		};
		case "CargoNet_01_barrels_F": { 
			RGG_Medical_Fuel = RGG_Medical_Fuel + 10;
			publicVariable "RGG_Medical_Fuel";
			systemChat format ["Med-Base now has %1 Fuel", RGG_Medical_Fuel];
		};
		case "I_CargoNet_01_ammo_F": { 
			RGG_Medical_Ammo = RGG_Medical_Ammo + 10;
			publicVariable "RGG_Medical_Ammo";
			systemChat format ["Med-Base now has %1 Ammo", RGG_Medical_Ammo];
		};
		default { 
			systemChat "error - nothing deployed";
		};
	};

	systemChat "activating RGGe_fnc_effects_blockSinker";
	[_object2] spawn RGGe_fnc_effects_blockSinker;
};

// Workshop ------------------------------------------------------------------------------------------
if (_seedPos inArea "Workshop_DZ") then {
	systemChat "Well done, Workshop supplies dropped successfully";
	sleep 10;

	switch (_className) do {
		case "I_supplyCrate_F": { 
			RGG_Workshop_Food = RGG_Workshop_Food + 10;
			publicVariable "RGG_Workshop_Food";
			systemChat format ["Workshop-Base now has %1 Food", RGG_Workshop_Food];
		};
		case "CargoNet_01_barrels_F": { 
			RGG_Workshop_Fuel = RGG_Workshop_Fuel + 10;
			publicVariable "RGG_Workshop_Fuel";
			systemChat format ["Workshop-Base now has %1 Fuel", RGG_Workshop_Fuel];
		};
		case "I_CargoNet_01_ammo_F": { 
			RGG_Workshop_Ammo = RGG_Workshop_Ammo + 10;
			publicVariable "RGG_Workshop_Ammo";
			systemChat format ["Workshop-Base now has %1 Ammo", RGG_Workshop_Ammo];
		};
		default { 
			systemChat "error - nothing deployed";
		};
	};

	systemChat "activating RGGe_fnc_effects_blockSinker";
	[_object2] spawn RGGe_fnc_effects_blockSinker;
};

// this checks for Level 2 bases  
[] spawn RGGs_fnc_spawn_baseSpawnContainerLevel2;
       
