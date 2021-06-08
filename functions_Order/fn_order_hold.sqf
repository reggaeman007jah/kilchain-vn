// one off order - stop moving 

FALLBACKREMAIN = false; // in case was running 
// systemChat "ARVN Units are holding position";
"ARVN Units are holding position" remoteExec ["systemChat", -2, true];
{playSound "hold"} remoteExec ["call",-2];

_units = allUnits inAreaArray "Redzone";

_indi = [];
{
	if ((side _x) == INDEPENDENT) then {_indi pushBack _x};
} forEach _units;

{
	_pos = getPos _x;
	_x doMove _pos;
	sleep 0.1;
} forEach _indi;