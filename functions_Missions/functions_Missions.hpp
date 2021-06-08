// RGGm - Mission Classes

class RGGm {
	tag = "RGGm";
	class functions_Missions {
		file = "functions_Missions";

		class mission_extractInjured {
			Description = "This function will create a medevac mission";
		};
		
		class mission_raptorOps {
			Description = "This function will create CAS mission to defend beleagured patrol";
		}; 

		class mission_extractDamagedTank {
			Description = "This function will create a mission to pick up a damaged tank";
		}; 

		class mission_deployVic {
			Description = "This function will create a mission to pick up and then deploy a tank or APC";
		}; 

		class mission_supportLRRP {
			Description = "This function will create a mission to support a long range patrol";
		}; 

		class mission_seekAndDestroy {
			Description = "This function will create an SAD mission";
		}; 

		class mission_destroyCamp {
			Description = "This function will create mission to destroy a local camp";
		}; 

		class mission_destroyRadar {
			Description = "This function will create mission to destroy a listening post";
		}; 

		class mission_destroyAmmo {
			Description = "This function will create mission to destroy a local ammo cache";
		};

		class mission_disruptAndEvade {
			Description = "This function will create mission to disrupt and evade in hostile terratory";
		};
	};
};