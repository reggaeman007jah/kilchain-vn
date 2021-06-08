/*
mini-battle for gunfire effect 

create 2 units, disdable damage - they shoot at eachother .. 10 seconds later, delete objects 
must be in an area where there are no players 
*/

_anchor = _this select 0;

_skirmishPos = [_anchor, 1000, 1200, 10, 0, 1, 0, 250] call RGGf_fnc_find_locationNoPlayers; // last param is prox dist check 

// create both units  
// disable damage 
// wait 10 seconds 
// delete units 

player allowDamage false;