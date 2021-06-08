/*
This function creates initial main base marker position
*/  

// ** imports 
// private ["_mainBaseLocation"];
// _mainBaseLocation = param[0]; // blufor FOB pos / spawn
// ** imports 

_mainBaseLocation = [6470,3839];

// register main base as a blue marker
_base = createMarker ["permaBase", _mainBaseLocation];
_base setMarkerShape "ELLIPSE";
_base setMarkerColor "ColorBlue";
_base setMarkerSize [200, 200];
// _base setMarkerAlpha 0.5;

// ** exports 
// [_battleZone, _bluforPos, _opforPos] call RGG_fnc_3_determineAmbientConflict;
[_mainBaseLocation] call RGG_fnc_1_setup_findLocation;
// ** exports 


/*
Notes:

this inital pos is provided by initserver, but this could be fed also from other scripts, if, say, this main base was lost and the centre for operations needed to be one of the smaller fobs


Creates marker for main base - this could be done separately, but felt it was just easy to manage markers in one place 
Creates marker for main battlezone 
Creates markers for both blufor and opfor fobs 
Blufor fob is created using a rand360 
Opfor fob is also created, however currently hardcoded (see issues below)
This fnc and subsequent fncs will enable the creation of a random battlezone, with each side given a FOB 
if fob A = 90 degrees, fob B will be 270 degrees 
On activation, units will spawn and go head to head, in an attempt to capture the other spawn position location

To do:
If a side unit gets to be within 10m of the enemy spawn point, then the losing side cannot spawn any more units 
Units are spawned every 5 mins 

*/


// while {TRUE} do {
	
// 	_pos = [_battleZone, 1, 500, 30, 0, 20, 0] call BIS_fnc_findSafePos;
// 	deleteMarker "_testPos";
// 	_testPosMarker = createMarker ["_testPos", _pos];
// 	_testPosMarker setMarkerShape "ELLIPSE";
// 	_testPosMarker setMarkerColor "ColorGreen";
// 	_testPosMarker setMarkerSize [50, 50];
// 	sleep 10;
// 	systemChat "testmarker done";
// };


// the above works like this:
// create random 360, and opposite number from 360 (in degrees)
// then using battlezone anchor point, find a point 750m away, both for 360 and opp360 
// then using find safezone for each, select a suitable location within 100m of each point.

// distance can vary potentially, with shorter distances meaning more intense fighting 
// spawn frequency will also affect this 
// there should be a marker like a tent to capture 

// create fob / start / respawn points for both enemies 
// note, if enemy takes the other spawn point they win

/*
create opposing FOB points 
blufor and opfor both get a point to control - this is where new units are spawned, and if this point is taken the mission is over 
select random 360 - assign to blufor 
select opposite degreee - assign to opfor
*/



