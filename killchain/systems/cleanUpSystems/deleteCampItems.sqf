systemChat "debug - killchainMissionFinal/killchain/systems/cleanUpSystems/deleteCampItems.sqf running";

_campItems = _this select 0; // is array 
_anchor = _campItems select 0; // anchor pos for camp 
_anchorPos = getPos _anchor;

// wait until no players near 
// need to check this does not conflict with new base items 
_playersAreNear = true;
while {_playersAreNear} do {
	_dataStore = [];
	{
		_playerPos = getPos _x;
		_dist = _anchorPos distance _playerPos;

		if (_dist < 500) then {
			_dataStore pushback _x;
		};
	} forEach allPlayers;

	_cnt = count _dataStore;

	if (_cnt == 0) then {
		_playersAreNear = false;
		// systemChat "players are not near - ok to delete items";
		{ deleteVehicle _x } forEach _campItems;
	};

	sleep 60; 
};