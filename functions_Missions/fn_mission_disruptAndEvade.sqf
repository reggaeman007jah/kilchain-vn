/*
drop off spec ops team in bandit country .. they blow stuff up and escape back to pathfinder 
hk teams hunt them down .. blufor have to use what they find to survive 

designated heli, parked somewhere off-base 
onGetIn, mission starts 

waits for heli to land and then take off when no one on board 

generate opfor teams nearby, with player multiplier 

generate random move orders for these groups around players position  
so, these teams will move all around the current battle area

current battle area is a cycle marker area, based on a random player in the area 
500m radius 

opfor units will be given random points to move to within this area 
these points must be within 200m of center 

limit these numbers maybe 

also, alwways one HK team stalking specops players 

on landing, a target will be created 500m away - go there and destroy, then escape 

above state is fine until mission done .. then into escape mode 

while in escape mode, troops will try to push specops out of town, but smaller teams will spawn between them and pathfinder 

need technicals as part of ambient movements 

also, every 1 minute, get random player form specops 
if after a minute they are still within 10m of their pos, then drop a flare on them - i.e. they have been spotted 
then, create bigger squad to move to that pos as a one-off attack 

https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#Engine
vehicle: Object - Vehicle the event handler is assigned to
engineState: Boolean - True when the engine is turned on, false when turned off

this addEventHandler ["Engine", {
	params ["_vehicle", "_engineState"];
}];

then wait until height is over x, 

then wait until cargo == 0 - then trigger things 

choose player from cargo list - this is the anchor player 

make marker area around cargo player - we assume the group will stay together here 

spawn target in area - must be at least xm away from pathfinder to ensure target is actually in city  

decide on target - fuel trucks to start with 

find mission target area - then safePos for trucks - ensure on road if poss 

overall we want to limit opfor to 50 base plus another 10 for each player in area  

spawn trucks - then spawn defending elements limit == 10 

then spawn randoms in area - here we want ... 

we need a checkCycle - we care about player numbers in this check as this will inform whether any new units need to be created

there is no in-field respawn, so if hit, and want back in - need heli 

every checkCycle, say every minute, move opfor groups to random locations. Check what I did in Tobruk as that worked nice 

Also, run an HK on players in area 

what players do here is up to them, they can head straight home, or destroy the trucks and then head home .. 

get lots of trucks and technicals driving around for targets

team should have RPGs and AKs to ensure they can reup in-field 

so make sure RPG is common ammo found 


update:
To-do 
Fix garbage so checks for player pos before deleting 
add ambient exp always near but never on players 
add ambient civvy cars occasionaslly 
add new task when one truck is killed - done
add cycle check that informs numbers for next cycle - can you turn the tide?
Killing trucks helps the score  
add indi markers 
create sub area within main area which is combat hotspot 


*/

// _data = _this select 0;
systemChat "running D&E";
// DISRUPTEVADE = true;

// game scores 
RGG_indiforPoints = 0;
RGG_opforPoints = 0;


_heli = _this select 0; // name of heli asset passed in 

// _HKSQUADGP = []; // to hold deployed HK groups 

/*
check:
	is in air? i.e. is heli over 5m? 
	if yes, then, is heli on ground? 
	If yes is on ground, then is heli in dropzone area?
	If yes, then start mission and close this checking loop 
*/

waitUntil { isEngineOn _heli }; 
systemChat "engine fired up";

_deploymentMission = true; // main loop 
_initPhase = true; // check whether heli is in air - if yes, progresses 
_dropOff = false;

private _HELI1ATL1 = "_HELI1ATL1";
while {_deploymentMission} do {
	
	// engine check - always runs while _deploymentMission is true 
	if (isEngineOn _heli) then {
		_HELI1ATL1 = (getPosATL _heli) select 2;
		_HELI1ATL1 = round _HELI1ATL1;
		systemChat str _HELI1ATL1;
	} else {
		// this should shut everything down if the engine is turned off
		_deploymentMission = false;
		_initPhase = false;
		_pickup = false;
		_wait = false;
		_dropoff = false;
		_complete = false;
		// deleteMarker _markerName; // belt and braces
		// [_heli] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
		// to do - think about how the above line can be brought into effect here ^^^ ??? 
		// I assume just re-run this script?
		systemChat "shutting down pickup system";
	};

	// watch for being in air  
	if (_initPhase) then {
		if (_HELI1ATL1 > 3) then {
			// as heli is in air, means players should be on board, and now we wait until heli is landed 
			// _freeCargoPositions = _myHeli emptyPositions "cargo";
			// systemChat format ["cargo available: %1", _freeCargoPositions];
			_initPhase = false;
			_dropOff = true;
		};
	};

	// watch for being on ground - if on ground, start mission 
	if (_dropOff) then {
		if ( ((_HELI1ATL1) < 1.5) ) then {
			// heli has landed  
			_pos = getPos _heli;

			// create DZ Marker Zone 
			deleteMarker "sideWinder";
			_pos1 = createMarker ["sideWinder", _pos];
			_pos1 setMarkerShape "RECTANGLE";
			_pos1 setMarkerColor "ColorRed";
			_pos1 setMarkerAlpha 0.2;
			_pos1 setMarkerSize [500, 500];
			
			_deploymentMission = false;
			systemChat "heli landed, mission starting";
			[west, _pos, "Sidewinder"] call BIS_fnc_addRespawnPosition; // create blu resapwn
	
			[_pos] spawn RGGs_fnc_spawn_fuelTruck;

			// _randomRoadPosAroundPlayer = [[[_pos,300]],[], {isOnRoad _this}] call BIS_fnc_randomPos;
			// // systemChat str _randomRoadPosAroundPlayer;

			// // O_Truck_03_fuel_F
			// _veh = createVehicle ["O_Truck_03_fuel_F", _randomRoadPosAroundPlayer];
			// deleteMarker "objPos";
			// _objPos = createMarker ["objPos", _randomRoadPosAroundPlayer];
			// _objPos setMarkerSize [20,20];
			// _objPos setMarkerShape "rectangle";
			// _objPos setMarkerColor "colorGreen";

			// [WEST, ["task1"], ["Do this and you get a cookie", "Earn Cookie", "cookiemarker"], randomRoadPosAroundPlayer ,1, 2, true] call BIS_fnc_taskCreate;
			// [west, ["taskType_"], ["Setting taskType", "The simple way", "marker2"], _randomRoadPosAroundPlayer, 1, 3, true, "my_CfgTaskType"] call BIS_fnc_taskCreate;
			// [west, ["task1"], ["Disrupt enemy fuel supplies", "Destroy Fuel Truck", "cookiemarker"], _randomRoadPosAroundPlayer, 1, 2] call BIS_fnc_taskCreate;
			// _sideWinderLZ = _pos inArea "sidewinder";

			// if (_sideWinderLZ) then {
			// 	// heli has landed in sideWinder LZ Area 
			// 	_deploymentMission = false;
			// 	systemChat "heli landed, mission starting";
			// 	_pos = getPos _heli;
			// 	[west, _pos, "Sidewinder"] call BIS_fnc_addRespawnPosition; // create blu resapwn
			// };
		};
	};

	sleep 5;
};

// hide marker from players 
// _pos1 setMarkerAlpha 0;

sleep 5;

DISRUPTEVADE = true;

systemChat "running random spawner";
execVM "killchain\systems\spawnerSystems\singleUnitSpawner.sqf";
sleep 30;

systemChat "running move orders";
execVM "killchain\systems\moveSystems.sqf\randomMoves.sqf";
sleep 10;

systemChat "running opforHK";
[60] execVM "killChain\systems\hunterKillerSystemsOpfor\runHK.sqf"; // passing a 'wait 1 min before kicking off' arg 
// sleep 30;
// systemChat "running vic spawner";
execVM "killChain\systems\spawnerSystems\singleVicSpawner.sqf";
// removed - too much .. need better system
// re-added, now very light touch 











// _deploymentMission = true; // main loop 
// _initPhase = true; // check whether heli is in air - if yes, progresses 
// _pickup = false; // check whether heli has landed - if yes, orders any units to board if nearby 
// _wait = false; // check is heli has taken off - if yes, watches for landing 
// _dropoff = false; // check if heli has landed - if yes, auto-disembark units 
// _complete = false; // check if heli has left LZ - if yes, repeat process 

// _myHeli = _heli;
// _markerName = str _heli; // unique marker name

// deleteMarker _markerName; // belt and braces - is needed??

// private _HELI1ATL1 = "_HELI1ATL1";
// while {_deploymentMission} do {

// 	// engine check - always runs while _deploymentMission is true 
// 	if (isEngineOn _heli) then {
// 		_HELI1ATL1 = (getPosATL _myHeli) select 2;
// 		_HELI1ATL1 = round _HELI1ATL1;
// 		systemChat str _HELI1ATL1;
// 	} else {
// 		// this should shut everything down if the engine is turned off
// 		_deploymentMission = false;
// 		_initPhase = false;
// 		_pickup = false;
// 		_wait = false;
// 		_dropoff = false;
// 		_complete = false;
// 		deleteMarker _markerName; // belt and braces
// 		[_heli] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
// 		systemChat "shutting down pickup system";
// 	};
 
// 	// set up heli for taking on passengers 
// 	if (_initPhase) then {
// 		if (_HELI1ATL1 > 3) then {
// 			// as heli is in air, means ready to take on passengers
// 			_freeCargoPositions = _myHeli emptyPositions "cargo";
// 			systemChat format ["cargo available: %1", _freeCargoPositions];
// 			_initPhase = false;
// 			_pickup = true;
// 		};
// 	};
 
//    // PICKUP 
//  	if (_pickup) then {
// 	// checks height - when on ground, orders an auto-board of units in greenzone 
//     systemChat "Land so troops can board";
// 		if ((_HELI1ATL1) < 1) then {
// 			_extractLocation = position _heli;
// 			_dir = direction _heli;
// 			_extractMarker = createMarker [_markerName, _extractLocation];
// 			_extractMarker setMarkerShape "RECTANGLE";
// 			_extractMarker setMarkerColor "ColorGreen";
// 			_extractMarker setMarkerDir _dir;
// 			_extractMarker setMarkerSize [15, 50];

// 			// this bit does not work as intended!!! why did i write this?
//   			_units = allUnits inAreaArray _markerName;
// 			_candidates = [];
// 			{
// 				if (_x != player) then {
// 					_candidates pushBack _x;
// 					systemChat format ["Pushing back %1", _x];
// 				};
// 			} forEach _units; 
// 			systemChat format ["_candidates %1", _candidates];
// 			// here we only want to progress from green strip if there are units to auto-board 
			
// 			// I think here we should go through _candidates and if isPlayer, remove
// 			// this way it will not register when you land and only player are nearby 
// 			{
// 				if (isPlayer _x) then {
// 					_candidates deleteAt _forEachIndex;
// 				};
// 			} forEach _candidates;
			
// 			_cnt = count _candidates;
// 			systemChat format ["_cnt %1", _cnt];

// 			if (_cnt > 0) then {
// 				// auto-board candidates
// 				_freeCargoPositions = _myHeli emptyPositions "cargo";
// 				systemChat format ["_freeCargoPositions %1", _freeCargoPositions];
// 				if (_freeCargoPositions > 0) then {
// 					{
// 						// while {_freeCargoPositions > 0} do {
// 							_x assignAsCargo _myHeli;
// 							_squaddieGrp = group _x;
// 							_x setUnitPos "MIDDLE";
// 							_HKSQUADGP pushBackUnique _squaddieGrp;						
// 						// };
// 					} forEach _candidates;	
// 					_candidates orderGetIn true;
// 				};
// 				_pickup = false; // close stage 
// 				_wait = true; // trigger next stage 
// 			} else {
// 				deleteMarker _markerName; // added this << 
// 				_pickup = false; // close stage 
// 				_initPhase = true; // go back one stage 				
// 			};
// 			// had issues on 23rd march where green strip was not being removed .. attempting to resolve here 
// 			// removed this - before this would always happen but now i am trying to only progress things when troops are there to be picked up 
// 			// _pickup = false; // close stage 
// 			// _wait = true; // trigger next stage 
// 		};
// 	};

// 	// WAIT / BOARD / TRANSIT
// 	if (_wait) then {
// 	systemChat "Troops boarded";
// 		if ((_HELI1ATL1) > 2) then {
// 			_wait = false;
// 			_dropoff = true;
// 			deleteMarker _markerName;
// 		};
// 	};

// 	// DISEMBARK
// 	if (_dropoff) then {
// 	systemChat "Get the troops on the ground";
// 		if ((_HELI1ATL1) < 1.5) exitWith {
// 			_extractLocation = position _heli;
// 			_extractMarker = createMarker [_markerName, _extractLocation];
// 			_extractMarker setMarkerShape "ELLIPSE";
// 			_extractMarker setMarkerColor "ColorRed";
// 			_extractMarker setMarkerSize [20, 20];

// 			// order getOut 
// 			{
// 				_squaddieGrp = group _x;
// 				_HKSQUADGP pushBackUnique _squaddieGrp;
// 				systemChat format ["hk group: %1", _HKSQUADGP];
// 				unassignVehicle _x;
// 			} forEach crew _heli;

// 			/*
// 			We need to know how many groups are now leaving, and delete from the output any group that has a player in it 
// 			so, count array content and count size of each group to test what you get 
// 			*/
// 			// systemChat format ["_HKSQUAD contains %1 elements: %2:", _testGroupExtract, _HKSQUADGP];
// 			// {
// 			// 	// count group size
// 			// 	_groupSize = count units _x;
// 			// 	systemChat format ["_HKSQUAD group sizes: %1:", _groupSize];
// 			// } forEach _HKSQUADGP;
// 			// _size = count units _group; 
// 			/*
// 			End of mini-test 
// 			*/

// 			// remove single unit groups from hk system 
// 			_groupCount = count _HKSQUADGP;
// 			for "_i" from 1 to _groupCount do {
// 				_group = _HKSQUADGP select (_i -1);
// 				_size = count units _group; 
				
// 				if (_size == 1) then {
// 					_toRemove = _HKSQUADGP select (_i -1); 
// 					systemChat format ["Deleting from HK candidates: %1:", _toRemove];
// 					_HKSQUADGP deleteAt (_i -1);
// 				} else {
// 					systemChat format ["Iteration / Group: %1, Size: %2", _group, _size];
// 				};
// 			}; 

// 			_units = allUnits inAreaArray _markerName;
// 			_units orderGetIn false;
// 			{
// 				_x setUnitPos "AUTO";
// 			} forEach _units; // should this be for HK group?

// 			if (HUNTERKILLER) then {
// 				// this bool can turn on/off this action 
// 				sleep 10;
// 				{
// 					[_x] execVM "killChain\systems\hunterKillerSystems\runHK.sqf";
// 					systemChat format ["debug - sending this: %1", _x];
// 				} forEach _HKSQUADGP;   
// 			};

// 			if (CPD) then {
// 				// this bool can turn on/off this action 
// 				sleep 10;
// 				{
// 					[_x, _heli] execVM "killChain\systems\cpdSystems\runCpd.sqf";
// 					systemChat format ["debug - sending this: %1", _x];
// 				} forEach _HKSQUADGP;   
// 			};

// 			_dropoff = false;
// 			_complete = true;
// 		};
// 	};

// 	if (_complete) then {
// 		_pos = getMarkerPos _markerName;
// 		_safeDelete = _heli distance _pos;
// 		if ((_safeDelete) > 5) then {
// 			deleteMarker _markerName;
// 			_complete = false;
// 			_initPhase = true;
// 		};
// 	};

// 	sleep 2;
// };

