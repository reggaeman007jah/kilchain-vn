// [17070.1,7132.84,0]

// create game logic 

// for test, run in loop 
sleep 5;

// test player get 
_playersOnGround = [] spawn RGGg_fnc_get_allPlayersOnGround;

// _playersOnGround = [];

// {
// 	_pos = getPos _x;
// 	_alt = _pos select 2;
// 	if (_alt < 2) then {
// 		_playersOnGround pushBack _x;
// 	};
// 	sleep 0.2;
// } forEach allPlayers;



systemChat format ["returning FNC: %1", _playersOnGround];


/*
while {TRUE} do {
	Item_ItemCompass
	soundSource say3D ["jungle1", 25];	

	systemChat "playing sound";
	sleep 20;
};