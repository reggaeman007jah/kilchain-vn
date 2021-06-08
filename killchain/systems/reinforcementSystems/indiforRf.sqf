
_initStartPos = _this select 0;
_objPos = _this select 1;

_indi = independent countSide allUnits;

if (_indi <10) then {
	// ORDER RF HERE
	systemChat "debug - INDIFOR RF Inbound";
	[_initStartPos, _objPos] execVM "killChain\systems\spawnerSystems\createIndiforRFUnits.sqf";
} else {
	systemChat "Debug - RF check made but there are too many INDIFOR troops in game - current limit is <10";
};
