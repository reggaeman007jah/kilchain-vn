/*
get anchor, find safePos or find wooded areas 
is there a sandbag mortar ?
*/


/*
vn_o_nva_65_static_mortar_type53
vn_o_nva_65_static_mortar_type63

vn_o_men_nva_65_29
*/
_startPos = _this select 0;

_classes = [
	"vn_o_nva_65_static_mortar_type53",
	"vn_o_nva_65_static_mortar_type63"
];

_class = selectRandom _classes;
_grp = createGroup [east, true];
_pos = [_startPos, 0, 100] call BIS_fnc_findSafePos;
_unit = _grp createUnit ["vn_o_men_nva_65_29", _pos, [], 1, "none"];
_static = _class createVehicle _pos;
_unit moveInGunner _static;
_unit setBehaviour "COMBAT";

tinmanModule addCuratorEditableObjects [[_static, _unit], true];
bluforZeus addCuratorEditableObjects [[_static, _unit], true];

