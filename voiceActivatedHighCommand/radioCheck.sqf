_dataStore = [];
{
	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
} forEach allPlayers;

_player = _dataStore select 0;

_playerPos = getPos _player;

_inRed = _playerPos inArea "redzone";

// check that there are units in redzone to command 
// get overall numbers of troops in redzone 
_unitsRedzone = allUnits inAreaArray "redzone";

// check indi and opfor numbers in redzone 
_redzoneIndi = 0;
{
	switch ((side _x)) do
	{
		case INDEPENDENT: {_redzoneIndi = _redzoneIndi + 1};
	};
} forEach _unitsRedzone;

// systemChat format ["_unitsRedZone: %1", _unitsRedzone];
// systemChat format ["_redzoneIndi: %1", _redzoneIndi];
// systemChat format ["_inRed: %1", _inRed];
// systemChat format ["KILLCHAINISLIVE: %1", KILLCHAINISLIVE];

// // test 

// 	vamp = true;
// 	_ehRemove1 = (findDisplay 46) displayRemoveEventHandler ['keyDown',rgg_vahco_Activate];
// 	systemChat 'VAHC ACTIVATED';
// 	systemChat 'Bravo Copies .. what do you need?';
	
// 	// {playSound "commandOut"} remoteExec ["call",0];
// 	systemChat 'OPTIONS:';
// 	systemChat '1 fall back (or move to) on my position - send them to player location';
// 	systemChat '2 fall back and (or move to) remain on my position - send them to player and always have them follow player';
// 	systemChat '3 move to attack objective';
// 	systemChat '4 confirm strength (numbers)';
// 	systemChat '5 Hold your position';
// 	// systemChat '5 confirm position (we need to get all units into one group here)';
// 	VAHCO_numericalInputbool = true; 
// 	VAHCO_orderSelectBool = true;
// 	execVM 'voiceactivatedhighcommand\VAHCO_keyDowns.sqf'; 
// 	execVM 'voiceactivatedhighcommand\VAHCO_keyDownMonitor.sqf'; 




// current:

if ((_inRed) && (_redzoneIndi > 0)) then {
	vamp = true;
	_ehRemove1 = (findDisplay 46) displayRemoveEventHandler ['keyDown',rgg_vahco_Activate];
	systemChat 'VAHC ACTIVATED';
	systemChat 'Bravo Copies .. what do you need?';
	{_player say2D "squelch";} remoteExec ["call",0];
	// {playSound "commandOut"} remoteExec ["call",0];
	systemChat 'OPTIONS:';
	systemChat '1 fall back (or move to) on my position - send them to player location';
	systemChat '2 fall back and (or move to) remain on my position - send them to player and always have them follow player';
	systemChat '3 move to attack objective';
	systemChat '4 confirm strength (numbers)';
	systemChat '5 Hold your position';
	// systemChat '5 confirm position (we need to get all units into one group here)';
	VAHCO_numericalInputbool = true; 
	VAHCO_orderSelectBool = true;
	execVM 'voiceactivatedhighcommand\VAHCO_keyDowns.sqf'; 
	execVM 'voiceactivatedhighcommand\VAHCO_keyDownMonitor.sqf'; 
} else {
	systemChat "CHHHKKHH - just staic - restarting system CHHKK ";
	vamp = false;
	_ehRemove1 = (findDisplay 46) displayRemoveEventHandler ['keyDown',rgg_vahco_Activate];
	execVM "voiceactivatedhighcommand\VAHCO_init.sqf";
};