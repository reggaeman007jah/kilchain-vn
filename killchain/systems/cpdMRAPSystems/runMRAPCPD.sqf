
systemChat "running runMRAPCPD.sqf";

_mrap = _this select 0;
systemChat format ["dropping off %1", _mrap];

sleep 1;

_commander = commander _mrap;
// systemChat format ["Commander is %1", _commander];

_group = group _commander;

// sleep 1;

// [_group] execVM "killchain/systems/cpdMRAPSystems/protectPlayerMRAP.sqf";
// systemChat format ["sending this: %1", _group];

//


// -----------------------------------------------------------------------------------------

// _cpdGroup = _this select 0; // the cpd group that was delivered 
// _heli = _this select 1; // delivery heli 
// systemChat format ["debug - running runCPD, deploying: %1", _cpdGroup];
// format ["debug - running runCPD, deploying: %1", _cpdGroup] remoteExec ["systemChat", 0]; // does this work??

// _groupLeader = leader _cpdGroup; // leader of cpd group 
// _cpdLeaderPos = getPos _groupLeader; // pos of cpd group leader 
_heliPos = getPos _commander; // get anchor for calcs 
// _dataStore = [1000]; // initial 1km value 
// _candidate = []; // container for winning / closest player 

// _cnt = count allPlayers;

// if (_cnt > 1) then {

// _anchor = _heli getRelPos [10,0];
deleteMarker "cpd1";
_cpd1 = createMarker ["cpd1", _heliPos];
_cpd1 setMarkerShape "ELLIPSE";
_cpd1 setMarkerColor "ColorRed";
_cpd1 setMarkerSize [20, 20];
_cpd1 setMarkerAlpha 0.8;
// sleep 8;

/*
we want to know if there are more than 1 player on server - if only one, then select 0 to apply CPD to player, if more than one ...
... then apply select 1 to essentially ignore the player and have the nearest player to marker receive AI team 
*/

_playersInGame = count allPlayers;

private ["_owner"];

if (_playersInGame == 1) then {
	_owner = 0;
} else {
	_owner = 1;
};

// apply team to player here 
private _markerPos = getMarkerPos "cpd1";
private _playerList = allPlayers apply { [_markerPos distanceSqr _x, _x] };
_playerList sort true;
private _closestPlayer = (_playerList select _owner) param [1, objNull];

systemChat format ["SP debug - winning player is: %1", _closestPlayer];
format ["MP debug - winning player is: %1", _closestPlayer] remoteExec ["systemChat", 0];
sleep 3;

// "MP debug - calling protectPlayer" remoteExec ["systemChat", 0, true];
// [_closestPlayer, _cpdGroup] execVM "killchain\systems\cpdSystems\protectPlayer.sqf";
deleteMarker "cpd1"; 

// -----------------------------------------------------------------------------------------
                                 
[_closestPlayer, _group] execVM "killchain\systems\cpdMRAPSystems\protectPlayerMRAP.sqf";
systemChat format ["sending this: %1", _group];
