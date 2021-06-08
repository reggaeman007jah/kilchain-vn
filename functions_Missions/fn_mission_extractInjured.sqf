/*
This function generates a random medevac mission 

To-do:


decide what anchor this should use - for now we can try to use Pathfinder 

or use the container drop system to enable players to decide where their medical FOB is 
this could also trigger the mission - PLUS - it might enable usage during a full killchain session by having a medical base near to the action 

side note - can you disable death and instead have a one-life system with AIS, to enforce medevac back to base for real heal? 

players get a notification with a location - go to 1234 1234 for pickup of walking wounded 

side note - can also enable ammo drops using similar system 

side note - dont forget padre system - dialog to request pickup, drop off, cas, ammo drop, medevac, patrol, scout etc 

side note - dont forget LZ assist - global system to share locational data across helis 

side note - dont forget in-air tracking, to track speed, heading and owner of heli nearby 

you go there 

injured boards heli 

defensive perimiter is there already 

spawn in enemy on approach 

set damage false on all units in that area - this is an effect thing 

ensure lots of machine gunners on both sides 

when near - auto smoke nearby 

when land - injured board 

take off and land at medi-base where they disembark and head into medi tent 

have white coats come out to greet also - like mash 

build system to nuke all when no players are near 

*/

// gen random pos 
// gen units + injured units 
// gen marker 
systemChat "DEBUG - RUNNING: missions_extractInjured";

// this should be informed by the dropping of a medical container 
// container drop should build a medical FOB 
// medical FOB is then the anchor for missions 
// missions must always be at least 1km away from anchor, no more than 4km 

_areaCenter = _this select 0;

_extractPos = [_areaCenter, 1000, 3000, 40, 0, 1, 0] call BIS_fnc_findSafePos;

// the welcome party switch will determine if the ambush happens on landing, on approach, or whether opfor are way further out as heli approaches 
private "_actDist";
switch (_welcomeParty) do {
	case "1": { _actDist = 20 }; // waits for landing before ambush - so sets activation var to small - needs a z value here 
	case "2": { _actDist = 100 }; // triggers an attack on close approach - so sets activation var to medium
	case "3": { _actDist = 500 }; // triggers an attack on long approach - so sets activation var to large 
	default { systemChat "Switch Error _trogActDist" };
};

_medevacPos = createMarker ["EXTRACT", _extractPos];
_medevacPos setMarkerShape "ELLIPSE";
_medevacPos setMarkerColor "ColorRed";
_medevacPos setMarkerSize [50, 50];
// replace this with voice markers 

_medevacPos1 = createMarker ["PZ", _extractPos];
_medevacPos1 setMarkerShape "ELLIPSE";
_medevacPos1 setMarkerColor "ColorRed";
_medevacPos1 setMarkerSize [5, 5];

MEDEVAC = true; // for marker system 
["MEDEVAC", _extractPos, "hd_pickup", "MEDEVAC_Marker", "colorRed"] spawn RGGe_fnc_effects_markers;

for "_i" from 1 to 10 do {
	_indiGroup = createGroup west;
	_unit = _indiGroup createUnit ["I_soldier_F", _extractPos, [], 0.1, "none"]; 
	_randomMovePos = [ ["EXTRACT"] ] call BIS_fnc_randomPos;
	_unit doMove _randomMovePos;
	_stance = selectRandom ["up", "middle", "down"];
	_unit setUnitPos _stance;
	sleep 2;
};

_injured = selectRandom [4,5,6,7,8];
for "_i" from 1 to _injured do {
	_indiGroup = createGroup west;
	// _randomMovePos = [ ["EXTRACT"] ] call BIS_fnc_randomPos;
	_unit = _indiGroup createUnit ["I_soldier_F", _extractPos, [], 0.1, "none"]; 
	// _unit doMove _randomMovePos; Item_Medikit
	_unit removeItem "Item_Medikit";
	_unit removeItem "Item_Medikit";
	_unit removeItem "Item_Medikit";
	_unit setDamage 0.9;
	sleep 2;
};

_injured = allUnits inAreaArray "PZ";

sleep 10;

{
	_x setDamage 0.9;
	
} forEach _injured;
// I do this ^^ bc when you spawn an injured unit they heal as soon as they spawn in .. so this is a hacky way around that issue 

// smoke trigger 
_trgSmk = createTrigger ["EmptyDetector", _missionPos];
_trgSmk setTriggerArea [1000, 1000, 0, false];
_trgSmk setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trgSmk setTriggerStatements ["this", "
	_smoke = createVehicle ['G_40mm_smokeYELLOW', _missionPos, [], 0, 'none']; 
", "systemChat 'no player near'"];

// attack manager 
attackNow = false;

_trg = createTrigger ["EmptyDetector", _extractPos];
_trg setTriggerArea [_actDist, _actDist, 0, false];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements ["this", "
	systemChat 'DEBUG - created trigger activator';
	_allUnitsX = allUnits inAreaArray 'BATTLEZONE';
	{
		_x enableAI 'MOVE';
		_x setBehaviour 'COMBAT';
		_x setCaptive false;
		_x setUnitPos 'AUTO';
	} forEach _allUnitsX;
	attackNow = true;
", "systemChat 'no player near'"];

waitUntil { attackNow; };

// create attacks here 

MEDEVAC = false;

