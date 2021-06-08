// -------------------------------------------------------------------------------------------

RGG_riseUp = {
	params ["_block", "_pos", "_dir"];
	_block enableSimulation false;
	_pos set [2,-5];
	_block setPos _pos;
	_block setDir _dir; // ?
	
	for [{_i = -5}, {_i < 0.2}, {_i = _i + 0.1}] do {
		_pos set [2,_i]; 
		
		_block setPos _pos;
		sleep 0.1;
	};

	_pos set [2,0];
	_block setPos _pos;
	_block enableSimulation true;
};

// -------------------------------------------------------------------------------------------

sleep 10;

_object2 = _this select 0;
_object2 enableSimulation false;
_seedPos = getPos _object2;

_rootPos = getPos _object2;

for [{_i = 0}, {_i > -5}, {_i = _i - 0.1}] do {
	_seedPos set [2,_i]; 
	_object2 setPos _seedPos;
	sleep 0.1;
};

_object2 setPos [0,0];

deleteVehicle _object2;

_genesisPos = _rootPos getPos [50,0];

_spawnSpeed = 2;
// _spawnSpeedLong = 1.5;



// -------------------------------------------------------------------------------------------
// block and asset positions 

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
// block creation 

_wallBlock = "Land_BagBunker_Large_F" createVehicle [0,0];
[_wallBlock, _northCentralBunker, 180] spawn RGG_riseUp;
sleep 4;

_wallBlock = "Land_HBarrierTower_F" createVehicle [0,0]; //  
[_wallBlock, _northTowerLeft, 180] spawn RGG_riseUp;

_wallBlock = "Land_HBarrierTower_F" createVehicle [0,0]; //  
[_wallBlock, _northTowerRight, 180] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0]; // 
[_wallBlock, _northWallLeft, 181.068] spawn RGG_riseUp; 

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0]; // 
[_wallBlock, _northWallRight, 181.068] spawn RGG_riseUp; 
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle [0,0]; //  
[_wallBlock, _northWestCorner, 271.068] spawn RGG_riseUp;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle [0,0];  
[_wallBlock, _northEastCorner, 1.068] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _westWall1, 91.5] spawn RGG_riseUp;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _eastWall1, 91.5] spawn RGG_riseUp;
sleep 4;

_wallBlock = "Land_HBarrierTower_F" createVehicle [0,0]; 
[_wallBlock, _westTower1, 90] spawn RGG_riseUp; 

_wallBlock = "Land_HBarrierTower_F" createVehicle [0,0];  
[_wallBlock, _eastTower1, 270] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle [0,0];  
[_wallBlock, _westWall2, 271.5] spawn RGG_riseUp;

_wallBlock = "Land_HBarrierWall6_F" createVehicle [0,0];  
[_wallBlock, _eastWall2, 91.5] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_BagBunker_Large_F" createVehicle [0,0];  
[_wallBlock, _westBunker, 90] spawn RGG_riseUp;

_wallBlock = "Land_BagBunker_Large_F" createVehicle [0,0];  
[_wallBlock, _eastBunker, 270] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle [0,0];  
[_wallBlock, _westWall3, 271.5] spawn RGG_riseUp;

_wallBlock = "Land_HBarrierWall6_F" createVehicle [0,0]; 
[_wallBlock, _eastWall3, 91.5] spawn RGG_riseUp; 
sleep 4;

_wallBlock = "Land_HBarrierTower_F" createVehicle [0,0];  
[_wallBlock, _westTower2, 90] spawn RGG_riseUp;

_wallBlock = "Land_HBarrierTower_F" createVehicle [0,0];  
[_wallBlock, _eastTower2, 270] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];
[_wallBlock, _westWall4, 93.5] spawn RGG_riseUp;  

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _eastWall4, 91.5] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle [0,0];  
[_wallBlock, _southWestCorner, 182.5] spawn RGG_riseUp;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle [0,0];  
[_wallBlock, _southEastCorner, 92.5] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _southWallLeft, 182.5] spawn RGG_riseUp;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _southWallRight, 182.5] spawn RGG_riseUp;
sleep 4;

_wallBlock = "Land_HBarrierTower_F" createVehicle [0,0];  
[_wallBlock, _southTowerLeft, 0] spawn RGG_riseUp;

_wallBlock = "Land_HBarrierTower_F" createVehicle [0,0];  
[_wallBlock, _southTowerRight, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _leftEntranceWall, 0] spawn RGG_riseUp;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _rightEntranceWall, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_Mil_WiredFence_Gate_F" createVehicle [0,0];  
[_wallBlock, _fence, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_BagBunker_Small_F" createVehicle [0,0];  
[_wallBlock, _gateHouse, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _innerDefenceCentral, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _innerDefenceLeft, 0] spawn RGG_riseUp;

_wallBlock = "Land_HBarrier_Big_F" createVehicle [0,0];  
[_wallBlock, _innerDefenceRight, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle [0,0];  
[_wallBlock, _northCentralTent, 0] spawn RGG_riseUp;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle [0,0];  
[_wallBlock, _southCentralTent, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle [0,0];  
[_wallBlock, _northWestTent, 0] spawn RGG_riseUp;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle [0,0];  
[_wallBlock, _southWestTent, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle [0,0];  
[_wallBlock, _northEastTent, 0] spawn RGG_riseUp;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle [0,0];  
[_wallBlock, _southEastTent, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle [0,0];  
[_wallBlock, _downwashWall1, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle [0,0];  
[_wallBlock, _downwashWall2, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle [0,0]; 
[_wallBlock, _downwashWall3, 0] spawn RGG_riseUp; 
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle [0,0];  
[_wallBlock, _downwashWall4, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle [0,0];  
[_wallBlock, _downwashWall5, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle [0,0];  
[_wallBlock, _downwashWall6, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle [0,0];  
[_wallBlock, _downwashWall7, 0] spawn RGG_riseUp;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle [0,0];  
[_wallBlock, _downwashWall8, 0] spawn RGG_riseUp;
sleep 5;

_wallBlock = "Land_HelipadSquare_F" createVehicle [0,0];  
[_wallBlock, _heliPad, 0] spawn RGG_riseUp;



// spawn units from main tent
[_northCentralTent] call RGG_fnc_3_spawn_bluforUnits;

// register main base as a blue marker
_base = createMarker ["Barracks", _seedPos];
_base setMarkerShape "ELLIPSE";
_base setMarkerColor "ColorBlue";
_base setMarkerSize [50, 50];
_base setMarkerAlpha 0.5;

_units = allUnits inAreaArray "Barracks";
systemChat "here come enemy";
[_northCentralTent] call RGG_fnc_3_spawn_opforUnits;
systemChat "here is moves";
while {true} do {

	_indiFor = [];

	{if ((side _x) == independent) then {_indiFor pushBack _x}} forEach _units;

	{
		_randomMovePos = [["Barracks"]] call BIS_fnc_randomPos;
		_behaviour = selectRandom ["safe", "aware"];
		_x setBehaviour _behaviour;
		_x doMove _randomMovePos;
		sleep 0.5;
		
	} forEach _indiFor;

	sleep 30;
};












































/*




// sleep 0.5;
// setAccTime 4;
// _rootPos = getPos Player; 
// _rootPos = _this select 0;
// _object2 = _this select 0;

// _rootPos = getPos _object2;
// deleteVehicle _object2;

sleep 10;
// setAccTime 4;
// _rootPos = getPos Player; 
// _rootPos = _this select 0;
_object2 = _this select 0;

_rootPos = getPos _object2;
deleteVehicle _object2;

_genesisPos = _rootPos getPos [50,0];

_spawnSpeed = 0.5;


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


// -------------------------------------------


_wallBlock = "Land_BagBunker_Large_F" createVehicle _northCentralBunker; //  
_wallBlock enableSimulation false;
_wallBlock setDir 180;
_northCentralBunker set [2,0]; 
_wallBlock setPos _northCentralBunker;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierTower_F" createVehicle _northTowerLeft; //  
_wallBlock enableSimulation false;
_wallBlock setDir 180;
_northTowerLeft set [2,0]; 
_wallBlock setPos _northTowerLeft;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrierTower_F" createVehicle _northTowerRight; //  
_wallBlock enableSimulation false;
_wallBlock setDir 180;
_northTowerRight set [2,0]; 
_wallBlock setPos _northTowerRight;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _northWallLeft; //  
_wallBlock enableSimulation false;
_wallBlock setDir 181.068;
_northWallLeft set [2,0]; 
_wallBlock setPos _northWallLeft;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _northWallRight; //  
_wallBlock enableSimulation false;
_wallBlock setDir 181.068;
_northWallRight set [2,0]; 
_wallBlock setPos _northWallRight;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _northWestCorner; //  
_wallBlock enableSimulation false;
_wallBlock setDir 271.068;
_northWestCorner set [2,0]; 
_wallBlock setPos _northWestCorner;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _northEastCorner;  
_wallBlock enableSimulation false;
_wallBlock setDir 1.068;
_northEastCorner set [2,0]; 
_wallBlock setPos _northEastCorner;
_wallBlock enableSimulation true;
sleep _spawnSpeed;



_wallBlock = "Land_HBarrier_Big_F" createVehicle _westWall1;  
_wallBlock enableSimulation false;
_wallBlock setDir 91.5;
_westWall1 set [2,0]; 
_wallBlock setPos _westWall1;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _eastWall1;  
_wallBlock enableSimulation false;
_wallBlock setDir 91.5;
_eastWall1 set [2,0]; 
_wallBlock setPos _eastWall1;
_wallBlock enableSimulation true;
sleep _spawnSpeed;



_wallBlock = "Land_HBarrierTower_F" createVehicle _westTower1;  
_wallBlock enableSimulation false;
_wallBlock setDir 90;
_westTower1 set [2,0]; 
_wallBlock setPos _westTower1;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrierTower_F" createVehicle _eastTower1;  
_wallBlock enableSimulation false;
_wallBlock setDir 270;
_eastTower1 set [2,0]; 
_wallBlock setPos _eastTower1;
_wallBlock enableSimulation true;
sleep _spawnSpeed;


_wallBlock = "Land_HBarrierWall6_F" createVehicle _westWall2;  
_wallBlock enableSimulation false;
_wallBlock setDir 271.5;
_westWall2 set [2,0]; 
_wallBlock setPos _westWall2;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _eastWall2;  
_wallBlock enableSimulation false;
_wallBlock setDir 91.5;
_eastWall2 set [2,0]; 
_wallBlock setPos _eastWall2;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_BagBunker_Large_F" createVehicle _westBunker;  
_wallBlock enableSimulation false;
_wallBlock setDir 90;
_westBunker set [2,0]; 
_wallBlock setPos _westBunker;
_wallBlock enableSimulation true;

_wallBlock = "Land_BagBunker_Large_F" createVehicle _eastBunker;  
_wallBlock enableSimulation false;
_wallBlock setDir 270;
_eastBunker set [2,0]; 
_wallBlock setPos _eastBunker;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _westWall3;  
_wallBlock enableSimulation false;
_wallBlock setDir 271.5;
_westWall3 set [2,0]; 
_wallBlock setPos _westWall3;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrierWall6_F" createVehicle _eastWall3;  
_wallBlock enableSimulation false;
_wallBlock setDir 91.5; 
_eastWall3 set [2,0]; 
_wallBlock setPos _eastWall3;
_wallBlock enableSimulation true;
sleep _spawnSpeed;


_wallBlock = "Land_HBarrierTower_F" createVehicle _westTower2;  
_wallBlock enableSimulation false;
_wallBlock setDir 90;
_westTower2 set [2,0]; 
_wallBlock setPos _westTower2;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrierTower_F" createVehicle _eastTower2;  
_wallBlock enableSimulation false;
_wallBlock setDir 270;
_eastTower2 set [2,0]; 
_wallBlock setPos _eastTower2;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _westWall4;  
_wallBlock enableSimulation false;
_wallBlock setDir 93.5;
_westWall4 set [2,0]; 
_wallBlock setPos _westWall4;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _eastWall4;  
_wallBlock enableSimulation false;
_wallBlock setDir 91.5;
_eastWall4 set [2,0]; 
_wallBlock setPos _eastWall4;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _southWestCorner;  
_wallBlock enableSimulation false;
_wallBlock setDir 182.5;
_southWestCorner set [2,0]; 
_wallBlock setPos _southWestCorner;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrierWall_corner_F" createVehicle _southEastCorner;  
_wallBlock enableSimulation false;
_wallBlock setDir 92.5;
_southEastCorner set [2,0]; 
_wallBlock setPos _southEastCorner;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _southWallLeft;  
_wallBlock enableSimulation false;
_wallBlock setDir 182.5;
_southWallLeft set [2,0]; 
_wallBlock setPos _southWallLeft;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _southWallRight;  
_wallBlock enableSimulation false;
_wallBlock setDir 182.5;
_southWallRight set [2,0]; 
_wallBlock setPos _southWallRight;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrierTower_F" createVehicle _southTowerLeft;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_southTowerLeft set [2,0]; 
_wallBlock setPos _southTowerLeft;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrierTower_F" createVehicle _southTowerRight;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_southTowerRight set [2,0]; 
_wallBlock setPos _southTowerRight;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _leftEntranceWall;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_leftEntranceWall set [2,0]; 
_wallBlock setPos _leftEntranceWall;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _rightEntranceWall;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_rightEntranceWall set [2,0]; 
_wallBlock setPos _rightEntranceWall;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_Mil_WiredFence_Gate_F" createVehicle _fence;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_fence set [2,0]; 
_wallBlock setPos _fence;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_BagBunker_Small_F" createVehicle _gateHouse;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_gateHouse set [2,0]; 
_wallBlock setPos _gateHouse;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _innerDefenceCentral;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_innerDefenceCentral set [2,0]; 
_wallBlock setPos _innerDefenceCentral;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _innerDefenceLeft;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_innerDefenceLeft set [2,0]; 
_wallBlock setPos _innerDefenceLeft;
_wallBlock enableSimulation true;

_wallBlock = "Land_HBarrier_Big_F" createVehicle _innerDefenceRight;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_innerDefenceRight set [2,0]; 
_wallBlock setPos _innerDefenceRight;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _northCentralTent;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_northCentralTent set [2,0]; 
_wallBlock setPos _northCentralTent;
_wallBlock enableSimulation true;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _southCentralTent;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_southCentralTent set [2,0]; 
_wallBlock setPos _southCentralTent;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _northWestTent;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_northWestTent set [2,0]; 
_wallBlock setPos _northWestTent;
_wallBlock enableSimulation true;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _southWestTent;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_southWestTent set [2,0]; 
_wallBlock setPos _southWestTent;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _northEastTent;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_northEastTent set [2,0]; 
_wallBlock setPos _northEastTent;
_wallBlock enableSimulation true;

_wallBlock = "Land_MedicalTent_01_NATO_generic_open_F" createVehicle _southEastTent;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_southEastTent set [2,0]; 
_wallBlock setPos _southEastTent;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _downwashWall1;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_downwashWall1 set [2,0]; 
_wallBlock setPos _downwashWall1;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _downwashWall2;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_downwashWall2 set [2,0]; 
_wallBlock setPos _downwashWall2;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _downwashWall3;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_downwashWall3 set [2,0]; 
_wallBlock setPos _downwashWall3;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _downwashWall4;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_downwashWall4 set [2,0]; 
_wallBlock setPos _downwashWall4;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _downwashWall5;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_downwashWall5 set [2,0]; 
_wallBlock setPos _downwashWall5;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _downwashWall6;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_downwashWall6 set [2,0]; 
_wallBlock setPos _downwashWall6;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _downwashWall7;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_downwashWall7 set [2,0]; 
_wallBlock setPos _downwashWall7;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_SilageWall_01_l_5m_F" createVehicle _downwashWall8;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_downwashWall8 set [2,0]; 
_wallBlock setPos _downwashWall8;
_wallBlock enableSimulation true;
sleep _spawnSpeed;

_wallBlock = "Land_HelipadSquare_F" createVehicle _heliPad;  
_wallBlock enableSimulation false;
_wallBlock setDir 0;
_heliPad set [2,0]; 
_wallBlock setPos _heliPad;
_wallBlock enableSimulation true;
sleep _spawnSpeed;


// _northWestTent = _northCentralTent getPos [8,270];
// _southWestTent = _northCentralTent getPos [8,270];

// _northEastTent = _northCentralTent getPos [8,90];
// _southEastTent = _northCentralTent getPos [8,90];


/*
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

/*
//Land_MedicalTent_01_NATO_tropic_generic_outer_F
_tentPos = _medicHutPos getPos [25,90];
_tent = "Land_MedicalTent_01_NATO_tropic_generic_outer_F" createVehicle _tentPos;
sleep _spawnSpeed;

//Land_MedicalTent_01_NATO_tropic_generic_outer_F
// _tentPos = _tentPos getPos [10,180];
// _tent = "Land_MedicalTent_01_NATO_tropic_generic_outer_F" createVehicle _tentPos;
// sleep _spawnSpeed;

// Land_MobileRadar_01_radar_F
_radarPos = _tentPos getPos [15,260];
_radar = "Land_MobileRadar_01_radar_F" createVehicle _radarPos;
sleep _spawnSpeed;

//Land_MobileRadar_01_generator_F
_gennyPos = _radarPos getPos [6,0];
_genny = "Land_MobileRadar_01_generator_F" createVehicle _gennyPos;
sleep _spawnSpeed;

// Land_Cargo_House_V2_F
_hqPos = _gennyPos getPos [25,0];
_hq = "Land_Cargo_House_V2_F" createVehicle _hqPos;
sleep _spawnSpeed;

// Land_Cargo_Patrol_V2_F
_towerPos = _hqPos getPos [10,90];
_hq = "Land_Cargo_Patrol_V2_F" createVehicle _towerPos;
_hq setDir 180;
sleep _spawnSpeed;