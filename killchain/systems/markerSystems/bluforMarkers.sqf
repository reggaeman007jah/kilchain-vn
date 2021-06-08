/*
This system will cycle on an always loop, showing locations of indifor group leaders 
It may one day show number in team, ammo, health etc .. for now though, just makers 

why if and while? if first means that this will only listen if the script is called 
and once called will only run when mission is live 
i could have left out the if and just used while, but then while checks would always 
be running in times where we are not in killchain, so this way seems lighter.
*/
sleep 20;
systemChat " DEBUG - BLUFOR MARKER SYSTEM RUNNING";

/*
THIS IS BROKEN !!!
*/

while {TRUE} do {

	_groups = allGroups; // gets all known game groups 
	private _RGG_bluforGroups = []; // empty array to store group IDs / names 

	{
		_RGG_bluforGroups pushBackUnique _x;
	} forEach _groups;

	{
		_size = count units _x; 
		if (_size > 0) then {
			_leader = leader _x;
			_leaderPos = getPos _leader;
			_zPos = _leaderPos select 2;
			if (_zPos < 10) then {
				_stampToString = str _x;
				deleteMarker _stampToString;
				_tempMarker = createMarker [_stampToString, _leaderPos];
				_tempMarker setMarkerType "b_inf";
			};			
		} else {
			_stampToString = str _x;
			deleteMarker _stampToString;
		};
	} forEach _RGG_bluforGroups;

	sleep 30;
};

