/*
This function identifies suitable location for blufor FOB + marker creation 
*/

// ** imports 
private ["_baseLocation"];
_baseLocation = param[0]; // blufor FOB pos / spawn
// ** imports 

// find suitable build location for blufor FOB 
_fobBaseLocation = [_baseLocation, 1000, 3000, 40, 0, 1, 0] call BIS_fnc_findSafePos;
 
// mark main area 
_battleZoneMarker = createMarker ["battleZone", _fobBaseLocation];
_battleZoneMarker setMarkerShape "ELLIPSE";
_battleZoneMarker setMarkerSize [1000, 1000];
_battleZoneMarker setMarkerAlpha 0.5;

// mark main area 
_battleZoneMarker = createMarker ["battleZone", _fobBaseLocation];
_battleZoneMarker setMarkerShape "ELLIPSE";
_battleZoneMarker setMarkerSize [100, 100];
_battleZoneMarker setMarkerAlpha 0.7;

// find suitable build location for blufor FOB 
_opforCampLocation = [_fobBaseLocation, 400, 1500, 10, 0, 0, 0] call BIS_fnc_findSafePos;

// mark camp area - delete veentually 
_battleZoneMarker = createMarker ["battleZone", _opforCampLocation];
_battleZoneMarker setMarkerShape "ELLIPSE";
_battleZoneMarker setMarkerSize [100, 100];
_battleZoneMarker setMarkerAlpha 0.7;

// ** exports 
[_fobBaseLocation] call RGG_fnc_2_build_bluforFob;
[_opforCampLocation] call RGG_fnc_2_build_opforCamp;
// ** exports 


/*
notes:
this could replace createBattleZone fnc 
_pos = 	[player, 1, 		150, 		3, 			0, 			20, 		0] 										call BIS_fnc_findSafePos;
		[center, minDist, 	maxDist, 	objDist, 	waterMode, 	maxGrad, 	shoreMode, blacklistPos, defaultPos] 	call BIS_fnc_findSafePos

find an area further than 1km, no further than 8km, 50m to nearest thing, not on water, max grad of 5%, not on a shore 
_fobBaseLocation = [_baseLocation, 1000, 8000, 50, 0, 5, 0] call BIS_fnc_findSafePos;