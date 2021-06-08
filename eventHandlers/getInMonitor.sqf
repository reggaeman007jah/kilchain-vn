/*
this script manages smoke actions while in heli 

toDo:
make sure smke systems work within attack helis 
*/

// this addEventHandler ["GetInMan", {
// 	params ["_unit", "_role", "_vehicle", "_turret"];
// }];

// todo - put heli names in an array and forEach them 

// _smokeHelis = [transport1a,transport2a,transport3a,RGG_Heli9,RGG_Heli7a,RGG_heli1a,RGG_heli2a,RGG_Heli3,RGG_Heli4,bigLifter];
// {
// 	_x addEventHandler ["getIn", {
// 	params ["_vehicle", "_role", "_unit", "_turret"];
// 	[_vehicle] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
// 	systemChat "someone got in";
// 	_vehicle removeEventHandler ["getIn", _thisEventHandler];
// } forEach _smokeHelis;
// why not work??


// fuck knows why this does not delete itself ... 
// RAIDER_3 addEventHandler ["getIn", {
// 	params ["_vehicle", "_role", "_unit", "_turret"];
// 	RAIDER_3 removeEventHandler ["getIn", 0];
// 	[_vehicle] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
// }];

// RAIDER_4 addEventHandler ["getIn", {
// 	params ["_vehicle", "_role", "_unit", "_turret"];
// 	RAIDER_4 removeEventHandler ["getIn", 0];
// 	[_vehicle] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
// }];

// RAIDER_5 addEventHandler ["getIn", {
// 	params ["_vehicle", "_role", "_unit", "_turret"];
// 	// systemChat format ["_unit: %1 / _role: %2 / _vehicle: %3", _unit, _role, _vehicle];
// 	RAIDER_5 removeEventHandler ["getIn", 0];
// 	[_vehicle] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
// }];



// player addEventHandler ["FiredNear", {
// 	systemChat "This Event Handler is now removing itself!";
// 	player removeEventHandler ["FiredNear", _thisEventHandler];
// }];


// sideWinder_1 addEventHandler ["getIn", {
// 	params ["_vehicle", "_role", "_unit", "_turret"];
// 	// systemchat format ["%1 just got into %2", _unit, _vehicle];
// 	// _cargo = [_vehicle] spawn RGGc_fnc_count_heliSeats;
// 	systemChat "Side Mission is a go...!";
// 	[sideWinder_1] spawn RGGm_fnc_mission_disruptAndEvade;
// }];




/*
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