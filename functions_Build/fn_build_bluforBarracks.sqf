/*
This function builds a barracks FOB complex
*/

// -------------------------------------------------------------------------------------------
// setup
systemChat "RUNNING - build_bluforBarracks";

sleep 10;
_spawnSpeed = 0.1;
_mapCorner = [0,0]; // corner pos for initial spawning to hide glitching 
_object2 = _this select 0; // reference to the item dropped 
_rootPos = getPos _object2; // reference to the position of the item dropped 

// [_object2] spawn RGGb_fnc_build_blockSinker;
[_object2] spawn RGGe_fnc_effects_blockSinker;

_base = createMarker ["Barracks", _rootPos];
_base setMarkerShape "ELLIPSE";
_base setMarkerColor "ColorGreen";
_base setMarkerSize [50, 50];
_base setMarkerAlpha 0.5;

// -------------------------------------------------------------------------------------------
// block and asset positions 

_genesisPos = _rootPos getPos [50,0];

_northCentralBunker = _genesisPos;

_northTowerLeft = _northCentralBunker getPos [8,270];
_northTowerLeft = _northTowerLeft getPos [7,180];
_northTowerRight = _northCentralBunker getPos [8,90];
_northTowerRight = _northTowerRight getPos [7,180];

_northWallLeft = _northTowerLeft getPos [7.8,270];
_northWallRight = _northTowerRight getPos [7.8,90];

_northWestCorner = _northWallLeft getPos [7.8,270];
_northWestCorner = _northWestCorner getPos [1.6,180];
_northWestCorner = _northWestCorner getPos [1.5,90];
_northEastCorner = _northWallRight getPos [7.8,90];
_northEastCorner = _northEastCorner getPos [1.2,180];
_northEastCorner = _northEastCorner getPos [.7,270];

_westWall1 = _northWestCorner getPos [7.1,180];
_westWall1 = _westWall1 getPos [1.3,270];
_eastWall1 = _northEastCorner getPos [6.28,180]; 
_eastWall1 = _eastWall1 getPos [1.4,90]; 

_westTower1 = _northWestCorner getPos [14.8,180];
_westTower1 = _westTower1 getPos [2.2,270];

_eastTower1 = _northEastCorner getPos [14.2,180];
_eastTower1 = _eastTower1 getPos [2.5,90];

_westWall2 = _northWestCorner getPos [22.9,180];
_westWall2 = _westWall2 getPos [5.5,270];

_eastWall2 = _northEastCorner getPos [21.35,180];
_eastWall2 = _eastWall2 getPos [5.9,90];

_westBunker = _northWestCorner getPos [31.2,180];
_westBunker = _westBunker getPos [9.8,270];

_eastBunker = _northEastCorner getPos [30.6,180];
_eastBunker = _eastBunker getPos [10.4,90];

_westWall3 = _northWestCorner getPos [40.4,180];
_westWall3 = _westWall3 getPos [5.5,270];

_eastWall3 = _northEastCorner getPos [38.9,180];
_eastWall3 = _eastWall3 getPos [5.9,90];

_westTower2 = _northWestCorner getPos [47.5,180];
_westTower2 = _westTower2 getPos [2,270];

_eastTower2 = _northEastCorner getPos [47,180];
_eastTower2 = _eastTower2 getPos [2.4,90];

_westWall4 = _northWestCorner getPos [55.2,180];
_westWall4 = _westWall4 getPos [.9,270];

_eastWall4 = _northEastCorner getPos [54.7,180];
_eastWall4 = _eastWall4 getPos [1.8,90];

_southWestCorner = _northWestCorner getPos [61.5,180];
_southWestCorner = _southWestCorner getPos [0.7,90];

_southEastCorner = _northEastCorner getPos [61.9,180];
_southEastCorner = _southEastCorner getPos [0.9,90];

_southWallLeft = _southWestCorner getPos [7.2,90];
_southWallLeft = _southWallLeft getPos [1.2,180];

_southWallRight = _southEastCorner getPos [6.2,270];
_southWallRight = _southWallRight getPos [1.5,180];

_southTowerLeft = _southWestCorner getPos [14.9,90];
_southTowerLeft = _southTowerLeft getPos [2.3,180];

_southTowerRight = _southEastCorner getPos [14,270];
_southTowerRight = _southTowerRight getPos [2.6,180];

_leftEntranceWall = _southTowerLeft getPos [5.9,180];
_leftEntranceWall = _leftEntranceWall getPos [2,90];

_rightEntranceWall = _southTowerRight getPos [5.9,180];
_rightEntranceWall = _rightEntranceWall getPos [2,270];

_fence = _genesisPos getPos [77.3,180];
_fence = _fence getPos [1.6,90];

_gateHouse = _genesisPos getPos [70,180];
_gateHouse = _gateHouse getPos [1.6,90];

_innerDefenceCentral = _genesisPos getPos [64,180];
_innerDefenceCentral = _innerDefenceCentral getPos [1.6,90];

_innerDefenceLeft = _innerDefenceCentral getPos [8.5,270];
_innerDefenceRight = _innerDefenceCentral getPos [8.5,90];

_northCentralTent = _genesisPos getPos [20,180];
_southCentralTent = _genesisPos getPos [30,180];

_northWestTent = _northCentralTent getPos [10,270];
_southWestTent = _southCentralTent getPos [10,270];

_northEastTent = _northCentralTent getPos [10,90];
_southEastTent = _southCentralTent getPos [10,90];

_downwashWall1 = _genesisPos getPos [40,180];
_downwashWall1 = _downwashWall1 getPos [20,270];
_downwashWall2 = _downwashWall1 getPos [5,90];
_downwashWall3 = _downwashWall1 getPos [10,90];
_downwashWall4 = _downwashWall1 getPos [15,90];
_downwashWall5 = _downwashWall1 getPos [20,90];
_downwashWall6 = _downwashWall1 getPos [25,90];
_downwashWall7 = _downwashWall1 getPos [30,90];
_downwashWall8 = _downwashWall1 getPos [35,90];

_helipad = _genesisPos getPos [51,180];


// -------------------------------------------------------------------------------------------
// generates enemy camp 
// finds a nice little wooded area not too far from the base 
_campRootPos = [_helipad, 600, 1200, 3, 0] call BIS_fnc_findSafePos;
_campSite = selectBestPlaces [_campRootPos, 400, "forest", 1, 1];
_campSitePos = ((_campSite select 0) select 0);

// comment out this marker section when ready to ship 
_campSiteMarker = createMarker ["_campSiteBarracks", _campSitePos];
_campSiteMarker setMarkerShape "ELLIPSE";
_campSiteMarker setMarkerColor "ColorRed";
_campSiteMarker setMarkerSize [15, 15];
// comment out this marker section when ready to ship 

// load data into global condidates array
_campData = [_campSitePos, _heliPad, "barracks"];
RGG_potentialEnemyCamps pushBack _campData; 

// creates enemy base items 
[_campSitePos, "barracks"] call RGGs_fnc_spawn_opforCamp;

// -------------------------------------------------------------------------------------------
// block creation 

_wallBlock = "Land_BagBunker_Large_F" createVehicle _mapCorner;
[_wallBlock, _northCentralBunker, 180] spawn RGGb_fnc_build_blockManager;
sleep 4;

_wallBlock = "Land_HBarrierTower_F" createVehicle _mapCorner; //  
[_wallBlock, _northTowerLeft, 180] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrierTower_F" createVehicle _mapCorner; //  
[_wallBlock, _northTowerRight, 180] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner; // 
[_wallBlock, _northWallLeft, 181.068] spawn RGGb_fnc_build_blockManager; 

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner; // 
[_wallBlock, _northWallRight, 181.068] spawn RGGb_fnc_build_blockManager; 
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _mapCorner; //  
[_wallBlock, _northWestCorner, 271.068] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _mapCorner;  
[_wallBlock, _northEastCorner, 1.068] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _westWall1, 91.5] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _eastWall1, 91.5] spawn RGGb_fnc_build_blockManager;
sleep 4;

_wallBlock = "Land_HBarrierTower_F" createVehicle _mapCorner; 
[_wallBlock, _westTower1, 90] spawn RGGb_fnc_build_blockManager; 

_wallBlock = "Land_HBarrierTower_F" createVehicle _mapCorner;  
[_wallBlock, _eastTower1, 270] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner;  
[_wallBlock, _westWall2, 271.5] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner;  
[_wallBlock, _eastWall2, 91.5] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_BagBunker_Large_F" createVehicle _mapCorner;  
[_wallBlock, _westBunker, 90] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_BagBunker_Large_F" createVehicle _mapCorner;  
[_wallBlock, _eastBunker, 270] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner;  
[_wallBlock, _westWall3, 271.5] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _mapCorner; 
[_wallBlock, _eastWall3, 91.5] spawn RGGb_fnc_build_blockManager; 
sleep 4;

_wallBlock = "Land_HBarrierTower_F" createVehicle _mapCorner;  
[_wallBlock, _westTower2, 90] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrierTower_F" createVehicle _mapCorner;  
[_wallBlock, _eastTower2, 270] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;
[_wallBlock, _westWall4, 93.5] spawn RGGb_fnc_build_blockManager;  

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _eastWall4, 91.5] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _mapCorner;  
[_wallBlock, _southWestCorner, 182.5] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _mapCorner;  
[_wallBlock, _southEastCorner, 92.5] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _southWallLeft, 182.5] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _southWallRight, 182.5] spawn RGGb_fnc_build_blockManager;
sleep 4;

_wallBlock = "Land_HBarrierTower_F" createVehicle _mapCorner;  
[_wallBlock, _southTowerLeft, 0] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrierTower_F" createVehicle _mapCorner;  
[_wallBlock, _southTowerRight, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _leftEntranceWall, 0] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _rightEntranceWall, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_Mil_WiredFence_Gate_F" createVehicle _mapCorner;  
[_wallBlock, _fence, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_BagBunker_Small_F" createVehicle _mapCorner;  
[_wallBlock, _gateHouse, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _innerDefenceCentral, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _innerDefenceLeft, 0] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _mapCorner;  
[_wallBlock, _innerDefenceRight, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _mapCorner;  
[_wallBlock, _northCentralTent, 0] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _mapCorner;  
[_wallBlock, _southCentralTent, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _mapCorner;  
[_wallBlock, _northWestTent, 0] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _mapCorner;  
[_wallBlock, _southWestTent, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _mapCorner;  
[_wallBlock, _northEastTent, 0] spawn RGGb_fnc_build_blockManager;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _mapCorner;  
[_wallBlock, _southEastTent, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _mapCorner;  
[_wallBlock, _downwashWall1, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _mapCorner;  
[_wallBlock, _downwashWall2, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _mapCorner; 
[_wallBlock, _downwashWall3, 0] spawn RGGb_fnc_build_blockManager; 
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _mapCorner;  
[_wallBlock, _downwashWall4, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _mapCorner;  
[_wallBlock, _downwashWall5, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _mapCorner;  
[_wallBlock, _downwashWall6, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _mapCorner;  
[_wallBlock, _downwashWall7, 0] spawn RGGb_fnc_build_blockManager;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _mapCorner;  
[_wallBlock, _downwashWall8, 0] spawn RGGb_fnc_build_blockManager;
sleep 5;

_wallBlock = "Land_HelipadSquare_F" createVehicle _mapCorner;  
[_wallBlock, _heliPad, 0] spawn RGGb_fnc_build_blockManager;

// create invisible marker for supply drops 
_barracksDZ = createMarker ["Barracks_DZ", _heliPad];
_barracksDZ setMarkerShape "ELLIPSE";
// _barracksDZ setMarkerColor "ColorRed";
_barracksDZ setMarkerSize [15, 15];
// _barracksDZ setMarkerAlpha 0.5;

// systemChat "there is an enemy attack on your barracks FOB";
// [_heliPad] call RGG_fnc_3_spawn_opforUnits;

// this manages ambient movement within the base

// spawn baseline units from main tent
// [_northCentralTent, 6, "Barracks"] call RGGs_fnc_spawn_bluforBaseMinCrew;

systemChat "Barracks Sentries Spawning In ...";
sleep 5;
[_northTowerLeft, 0, "tower", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_northTowerRight, 0, "tower", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_westTower1, 270, "tower", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_eastTower1, 90, "tower", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_westTower2, 270, "tower", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_eastTower2, 90, "tower", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_southTowerLeft, 180, "tower", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_southTowerRight, 180, "tower", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_westWall2, 270, "wall", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_westWall3, 270, "wall", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_eastWall2, 90, "wall", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_eastWall3, 90, "wall", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_northWestCorner, 270, "corner", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_northEastCorner, 90, "corner", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_southWestCorner, 270, "corner", "barracks"] call RGGs_fnc_spawn_bluforSentries;
sleep 1;
[_southEastCorner, 270, "corner", "barracks"] call RGGs_fnc_spawn_bluforSentries;
systemChat "Barracks Sentries Spawned In ...";

// -------------------------------------------------------------------------------------------

BARRACKS = true; // designates this base as active and triggers creation of next base crate (and truck)

// ----- create next spawn crate / truck -----
// [] spawn RGGs_fnc_spawn_baseSpawnCrate;
[] spawn RGGs_fnc_spawn_baseSpawnContainer;





// _units = allUnits inAreaArray "Barracks";
// _indiFor = [];
// { if ((side _x) == independent) then {_indiFor pushBack _x} } forEach _units;

// // defence locations 
// _defenceLocations = [_northCentralBunker, _northTowerLeft, _northTowerRight, _northWestCorner, _northEastCorner, _westTower1, _eastTower1, _westBunker, _eastBunker, _westTower2, _eastTower2, _southWestCorner, _southEastCorner, _southTowerLeft, _southTowerRight, _gateHouse];


// {
// 	// _randomMovePos = [["Barracks"]] call BIS_fnc_randomPos;
// 	// _behaviour = selectRandom ["safe", "aware"];
// 	// _x setBehaviour _behaviour;
// 	// _x doMove _randomMovePos;
// 	_randomPos = selectRandom _defenceLocations;
// 	_building = nearestObjects [_randomPos, ["House", "Building"], 5] select 0;
// 	// systemChat str _building;
// 	// _nBuilding = nearestBuilding _randomPos;
// 	_x doMove (_building buildingPos 1);
// 	// _x doMove _nBuilding;
// 	systemChat format ["indifor unit moving to: %1", _building];
	
// 	sleep 5;
	
// } forEach _indiFor;


