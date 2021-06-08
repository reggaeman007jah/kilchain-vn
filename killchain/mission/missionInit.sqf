/*
From: initServer.sqf 

Plan:
Create points to patrol based on mission-placed markers - this gives mission-maker control without needing to open a script  

Mission Marker names are as follows: 
killchainObj1, killchainObj1, killchainObj1, killchainObj1, killchainObj1, killchainObj1, killchainFinal

to-do:
Replace:
// ONEPOINT = false;
// TWOPOINT = false;
// THREEPOINT = false;
System with more simple system 

*/

systemChat "cold-zone system activated - go to the office to start the mission";

// this is to enable player-controlled mission start 
waitUntil { (KILLCHAINMISSIONSTART == true) };

// declare Player Command bool 
RGG_IndiPlayerSystem = false;

// check here - is there indiFor player slot taken when mission has started?
_dataStore = [];
{
	if ((side _x) == INDEPENDENT) then { _dataStore pushback _x }
} forEach allPlayers;

_cnt = count _dataStore;
if (_cnt == 1) then {
	systemChat "INDIFOR PLAYER COMMAND SYSTEM ACTIVATED";
	RGG_IndiPlayerSystem = true;
} else {
	systemChat "STANDARD AI COMMAND SYSTEM ACTIVATED";
};
// if there is an indifor player on mission start, then RGG_IndiPlayerSystem is true, and can be used if needed in future 

// mission bool 
KILLCHAINISLIVE = true;

// voice bools 
COMMANDSPEAKING = false;
// this should ensure that second-level (random) voice alerts do not speak over mission-progression voice alerts 

// enables shushing of command woman 
BESILENT = false;
// if this is false, then command lady will speak, turn to TRUE on console to silence her 

// mission state 
monitorDefence = false;
// to-do - check what this bool does 
// still don't know!

// base-counter var for tracking how many missions have been completed 
patrolPointsTaken = 0;
publicVariable "patrolPointsTaken";
// this will be key to progression in mission 

// flybyIsActive 
flybyIsActive = true;
// this helps to ensure an orderly spawning of ambient aircraft 

// field bases array
RGG_fieldbases = [];
// TBC what does this hold and what is it used for?
// still don't know 

// respawn location store 
RGG_respawnStore = [];
// used to manage the last-point-spawn system 
// we might be able to remove this, as respawns are now limited to main FOB 

// check for whether ok to delete quickVics 
[] spawn RGGd_fnc_delete_quickVics;
// can't recall what this does 

// will hold disposable vics like quads 
RGG_quickVics = [];

// this means that there is a cycleChance that specOps will hunt down players 
SPECOPSATTACKS = true;
// side missions disable this 

// mission status 
MISSIONTASK = "Setting up initial patrol";
publicVariable "MISSIONTASK";
// there are a few different stages of the mission, these states will track the current task 
// to do - confirm what purpose MISSIONTASK does 
// still to-do 

// gather all patrol point position data from mission markers 
RGG_PatrolPoints = [];
for [{private _i = 1}, {_i < 7}, {_i = _i + 1}] do {
    private _marker = format ["killchainObj%1", _i];
	RGG_PatrolPoints pushBack (getMarkerPos _marker);
};
RGG_PatrolPoints pushBack (getMarkerPos "killchainFinal");

// reinstated to test further - later march 2021
execVM "killchain\systems\markerSystems\indiforMarkers.sqf";

[900] execVM "killChain\systems\hunterKillerSystemsOpfor\runHK.sqf"; // 15 minute arg delay 

// test of disposable jeeps - this must be managed, otherwise they will be everywhere 
["vn_b_wheeled_m151_mg_03", [17113.8,7162.41,0]] spawn RGGv_fnc_vehicle_quickTransport;

// commence mission 
execVM "killchain\mission\missionStart.sqf";
systemChat "RUNNING PHASE 1";