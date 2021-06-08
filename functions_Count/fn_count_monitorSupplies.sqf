/*
This function counts / monitors / displays base supplies in a systemchat

To-do:
make this only appear while in map mode

*/

systemChat "RUNNING - count_monitorSupplies";

while {true} do {
	
	sleep 15;

	if (BARRACKS) then {
		systemChat "Barracks Supplies:";
		systemChat format ["Food: %1 ¦ Ammo: %2 ¦ Fuel: %3 ¦ Sentries: %4", RGG_Barracks_Food, RGG_Barracks_Ammo, RGG_Barracks_Fuel, RGG_Barracks_Sentries];
		// systemChat format ["Ammo: %1", RGG_Barracks_Ammo];
		// systemChat format ["Fuel: %1", RGG_Barracks_Fuel];	
		// systemChat format ["Sentries: %1", RGG_Barracks_Sentries];	
	};

	sleep 5;

	if (MEDICAL) then {
		systemChat "Med-Base Supplies:";
		systemChat format ["Food: %1 ¦ Ammo: %2 ¦ Fuel: %3 ¦ Sentries: %4", RGG_Medical_Food, RGG_Medical_Ammo, RGG_Medical_Fuel, RGG_Medical_Sentries];
		// systemChat format ["Food: %1", RGG_Medical_Food];
		// systemChat format ["Ammo: %1", RGG_Medical_Ammo];
		// systemChat format ["Fuel: %1", RGG_Medical_Fuel];	
	};

	sleep 5;

	if (RADAR) then {
		systemChat "Radar-Base Supplies:";
		systemChat format ["Food: %1", RGG_Radar_Food];
		systemChat format ["Ammo: %1", RGG_Radar_Ammo];
		systemChat format ["Fuel: %1", RGG_Radar_Fuel];	
	};

	sleep 5;

	if (OBSERVATION) then {
		systemChat "Observation-Post Supplies:";
		systemChat format ["Food: %1", RGG_Observation_Food];
		systemChat format ["Ammo: %1", RGG_Observation_Ammo];
		systemChat format ["Fuel: %1", RGG_Observation_Fuel];	
	};

	sleep 5;

	if (HELI) then {
		systemChat "Heli-Base Supplies:";
		systemChat format ["Food: %1", RGG_Heli_Food];
		systemChat format ["Ammo: %1", RGG_Heli_Ammo];
		systemChat format ["Fuel: %1", RGG_Heli_Fuel];	
	};

	sleep 5;

	if (CAR) then {
		systemChat "Car Pool Supplies:";
		systemChat format ["Food: %1", RGG_Car_Food];
		systemChat format ["Ammo: %1", RGG_Car_Ammo];
		systemChat format ["Fuel: %1", RGG_Car_Fuel];	
	};

	sleep 5;

	if (WORKSHOP) then {
		systemChat "Workshop Supplies:";
		systemChat format ["Food: %1", RGG_Workshop_Food];
		systemChat format ["Ammo: %1", RGG_Workshop_Ammo];
		systemChat format ["Fuel: %1", RGG_Workshop_Fuel];	
	};

	sleep 5;

	if (TRAINING) then {
		systemChat "Training-Camp Supplies:";
		systemChat format ["Food: %1", RGG_Training_Food];
		systemChat format ["Ammo: %1", RGG_Training_Ammo];
		systemChat format ["Fuel: %1", RGG_Training_Fuel];	
	};
};

