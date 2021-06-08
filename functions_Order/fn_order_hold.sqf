// one off order - stop moving 

FALLBACKREMAIN = false; // in case was running 
systemChat "ARVN Units are holding position";
{playSound "hold"} remoteExec ["call",0];

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