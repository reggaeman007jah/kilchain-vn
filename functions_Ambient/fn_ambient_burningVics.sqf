/*
This function manages creation of ambient burning wrecks
*/

// ** imports 
// private ["_battleZone", "_burningVics"];
// _battleZone = param[0]; // main battlezone pos
// _burningVics = param[1]; // number of vics to burn
// ** imports 

// decide on when they should be burning - what triggers the spawn and fire?
// to do: spawn vics, then reduce damage so they burn 

/*
take the obj point ahead of the current one 
if you are at end stage - do not do this 
get an anchor .. spawn vic and set heavy damage .. 
vic should be spawned 300-500m away from anchor and away from current pos  
to do this .. get relative heading from next to current 
so, if current obj is directly south of anchor, then get random heading from 270 - 90 degrees 

big question .. how do you make current obj relatve south?
Find position 100 metres away at player's 3 o'clock:
_relpos = player getRelPos [100, 90];
*/
systemChat "ambiVics running";
private ["_mainAnchor"];

switch (patrolPointsTaken) do {
	case (0): {
		_mainAnchor = RGG_PatrolPoints select 1;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (1): {
		_mainAnchor = RGG_PatrolPoints select 2;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (2): {
		_mainAnchor = RGG_PatrolPoints select 3;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (3): {
		_mainAnchor = RGG_PatrolPoints select 4;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (4): {
		_mainAnchor = RGG_PatrolPoints select 5;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	case (5): {
		_mainAnchor = RGG_PatrolPoints select 6;
		// _anchor1 = [_mainAnchor, 10, 150] call BIS_fnc_findSafePos;
	};
	default {
		systemChat "error Patrol Point switch";
	};
};

systemChat format ["_mainAnchor from burnVic switch is: %1", _mainAnchor];

_jeep = "O_Truck_02_covered_F" createVehicle _mainAnchor;

_jeep setDammage 1;
// systemChat "burning vic system run successfully";


// // _firstPos = getPos _jeep;
// _dir = selectRandom [270, 0, 90];
// _relpos = _jeep getRelPos [100, _dir];
// // deleteVehicle _jeep;

// _objective1 = createMarker ["car", _relpos];
// _objective1 setMarkerShape "ELLIPSE";
// _objective1 setMarkerColor "ColorRed";
// _objective1 setMarkerSize [100, 100];

// _jeep = "O_Truck_02_covered_F" createVehicle _relpos;
// _jeep setDammage 1;
// systemChat "burning vic system run successfully";

// sleep 20;
// deleteMarker "car"; 
// systemChat "vic marker deleted";



