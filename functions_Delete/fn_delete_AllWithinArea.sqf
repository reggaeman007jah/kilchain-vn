
_pos = _this select 0;
{ 
	deleteVehicle _x 
} forEach nearestObjects [_pos, ['all'], 400];
