/*
This function manages the depletion of base supplies over time 

to-do:
add system that captures when a base has zero of something, so we can remove the base perk 

*/
systemChat "RUNNING - count_depleteSupplies";

while {true} do {

	if (BARRACKS) then {
		if (RGG_Barracks_Food > 0) then {
			RGG_Barracks_Food = RGG_Barracks_Food -1;
		};
		if (RGG_Barracks_Fuel > 0) then {
			RGG_Barracks_Fuel = RGG_Barracks_Fuel - 0.5;
		};
		if (RGG_Barracks_Ammo > 0) then {
			RGG_Barracks_Ammo = RGG_Barracks_Ammo -1;
		};
	};

	sleep 1;

	if (MEDICAL) then {
		if (RGG_Medical_Food > 0) then {
			RGG_Medical_Food = RGG_Medical_Food -1;
		};
		if (RGG_Medical_Fuel > 0) then {
			RGG_Medical_Fuel = RGG_Medical_Fuel -1;
		};
		if (RGG_Medical_Ammo > 0) then {
			RGG_Medical_Ammo = RGG_Medical_Ammo - 0.5;
		};
	};

	sleep 120;

};