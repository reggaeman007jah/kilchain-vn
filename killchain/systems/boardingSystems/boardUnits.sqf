// spawn units

_freeCargoPositions = _this select 0;
_heli = _this select 1;

_spawn = [18631.7,8384.17,0.136719];
_float = diag_tickTime;
_stampToString = str _float;
_stampToString = createGroup [independent, true];
_stampToString setFormation "DIAMOND";

_classes = [
	"vn_i_men_sf_01",
	"vn_i_men_sf_02",
	"vn_i_men_sf_03",
	"vn_i_men_sf_04",
	"vn_i_men_sf_05",
	"vn_i_men_sf_06",
	"vn_i_men_sf_07",
	"vn_i_men_sf_08",
	"vn_i_men_sf_09",
	"vn_i_men_sf_10",
	"vn_i_men_sf_11",
	"vn_i_men_sf_12"
],

for "_i" from 1 to _freeCargoPositions do {
	_class = selectRandom _classes;
	_unit = _stampToString createUnit [_class, _spawn, [], 0.1, "none"]; 
	tinmanModule addCuratorEditableObjects [[_unit], true];
	_unit assignAsCargo _heli;
	[_unit] orderGetIn true;
	_sleep = selectRandom [2, 2.1, 2,3];
	sleep _sleep;
};

[_heli] execVM "killchain\systems\boardingSystems\checkDeploy.sqf";
