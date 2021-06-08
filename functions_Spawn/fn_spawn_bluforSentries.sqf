/*
This function creates wall, corner and tower sentries

Note:
Is called from:
	when bases are being built 
	TBC ??
	it is run once per sentry

Takes location and direction and block type (for height) as args 
Also takes base type as an arg - this is to ensure that sentry calcs are managed properly 
*/

// ----- setup ----- 
// systemChat "RUNNING - spawn_bluforSentriesBaseSpawnContainer";
private ["_spawnPoint", "_spawnDirection", "_wallType", "_baseType"];
_spawnPoint = param[0];
_spawnDirection = param[1];
_wallType = param[2];
_baseType = param[3];


// russia classes for opfor 
_sniper = "O_R_recon_M_F";
_machineGunner = "O_R_Soldier_AR_F";
_rifleMan = "O_R_Soldier_A_F";


// ----- function -----
// this first switch simply calculates the new sentry score for the base in question
switch (_baseType) do {
	case "supply": { RGG_Supply_Sentries = RGG_Supply_Sentries + 1; publicVariable "RGG_Supply_Sentries"; };
	case "barracks": { RGG_Barracks_Sentries = RGG_Barracks_Sentries + 1; publicVariable "RGG_Barracks_Sentries"; };
	case "medical": { RGG_Medical_Sentries = RGG_Medical_Sentries + 1; publicVariable "RGG_Medical_Sentries"; };
	case "workshop": { RGG_Workshop_Sentries = RGG_Workshop_Sentries + 1; publicVariable "RGG_Workshop_Sentries"; };
	// case "value": { };
	// case "value": { };
	// case "value": { };
	// case "value": { };
	// case "value": { };
	default { systemChat format ["ERROR: _baseType switch: %1", _baseType]; };
};

// this second switch sets up the sentry, in terms of position (on each block-type) and onKilled EH 
switch (_wallType) do {
	case "wall": { 
		private ["_shift"];
		// this switch pushes the block slightly away from the parsed direction, to ensure the unit does not spawn ...
		// on the top block, but rather spawns on the lower (protected) level
		switch (_spawnDirection) do {
			case 0: { _shift = 180 };
			case 90: { _shift = 270 };
			case 180: { _shift = 0 };
			case 270: { _shift = 90 };
			default { systemChat format ["ERROR: _spawnDirection switch: %1", _spawnDirection]; };
		};
		_spawnHeight = 0.3;
		_vrBlock = _spawnPoint;
		_vrBlock set [2, _spawnHeight];
		_vrBlock = _vrBlock getPos [1.3, _shift]; // shift away so unit is not on top block 
		_vrWallBlock = "Land_VR_Shape_01_cube_1m_F" createVehicle _vrBlock; 
		_vrWallBlock enableSimulation false;
		_vrWallBlock setPos _vrBlock;

		// _indiGroup = createGroup independent;
		_indiGroup = createGroup [east, true];
		// _unit1 = _indiGroup createUnit ["B_G_Soldier_A_F", [0,0], [], 0, "FORM"]; // walls get basic riflemen 
		_unit1 = _indiGroup createUnit [_rifleMan, [0,0], [], 0, "FORM"]; // walls get basic riflemen 
		_vrBlock set [2,3];

		_unit1 enableSimulation false;
		_unit1 setPos _vrBlock;
		_unit1pos = getPos _unit1;

		_unit1pos set [2,2.6];

		_unit1 setPos _unit1pos;

		_unit1 enableSimulation true;
		_unit1 setUnitPos "UP";
		_unit1 setFormDir _spawnDirection;

		_unit1 setVariable ["sentryAlive", [_spawnPoint, _spawnDirection, _wallType, _baseType], TRUE]; 
		_testVariable = _unit1 getVariable "sentryAlive";

		_unit1 addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];

			_sentryData = _unit getVariable "sentryAlive";
			_block = _sentryData select 0;
			_dir = _sentryData select 1;
			_pos = _sentryData select 2;
			_baseType = _sentryData select 3;

			systemChat format ["A %1 WALL SENTRY IS DEAD", _baseType];

			switch (_baseType) do {
				case "supply": { RGG_Supply_Sentries = RGG_Supply_Sentries - 1; publicVariable "RGG_Supply_Sentries"; };
				case "barracks": { RGG_Barracks_Sentries = RGG_Barracks_Sentries - 1; publicVariable "RGG_Barracks_Sentries"; };
				case "medical": { RGG_Medical_Sentries = RGG_Medical_Sentries - 1; publicVariable "RGG_Medical_Sentries"; };
				case "workshop": { RGG_Workshop_Sentries = RGG_Workshop_Sentries - 1; publicVariable "RGG_Workshop_Sentries"; };
				// case "value": { };
				// case "value": { };
				// case "value": { };
				// case "value": { };
				// case "value": { };
				default { systemChat "Error / Switch _baseType invalid"; };
			};

			[_unit] spawn RGGc_fnc_count_bluforSentryRespawnCheck;
		}];
		deleteVehicle _vrWallBlock;
	};
	case "tower": { 
		_spawnHeight = 1.2;
		_vrBlock = _spawnPoint;
		_vrBlock set [2, _spawnHeight];
		_vrWallBlock = "Land_VR_Shape_01_cube_1m_F" createVehicle _vrBlock; 
		_vrWallBlock enableSimulation false;
		_vrWallBlock setPos _vrBlock;

		// _indiGroup = createGroup independent;
		_indiGroup = createGroup [east, true];
		// _unit1 = _indiGroup createUnit ["B_G_Soldier_M_F", [0,0], [], 0, "FORM"]; // towers get sharpshooters
		_unit1 = _indiGroup createUnit [_sniper, [0,0], [], 0, "FORM"]; // towers get sharpshooters
		_vrBlock set [2,3];

		_unit1 enableSimulation false;
		_unit1 setPos _vrBlock;
		_unit1pos = getPos _unit1;

		_unit1pos set [2,2.6];

		_unit1 setPos _unit1pos;

		_unit1 enableSimulation true;
		_unit1 setUnitPos "UP";
		_unit1 setFormDir _spawnDirection;

		_unit1 setVariable ["sentryAlive", [_spawnPoint, _spawnDirection, _wallType, _baseType], TRUE]; 
		_testVariable = _unit1 getVariable "sentryAlive";

		_unit1 addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];

			_sentryData = _unit getVariable "sentryAlive";
			_block = _sentryData select 0;
			_dir = _sentryData select 1;
			_pos = _sentryData select 2;
			_baseType = _sentryData select 3;

			systemChat format ["A %1 TOWER SENTRY IS DEAD", _baseType];

			switch (_baseType) do {
				case "supply": { RGG_Supply_Sentries = RGG_Supply_Sentries - 1; publicVariable "RGG_Supply_Sentries"; };
				case "barracks": { RGG_Barracks_Sentries = RGG_Barracks_Sentries - 1; publicVariable "RGG_Barracks_Sentries"; };
				case "medical": { RGG_Medical_Sentries = RGG_Medical_Sentries - 1; publicVariable "RGG_Medical_Sentries"; };
				case "workshop": { RGG_Workshop_Sentries = RGG_Workshop_Sentries - 1; publicVariable "RGG_Workshop_Sentries"; };
				// case "value": { };
				// case "value": { };
				// case "value": { };
				// case "value": { };
				// case "value": { };				
				default { systemChat "Error / Switch _baseType invalid"; };
			};

			[_unit] spawn RGGc_fnc_count_bluforSentryRespawnCheck;
		}];
		deleteVehicle _vrWallBlock;
	};
	case "corner": { 
		private ["_shift"];
		switch (_spawnDirection) do {
			case 0: { _shift = 180 };
			case 90: { _shift = 270 };
			case 180: { _shift = 0 };
			case 270: { _shift = 90 };
			default { systemChat format ["ERROR: _spawnDirection switch: %1", _spawnDirection]; };
		};
		_spawnHeight = 0.3;
		_vrBlock = _spawnPoint;
		_vrBlock set [2, _spawnHeight];
		_vrBlock = _vrBlock getPos [0.1, _shift]; 
		_vrWallBlock = "Land_VR_Shape_01_cube_1m_F" createVehicle _vrBlock; 
		_vrWallBlock enableSimulation false;
		_vrWallBlock setPos _vrBlock;

		_indiGroup = createGroup [east, true];
		// _indiGroup = createGroup independent;
		_unit1 = _indiGroup createUnit [_machineGunner, [0,0], [], 0, "FORM"]; // corner blocks get auto gunners 
		// _unit1 = _indiGroup createUnit ["B_G_Soldier_AR_F", [0,0], [], 0, "FORM"]; // corner blocks get auto gunners 
		_vrBlock set [2,3];

		_unit1 enableSimulation false;
		_unit1 setPos _vrBlock;
		_unit1pos = getPos _unit1;

		_unit1pos set [2,2.6];

		_unit1 setPos _unit1pos;

		_unit1 enableSimulation true;
		_unit1 setUnitPos "UP";
		_unit1 setFormDir _spawnDirection;

		_unit1 setVariable ["sentryAlive", [_spawnPoint, _spawnDirection, _wallType, _baseType], TRUE]; 
		_testVariable = _unit1 getVariable "sentryAlive";

		_unit1 addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];

			_sentryData = _unit getVariable "sentryAlive";
			_block = _sentryData select 0;
			_dir = _sentryData select 1;
			_pos = _sentryData select 2;
			_baseType = _sentryData select 3;

			systemChat format ["A %1 CORNER SENTRY IS DEAD", _baseType];

			switch (_baseType) do {
				case "supply": { RGG_Supply_Sentries = RGG_Supply_Sentries - 1; publicVariable "RGG_Supply_Sentries"; };
				case "barracks": { RGG_Barracks_Sentries = RGG_Barracks_Sentries - 1; publicVariable "RGG_Barracks_Sentries"; };
				case "medical": { RGG_Medical_Sentries = RGG_Medical_Sentries - 1; publicVariable "RGG_Medical_Sentries"; };
				case "workshop": { RGG_Workshop_Sentries = RGG_Workshop_Sentries - 1; publicVariable "RGG_Workshop_Sentries"; };
				// case "value": { };
				// case "value": { };
				// case "value": { };
				// case "value": { };
				// case "value": { };
				default { systemChat "Error / Switch _baseType invalid"; };
			};
			[_unit] spawn RGGc_fnc_count_bluforSentryRespawnCheck;
		}];

		deleteVehicle _vrWallBlock;
	};
	default { systemChat "error, no wall type specified" };
};
