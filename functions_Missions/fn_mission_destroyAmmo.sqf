/*


*/

systemChat "DEBUG - RUNNING: missions_destroyAmmo";
_areaCenter = _this select 0; // sat dish object from patrol point  

_assetsCamp = [
	"Land_Cargo_HQ_V4_F"
	// "Land_MobileRadar_01_radar_F"
];

// opfor infi 
_assetsInfi = [
	"CUP_O_sla_Soldier_MG_desert",
	"CUP_O_sla_Soldier_GL_desert",
	"CUP_O_sla_soldier_desert",
	"CUP_O_sla_soldier_desert",
	"CUP_O_sla_soldier_desert",
	"CUP_O_sla_soldier_desert"
];


_missionPos = [_areaCenter, 150, 200, 10, 0, 1, 0, 50] call RGGf_fnc_find_locationNoPlayers; // last param is prox dist check 
// _missionPos = [_areaCenter, 6000, 6500, 10, 0, 1, 0] call BIS_fnc_findSafePos;
sleep 5;

_pos1 = createMarker ["KILLZONE", _missionPos];
_pos1 setMarkerType "hd_objective";
_pos1 setMarkerColor "ColorRed";
_anchorPos = getMarkerPos 'KILLZONE';

// create units 
systemChat "debug - creating units";
_opGroup = createGroup [east, true];
{
	_dist = random 10;
	_dir = random 359;
	_thingPos = _missionPos getPos [_dist, _dir];

	_unit = _opGroup createUnit [_x, _thingPos, [], 0.1, "none"]; 
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;
	_unit setDir _dir;

	sleep 0.1;
} forEach _assetsInfi;

_item1 = true;
_item2 = true;
_item3 = true;
_item4 = true;

_box1 = "Box_Syndicate_Ammo_F" createVehicle _missionPos;
sleep 1;
_box2 = "Box_Syndicate_Ammo_F" createVehicle _missionPos;
sleep 1;
_box3 = "Box_Syndicate_Ammo_F" createVehicle _missionPos;
sleep 1;
_box4 = "Box_Syndicate_Ammo_F" createVehicle _missionPos;

_box1 addEventHandler ["Explosion", {
	params ["_vehicle", "_damage"];
	systemChat "item 1 destroyed";
	deleteVehicle _vehicle;
	_item1 = false;
}];
_box2 addEventHandler ["Explosion", {
	params ["_vehicle", "_damage"];
	systemChat "item 1 destroyed";
	deleteVehicle _vehicle;
	_item2 = false;
}];
_box3 addEventHandler ["Explosion", {
	params ["_vehicle", "_damage"];
	systemChat "item 1 destroyed";
	deleteVehicle _vehicle;
	_item3 = false;
}];
_box4 addEventHandler ["Explosion", {
	params ["_vehicle", "_damage"];
	systemChat "item 1 destroyed";
	deleteVehicle _vehicle;
	_item4 = false;
}];

_checking = true;

while {_checking} do {
	if ((!_item1) && (!_item2) && (!_item3) && (!_item4)) then {
		"Weapons Cache Destroyed - Well Done!" remoteExec ["hint", 0, true];	
		_checking = false;
		RGG_sideMissionCompleted = true;
		deleteMarker "KILLZONE";
	};
	sleep 20;
};
