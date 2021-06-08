/*
mainPZ is the name of the listening marker 
*/

/*
From: initServer.sqf 

Note:
This should be improved to use waitUntil - waitUntil units inAreaArray == 0 
This was yu can reduce the background checks, and also make the subsequent groups appear quickly - good for when there is more than one heli doing pickup 

*/

// this will spawn a fireteam contantly, and only respawn another team when the previous one has been removed from the "pz1" marker area 
sleep 10;

// systemChat "para spawner activated";
// "recon para spawner activated" remoteExec ["systemChat", 0, true];	
// sleep 1;

// todo - make this only happy when players are nearby 













while {true} do {

	_units = allUnits inAreaArray "mainPZ";
	_spawn = [15728.8,7141.19,0];

	_unitCount1 = count _units;

	if (_unitCount1 == 0) then {
		_float = diag_tickTime;
		_stampToString = str _float;
		_stampToString = createGroup [independent, true];
		for "_i" from 1 to 1 do { 
			"vn_i_men_ranger_20" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"vn_i_men_ranger_21" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"vn_i_men_ranger_20" createUnit [_spawn, _stampToString]; 
			sleep 0.1;
		};
		for "_i" from 1 to 1 do { 
			"vn_i_men_ranger_21" createUnit [_spawn, _stampToString];  
			sleep 0.1;
		};
		// for "_i" from 1 to 1 do { 
		// 	"vn_i_men_ranger_20" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"vn_i_men_ranger_21" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"vn_i_men_ranger_06" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"vn_i_men_ranger_11" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"vn_i_men_ranger_07" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"vn_i_men_ranger_17" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"vn_i_men_ranger_03" createUnit [_spawn, _stampToString];  
		// 	sleep 0.1;
		// };
		_stampToString move [15727.8,7067.73,0];
		_stampToString setFormation "diamond";
		
		systemChat "grunts ready .............................................!";
	};

	sleep 20;
};

		// for "_i" from 1 to 1 do { 
		// 	// "B_W_Soldier_A_F" createUnit [[15074,17244], _indiGroup]; 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_AR_F
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_LAT_F
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_Sharpshooter_F
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_TL_F B_W_Recon_GL_F
		// 	sleep 0.1;
		// };
		// for "_i" from 1 to 1 do { 
		// 	"B_W_Soldier_A_F" createUnit [[15074,17244], _stampToString]; B_W_Recon_TL_F B_W_Recon_GL_F
		// 	sleep 0.1;
		// };