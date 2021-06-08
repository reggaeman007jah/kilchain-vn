// runs from disrupt and evede side mission 
// creates truck near respawn point, for demo 
// when demo'd, respawns another assuming sidemission bool is active 
// takes anchor pos as an arg 
systemChat "fueltruck spawner activcated";
_pos = _this select 0;

_randomRoadPosAroundPlayer = [[[_pos,300]],[], {isOnRoad _this}] call BIS_fnc_randomPos;
_veh = createVehicle ["O_Truck_03_fuel_F", _randomRoadPosAroundPlayer];
deleteMarker "objPos";
_objPos = createMarker ["objPos", _randomRoadPosAroundPlayer];
_objPos setMarkerSize [20,20];
_objPos setMarkerShape "rectangle";
_objPos setMarkerColor "colorRed";

_veh addEventHandler ["Explosion", {
	params ["_vehicle", "_damage"];
	systemChat "truck destroyed";
	_pos = getMarkerPos 'sidewinder';
	[_pos] spawn RGGs_fnc_spawn_fuelTruck;
	_veh removeEventHandler ["Explosion", 0]; 
}];



// _cycle = true;

// sleep 20;

// while {_cycle} do {
	
// 	if (DISRUPTEVADE) then {
// 		// check if alive - if ! then re-run 
// 		if (!alive _veh) then {
// 			_cycle = false;
// 			// re-run function 
// 			systemChat "VIC DESTROYED WELL DONE";
// 			deleteMarker "objPos";
// 			[_pos] spawn RGGs_fnc_spawn_fuelTruck;
// 		} else {
// 			systemChat "vic is not dead";
// 		};
// 	} else {
// 		_cycle = false;
// 	};

// 	systemChat "truck cycle";
// 	sleep 5;
// };

