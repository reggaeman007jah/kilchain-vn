/*
This function builds a supply-base FOB 

Notes:
I use setVariable on the supply blocks to record their spawn location, so they can be respawned at the native position after being absorbed by a base 

*/

// -------------------------------------------------------------------------------------------
// setup 
systemChat "RUNNING - build_bluforSupplyDepot";

sleep 10;
_spawnSpeed = 0.5;
_mapCorner = [0,0]; // corner pos for initial spawning to hide glitching 
_object2 = _this select 0; // reference to the item dropped 
_rootPos = getPos _object2; // reference to the position of the item dropped 

// [_object2] spawn RGGb_fnc_build_blockSinker;
[_object2] spawn RGGe_fnc_effects_blockSinker;


// -------------------------------------------------------------------------------------------
// block and asset positions 

_genesisPos = _rootPos getPos [20,315];				// 20m NW of root pos 

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

_heliPadPos = _SECorner getPos [15,315];

_medicHutPos = _heliPadPos getPos [10,270];
_medicHutPos = _medicHutPos getPos [5,270];
_medicHutPos = _medicHutPos getPos [2,180];

_officePos = _medicHutPos getPos [7,270];

_food1Pos = _heliPadPos getPos [3,180];
_food2Pos = _food1Pos getPos [3,90];
_food3Pos = _food1Pos getPos [3,0];
_food4Pos = _food2Pos getPos [3,0];

_ammo1Pos = _food1Pos getPos [12,0];
_ammo2Pos = _ammo1Pos getPos [3,90];
_ammo3Pos = _ammo1Pos getPos [3,0];
_ammo4Pos = _ammo2Pos getPos [3,0];

_fuel1Pos = _food1Pos getPos [21,0];
_fuel2Pos = _fuel1Pos getPos [3,90];
_fuel3Pos = _fuel1Pos getPos [3,0];
_fuel4Pos = _fuel2Pos getPos [3,0];

// -------------------------------------------------------------------------------------------
// // generates enemy camp 
// // finds a nice little wooded area not too far from the base 
// _campRootPos = [_heliPadPos, 600, 1200, 3, 0] call BIS_fnc_findSafePos;
// _campSite = selectBestPlaces [_campRootPos, 400, "forest", 1, 1];
// _campSitePos = ((_campSite select 0) select 0);

// // comment out this marker section when ready to ship 
// _campSiteMarker = createMarker ["_campSiteSupply", _campSitePos];
// _campSiteMarker setMarkerShape "ELLIPSE";
// _campSiteMarker setMarkerColor "ColorRed";
// _campSiteMarker setMarkerSize [15, 15];
// // comment out this marker section when ready to ship 

// // load data into global condidates array
// _campData = [_campSitePos, _heliPadPos, "supply"];
// RGG_potentialEnemyCamps pushBack _campData; 

// // creates enemy base items 
// [_campSitePos, "supply"] call RGGs_fnc_spawn_opforCamp;

// -------------------------------------------------------------------------------------------
// block creation 

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _mapCorner; // NW Corner 
[_wallBlock, _NWCorner, 271.068] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // north 1
[_wallBlock, _northBlock1, 1.4] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // north 2
[_wallBlock, _northBlock2, 1.4] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // north 3
[_wallBlock, _northBlock3, 1.4] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // north 4
[_wallBlock, _northBlock4, 1.4] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _mapCorner; // NE Corner 
[_wallBlock, _NECorner, 0.483] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // east 1
[_wallBlock, _eastBlock1, 91.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // east 2
[_wallBlock, _eastBlock2, 91.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // east 3
[_wallBlock, _eastBlock3, 91.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // east 4
[_wallBlock, _eastBlock4, 91.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _mapCorner; // SE Corner 
[_wallBlock, _SECorner, 91.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // south 1
[_wallBlock, _southBlock1, 181.4] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // south 2
[_wallBlock, _southBlock2, 181.4] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // south 3
[_wallBlock, _southBlock3, 181.4] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // south 4
[_wallBlock, _southBlock4, 181.4] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _mapCorner; // SW Corner
[_wallBlock, _SWCorner, 181.4] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // west 1
[_wallBlock, _westBlock1, 271.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // west 2
[_wallBlock, _westBlock2, 271.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; // west 4
[_wallBlock, _westBlock4, 271.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

// gates 
_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner; // gate 1
[_wallBlock, _gateBlock1, 181.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner; // gate 2
[_wallBlock, _gateBlock2, 181.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

// bunkers 
_wallBlock = "Land_BagBunker_Small_F" createVehicle _mapCorner; // bunker 1
[_wallBlock, _bunker1, 91.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierTower_F" createVehicle _mapCorner; // bunker 3
[_wallBlock, _bunker2, 91.703] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner; // bunker 3
[_wallBlock, _gateBlock3, 90] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;
 
// OFFICE 

_office = "Land_Cargo_House_V3_F" createVehicle _mapCorner;
[_office, _officePos, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

// -------------------------------------------------------------------------------------------

// register main base as a blue marker
_base = createMarker ["Supply", _rootPos];
_base setMarkerShape "ELLIPSE";
_base setMarkerColor "ColorBlue";
_base setMarkerSize [50, 50];
_base setMarkerAlpha 0.5;

// sentries 
systemChat "Supply-Base Sentries Spawning In ...";
sleep 5;
[_bunker2, 0, "tower", "supply"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_SWCorner, 270, "corner", "supply"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_SECorner, 90, "corner", "supply"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_NECorner, 270, "corner", "supply"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_NWCorner, 90, "corner", "supply"] call RGGs_fnc_spawn_bluforSentries;
systemChat "Supply-Base Sentries Spawned In ...";

// ----- SUPPLIES ----- // 
systemChat "Supplies Spawning In ...";
sleep 5;

// food 
_food1 = "I_supplyCrate_F" createVehicle _mapCorner;
_food1 setVariable ["supplySpawnPos", [_food1Pos], TRUE]; 
[_food1, _food1Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Food = RGG_Supply_Food + 10;
publicVariable "RGG_Supply_Food";
sleep _spawnSpeed;

_food2 = "I_supplyCrate_F" createVehicle _mapCorner;
_food2 setVariable ["supplySpawnPos", [_food2Pos], TRUE]; 
[_food2, _food2Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Food = RGG_Supply_Food + 10;
publicVariable "RGG_Supply_Food";
sleep _spawnSpeed;

_food3 = "I_supplyCrate_F" createVehicle _mapCorner;
_food3 setVariable ["supplySpawnPos", [_food3Pos], TRUE]; 
[_food3, _food3Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Food = RGG_Supply_Food + 10;
publicVariable "RGG_Supply_Food";
sleep _spawnSpeed;

_food4 = "I_supplyCrate_F" createVehicle _mapCorner;
_food4 setVariable ["supplySpawnPos", [_food4Pos], TRUE]; 
[_food4, _food4Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Food = RGG_Supply_Food + 10;
publicVariable "RGG_Supply_Food";
sleep _spawnSpeed;

// ammo
_ammo1 = "I_CargoNet_01_ammo_F" createVehicle _mapCorner;
_ammo1 setVariable ["supplySpawnPos", [_ammo1Pos], TRUE]; 
[_ammo1, _ammo1Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Ammo = RGG_Supply_Ammo + 10;
publicVariable "RGG_Supply_Ammo";
sleep _spawnSpeed;

_ammo2 = "I_CargoNet_01_ammo_F" createVehicle _mapCorner;
_ammo2 setVariable ["supplySpawnPos", [_ammo2Pos], TRUE]; 
[_ammo2, _ammo2Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Ammo = RGG_Supply_Ammo + 10;
publicVariable "RGG_Supply_Ammo";
sleep _spawnSpeed;

_ammo3 = "I_CargoNet_01_ammo_F" createVehicle _mapCorner;
_ammo3 setVariable ["supplySpawnPos", [_ammo3Pos], TRUE]; 
[_ammo3, _ammo3Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Ammo = RGG_Supply_Ammo + 10;
publicVariable "RGG_Supply_Ammo";
sleep _spawnSpeed;

_ammo4 = "I_CargoNet_01_ammo_F" createVehicle _mapCorner;
_ammo4 setVariable ["supplySpawnPos", [_ammo4Pos], TRUE]; 
[_ammo4, _ammo4Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Ammo = RGG_Supply_Ammo + 10;
publicVariable "RGG_Supply_Ammo";
sleep _spawnSpeed;

// fuel
_fuel1 = "CargoNet_01_barrels_F" createVehicle _mapCorner;
_fuel1 setVariable ["supplySpawnPos", [_fuel1Pos], TRUE]; 
[_fuel1, _fuel1Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Fuel = RGG_Supply_Fuel + 10;
publicVariable "RGG_Supply_Fuel";
sleep _spawnSpeed;

_fuel2 = "CargoNet_01_barrels_F" createVehicle _mapCorner;
_fuel2 setVariable ["supplySpawnPos", [_fuel2Pos], TRUE]; 
[_fuel2, _fuel2Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Fuel = RGG_Supply_Fuel + 10;
publicVariable "RGG_Supply_Fuel";
sleep _spawnSpeed;

_fuel3 = "CargoNet_01_barrels_F" createVehicle _mapCorner;
_fuel3 setVariable ["supplySpawnPos", [_fuel3Pos], TRUE]; 
[_fuel3, _fuel3Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Fuel = RGG_Supply_Fuel + 10;
publicVariable "RGG_Supply_Fuel";
sleep _spawnSpeed;

_fuel4 = "CargoNet_01_barrels_F" createVehicle _mapCorner;
_fuel4 setVariable ["supplySpawnPos", [_fuel4Pos], TRUE]; 
[_fuel4, _fuel4Pos, 0] spawn RGGb_fnc_build_blockManager;
RGG_Supply_Fuel = RGG_Supply_Fuel + 10;
publicVariable "RGG_Supply_Fuel";
sleep _spawnSpeed;

sleep 5;
systemChat "Supplies Spawned In ...";

// trigger supply respawn system 
// TBC

// -------------------------------------------------------------------------------------------

// SUPPLY = true; // designates this base as active and triggers creation of next base crate (and truck)
// note, there is no other test for SUPPLY DEPOT other than dropping a crate down - all other bases will need a check  

// ----- create next spawn crate / truck -----
// [] spawn RGGs_fnc_spawn_baseSpawnCrate;
// [] spawn RGGs_fnc_spawn_baseSpawnContainer;
