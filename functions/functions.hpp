class RGG {
	tag = "RGG";
	class functions {
		file = "functions";
		class 0_init_removeWeapons {
			Description = "This function will remove player's weapons on join";
		};
		class 1_setup_createMainBaseMarker {
			Description = "This function creates initial main base marker position";
		};
		class 1_setup_findLocation {
			Description = "This function identifies suitable location for blufor FOB + marker creation ";
		};
		class 2_build_bluforFob {
			Description = "This function manages creation of blufor fob";
		};
		class 2_build_opforCamp {
			Description = "This function manages creation of opfor camp";
		};
		class 2_build_bluforMedbase {
			Description = "This function manages creation of blufor med-base";
		};
		class 2_build_bluforBarracks {
			Description = "This function manages creation of blufor barracks";
		};
		class 3_spawn_bluforUnits {
			Description = "This function spawns blufor in the battlezone";
		};
		class 3_spawn_opforUnits {
			Description = "This function spawns opfor in the battlezone";
		};
		// class 4_ambient_burningVics {
		// 	Description = "This function manages creation of ambient burning wrecks";
		// };
		// class 4_ambient_flybys {
		// 	Description = "This function manages all ambient effects in the battlezone, such as burning wrecks and helis/planes flying overhead";
		// };
	};
};

