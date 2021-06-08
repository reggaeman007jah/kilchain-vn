/*
the job of this script is to manage deployment of indifor grunts to the patrol area - NOT to manage HKs 
*/
systemChat "pickupMon is on";
_heli = _this select 0;

_HKSQUADGP = []; // to hold deployed HK groups 

_deploymentMission = true; // main loop 
_initPhase = true; // check whether heli is in air - if yes, progresses 
_pickup = false; // check whether heli has landed - if yes, orders any units to board if nearby 
_wait = false; // check is heli has taken off - if yes, watches for landing 
_dropoff = false; // check if heli has landed - if yes, auto-disembark units 
_complete = false; // check if heli has left LZ - if yes, repeat process 

_myHeli = _heli;
_markerName = str _heli; // unique marker name

deleteMarker _markerName; // belt and braces - is needed??

private _HELI1ATL1 = "_HELI1ATL1";
private _freeCargoPositions = "_freeCargoPositions"; // using this to spawn only enough for available seats in the slick - eventually 

while {_deploymentMission} do {

	// engine check - always runs while _deploymentMission is true 
	if (isEngineOn _heli) then {
		_HELI1ATL1 = (getPosATL _myHeli) select 2;
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
		deleteMarker _markerName; // belt and braces
		[_heli] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
		systemChat "shutting down pickup system";
	};
 
	// set up heli for taking on passengers 
	if (_initPhase) then {
		if (_HELI1ATL1 > 3) then {
			// as heli is in air, means ready to take on passengers
			_freeCargoPositions = _myHeli emptyPositions "cargo";
			systemChat format ["cargo available: %1", _freeCargoPositions];
			_initPhase = false;
			_pickup = true;
		};
	};
 
   // PICKUP 
 	if (_pickup) then {
	// checks height - when on ground, orders an auto-board of units in greenzone 
    systemChat "Land so troops can board";
		if ((_HELI1ATL1) < 1) then {
			_extractLocation = position _heli;
			_dir = direction _heli;
			_extractMarker = createMarker [_markerName, _extractLocation];
			_extractMarker setMarkerShape "RECTANGLE";
			_extractMarker setMarkerColor "ColorGreen";
			_extractMarker setMarkerDir _dir;
			_extractMarker setMarkerSize [15, 50];

			// this bit does not work as intended!!! why did i write this?
  			_units = allUnits inAreaArray _markerName;
			_candidates = [];
			{
				if (_x != player) then {
					_candidates pushBack _x;
					systemChat format ["Pushing back %1", _x];
				};
			} forEach _units; 
			systemChat format ["_candidates %1", _candidates];
			// here we only want to progress from green strip if there are units to auto-board 
			
			// I think here we should go through _candidates and if isPlayer, remove
			// this way it will not register when you land and only player are nearby 
			{
				if (isPlayer _x) then {
					_candidates deleteAt _forEachIndex;
				};
			} forEach _candidates;
			
			_cnt = count _candidates;
			systemChat format ["_cnt %1", _cnt];

			if (_cnt > 0) then {
				// auto-board candidates
				_freeCargoPositions = _myHeli emptyPositions "cargo";
				systemChat format ["_freeCargoPositions %1", _freeCargoPositions];
				if (_freeCargoPositions > 0) then {
					{
						// while {_freeCargoPositions > 0} do {
							_x assignAsCargo _myHeli;
							_squaddieGrp = group _x;
							_x setUnitPos "MIDDLE";
							_HKSQUADGP pushBackUnique _squaddieGrp;						
						// };
					} forEach _candidates;	
					_candidates orderGetIn true;
				};
				_pickup = false; // close stage 
				_wait = true; // trigger next stage 
			} else {
				deleteMarker _markerName; // added this << 
				_pickup = false; // close stage 
				_initPhase = true; // go back one stage 				
			};
			// had issues on 23rd march where green strip was not being removed .. attempting to resolve here 
			// removed this - before this would always happen but now i am trying to only progress things when troops are there to be picked up 
			// _pickup = false; // close stage 
			// _wait = true; // trigger next stage 
		};
	};

	// WAIT / BOARD / TRANSIT
	if (_wait) then {
	systemChat "Troops boarded";
		if ((_HELI1ATL1) > 2) then {
			_wait = false;
			_dropoff = true;
			deleteMarker _markerName;
		};
	};

	// DISEMBARK
	if (_dropoff) then {
	systemChat "Get the troops on the ground";
		if ((_HELI1ATL1) < 1.5) exitWith {
			_extractLocation = position _heli;
			_extractMarker = createMarker [_markerName, _extractLocation];
			_extractMarker setMarkerShape "ELLIPSE";
			_extractMarker setMarkerColor "ColorRed";
			_extractMarker setMarkerSize [20, 20];

			// order getOut 
			{
				_squaddieGrp = group _x;
				_HKSQUADGP pushBackUnique _squaddieGrp;
				systemChat format ["hk group: %1", _HKSQUADGP];
				unassignVehicle _x;
			} forEach crew _heli;

			/*
			We need to know how many groups are now leaving, and delete from the output any group that has a player in it 
			so, count array content and count size of each group to test what you get 
			*/
			systemChat format ["_HKSQUAD contains %1 elements: %2:", _testGroupExtract, _HKSQUADGP];
			{
				// count group size
				_groupSize = count units _x;
				systemChat format ["_HKSQUAD group sizes: %1:", _groupSize];
			} forEach _HKSQUADGP;
			_size = count units _group; 
			/*
			End of mini-test 
			*/

			// remove single unit groups from hk system 
			_groupCount = count _HKSQUADGP;
			for "_i" from 1 to _groupCount do {
				_group = _HKSQUADGP select (_i -1);
				_size = count units _group; 
				
				if (_size == 1) then {
					_toRemove = _HKSQUADGP select (_i -1); 
					systemChat format ["Deleting from HK candidates: %1:", _toRemove];
					_HKSQUADGP deleteAt (_i -1);
				} else {
					systemChat format ["Iteration / Group: %1, Size: %2", _group, _size];
				};
			}; 

			_units = allUnits inAreaArray _markerName;
			_units orderGetIn false;

			// {
			// 	_x setUnitPos "AUTO";
			// 	// _x setBehaviour "AWARE";
			// 	_x doMove RGG_DynamicPatrolPosition; // new global that states where indifor should be 
			// 	systemChat format ["%1 moving to %2", _x, RGG_DynamicPatrolPosition];
			// 	sleep 1;
			// } forEach _units; // should this be for HK group?


			if (HUNTERKILLER) then {
				// this bool can turn on/off this action 
				sleep 10;
				{
					[_x] execVM "killChain\systems\hunterKillerSystems\runHK.sqf";
					systemChat format ["debug - sending this: %1", _x];
				} forEach _HKSQUADGP;   
			};

			// if (CPD) then {
			// 	// this bool can turn on/off this action 
			// 	sleep 10;
			// 	{
			// 		[_x, _heli] execVM "killChain\systems\cpdSystems\runCpd.sqf";
			// 		systemChat format ["debug - sending this: %1", _x];
			// 	} forEach _HKSQUADGP;   
			// };

			_dropoff = false;
			_complete = true;
		};
	};

	if (_complete) then {
		_pos = getMarkerPos _markerName;
		_safeDelete = _heli distance _pos;
		if ((_safeDelete) > 5) then {
			deleteMarker _markerName;
			_complete = false;
			_initPhase = true;
		};
	};

	sleep 2;
};

