/*
Takes classname and spawnpopint as args 
This func will create a vehicle of provided classname 
created vic will have EHs to manage secoind, third etc vics being created 
When someone gets in, another of same type is created 
There should always be one unused vic at patrol point, so if you get in it, another spawns 
Anotehr EH - getOut - will ensure that when they are abandoned, they get deleted when all players are far away 
*/


/*
"I_G_Quadbike_01_F" should be passed in as an arg 
*/

systemChat "RUNNING - vehicle_quickTransport";
private ["_className", "_spawnAnchor"];
_className = param[0];
_spawnAnchor = param[1];

/*
We need to limit the amount of disposables we can create !
*/

_cnt = count RGG_quickVics;
sleep 10;
if (_cnt < 21) then {
	// create vic
	_vicLocation = _spawnAnchor findEmptyPosition [1,30,"B_Heli_Light_01_dynamicLoadout_F"];
	_quaddy = createVehicle [_className, _vicLocation]; 

	_quaddy addEventHandler ["getIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];
		_class = typeOf _vehicle;
		_pos = getPos _vehicle;
		RGG_quickVics pushBackUnique _vehicle;
		[_class, _pos] spawn RGGv_fnc_vehicle_quickTransport;
		_vehicle removeEventHandler ["getIn", _thisEventHandler];
	}];
} else {
	systemChat "too many disposable vics .. time to walk";
};




