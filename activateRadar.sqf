_dish = _this select 0;
_item = _this select 1;

_pos = getPos _dish;
_dir = getDir _dish;

_anchor = createMarker ["radarPos", _pos];
_anchor setMarkerShape "ELLIPSE";
_anchor setMarkerSize [800,800];
_anchor setMarkerAlpha 0.3;
_anchor setMarkerDir _dir;

_opforRadioOn = true;

_unitsCore = allUnits inAreaArray "radarPos";

_batteryCycles = 0;
_dataStore = [];

while {_opforRadioOn} do {
	if (_batteryCycles < 3) then {
		systemChat "radio cycle";
		_batteryCycles = _batteryCycles +1;
		{
			switch ((side _x)) do
			{
				case EAST: {
					_pos = getPos _x;
					_stampToString = str _x;
					deleteMarker _stampToString;
					_tempMarker = createMarker [_stampToString, _pos];
					_tempMarker setMarkerType "o_inf";
					_dataStore pushBackUnique _stampToString;
				};
			};
		} forEach _unitsCore;
		sleep 10;	
	} else {
		{
			deleteMarker _x;
		} forEach _dataStore;
		_opforRadioOn = false;
		deleteMarker "radarPos";
		deleteVehicle _item;
	};
};

