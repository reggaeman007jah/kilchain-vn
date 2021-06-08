/*
This function manages creation of a basic blufor fob - walls and interior buildings 
*/

// ** imports 
private ["_fobBaseLocation"];
_fobBaseLocation = param[0]; // blufor FOB pos / spawn
// ** imports 

_rootPos = _fobBaseLocation; 

// _genesisPos = _rootPos getPos [-20,20];
// _spawnSpeed = 0.3;
// _wallSpacing = 8.7;

sleep 30;

// _rootPos = getPos Player; 

_genesisPos = _rootPos getPos [10,0];

_spawnSpeed = 0.5;



_NWCorner = _genesisPos getPos [1.7,180]; 			// NW Corner

_northBlock1 = _genesisPos getPos [5.5,90];			// north 1
_northBlock2 = _genesisPos getPos [13.9,90];		// north 2
_northBlock3 = _genesisPos getPos [22.3,90];		// north 3
_northBlock4 = _genesisPos getPos [30.7,90];		// north 4

_NECorner = _genesisPos getPos [38.2,90];			// NE Corner
_NECorner = _NECorner getPos [1.2,180];				// NE Corner v2

_eastBlock1 = _NECorner getPos [5.6,180];			// east 1
_eastBlock1 = _eastBlock1 getPos [2,90];			// east 1 v2
_eastBlock2 = _eastBlock1 getPos [8.3,180];  		// east 2
_eastBlock3 = _eastBlock1 getPos [16.7,180];		// east 3
_eastBlock4 = _eastBlock1 getPos [25.1,180];		// east 4

_SECorner = _eastBlock1 getPos [32.5, 180];			// SE Corner
_SECorner = _SECorner getPos [1.38, 270];			// SE Corner v2

_southBlock1 = _SECorner getPos [1.53,180];			// south 1
_southBlock1 = _southBlock1 getPos [5.7,270];		// south 1 v2
_southBlock2 = _southBlock1 getPos [8.47,270];		// south 2
_southBlock3 = _southBlock1 getPos [16.8,270];		// south 3
_southBlock4 = _southBlock1 getPos [25.1,270];		// south 4

_SWCorner = _southBlock1 getPos [32.5,270];			// SW Corner
_SWCorner = _SWCorner getPos [1.2,00];				// SW Corner v2

_westBlock1 = _SWCorner getPos [5.68,00];			// west 1
_westBlock1 = _westBlock1 getPos [1.8,270];			// west 1
_westBlock2 = _westBlock1 getPos [8.32,0];			// west 2
_westBlock3 = _westBlock1 getPos [16.7,0];			// west 3
_westBlock4 = _westBlock1 getPos [25,0];			// west 4

_gateBlock1 = _westBlock4 getPos [5.7,270];			// gateblock 1
_gateBlock1 = _gateBlock1 getPos [2.5,180];			// gateblock 1
_gateBlock2 = _gateBlock1 getPos [11,180];			// gateblock 1

_bunker1 = _gateBlock1 getPos [3.6,180];
_bunker1 = _bunker1 getPos [4,270];
_bunker2 = _bunker1 getPos [16,90];
_bunker2 = _bunker2 getPos [5,180];

_gateBlock3 = _bunker2 getPos [7,45];
_gateBlock3 = _gateBlock3 getPos [5,0];
_gateBlock3 = _gateBlock3 getPos [4.5,90];
// _bunker3 = _northBlock4 getPos [10,180];



_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _NWCorner; // NW Corner 
_wallBlock enableSimulation false;
_wallBlock setDir 271.068;
_NWCorner set [2,0]; 
_wallBlock setPos _NWCorner;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _northBlock1; // north 1
_wallBlock enableSimulation false;
_wallBlock setDir 1.4;
_northBlock1 set [2,0]; 
_wallBlock setPos _northBlock1;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _northBlock2; // north 2
_wallBlock enableSimulation false;
_wallBlock setDir 1.4;
_northBlock2 set [2,0]; 
_wallBlock setPos _northBlock2;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _northBlock3; // north 3
_wallBlock enableSimulation false;
_wallBlock setDir 1.4;
_northBlock3 set [2,0]; 
_wallBlock setPos _northBlock3;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _northBlock4; // north 4
_wallBlock enableSimulation false;
_wallBlock setDir 1.4;
_northBlock4 set [2,0]; 
_wallBlock setPos _northBlock4;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _NECorner; // NE Corner 
_wallBlock enableSimulation false;
_wallBlock setDir 0.483;
_NECorner set [2,0]; 
_wallBlock setPos _NECorner;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _eastBlock1; // east 1
_wallBlock enableSimulation false;
_wallBlock setDir 91.703;
_eastBlock1 set [2,0]; 
_wallBlock setPos _eastBlock1;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _eastBlock2; // east 2
_wallBlock enableSimulation false;
_wallBlock setDir 91.703;
_eastBlock2 set [2,0]; 
_wallBlock setPos _eastBlock2;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _eastBlock3; // east 3
_wallBlock enableSimulation false;
_wallBlock setDir 91.703;
_eastBlock3 set [2,0]; 
_wallBlock setPos _eastBlock3;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _eastBlock4; // east 4
_wallBlock enableSimulation false;
_wallBlock setDir 91.703;
_eastBlock4 set [2,0]; 
_wallBlock setPos _eastBlock4;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _SECorner; // SE Corner 
_wallBlock enableSimulation false;
_wallBlock setDir 91.703;
_SECorner set [2,0]; 
_wallBlock setPos _SECorner;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _southBlock1; // south 1
_wallBlock enableSimulation false;
_wallBlock setDir 181.4;
_southBlock1 set [2,0]; 
_wallBlock setPos _southBlock1;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _southBlock2; // south 2
_wallBlock enableSimulation false;
_wallBlock setDir 181.4;
_southBlock2 set [2,0]; 
_wallBlock setPos _southBlock2;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _southBlock3; // south 3
_wallBlock enableSimulation false;
_wallBlock setDir 181.4;
_southBlock3 set [2,0]; 
_wallBlock setPos _southBlock3;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _southBlock4; // south 4
_wallBlock enableSimulation false;
_wallBlock setDir 181.4;
_southBlock4 set [2,0]; 
_wallBlock setPos _southBlock4;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _SWCorner; // SW Corner
_wallBlock enableSimulation false;
_wallBlock setDir 181.4;
_SWCorner set [2,0]; 
_wallBlock setPos _SWCorner;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _westBlock1; // west 1
_wallBlock enableSimulation false;
_wallBlock setDir 271.703;
_westBlock1 set [2,0]; 
_wallBlock setPos _westBlock1;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _westBlock2; // west 2
_wallBlock enableSimulation false;
_wallBlock setDir 271.703;
_westBlock2 set [2,0]; 
_wallBlock setPos _westBlock2;
_wallBlock enableSimulation true;
sleep _spawnSpeed;
sleep _spawnSpeed;

// _wallBlock = "Land_HBarrierWall6_F" createVehicle _westBlock3; // west 3
// _wallBlock enableSimulation false;
// _wallBlock setDir 271.703;
// _westBlock3 set [2,0]; 
// _wallBlock setPos _westBlock3;
// _wallBlock enableSimulation true;
// sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _westBlock4; // west 4
_wallBlock enableSimulation false;
_wallBlock setDir 271.703;
_westBlock4 set [2,0]; 
_wallBlock setPos _westBlock4;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

// gates 
_wallBlock = "Land_HBarrier_Big_F" createVehicle _gateBlock1; // gate 1
_wallBlock enableSimulation false;
_wallBlock setDir 181.703;
_gateBlock1 set [2,0]; 
_wallBlock setPos _gateBlock1;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _gateBlock2; // gate 2
_wallBlock enableSimulation false;
_wallBlock setDir 181.703;
_gateBlock2 set [2,0]; 
_wallBlock setPos _gateBlock2;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

// bunkers 
_wallBlock = "Land_BagBunker_Small_F" createVehicle _bunker1; // bunker 1
_wallBlock enableSimulation false;
_wallBlock setDir 91.703;
_bunker1 set [2,0]; 
_wallBlock setPos _bunker1;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

// _wallBlock = "Land_BagBunker_Small_F" createVehicle _bunker2; // bunker 2
// _wallBlock enableSimulation false;
// _wallBlock setDir 91.703;
// _bunker2 set [2,0]; 
// _wallBlock setPos _bunker2;
// _wallBlock enableSimulation true;
// sleep _spawnSpeed;

_wallBlock = "Land_HBarrierTower_F" createVehicle _bunker2; // bunker 3
_wallBlock enableSimulation false;
_wallBlock setDir 91.703;
_bunker2 set [2,0]; 
_wallBlock setPos _bunker2;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _gateBlock3; // bunker 3
_wallBlock enableSimulation false;
_wallBlock setDir 90;
_gateBlock3 set [2,0]; 
_wallBlock setPos _gateBlock3;
_wallBlock enableSimulation true;
sleep _spawnSpeed;


// Land_HelipadSquare_F
_heliPadPos = _SECorner getPos [15,315];
_heliPad = "Land_HelipadSquare_F" createVehicle _heliPadPos;
sleep _spawnSpeed;

// Land_Medevac_house_V1_F
_medicHutPos = _heliPadPos getPos [10,270];
_medicHutPos = _medicHutPos getPos [5,270];
_medicHutPos = _medicHutPos getPos [2,180];
_medicHut = "Land_Medevac_house_V1_F" createVehicle _medicHutPos;
_medicHut setDir 270;
sleep _spawnSpeed;

// OFFICE 
_officePos = _medicHutPos getPos [7,270];
_office = "Land_Cargo_House_V3_F" createVehicle _officePos;
_medicHut setDir 0;
sleep _spawnSpeed;

// medic tent 
_medicTentPos = _heliPad getPos [18,0];
_medicTentPos = _medicTentPos getPos [3,90];
_medicTent = "Land_MedicalTent_01_MTP_closed_F" createVehicle _medicTentPos;
sleep _spawnSpeed;

_medicTentPos = _medicTentPos getPos [10,270];
_medicTent = "Land_MedicalTent_01_MTP_closed_F" createVehicle _medicTentPos;
sleep _spawnSpeed;


// _wallBlock = "Land_HBarrierWall6_F" createVehicle _genesisPos;
// _startPosition = _genesisPos;
// for "_i" from 1 to 5 do {
// 	_wallBlock = "Land_HBarrierWall6_F" createVehicle _startPosition;
// 	_wallBlock enableSimulation false;
// 	_wallBlock setDir 180;
// 	_wallBlockPos = getPos _wallBlock;
// 	_wallBlockPos set [2,0]; 
// 	_wallBlock setPos _wallBlockPos;
// 	_pos = _startPosition select 0;	
// 	_newPos = _pos + _wallSpacing;				
// 	_startPosition set [0, _newPos];
// 	_wallBlock enableSimulation true;
// 	sleep _spawnSpeed;	
// };

// _startPosition = _genesisPos;
// for "_i" from 1 to 5 do {
// 	_wallBlock = "Land_HBarrierWall6_F" createVehicle _startPosition;
// 	_wallBlock enableSimulation false;
// 	_wallBlock setDir 90;
// 	_wallBlockPos = getPos _wallBlock;
// 	_wallBlockPos set [2,0]; 
// 	_wallBlock setPos _wallBlockPos;
// 	_pos = _startPosition select 1;	
// 	_newPos = _pos + _wallSpacing;				
// 	_startPosition set [1, _newPos];
// 	_wallBlock enableSimulation true;
// 	sleep _spawnSpeed;	
// };

// _startPosition = _genesisPos;
// for "_i" from 1 to 5 do {
// 	_wallBlock = "Land_HBarrierWall6_F" createVehicle _startPosition;
// 	_wallBlock enableSimulation false;
// 	_wallBlock setDir 0;
// 	_wallBlockPos = getPos _wallBlock;
// 	_wallBlockPos set [2,0]; 
// 	_wallBlock setPos _wallBlockPos;
// 	_pos = _startPosition select 0;	
// 	_newPos = _pos - _wallSpacing;				
// 	_startPosition set [0, _newPos];
// 	_wallBlock enableSimulation true;
// 	sleep _spawnSpeed;	
// };

// _startPosition = _genesisPos;
// for "_i" from 1 to 5 do {
// 	_wallBlock = "Land_HBarrierWall6_F" createVehicle _startPosition;
// 	_wallBlock setDir 270;
// 	_wallBlockPos = getPos _wallBlock;
// 	_wallBlockPos set [2,0]; 
// 	_wallBlock setPos _wallBlockPos;
// 	_pos = _startPosition select 1;	
// 	_newPos = _pos - _wallSpacing;				
// 	_startPosition set [1, _newPos];
// 	sleep _spawnSpeed;	
// };

sleep 5;

// Land_HelipadSquare_F
// _heliPadPos = _rootPos getPos [10,10];
// _heliPad = "Land_HelipadSquare_F" createVehicle _heliPadPos;
// sleep _spawnSpeed;

// // Land_Medevac_house_V1_F
// _medicHutPos = _heliPadPos getPos [10,180];
// _medicHut = "Land_Medevac_house_V1_F" createVehicle _medicHutPos;
// sleep _spawnSpeed;

// //Land_MedicalTent_01_NATO_tropic_generic_outer_F
// _tentPos = _medicHutPos getPos [25,90];
// _tent = "Land_MedicalTent_01_NATO_tropic_generic_outer_F" createVehicle _tentPos;
// sleep _spawnSpeed;

// //Land_MedicalTent_01_NATO_tropic_generic_outer_F
// _tentPos = _tentPos getPos [10,180];
// _tent = "Land_MedicalTent_01_NATO_tropic_generic_outer_F" createVehicle _tentPos;
// sleep _spawnSpeed;

// // Land_MobileRadar_01_radar_F
// _radarPos = _tentPos getPos [15,260];
// _radar = "Land_MobileRadar_01_radar_F" createVehicle _radarPos;
// sleep _spawnSpeed;

// //Land_MobileRadar_01_generator_F
// _gennyPos = _radarPos getPos [6,0];
// _genny = "Land_MobileRadar_01_generator_F" createVehicle _gennyPos;
// sleep _spawnSpeed;

// // Land_Cargo_House_V2_F
// _hqPos = _gennyPos getPos [25,0];
// _hq = "Land_Cargo_House_V2_F" createVehicle _hqPos;
// sleep _spawnSpeed;

// // Land_Cargo_Patrol_V2_F
// _towerPos = _hqPos getPos [10,90];
// _hq = "Land_Cargo_Patrol_V2_F" createVehicle _towerPos;
// _hq setDir 180;
// sleep _spawnSpeed;


// ** exports 
[_fobBaseLocation] call RGG_fnc_3_spawn_bluforUnits;
[_fobBaseLocation] call RGGa_fnc_ambient_flybys_jets; 
// [_fobBaseLocation] call RGG_fnc_4_ambient_flybys; 

// ** exports 

// build blufor base
// _wall1 = Land_HBarrierWall6_F

// generate conflict zone as a large grey marker
// _battleZone = [_fobBaseLocation, 2000, 5000, 3, 0, 0, 0] call BIS_fnc_findSafePos; // generate point between 2000m and 5000m away from main base, and always over land 



// build blufor base 
// _buildLocation = _fobBaseLocation findEmptyPosition [1,50,"B_Heli_Light_01_dynamicLoadout_F"];
// _baseBuilding1 = createVehicle ["Land_MedicalTent_01_tropic_closed_F", _buildLocation, [], 30, "none"]; 

// _heliPadPos = _baseBuilding1 getPos [20,90]; 
// _heliPad = createVehicle ["Land_HelipadCircle_F", _heliPadPos];

// _fobPos = _baseBuilding1 getPos [20,180];
// sleep 0.6;
// _ammoSup = createVehicle ["Box_NATO_Support_F", _fobPos];//ammmo 
// [ "AmmoboxInit", [_ammoSup, true, {true}] ] call BIS_fnc_arsenal;
// _repairPos = _fobPos findEmptyPosition [10,100,"B_Heli_Light_01_dynamicLoadout_F"];
// _ammoSup = createVehicle ["B_Slingload_01_Repair_F", _repairPos];//vehicle repair 




/*



// // wall 1
private _startPosition = [6400,4300];
for "_i" from 1 to 5 do {
	_wallBlock = "Land_HBarrierWall6_F" createVehicle _startPosition;
	_wallBlock setDir 180;
	_wallBlockPos = getPos _wallBlock;
	_wallBlockPos set [2,0]; 
	_wallBlock setPos _wallBlockPos;
	_pos = _startPosition select 0;	
	_newPos = _pos + 8.9;				
	_startPosition set [0, _newPos];
	sleep _spawnSpeed;	
};

// // wall 2
private _startPosition = [6400,4330];
for "_i" from 1 to 5 do {
	_wallBlock = "Land_HBarrierWall6_F" createVehicle _startPosition;
	_pos = _startPosition select 0;	
	_newPos = _pos + 8.9;				
	_startPosition set [0, _newPos];
	sleep _spawnSpeed;		
// };

// // wall 3
private _startPosition = [6400,4324];
for "_i" from 1 to 3 do {
	_wallBlock = "Land_HBarrierWall6_F" createVehicle _startPosition;
	_wallBlock setDir 270;
	_wallBlockPos = getPos _wallBlock;
	_wallBlockPos set [2,0]; 
	_wallBlock setPos _wallBlockPos;
	_pos = _startPosition select 1;	
	_newPos = _pos - 8.9;				
	_startPosition set [1, _newPos];
	sleep _spawnSpeed;		
// };

// // wall 4
private _startPosition = [6438,4324];
for "_i" from 1 to 2 do {
	_wallBlock = "Land_HBarrierWall6_F" createVehicle _startPosition;
	_wallBlock setDir 90;
	_wallBlockPos = getPos _wallBlock;
	_wallBlockPos set [2,0]; 
	_wallBlock setPos _wallBlockPos;
	_pos = _startPosition select 1;	
	_newPos = _pos - 8.9;				
	_startPosition set [1, _newPos];
	sleep _spawnSpeed;		
};


// new exp 
// [6412.87,4346.68] Land_HBarrierWall_corner_F 
// [6413.55,4340.61] Land_HBarrierWall6_F
// [6413.81,4332.32] Land_HBarrierWall6_F
// [6413.82,4325.4] Land_HBarrierWall_corner_F

// genesis pos 
// _wallGenesisPos = [6412.87,4346.68];

// genesis corner block 
// _wallBlockPos = _wallGenesisPos;
// _wallBlock1 = "Land_HBarrierWall_corner_F" createVehicle _wallBlockPos;

// sleep _spawnSpeed;

// block 2
// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 0.35;
// _wallBlockPos set [0,_posAdjust];
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 6.02;
// _wallBlockPos set [1,_posAdjust];
// _wallBlock2 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock2 setDir 90;
// _wallBlockPos = getPos _wallBlock2;
// _wallBlockPos set [2,0]; 
// _wallBlock2 setPos _wallBlockPos;

// sleep _spawnSpeed;

// block 3
// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 2.8; // 3.0
// _wallBlockPos set [0,_posAdjust];
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 8; // 6.02 > 5 // 5 > 8 // 
// _wallBlockPos set [1,_posAdjust];
// _wallBlock2 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock2 setDir 90;
// _wallBlockPos = getPos _wallBlock2;
// _wallBlockPos set [2,0]; 
// _wallBlock2 setPos _wallBlockPos;

// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 2.8; // 3.0
// _wallBlockPos set [0,_posAdjust];
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 8; // 6.02 > 5 // 5 > 8 // 
// _wallBlockPos set [1,_posAdjust];
// _wallBlock2 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock2 setDir 90;
// _wallBlockPos = getPos _wallBlock2;
// _wallBlockPos set [2,0]; 
// _wallBlock2 setPos _wallBlockPos;
// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 2.8; // 3.0
// _wallBlockPos set [0,_posAdjust];

// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 2.8; // 3.0
// _wallBlockPos set [0,_posAdjust];
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 8; // 6.02 > 5 // 5 > 8 // 
// _wallBlockPos set [1,_posAdjust];
// _wallBlock2 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock2 setDir 90;
// _wallBlockPos = getPos _wallBlock2;
// _wallBlockPos set [2,0]; 
// _wallBlock2 setPos _wallBlockPos;

// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 2.8; // 3.0
// _wallBlockPos set [0,_posAdjust];
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 8; // 6.02 > 5 // 5 > 8 // 
// _wallBlockPos set [1,_posAdjust];
// _wallBlock2 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock2 setDir 90;
// _wallBlockPos = getPos _wallBlock2;
// _wallBlockPos set [2,0]; 
// _wallBlock2 setPos _wallBlockPos;

// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 2.8; // 3.0
// _wallBlockPos set [0,_posAdjust];
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 8; // 6.02 > 5 // 5 > 8 // 
// _wallBlockPos set [1,_posAdjust];
// _wallBlock2 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock2 setDir 90;
// _wallBlockPos = getPos _wallBlock2;
// _wallBlockPos set [2,0]; 
// _wallBlock2 setPos _wallBlockPos;
// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 2.8; // 3.0
// _wallBlockPos set [0,_posAdjust];
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 8; // 6.02 > 5 // 5 > 8 // 
// _wallBlockPos set [1,_posAdjust];
// _wallBlock2 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock2 setDir 90;
// _wallBlockPos = getPos _wallBlock2;
// _wallBlockPos set [2,0]; 
// _wallBlock2 setPos _wallBlockPos;
// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 2.8; // 3.0
// _wallBlockPos set [0,_posAdjust];
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 8; // 6.02 > 5 // 5 > 8 // 
// _wallBlockPos set [1,_posAdjust];
// _wallBlock2 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock2 setDir 90;
// _wallBlockPos = getPos _wallBlock2;
// _wallBlockPos set [2,0]; 
// _wallBlock2 setPos _wallBlockPos;
// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 2.8; // 3.0
// _wallBlockPos set [0,_posAdjust];
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 8; // 6.02 > 5 // 5 > 8 // 
// _wallBlockPos set [1,_posAdjust];
// _wallBlock2 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock2 setDir 90;
// _wallBlockPos = getPos _wallBlock2;
// _wallBlockPos set [2,0]; 
// _wallBlock2 setPos _wallBlockPos;

// _posAdjust2 = _wallBlockPos select 0; // grabs value of x value 
// _posAdjust2 = _posAdjust2 - 0.8; // makes manual adjustment to align thins better 	
// _wallBlockPos set [0,_posAdjust2]; // sets value 
// _wallBlock2 setPos _wallBlockPos; // resets position of block

// _posAdjust2 = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust2 = _posAdjust2 + 1; // makes manual adjustment to align thins better 	
// _wallBlockPos set [1,_posAdjust2]; // sets value 
// _wallBlock2 setPos _wallBlockPos; // resets position of block

// sleep _spawnSpeed;

// block 3
// _posAdjust = _wallBlockPos select 1; // grabs value of y value 
// _posAdjust = _posAdjust - 8.15;
// _wallBlockPos set [1,_posAdjust];
// _posAdjust = _wallBlockPos select 0; // grabs value of y value 
// _posAdjust = _posAdjust - 1;
// _wallBlockPos set [0,_posAdjust];
// _wallBlock3 = "Land_HBarrierWall6_F" createVehicle _wallBlockPos;
// _wallBlock3 setDir 90;
// _wallBlockPos = getPos _wallBlock3;
// _wallBlockPos set [2,0]; 
// _wallBlock3 setPos _wallBlockPos;

// sleep _spawnSpeed;

// block 4
// _wallBlock4 = "Land_HBarrierWall_corner_F" createVehicle [6413.82,4325.4];
// 	_wallBlock4 setDir 90; // sets initial angle 
// 	_wallBlockPos = getPos _wallBlock4; // get pos of block 
// 	_wallBlockPos set [2,0]; // sets 0 value in third position of array
// 	_wallBlock4 setPos _wallBlockPos; // resets position to ensure snapping 

// 	_posAdjust = _wallBlockPos select 1; // grabs value of y value 
// 	_posAdjust = _posAdjust - 1.5; // makes manual adjustment to stop it from clipping neighbour block 	
// 	_wallBlockPos set [1,_posAdjust]; // sets value 
// 	_wallBlock4 setPos _wallBlockPos; // resets position of block 

// 	_posAdjust2 = _wallBlockPos select 0; // grabs value of x value 
// 	_posAdjust2 = _posAdjust2 - 1; // makes manual adjustment to align thins better 	
// 	_wallBlockPos set [0,_posAdjust2]; // sets value 
// 	_wallBlock4 setPos _wallBlockPos; // resets position of block
// end exp 










