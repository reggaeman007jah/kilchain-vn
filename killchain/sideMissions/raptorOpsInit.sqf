// this is to enable player-controlled mission start 
waitUntil { (RAPTOROPS == true) };

// initialise Side Missions 
_pos = getPos ammo1;
[_pos] spawn RGGm_fnc_mission_raptorOps;
