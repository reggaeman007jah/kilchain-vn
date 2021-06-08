// spawns friendly MRAP at the MA (Main Airbase)
// [15057.1,17159.1,0] from 
// [15090.8,17142.2,0] to 
/*
ok, why constantly spam this?

*/

sleep 10;

while {true} do {

	_units = allUnits inAreaArray "pz3";
	_spawn = [15057.1,17159.1,0];

	_unitCount1 = count _units;

	if (_unitCount1 == 0) then {
		// _float = diag_tickTime;
		// _stampToString = str _float;
		// _stampToString = createGroup [west, true];
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_AR_F" createUnit [_spawn, _stampToString]; 
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_LAT_F" createUnit [_spawn, _stampToString]; 
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_Sharpshooter_F" createUnit [_spawn, _stampToString]; 
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_TL_F" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Recon_TL_F" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		// _stampToString move [15090.8,17142.2,0];
		// _stampToString setFormation "DIAMOND";
		_opforVic = [[15057,17159], 116, "B_MRAP_01_gmg_F", west] call BIS_fnc_spawnVehicle;
		// _opforVic setDir 116;
		_opforVic doMove [15090.8,17142.2,0];
		systemChat "MRAP ready .............................................!";
	};

	sleep 20;
};

systemChat "debug - delete when tested - mrap spawner activated";





	


