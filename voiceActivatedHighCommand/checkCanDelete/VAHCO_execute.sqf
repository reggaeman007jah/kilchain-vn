
// what was I thinking here?

_VACF_heading = _this select 0;
_VACF_distance = _this select 1;

execVM "voiceActivatedCoordFinder\VACF_clearKeyDowns.sqf";
systemChat "processing data...";
sleep 3;

RGG_callVACF = {
	_VACF_result = player getPos [_VACF_distance, _VACF_heading];
	systemChat str _VACF_result;
	sleep 12;
	systemChat str _VACF_result;
	sleep 12;
	systemChat str _VACF_result;
};
[_VACF_heading, _VACF_distance] call RGG_callVACF;
	
execVM "voiceActivatedCoordFinder\initialiseVACF.sqf";


























// _lat = _this select 0;
// _lon = _this select 1;
// _rnd = _this select 2;
// _radi = _this select 3;
// _pos = [_lat, _lon];

// // createMarker
// deleteMarker "gun1";
// _marker1 = createMarker ["gun1", _pos];
// _marker1 setMarkerShapeLocal "ELLIPSE";
// _marker1 setMarkerColorLocal "ColorRed";
// _marker1 setMarkerSizeLocal [100, 100];
// _marker1 setMarkerAlphaLocal 0.9;

// // function
// RGG_callVACF = {
	
// 	numericalInput = false;
	
// 	params ["_shell", "_origin", "_radius", "_count"];

// 	while {_count = _count - 1; _count >= 0} do {

// 		private _int = selectRandom [1, 2, 4, 8];
// 		private _dir = random 360;
// 		private _rad = random _radius;
// 		private _prj = _shell createVehicle (_origin getPos [_rad, _dir]);		
// 		sleep _int;
// 	};
// 	systemChat "barrage over";

// 	numericalInputBool = false;
// 	deleteMarker "gun1";
// 	// execVM "voiceActivatedArty\initialiseVAA.sqf";
// 	systemChat "reactivating initVAA after calling strike";	
// 	execVM "voiceActivatedArty\initialiseVAA.sqf";
// };

// ["R_80mm_HE", _pos, _radi, _rnd] call RGG_callVACF;
