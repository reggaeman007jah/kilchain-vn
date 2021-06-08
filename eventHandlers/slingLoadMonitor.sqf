sleep 1;

// RAIDER_1 addEventHandler ["RopeAttach", {
// 	params ["_object1", "_rope", "_object2"];

// 	if (typeOf _object2 == "B_A_MRAP_03_hmg_F") then { 
// 		systemChat "MRAP Deployed:"; 
// 		[_object2] execVM "killchain\systems\hunterKillerMRAPSystems\runMRAPHK.sqf"; // needs group 
// 		RAIDER_1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
// 	};

// 	// // food 
// 	// if (typeOf _object2 == "I_supplyCrate_F") then { 
// 	// 	systemChat "Supplies Loaded"; 
// 	// 	RGG_Supply_Food = RGG_Supply_Food - 10;
// 	// 	publicVariable "RGG_Supply_Food";
// 	// 	// if (true) exitWith {};
		
// 	// 	heli1 removeEventHandler ["RopeAttach", 0]; // otherwise this triggers 4 times!
// 	// 	// execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
// 	// };
	
// 	// // fuel 
// 	// if (typeOf _object2 == "CargoNet_01_barrels_F") then { 
// 	// 	systemChat "Fuel Loaded"; 
// 	// 	RGG_Supply_Fuel = RGG_Supply_Fuel - 10;
// 	// 	publicVariable "RGG_Supply_Fuel";
// 	// 	heli1 removeEventHandler ["RopeAttach", 0]; // otherwise this triggers 4 times!
// 	// 	execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
// 	// };

// 	// // ammo 
// 	// if (typeOf _object2 == "I_CargoNet_01_ammo_F") then { 
// 	// 	systemChat "Ammo Loaded"; 
// 	// 	RGG_Supply_Ammo = RGG_Supply_Ammo - 10;
// 	// 	publicVariable "RGG_Supply_Ammo";
// 	// 	heli1 removeEventHandler ["RopeAttach", 0]; // otherwise this triggers 4 times!
// 	// 	execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
// 	// };
// }];

// RAIDER_2 addEventHandler ["RopeAttach", {
// 	params ["_object1", "_rope", "_object2"];

// 	if (typeOf _object2 == "B_A_MRAP_03_hmg_F") then { 
// 		systemChat "MRAP Deployed:"; 
// 		[_object2] execVM "killchain\systems\hunterKillerMRAPSystems\runMRAPHK.sqf"; // needs group 
// 		RAIDER_2 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
// 	};

// }];

// no bigbirds in fallujah
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


		// if (HUNTERKILLER) then {
		// 	systemChat "HK";
		// 	[_object2] execVM "killchain\systems\hunterKillerMRAPSystems\runMRAPHK.sqf"; 
		// 	Big_Lifter_2 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		// 	execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
		// };

		// if (CPD) then {
		// 	systemChat "CPD";
		// 	[_object2] execVM "killchain\systems\cpdMRAPSystems\runMRAPCPD.sqf"; 
		// 	Big_Lifter_2 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		// 	execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
		// };

/*
This EH manages the actions following the dropping off of a sling load item 
B_Slingload_01_Medevac_F = creates med-base 
B_Slingload_01_Ammo_F = creates barracks 
I_supplyCrate_F = adds supplies score to a base 
CargoNet_01_barrels_F = adds fuel score to a base 
I_CargoNet_01_ammo_F = adds ammo score to a base 

Currently I remove and then reattach the EH, to prevent the function from being called four times (one for each rope) 
setVariable is a batter way - explore this!
https://community.bistudio.com/wiki/setVariable
*/

/*
DELETE ^^ TO SEE CODE 

// this detects the thing you have deployed via slingload, and takes relevant follow on action 
bigHeli1 addEventHandler ["RopeBreak", {
	params ["_object1", "_rope", "_object2"];
	
	// this did not work ... make it work! 
	
	// switch (_object2) do {
	// 	case (typeOf _object2 == "B_Slingload_01_Medevac_F"): {
	// 		systemChat "Med-Base Deployed:"; 
	// 		[_object2, "B_Slingload_01_Medevac_F"] spawn RGGb_fnc_build_bluforMedbase; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	case (typeOf _object2 == "B_Slingload_01_Ammo_F"): {
	// 		systemChat "Barracks Deployed"; 
	// 		[_object2, "B_Slingload_01_Ammo_F"] spawn RGGb_fnc_build_bluforBarracks; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	case "I_supplyCrate_F": {
	// 		systemChat "Supplies Deployed"; 
	// 		[_object2, "I_supplyCrate_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	case "CargoNet_01_barrels_F": {
	// 		systemChat "Fuel Deployed"; 
	// 		[_object2, "CargoNet_01_barrels_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	case "I_CargoNet_01_ammo_F": {
	// 		systemChat "Ammo Deployed"; 
	// 		[_object2, "I_CargoNet_01_ammo_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
	// 		heli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	// 	};
	// 	default { systemChat "Error: no suitable object found in rope break EH"; };
	// };

	// ----- BASES ----- //

	// supply base 
	if (typeOf _object2 == "B_Slingload_01_Cargo_F") then { 
		systemChat "Supply Depot Deployed"; 
		[_object2, "B_Slingload_01_Cargo_F"] spawn RGGb_fnc_build_bluforSupplyDepot; // NOTE - test theory that you do not need this second arg !!
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// barracks 
	if (typeOf _object2 == "B_Slingload_01_Ammo_F") then { 
		systemChat "Barracks Deployed"; 
		[_object2, "B_Slingload_01_Ammo_F"] spawn RGGb_fnc_build_bluforBarracks; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// med-base 
	if (typeOf _object2 == "B_Slingload_01_Medevac_F") then { 
		systemChat "Med-Base Deployed:"; 
		[_object2, "B_Slingload_01_Medevac_F"] spawn RGGb_fnc_build_bluforMedbase; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// workshop-base 
	if (typeOf _object2 == "B_Slingload_01_Fuel_F") then { 
		systemChat "workshop-Base Deployed:"; 
		[_object2, "B_Slingload_01_Fuel_F"] spawn RGGb_fnc_build_bluforWorkshop; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// ----- SUPPLIES ----- //

	// food 
	if (typeOf _object2 == "I_supplyCrate_F") then { 
		systemChat "Supplies Deployed"; 
		// here we apply a check to see if the respawn system is active (processing respawns)
		// we only call this is the queue is empty 
		if (!RESPAWNQUEUE) then {
			[] spawn RGGs_fnc_spawn_bluforSentryRespawnQueue; // triggers the sentry respawn checking process 
		};
		[_object2, "I_supplyCrate_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};
	
	// fuel 
	if (typeOf _object2 == "CargoNet_01_barrels_F") then { 
		systemChat "Fuel Deployed"; 
		[_object2, "CargoNet_01_barrels_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

	// ammo 
	if (typeOf _object2 == "I_CargoNet_01_ammo_F") then { 
		systemChat "Ammo Deployed"; 
		[_object2, "I_CargoNet_01_ammo_F"] spawn RGGc_fnc_count_bluforBaseSupplies; 
		bigHeli1 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
	};

}];

// this detects when supplies are picked up from the depot, and reduces score accorindgly 
// heli1 addEventHandler ["RopeAttach", {
// 	params ["_object1", "_rope", "_object2"];

// 	// food 
// 	if (typeOf _object2 == "I_supplyCrate_F") then { 
// 		systemChat "Supplies Loaded"; 
// 		RGG_Supply_Food = RGG_Supply_Food - 10;
// 		publicVariable "RGG_Supply_Food";
// 		// if (true) exitWith {};
		
// 		heli1 removeEventHandler ["RopeAttach", 0]; // otherwise this triggers 4 times!
// 		// execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
// 	};
	
// 	// fuel 
// 	if (typeOf _object2 == "CargoNet_01_barrels_F") then { 
// 		systemChat "Fuel Loaded"; 
// 		RGG_Supply_Fuel = RGG_Supply_Fuel - 10;
// 		publicVariable "RGG_Supply_Fuel";
// 		heli1 removeEventHandler ["RopeAttach", 0]; // otherwise this triggers 4 times!
// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
// 	};

// 	// ammo 
// 	if (typeOf _object2 == "I_CargoNet_01_ammo_F") then { 
// 		systemChat "Ammo Loaded"; 
// 		RGG_Supply_Ammo = RGG_Supply_Ammo - 10;
// 		publicVariable "RGG_Supply_Ammo";
// 		heli1 removeEventHandler ["RopeAttach", 0]; // otherwise this triggers 4 times!
// 		execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
// 	};
// }];


