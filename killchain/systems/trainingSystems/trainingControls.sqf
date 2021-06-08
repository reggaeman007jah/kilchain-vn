
private _heliTrainer = _this select 0;

_heliTrainer addAction ["<t color='#FF0000'>Enable Damage</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target allowDamage true;
}];

_heliTrainer addAction ["<t color='#FF0000'>Disable Damage</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target allowDamage false;
}];

_heliTrainer addAction ["<t color='#FF0000'>Damage Tail Rotor</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setHitPointDamage ["HitVRotor", 1];
}];

_heliTrainer addAction ["<t color='#FF0000'>Damage Main Rotor</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setHitPointDamage ["HitHRotor", 1];
}];

_heliTrainer addAction ["<t color='#FF0000'>Kill Engine</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setFuel 0;
}];

_heliTrainer addAction ["<t color='#FF0000'>Refuel Engine</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setFuel 1;
	systemChat "starting engine";
}];

_heliTrainer addAction ["<t color='#00FF00'>Go Fast and North</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setVelocity [0, 80, 0];
}];

_heliTrainer addAction ["<t color='#00FF00'>Fix It Up</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setDamage 0;
}];

_heliTrainer addAction ["<t color='#00FF00'>Set Height 200m</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[_target, 200] call BIS_fnc_setHeight;
}];

