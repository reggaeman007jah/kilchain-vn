
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

// remove shift map clicks 
// onMapSingleClick {_shift};

// remove stamina 
player enableStamina FALSE;
player addEventHandler ['Respawn',{ player enableStamina FALSE }];

sleep 5;

// untested !!
tinmanModule addCuratorEditableObjects [[player], true];

// voiceMarkerSystem 
// vamp = false;
// execVM "killchain\systems\voiceSystems\voiceMarkerSystem\1_vmsInit.sqf";
// execVM "voiceMarkerSystem\1_vmsInit.sqf";

private _playerFaction = faction player;
// systemChat format ["you are %1 faction", _playerFaction];

if (_playerFaction == "I_ARVN") then {
	vamp = false;
	systemChat "you have use of voice activated systems";
	execVM "voiceactivatedhighcommand\VAHCO_init.sqf";
};



// welcome message 
// execVM "media\sounds\welcome.sqf";

// initial smoke inits for helis 
// [RGG_heli1a] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
// [RGG_heli2a] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
// [RGG_heli3] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";
// [RGG_heli4] execVM "killchain\systems\smokeSystems\smokeSystems.sqf";

// training event handler 
// execVM "eventHandlers\trainingGetInMonitor.sqf";
// this needed aegis - removed for now 



// JTAC
// systemChat "JTAC Systems spinning up";
// execVM "autoPatrolSystem\JTAC_Systems\JTACinit.sqf";

/*
To do: reinstall JTAC and Voice Marker System here 
*/

// test - remove if does not work 
// [player, ["<t color='#FF0000'>DROP RED SMOKE</t>", {_smoke = "SmokeShellRed" createVehicle position player;},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];
// player addAction ["<t color='#FF0000'>DROP RED SMOKE</t>", {_smoke = "SmokeShellRed" createVehicle position player;}];

// for future 
// execVM "voiceActivatedCoordFinder\VACF_init.sqf";
// execVM "voiceActivatedDataStore\VADS_init.sqf";
// execVM "voiceActivatedDataManager\VADM_init.sqf";
// execVM "voiceActivatedSyncShot\VASS_init.sqf";

// test keyDown EH 
// execVM "eventHandlers\keyDown.sqf";




// from Woofer ...

// This is an addaction that needs to go somewhere where a player can access it
// Preferably on the arsenal box and maybe a transport helo
// this addAction ["save player loadout", {KILLCHAIN_SAVED_LOADOUT = getUnitLoadout player}];

// This is an addaction that needs to go somewhere where a player can access it
// Preferably on the arsenal box and maybe a transport helo
/*
this addAction ["load saved loadout", {
	if (isNil {missionNamespace getVariable "KILLCHAIN_SAVED_LOADOUT"}) then {
	systemChat "KILLCHAIN: no loadout saved";
	} else {player setUnitLoadout KILLCHAIN_SAVED_LOADOUT;};
}];
*/



// // If the loadout variable hasn't been set by the player, do nothing
// if (isNil {missionNamespace getVariable "KILLCHAIN_SAVED_LOADOUT"}) then {

// 	systemChat "KILLCHAIN: no loadout saved";

// // If the loadout variable has been set by a player at some point, load the saved loadout to the player
// } else {

// 	player setUnitLoadout KILLCHAIN_SAVED_LOADOUT;

// };