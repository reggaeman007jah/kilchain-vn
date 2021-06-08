/*
get anchor, find safePos or find wooded areas 
is there a sandbag mortar ?

vn_o_nva_65_static_rpd_high
vn_o_nva_65_static_pk_low
vn_o_nva_65_static_pk_high
vn_o_nva_65_static_dshkm_low_01
vn_o_nva_65_static_dshkm_low_02
vn_o_nva_65_static_dshkm_high_01
*/

_startPos = _this select 0;

_opforClasses = [
	"vn_o_men_nva_01",
	"vn_o_men_nva_02",
	"vn_o_men_nva_03",
	"vn_o_men_nva_04",
	"vn_o_men_nva_05",
	"vn_o_men_nva_06",
	"vn_o_men_nva_07",
	"vn_o_men_nva_08",
	"vn_o_men_nva_09",
	"vn_o_men_nva_10",
	"vn_o_men_nva_11",
	"vn_o_men_nva_12"
];

_classes = [
	"vn_o_nva_65_static_rpd_high",
	"vn_o_nva_65_static_pk_low",
	"vn_o_nva_65_static_pk_high",
	"vn_o_nva_65_static_dshkm_low_01",
	"vn_o_nva_65_static_dshkm_low_02",
	"vn_o_nva_65_static_dshkm_high_01"
];

_class = selectRandom _classes;
_manned = selectRandom _opforClasses;

_grp = createGroup [east, true];
_pos = [_startPos, 0, 50] call BIS_fnc_findSafePos;
_unit = _grp createUnit [_manned, _pos, [], 1, "none"];
_static = _class createVehicle _pos;
_unit moveInGunner _static;
_unit setBehaviour "COMBAT";
	







