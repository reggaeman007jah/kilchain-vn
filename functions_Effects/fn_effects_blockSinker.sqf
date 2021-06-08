/*
This function manages the sinking and deleting of blocks passed to it

Notes: 
Been trying to fix a bug where sometimes the crate does not spawn back in ... I am trying to deeletVehicle within the code block each time rather than once right at the end 
Fixed - I was not parsing the setVariable value on the second creation, so instead I dont delete the crate and instead just re-teleport back to origin 
*/

// -------------------------------------------------------------------------------------------
// systemChat "RUNNING - effects_blockSinker";
params ["_object2"];

_object2 = _this select 0;
_object2 enableSimulation false;
_seedPos = getPos _object2;

sleep 2;
// systemChat "fn_effects - blockSinker - now";

for [{_i = 0}, {_i > -5}, {_i = _i - 0.1}] do {
	_seedPos set [2,_i]; 
	_object2 setPos _seedPos;
	sleep 0.1;
};

sleep 2;

_object2 setPos [0,0];

if (typeOf _object2 == "I_supplyCrate_F") then { 
	_supplySpawnPos = _object2 getVariable "supplySpawnPos";
	_pos = _supplySpawnPos select 0;
	[_object2, _pos, 0] spawn RGGe_fnc_effects_blockRiser;
};

if (typeOf _object2 == "I_CargoNet_01_ammo_F") then { 
	_supplySpawnPos = _object2 getVariable "supplySpawnPos";
	_pos = _supplySpawnPos select 0;
	[_object2, _pos, 0] spawn RGGe_fnc_effects_blockRiser;
};

if (typeOf _object2 == "CargoNet_01_barrels_F") then { 
	_supplySpawnPos = _object2 getVariable "supplySpawnPos";
	_pos = _supplySpawnPos select 0;
	[_object2, _pos, 0] spawn RGGe_fnc_effects_blockRiser;
};

// containers
if (typeOf _object2 == "B_Slingload_01_Cargo_F") then { 
	// systemChat format ["----- DELETING SUPPLY CONTAINER %1 -----", _object2];
	deleteVehicle _object2;
};

if (typeOf _object2 == "B_Slingload_01_Medevac_F") then { 
	// systemChat format ["----- DELETING MEDICAL CONTAINER %1 -----", _object2];
	deleteVehicle _object2;
};

if (typeOf _object2 == "B_Slingload_01_Ammo_F") then { 
	// systemChat format ["----- DELETING AMMO CONTAINER %1 -----", _object2];
	deleteVehicle _object2;
};






// systemChat format ["----- DELETING %1 -----", _object2];
// deleteVehicle _object2;


// ------------------------------------------------------------------------------------------


