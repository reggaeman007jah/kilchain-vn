/*
This function will manage all ambi-spawns

anchor - probably best to use the patrol point - it can be player positions too ..

we want to randmoise the origin / destination, as well as the fly height 

We also want to randomise the line itself - i.e. directly over point, or 200 / 400m each side?

we need a way to ensure that we don't overuse this - so somehow make sure gaps in-between are big enough 

think about using flyheight as a param to ensure no two batches are the same height ..?

*/

// ** imports 
// private ["_fobBaseLocation"];
// _fobBaseLocation = param[0]; // focus point for flybys 
// ** imports 

// while {true} do {
	
// 	// choose random function to run 
// 	sleep 60 + random 180;
// };


private ["_flybyAnchor"];
_flybyAnchor = param[0]; // focus point for flybys 

// aircraft type - always the same in each batch 
_type = selectRandom [
	"B_Plane_CAS_01_dynamicLoadout_F", 
	"B_Heli_Transport_01_F", 
	"B_Heli_Transport_03_F", 
	"B_Heli_Light_01_dynamicLoadout_F"
]; 

// determine number and formation of aircraft in wave 
_number = selectRandom [1,2,3,4,5];
private ["_formationType","_singleAmbient","_line","_echelon","_vee","_wedge","_parallel"];
switch (_number) do {
	case 1: { _formationType = selectRandom ["_singleAmbient"] }; 
	case 2: { _formationType = selectRandom ["_line", "_echelon"] };
	case 3: { _formationType = selectRandom ["_line", "_echelon", "_vee"] };
	case 4: { _formationType = selectRandom ["_line", "_echelon"] };
	case 5: { _formationType = selectRandom ["_echelon", "_vee"] }; 
	default { systemChat "error: ambient formation selection broken / _origin / _formationType / switch" };
};

// height 
_height = selectRandom [100,300,500,700];

// origin / destination - determines start and end headings for ambient flight paths 
_origin = selectRandom [1,2,3,4,5,6,7,8]; // 1=n 2=ne 3=e 4=se 5=s 6=sw 7=w 8=nw 
private ["_ambientOrigin","_ambientDestination"];

switch (_origin) do {
	case 1: 	{ _ambientOrigin = 0, _ambientDestination = 180 };
	case 2: 	{ _ambientOrigin = 45, _ambientDestination = 225 };
	case 3: 	{ _ambientOrigin = 90, _ambientDestination = 270 };
	case 4: 	{ _ambientOrigin = 135, _ambientDestination = 315 };
	case 5: 	{ _ambientOrigin = 180, _ambientDestination = 0 };
	case 6: 	{ _ambientOrigin = 225, _ambientDestination = 45 };
	case 7: 	{ _ambientOrigin = 270, _ambientDestination = 90 };
	case 8: 	{ _ambientOrigin = 315, _ambientDestination = 135 };
	default 	{ systemChat "error: ambient flight paths broken / _origin / _ambientOrigin / switch" };
};

// calculates ambient start and end points to fly over FOB 
_startPos = _flybyAnchor getPos [2500, _ambientOrigin]; 
_endPos = _flybyAnchor getPos [2500, _ambientDestination]; 

// calculate any flightpath offset 
_offset = selectRandom [1,2,3,4,5]; // 3 is directly over spot, 2 is slightly left, 5 is far off right etc 
// not currently used 

// spawn formation 
switch (_formationType) do {

	// single ambient 
	case "_singleAmbient": { [_startPos, _endPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby; };

	// 2 - 5 ambients - Line formation 
	case "_line": {
		_spacerDist = 5; 
		_spacerTime = 1; 
		for "_i" from 1 to _number do {
			[_startPos, _endPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby;
			sleep 5; 	
		};
	};

	// 2 - 5 ambients - echelon formation 
	case "_echelon": {
		_spacerDist = 50; 
		_spacerTime = 1; 
		for "_i" from 1 to _number do {
			[_startPos, _endPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby;
			switch (_origin) do {
				case 1: { _startPos = _startPos getPos [_spacerDist, 90]; _endPos = _endPos getPos [_spacerDist, 90] };
				case 2: { _startPos = _startPos getPos [_spacerDist, 135]; _endPos = _endPos getPos [_spacerDist, 135] };
				case 3: { _startPos = _startPos getPos [_spacerDist, 180]; _endPos = _endPos getPos [_spacerDist, 180] };
				case 4: { _startPos = _startPos getPos [_spacerDist, 225]; _endPos = _endPos getPos [_spacerDist, 225] };
				case 5: { _startPos = _startPos getPos [_spacerDist, 270]; _endPos = _endPos getPos [_spacerDist, 270] };
				case 6: { _startPos = _startPos getPos [_spacerDist, 315]; _endPos = _endPos getPos [_spacerDist, 315] };
				case 7: { _startPos = _startPos getPos [_spacerDist, 0]; _endPos = _endPos getPos [_spacerDist, 0] };
				case 8: { _startPos = _startPos getPos [_spacerDist, 45]; _endPos = _endPos getPos [_spacerDist, 45] };
				default { systemChat "error: ambient echelon formation selection broken / _origin / _startPos / switch" };
			};
			sleep _spacerTime; 	
		};
	};

	// 3 or 5 ambients - vee formation - to do 
	case "_vee": {
		_spacerDist = 50;
		_spacerTime = 1;
		if (_number == 5) then {
			// get lead, then one left and one right, then another left and another right but further away 
		} else {
			//
		};
	};

	// 3 or 5 ambients - wedge formation 
	case "_wedge": {

		// declare vars 
		private ["_startPosLeft","_endPosLeft","_startPosRight","_endPosRight"];

		systemChat "ambient spawning";

		_spacerDist = 10; // test this to ensure echelon looks nice - too small and it just looks like a line formation
		_spacerTime = 1.5; // test this to ensure echelon looks nice - too small and it just looks like a line formation 

		_ambi1StartPos = _startPos;
		_ambi1EndPos = _endPos;

		_ambi2StartPos = _startPos getPos [100, 90]; 
		_ambi2EndPos = _endPos getPos [100, 90]; 

		_ambi3StartPos = _startPos getPos [150, 90]; 
		_ambi3EndPos = _endPos getPos [150, 90]; 

		_ambi4StartPos = _startPos getPos [200, 90]; 
		_ambi4EndPos = _endPos getPos [200, 90]; 

		// lead ambient 
		[_ambi1StartPos, _ambi1EndPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby; 
		sleep _spacerTime;
		[_ambi2StartPos, _ambi2EndPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby; 
		sleep _spacerTime;
		[_ambi3StartPos, _ambi3EndPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby; 
		sleep _spacerTime;
		[_ambi4StartPos, _ambi4EndPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby; 
		sleep _spacerTime;


		// pair ambients - pos creation
		// for "_i" from 1 to (_number -1) do {
		// 	switch (_origin) do {
		// 		case 1: { _startPosLeft = _startPos getPos [_spacerDist, 90]; _endPosLeft = _endPos getPos [_spacerDist, 90]; _startPosRight = _startPos getPos [_spacerDist, 270]; _endPosRight = _endPos getPos [_spacerDist, 270]; };
		// 		case 2: { _startPosLeft = _startPos getPos [_spacerDist, 135]; _endPosLeft = _endPos getPos [_spacerDist, 135]; _startPosRight = _startPos getPos [_spacerDist, 315]; _endPosRight = _endPos getPos [_spacerDist, 315]; };
		// 		case 3: { _startPosLeft = _startPos getPos [_spacerDist, 180]; _endPosLeft = _endPos getPos [_spacerDist, 180]; _startPosRight = _startPos getPos [_spacerDist, 0]; _endPosRight = _endPos getPos [_spacerDist, 0]; };
		// 		case 4: { _startPosLeft = _startPos getPos [_spacerDist, 225]; _endPosLeft = _endPos getPos [_spacerDist, 225]; _startPosRight = _startPos getPos [_spacerDist, 45]; _endPosRight = _endPos getPos [_spacerDist, 45]; };
		// 		case 5: { _startPosLeft = _startPos getPos [_spacerDist, 270]; _endPosLeft = _endPos getPos [_spacerDist, 270]; _startPosRight = _startPos getPos [_spacerDist, 90]; _endPosRight = _endPos getPos [_spacerDist, 90]; };
		// 		case 6: { _startPosLeft = _startPos getPos [_spacerDist, 315]; _endPosLeft = _endPos getPos [_spacerDist, 315]; _startPosRight = _startPos getPos [_spacerDist, 135]; _endPosRight = _endPos getPos [_spacerDist, 135]; };
		// 		case 7: { _startPosLeft = _startPos getPos [_spacerDist, 0]; _endPosLeft = _endPos getPos [_spacerDist, 0]; _startPosRight = _startPos getPos [_spacerDist, 180]; _endPosRight = _endPos getPos [_spacerDist, 180]; };
		// 		case 8: { _startPosLeft = _startPos getPos [_spacerDist, 45]; _endPosLeft = _endPos getPos [_spacerDist, 45]; _startPosRight = _startPos getPos [_spacerDist, 225]; _endPosRight = _endPos getPos [_spacerDist, 225]; };
		// 		default { systemChat "error: ambient wedge formation selection broken / _origin / _startPosleft / _startPosRight / switch" };
		// 	};

		// 	// pair ambients - spawn 
		// 	[_startPosLeft, _endPosLeft, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby; // left ambient 
		// 	[_startPosRight, _endPosRight, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby; // right ambient 

		// 	// spacer sleep
		// 	sleep _spacerTime; 	
		// };
	};

	// 4 or 6 ambients - parallel formation - to do
	// case _parallel: {
	// };
	// default 	{ hint "default" };
};


// determine system to prevent overuse 
// add gap-bool system in separate script - if live, then no spawn 