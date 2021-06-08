/*
NOTE - currently not in use 

This function generates minimum base ground crew  

requires: spawn location 
*/

// ** imports 
// _fobBaseLocation
systemChat "RUNNING - spawn_baseMinCrew";
private ["_spawnPoint", "_spawnNumber", "_markerArea"];

// private ["_bluforFob", "_opforFob", "_initialBluforInfiPresence", "_initialBluforVicPresence", "_battleZone"];
// _bluforFob = param[0]; // blufor FOB pos / spawn 
// _opforFob = param[1]; //opfor FOB pos / spawn 
// _initialBluforInfiPresence = param[2]; // size of blufor infi force
// _initialBluforVicPresence = param[3]; // size of blufor vic force
// _battleZone = param[4];
_spawnPoint = param[0];
_spawnNumber = param[1];
_markerArea = param[2];
_indiGroup = createGroup independent;
_fireTeam = [];
// _fireTeamCount = count _fireteam;
// systemChat format ["initial fireteam count: %1", _fireTeamCount];
// systemChat format ["parsed marker value: %1", _markerArea];

// create basic base units 
for "_i" from 1 to _spawnNumber do {
	
	_unit = _indiGroup createUnit ["B_G_Soldier_A_F", _spawnPoint, [], 0, "FORM"];
	_unit setBehaviour "careless";
	_fireTeam pushBack _unit;
	systemChat "unit created";
	sleep 5;
	
};

// {
// 	_x setBehaviour "careless";
// } forEach _fireTeam;

// _markerArea = "Barracks";

	// _fireTeam = [];
	// _unit1 = _indiGroup createUnit ["I_soldier_F", _spawnPoint, [], 0.1, "none"]; 
	// _unit2 = _indiGroup createUnit ["I_support_MG_F", _spawnPoint, [], 0.1, "none"]; 
	// _unit3 = _indiGroup createUnit ["I_Soldier_GL_F", _spawnPoint, [], 0.1, "none"]; 
	// _unit4 = _indiGroup createUnit ["I_Soldier_M_F", _spawnPoint, [], 0.1, "none"]; 
	// _unit5 = _indiGroup createUnit ["I_medic_F", _spawnPoint, [], 0.1, "none"]; 
	// _fireTeam pushBack _unit1;
	// _fireTeam pushBack _unit2;
	// _fireTeam pushBack _unit3;
	// _fireTeam pushBack _unit4;
	// _fireTeam pushBack _unit5;
	// systemChat str _fireTeam;


_fireTeamCount = count _fireteam;
// systemChat format ["second fireteam count: %1", _fireTeamCount];
// systemChat format ["second parsed marker value: %1", _markerArea];


while {_fireTeamCount > 1} do {

	// _indiFor = [];

	// {if ((side _x) == independent) then {_indiFor pushBack _x}} forEach _units;

	{
		_randomMovePos = [ [_markerArea] ] call BIS_fnc_randomPos;
		// systemChat format ["marker value: %1", _markerArea];
		// _behaviour = selectRandom ["safe", "aware"];
		// _x setBehaviour "careless";
		_x doMove _randomMovePos;
		// sleep 0.5;
		
	} forEach _fireTeam;

	_fireTeamCount = count _fireteam;
	
	sleep 60;
	systemChat format ["There are %1 units wandering around %2", _fireTeamCount, _markerArea]
};


// _unit3 = _indiGroup createUnit ["B_G_Soldier_A_F", _eastBunker, [], 0, "NONE"];
// sleep 1;
// _unit3 = _indiGroup createUnit ["B_G_Soldier_A_F", _eastBunker, [], 0, "NONE"];
// sleep 1;
// _unit3 = _indiGroup createUnit ["B_G_Soldier_A_F", _westBunker, [], 0, "NONE"];
// sleep 1;
// _unit3 = _indiGroup createUnit ["B_G_Soldier_A_F", _westBunker, [], 0, "NONE"];
// sleep 1;
// _unit3 = _indiGroup createUnit ["B_G_Soldier_A_F", _northBunker, [], 0, "NONE"];
// sleep 1;
// _unit3 = _indiGroup createUnit ["B_G_Soldier_A_F", _northBunker, [], 0, "NONE"];
// sleep 1;
// _unit3 = _indiGroup createUnit ["B_G_Soldier_A_F", _gateHouse, [], 0, "NONE"];
// sleep 1;
// _unit3 = _indiGroup createUnit ["B_G_Soldier_A_F", _gateHouse, [], 0, "NONE"];



// _eastBunker = param[1];
// _westBunker = param[2];
// _northBunker = param[3];
// _gateHouse = param[4];
// ** imports 


// test markers 
// create invisible marker for supply drops 
// _northBunkerMarker = createMarker ["_northBunker", _northBunker];
// _northBunkerMarker setMarkerShape "ELLIPSE";
// _northBunkerMarker setMarkerColor "ColorRed";
// _northBunkerMarker setMarkerSize [15, 15];
// _northBunkerMarker setMarkerAlpha 0.5;

// _eastBunkerMarker = createMarker ["_eastBunker", _eastBunker];
// _eastBunkerMarker setMarkerShape "ELLIPSE";
// _eastBunkerMarker setMarkerColor "ColorRed";
// _eastBunkerMarker setMarkerSize [15, 15];
// _eastBunkerMarker setMarkerAlpha 0.5;

// _westBunkerMarker = createMarker ["_westBunker", _westBunker];
// _westBunkerMarker setMarkerShape "ELLIPSE";
// _westBunkerMarker setMarkerColor "ColorRed";
// _westBunkerMarker setMarkerSize [15, 15];
// _westBunkerMarker setMarkerAlpha 0.5;

// _gatehouseMarker = createMarker ["_gatehouse", _gatehouse];
// _gatehouseMarker setMarkerShape "ELLIPSE";
// _gatehouseMarker setMarkerColor "ColorRed";
// _gatehouseMarker setMarkerSize [15, 15];
// _gatehouseMarker setMarkerAlpha 0.5;


// _spawnPos = _this select 0; // position parsed to this script on execution // IS THIS NEEDED?
// _numberOfCycles = _this select 1; // number of times we run this // 4 = 4 fire teams  
_numberOfCycles = 2; //   
// _area = 2; // distribution of units on spawn  
// _timer = 1; // spawn cycle gap  
// _nBuilding = nearestBuilding _fobBaseLocation;
// _allPositions = nearestBuilding _nBuilding buildingPos -1;
// _countPositions = count _allPositions;
// systemChat format ["Available Positions: %1", _countPositions];

// _indiGroup = createGroup independent;

// for "_i" from 1 to _numberOfCycles do {
// 	_indiGroup = createGroup independent;
// 	_unit4 = _indiGroup createUnit ["B_G_Soldier_A_F", _spawnPoint, [], 0, "FORM"];
// 	_nBuildingGate = nearestBuilding _gateHouse;
// 	_allPositions = nearestBuilding _nBuildingGate buildingPos -1;
// 	_countPositions = count _allPositions;
// 		_countPositions = _countPositions -1;
// 	_randomPos = random _countPositions;
// 	_testPos = _allPositions select _randomPos;
// 	_unit4 doMove _testPos;
// 	systemChat "unit moving into gatehouse";
// 	sleep 5;
// };

// sleep 5;

// for "_i" from 1 to _numberOfCycles do {
// 	_indiGroup = createGroup independent;
// 	_unit = _indiGroup createUnit ["B_G_Soldier_A_F", _spawnPoint, [], 0, "FORM"];
// 	_nBuilding = nearestBuilding _northBunker;
// 	_allPositions = nearestBuilding _nBuilding buildingPos -1;
// 	_countPositions = count _allPositions;
// 		_countPositions = _countPositions -1;
// 	_randomPos = random _countPositions;
// 	_testPos = _allPositions select _randomPos;
// 	_unit doMove _testPos;
// 	systemChat "unit moving into north bunker";
// 	sleep 5;
// };

// sleep 5;

// for "_i" from 1 to _numberOfCycles do {
// 	_indiGroup = createGroup independent;
// 	_unit2 = _indiGroup createUnit ["B_G_Soldier_A_F", _spawnPoint, [], 0, "FORM"];
// 	_nBuilding = nearestBuilding _eastBunker;
// 	_allPositions = nearestBuilding _nBuilding buildingPos -1;
// 	_countPositions = count _allPositions;
// 		_countPositions = _countPositions -1;
// 	_randomPos = random _countPositions;
// 	_testPos = _allPositions select _randomPos;
// 	_unit2 doMove _testPos;
// 	systemChat "unit moving into east bunker";
// 	sleep 5;
// };




	// _nBuildingWest = nearestObject _westBunker;
	// systemChat format ["Nearest Building: %1", _nBuildingWest];

	// sleep 2;

	// _allPositions = nearestBuilding _nBuildingWest buildingPos -1;
	// systemChat format ["Positions: %1", _allPositions];

	// sleep 2;

	// _testMarkerPos = _allPositions select 0;
	// _gatehouseMarker2 = createMarker ["_gatehouse2", _testMarkerPos];
	// _gatehouseMarker2 setMarkerShape "ELLIPSE";
	// _gatehouseMarker2 setMarkerColor "ColorGreen";
	// _gatehouseMarker2 setMarkerSize [25, 25];
	

	// sleep 2;

	// _countPositions = count _allPositions;
	// systemChat format ["Positions Count: %1", _countPositions];

	// sleep 2;

	// // _countPositions = _countPositions -1;

	// _randomPos = random _countPositions;

	// _testPos = _allPositions select _randomPos;

	// _unit3 doMove _testPos;
	// systemChat "unit moving into west bunker";
	// sleep 5;






// _nBuilding = nearestBuilding position player;
// _allPositions = nearestBuilding _nBuilding buildingPos -1;
// _countPositions = count _allPositions;

// systemChat format ["Nearest building: %1", _nBuilding];
// systemChat format ["Available Positions: %1", _countPositions];

// _group = createGroup west;

// sleep 1;
// systemChat "-----------------";

// _unit = _group createUnit ["B_G_Soldier_A_F", [4837.39,4729.91,0], [], 0, "FORM"];
// _countPositions = count _allPositions;
// systemChat format ["Available Positions: %1", _countPositions];
// _testPos = _allPositions select 1;
// _unit doMove _testPos;
// sleep 10;

// _unit = _group createUnit ["B_G_Soldier_A_F", [4837.39,4729.91,0], [], 0, "FORM"];
// _countPositions = count _allPositions;
// systemChat format ["Available Positions: %1", _countPositions];
// _testPos = _allPositions select 2;
// _unit doMove _testPos;