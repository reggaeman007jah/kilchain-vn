/*
Manages the destruction of enemy camps 
*/

params ["_campType"];

systemChat format ["testing new FNC - parsed data = %1", _campType];

// RGG_potentialEnemyCamps = [];
// this holds enemy camp positions = when 9, job is done 
// RGG_destroyedEnemyCamps = [];

systemChat format ["RGG_potentialEnemyCamps: %1", RGG_potentialEnemyCamps];

RGG_destroyedEnemyCamps pushBack _campType;
systemChat format ["RGG_destroyedEnemyCamps: %1", RGG_destroyedEnemyCamps];

_num = 0;

systemChat "testing forEach extract";
{
	_num = _num +1;
	systemChat format ["_num: %1", _num];
	_data0 = _x select 0;
	systemChat str _data0;
	_data1 = _x select 1;
	systemChat str _data1;
	_data2 = _x select 2;
	systemChat str _data2;
	if (_data2 == _campType) then {
		hint "matched data";
		systemChat "..........";
		// systemChat format ["_x: %1", _x];
		_num = _num -1;
		systemChat format ["RGG_potentialEnemyCamps: %1", RGG_potentialEnemyCamps];
		_data = RGG_potentialEnemyCamps select 0;
		systemChat format ["RGG_potentialEnemyCamps Select 0: %1", _data];
		systemChat "what can we delete from this ^^ ?";
		
		RGG_potentialEnemyCamps deleteAt _num;
	};
} foreach RGG_potentialEnemyCamps;

systemChat "...........";
systemChat format ["RGG_potentialEnemyCamps: %1", RGG_potentialEnemyCamps];
systemChat format ["RGG_destroyedEnemyCamps: %1", RGG_destroyedEnemyCamps];
systemChat "...........";
// _campData = [_campSitePos, _heliPad, "barracks"];