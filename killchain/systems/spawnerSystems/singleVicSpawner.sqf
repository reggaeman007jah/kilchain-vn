
// this is used explusively by sideWinder Ops 
systemChat "running singleVic Spawner";

while {DISRUPTEVADE} do {

	_enemyCount = east countSide allUnits;

	if ((_enemyCount >= 80) && (_enemyCount < 110)) then {

		// systemChat format ["_enemyCount = %1 ... time for technicals ... ;)", _enemyCount];
		_RGG_hub = getMarkerPos "sideWinder";
		_pos = [_RGG_hub, 1, 1000, 3, 0, 20, 0] call BIS_fnc_findSafePos;
		_opforVic = [_pos, 180, "O_G_Offroad_01_armed_F", east] call BIS_fnc_spawnVehicle;
		sleep 600;
	};

	sleep 60;
};

