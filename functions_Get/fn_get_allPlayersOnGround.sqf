/*
This will return all players deemed to be on the ground 
*/

_playersOnGround = [];

{
	_pos = getPos _x;
	_alt = _pos select 2;
	if (_alt < 2) then {
		_playersOnGround pushBack _x;
	};
	sleep 0.2;
} forEach allPlayers;

_playersOnGround