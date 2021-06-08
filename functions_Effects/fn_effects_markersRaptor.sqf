_loop = true;

params ["_pos", "_type", "_name", "_col"];

// _loop = _this select 0; // bool that controls how long the marker lives / shows 
_pos = _this select 0; // position of marker 
_type = _this select 1; // type of marker 
_name = _this select 2; // name of marker 
_col = _this select 3; // colour of marker 

while {RAPTOROPS} do {
	_mkr = createMarker [_name, _pos];
	_mkr setMarkerType _type;
	_mkr setMarkerColor _col;
	_mkr setMarkerAlpha 0.1;
	sleep 0.1;
	_mkr setMarkerAlpha 0.2;
	sleep 0.1;
	_mkr setMarkerAlpha 0.3;
	sleep 0.1;
	_mkr setMarkerAlpha 0.4;
	sleep 0.1;
	_mkr setMarkerAlpha 0.5;
	sleep 0.1;
	_mkr setMarkerAlpha 0.6;
	sleep 0.1;
	_mkr setMarkerAlpha 0.7;
	sleep 0.1;
	_mkr setMarkerAlpha 0.8;
	sleep 0.1;
	_mkr setMarkerAlpha 0.9;
	sleep 0.1;
	_mkr setMarkerAlpha 1;
	sleep 3;
	deleteMarker _name; 
};

