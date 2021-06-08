/*
This function manages all ambient flybys - Littlebirds
*/

// ** imports 
// private ["_fobBaseLocation"];
// _fobBaseLocation = param[0]; // focus point for flybys 
// ** imports 

_fobBaseLocation = getPos player;

while {true} do {
	// _sleep = selectRandom [30, 60, 90, 120, 180, 240, 300]; // determines how long between each batch of ambients 
	// sleep _sleep; // random sleep between spawn batches 

	// manual low sleep for testing 
	_sleep = 5;

	// set number of ambients per spawn 
	// _number = selectRandom [1,2,3,4,5,6]; 
	_number = 5;

	// confirmed type of ambient 
	// _type = selectRandom ["B_Plane_CAS_01_dynamicLoadout_F", "B_Heli_Transport_01_F", "B_Heli_Transport_03_F", "B_Heli_Light_01_dynamicLoadout_F"]; 
	_type = selectRandom ["B_Heli_Transport_03_F"]; 
	// note: 4 types, each batch is always the same type - you wont get a jet and an MH6 together 

	// local vars declared 
	private ["_n","_ne","_s","_se","_s","_sw","_w","_nw","_ambientOrigin","_ambientDestination"];

	// determine origin (heading)
	// _origin = selectRandom [1,2,3,4,5,6,7,8]; // 1=n 2=ne 3=e 4=se 5=s 6=sw 7=w 8=nw 
	_origin = selectRandom [1]; // 1=n 2=ne 3=e 4=se 5=s 6=sw 7=w 8=nw 

	// determines start and end headings for ambient flight paths 
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
	_startPos = _fobBaseLocation getPos [2500, _ambientOrigin]; 
	_endPos = _fobBaseLocation getPos [2500, _ambientDestination]; 

	// set ambient height 
	// _height = selectRandom [100,300,500];
	_height = selectRandom [300];

	// declare vars 
	private ["_formationType","_singleAmbient","_line","_echelon","_vee","_wedge","_parallel"];

	// determine formation 
	switch (_number) do {
		case 1: { _formationType = selectRandom ["_singleAmbient"] }; 
		case 2: { _formationType = selectRandom ["_line", "_echelon"] };
		// case 3: { _formationType = selectRandom [_line, _echelon, _vee, _wedge] };
		case 3: { _formationType = selectRandom ["_line", "_echelon", "_wedge"] };
		// case 4: { _formationType = selectRandom [_line, _echelon, _parallel] };
		case 4: { _formationType = selectRandom ["_line", "_echelon"] };
		// case 5: { _formationType = selectRandom [_line, _echelon, _vee, _wedge] };
		case 5: { _formationType = selectRandom ["_wedge"] }; // testDelete - just testing echelon 
		// case 5: { _formationType = selectRandom ["_line", "_echelon", "_wedge"] };
		// case 6: { _formationType = selectRandom [_line, _echelon, _parallel] };
		case 6: { _formationType = selectRandom ["_line", "_echelon"] };
		default { systemChat "error: ambient formation selection broken / _origin / _formationType / switch" };
	};

	// spawn formation 
	switch (_formationType) do {

		// single ambient 
		case "_singleAmbient": { [_startPos, _endPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby; };

		// 2 - 6 ambients - Line formation 
		case "_line": {
			_spacerDist = 5; // test this to ensure echelon looks nice - too small and it just looks like a line formation
			_spacerTime = 1; // test this to ensure echelon looks nice - too small and it just looks like a line formation 

			for "_i" from 1 to _number do {
				[_startPos, _endPos, _height, "FULL", _type, west] call BIS_fnc_ambientFlyby;

				sleep 5; // spacer sleep between each iteration to prevent spawn overlaps 	
			};
		};

		// 2 - 6 ambients - echelon formation 
		case "_echelon": {
			_spacerDist = 50; // test this to ensure echelon looks nice - too small and it just looks like a line formation
			_spacerTime = 1; // test this to ensure echelon looks nice - too small and it just looks like a line formation 
			
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

				sleep _spacerTime; // spacer sleep between each iteration to prevent spawn overlaps 	
			};
		};

		// 3 or 5 ambients - vee formation - to do 
		// case _vee: {
		// 	if (_number == 5) then {
		// 		// 
		// 	} else {
		// 	};
		// };

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

	sleep 10;
};




// echelon jets 
/*
get start pos of focus area (eg player, fob etc) 
Calc start point 5km away from focus 
Calc end point 5km away from focus 

decide type of ambient - littlebird, chinook, hellcat, jet 

decide on height - low medium high very high 

decide on number 1 to 5

decide on formation (based on number)- column, line, echelon 

*/


/*
ambient spawner for effect only 
Improvement ideas 
decide from which / to direction 
decide how many in flight 
decide on formation (line or column or echelon or vee)
decide on spawn gap 
decide on alt#
decide on speed 
decide if mixed or one class (if mixed, what are the other downstream requirements (ie no AH6 + jets))
store pos at local so it does not crap out if the obj changes 
always have ambient flybys go relative to the next patrol obj
*/




/*
notes:

how do we want to run this system? flyby over any live base? or over players?
could we grab pos of each player on server and send over their heads?

from das attorney 
https://forums.bohemia.net/forums/topic/163897-getpos-player-in-multiplayer/

***

private ["_sleep","_pos","_player","_players"];

_sleep = 5;	// change this number to alter rate of script.
while {true} do {
	_players = playableUnits + switchableUnits;

	if (count _players > 0) then {}
		{
			_player = _x;
			if (not isNull _player) then
			{
				_pos = getPosATL _player;
							
					//Now you know the player and his/her position,
					//you can do your code here
				
			};
		} forEach _players;
		sleep _sleep;
	}
	else
	{
		// exception code in case no players
		sleep _sleep;
	};
};

***

from kc grimes

playerarray = [];
{
	playerarray = playerarray + [_x];
} forEach playableUnits;

randomplayer = playerarray call BIS_fnc_selectRandom;

randomplayerpos = getPos randomplayer;
_wp = AS addWaypoint [randomplayerpos, 0];
_wp setWaypointType "MOVE"; 

***




old 
B_Plane_CAS_01_dynamicLoadout_F
[startPos, endPos, altitude, speedMode, classname, side] call BIS_fnc_ambientFlyby;
always over RGG_patrol_obj
player getPos [100,45];
000 / 180 
180 / 000
090 / 270
270 / 090
get an origin by taking patrol point, then get pos east at 090 100m 
then get pos west 270 from patrol point 
