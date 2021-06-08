/*
This function generates spawns the correct crate (and eventually spawn truck) in the correct order, at the designated spawn point 

Notes:
It checks the base bool 
Using an if statement will ensure we work down the list, which will be useful if you need to recreate a destroyed base 

Order:
1: Supply 
2: Barracks 
3: Medical 
4: Workshop / key item: Land_RepairDepot_01_green_F / seed: B_Slingload_01_Fuel_F
5: 
6:
7:
8:
9:

Tier 1 / SBM 
Supply				Outpost Sierra	(Oscar Sierra / Camp Sierra / The Warehouse)
Barracks 			Outpost Bravo 	(Oscar Bravo / Camp Bravo / The Snakepit)
Medical Outpost 	Outpost Mike	(Oscar Mike / Camp Mike / The Bloodbank)

Tier 2 / WHV
Workshop			Outpost Whiskey	(Oscar Whiskey / Camp Whiskey / The Greasepit)
Heli Base 			Outpost Hotel	(Oscar Hotel / Camp Hotal / The Rotary Club)
Car Pool 			Outpost Victor	(Oscar Victor / Camp Victor / The Car Park)

Tier 3 / LTR
Logistics Post	 	Outpost Lima	(Oscar Lima / Camp Lima / Mainline)
Training Camp		Outpost Tango  	(Oscar Tango / Camp Tango / Tango Down)
Radar Station 		Outpost Romeo 	(Oscar Romeo / Camp Romeo / Skynet)

*/

systemChat "RUNNING - spawn_baseSpawnContainer";

// removing this for now, as not relevant to killchain 

// if (!SUPPLY) then {
// 	// create supply depot spawn container 
// 	_container = "B_Slingload_01_Cargo_F" createVehicle [0,0];  
// 	[_container, [4084,10273,0], 0] spawn RGGe_fnc_effects_blockRiser;
// } else {
// 	if (!BARRACKS) then {
// 		// create barracks spawn container 
// 		_container = "B_Slingload_01_Ammo_F" createVehicle [0,0];  
// 		[_container, [4084,10273,0], 0] spawn RGGe_fnc_effects_blockRiser;
// 	} else {
// 		if (!MEDICAL) then {
// 			// create med-base spawn container 
// 			_container = "B_Slingload_01_Medevac_F" createVehicle [0,0];  
// 			[_container, [4084,10273,0], 0] spawn RGGe_fnc_effects_blockRiser;
// 		} else {
// 			if (!WORKSHOP) then {
// 				// create workshop spawn container 
// 				_container = "B_Slingload_01_Fuel_F" createVehicle [0,0];  
// 				[_container, [4084,10273,0], 0] spawn RGGe_fnc_effects_blockRiser;
// 			} else {
// 				systemChat "Note: No more bases left to build";
// 			};
// 		};
// 	};
// };
