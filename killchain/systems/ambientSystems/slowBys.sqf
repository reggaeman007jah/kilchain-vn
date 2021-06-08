
sleep 300;

while {true} do {

	_helis = [
		"vn_b_air_uh1d_02_07",
		"vn_b_air_ah1g_02",
		"vn_b_air_oh6a_01",
		"vn_b_air_ch34_04_03"
	];
	_chosenHeli = selectRandom _helis;

	_candidates = [];
	{
		_candidates pushBack _x;
	} forEach allPlayers;
	_chosenOne = selectRandom _candidates;
	
	_anchor = getPos _chosenOne;
	_startPos = _anchor getpos [2500,180];
	_endPos = _anchor getPos [2500,0];
	[_startPos, _endPos, 30, "LIMITED", _chosenHeli, west] call BIS_fnc_ambientFlyby;
	sleep 900;
};  