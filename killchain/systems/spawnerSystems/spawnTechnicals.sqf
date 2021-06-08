systemChat "debug - delete when tested - technical spawner activated";
_anchor = _this select 0;
_target = _this select 1;

// private ["_num", "_delay"]; 
_num = 0;
_delay = 0;

_classList = [
	"O_LSV_02_armed_F",
	"O_G_Offroad_01_armed_F"
];

switch (patrolPointsTaken) do {
	case 1: { _num = 2; _delay = 30; };
	case 2: { _num = 2; _delay = 30; };
	case 3: { _num = 3; _delay = 30; };
	case 4: { _num = 3; _delay = 30; };
	case 5: { _num = 4; _delay = 20; };
	case 6: { _num = 4; _delay = 20; };
	default { systemChat "zero patrol points - no technicals" };
};

for "_i" from 1 to _num do {
	_pos = [_anchor, 0, 100] call BIS_fnc_findSafePos;
	_class = selectRandom _classList;
	_opforVic = [_pos, 180, _class, east] call BIS_fnc_spawnVehicle;
	_opforVic doMove _target;
	sleep _delay;
};
