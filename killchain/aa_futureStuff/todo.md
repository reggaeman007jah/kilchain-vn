To do...

============================================================================

Add EH to track blue on blue kills
Decide on suitable punishment

http://www.armaholic.com/forums.php?m=posts&q=33056
source: Pierre MGI

\_index = player addMPEventHandler ["MPKilled", { _this execVM "playerKilled.sqf"; }];

Triggered when the unit is killed. EH can be added on any machine and EH code will trigger globally on every connected client and server.
This EH is clever enough to be triggered globally only once even if added on all clients or a single client that is then disconnected, EH
will still trigger globally only once.

MPKilled
unit: Object - Object the event handler is assigned to
killer: Object - Object that killed the unit
Contains the unit itself in case of collisions
instigator: Object - Person who pulled the trigger
useEffects: Boolean - same as useEffects in setDamage alt syntax

This was used before but does not work:

If !(isServer) exitwith {};

{\_x addMPEventHandler ["MPKilled", {
_dead = _this select 0;
_killer = _this select 1;
if ((side _dead == independent) && (side _killer == west)) then {
systemChat "oh noes - blufor killed a friendly"
};
}];
} foreach allUnits;

============================================================================

taken from init.sqf - what were these for?

execVM "VAMP_initParams\vampInitParams.sqf";

execVM "voiceActivatedArty\VAA_Init.sqf";

execVM "autoPatrolSystem\timeStampSystems\timeGen.sqf";

============================================================================

build arty system as before

============================================================================

why did I nit use this? from init.sqf...
execVM "autoPatrolSystem\reinforcementSystems\bluforRF.sqf";

============================================================================

again from init.sqf - what was this for?
// DECIDE = false; // I think this is the only var i need to declare, as the motion.sqf relys on this.

============================================================================

how to do garbage control better ...

having a basic timer cycle can lead to immersion break
so, maybe at a key point you create a new marker, on the position of the old obj marker - "cleanup"
then set a timer to enable players to leave the area, then do cleanup just in that zone ... better chance that noone will
see the function happen ..

// garbage collection - this needs to be mission-based
// while {true} do {
// sleep 600;
// // systemChat "cleanup";
// { deleteVehicle \_x } forEach allDead;
// };

============================================================================

// SF Manager
//player addAction ["Pick up SF", "autoPatrolSystem\callSF.sqf"];
// player setVariable ["isBusy", 111]; // i.e. not busy and needs a task
// execVM "autoPatrolSystem\checkSF.sqf";
// execVM "autoPatrolSystem\checkRF.sqf";
// execVM "autoPatrolSystem\motion.sqf";
// sleep 0.5;

// AI Behaviour Management
// player addAction ["Change Behaviour to Combat", "Modes\combatMode.sqf"];
// player addAction ["Change Behaviour to Safe", "Modes\safeMode.sqf"];
// player addAction ["Change Behaviour to Stealth", "Modes\stealthMode.sqf"];
// player addAction ["Change Behaviour to Aware", "Modes\awareMode.sqf"];

// heli drops
// player addAction ["Drop Smoke", "heliDrops\dropSmoke.sqf"];
// player addAction ["Drop Flare", "heliDrops\dropFlare.sqf"];
// heli2 addAction ["Drop Smoke", "heliDrops\dropSmoke.sqf"];
// heli2 addAction ["Drop Flare", "heliDrops\dropFlare.sqf"];

// Land Check Test Output
// player addAction ["Test findSafeSpot output", "landCheck\landCheck.sqf"];

# above all taken from initServer.sqf ..?

might be useful:

this addEventHandler ["GetIn", {
params ["_vehicle", "_role", "_unit", "_turret"]; {
\_object = \_unit;
[\_object, ["Greetings!", {hint "Hello!"}]] remoteExec ["addAction"]; systemChat str \_unit;
};
}];

============================================================================

more stuff taken from initServer.sqf:

// initialise Heli Systems
// execVM "autoPatrolSystem\heliSystems\heliSystemsInit.sqf";
// // systemchat "debug --- Heli Systems ACTIVATED";
// sleep 0.5;

// initialise debug UAV
// execVM "autoPatrolSystem\UAV\uav.sqf";
// systemchat "debug --- UAV Systems ACTIVATED";
// sleep 0.5;

// test addAction
// // heliAttack4
// // if (isServer) then
// {
// \_object = heliAttack4;
// [\_object, ["Greetings!", {hint "Hello!"}]] remoteExec ["addAction"];
// };
// sleep 60;

============================================================================

while {true} do {
{ deleteVehicle \_x } forEach allDead;
systemChat "cleanup";
sleep 30;
};

The above is currently in initSever - we need a much better system of cleanup
Maybe based on patrol point progression..? Or maybe an EH on dead, to wait x seconds
before deleting..?

============================================================================

Add ambient bombing runs

============================================================================

sort out sapper system - I took this:

// track created units  
spawnedIndiUnit = 0;
spawnedOpforUnit = 0;
publicVariable "spawnedIndiUnit";
publicVariable "spawnedOpforUnit";

// track sapper units
spawnedSapperUnit = 0;

// track whether opfor sapper ops are happening
SAPPERS = false;
publicVariable "SAPPERS";

// sapper stats
sapperWin = 0;
baseDefend = 0;
publicVariable "sapperWin";
publicVariable "baseDefend";

============================================================================

// broken links
RGG_brokenLinks = [];
// maybe make it so if any link is broken, you lose your respawn position?

============================================================================

// you could maybe also track mission time on each 'take' to track time for each mission point?

============================================================================

// bool to track if a patrol has been lost
LOSTPATROL = false;

// base-counter var for tracking how many patrols have been totally wiped out while in-field
lostPatrols = 0;

============================================================================

// base-counter var for tracking how many times RF have been called in
reinforcementsCalled = 0;
publicVariable "reinforcementsCalled";

============================================================================

// createGuardedPoint [east, RGG_patrol_obj, -1, objNull];
// systemChat "guard wp set";

============================================================================

// // calculate static defences
// switch (patrolPointsTaken) do {
// case 0: {
// systemChat "no statics this time around";
// \_rndOp1 = random [8, 12, 16];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [5, 25, 50];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// };
// case 1: {
// for "\_i" from 1 to 1 do {
// \_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_HMG_01_high_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// for "\_i" from 1 to 1 do {
// \_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_static_AT_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// // O_static_AT_F
// \_rndOp1 = random [8, 14, 18];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [5, 25, 50];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// };
// case 2: {
// for "\_i" from 1 to 1 do {
// \_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_G_Mortar_01_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning mortar opfor";
// sleep 1;
// };
// for "\_i" from 1 to 1 do {
// \_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_static_AT_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// \_rndOp1 = random [8, 16, 20];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [5, 25, 50];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// };
// case 3: {
// for "\_i" from 1 to 2 do {
// \_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_HMG_01_high_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// for "\_i" from 1 to 1 do {
// \_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_static_AT_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// \_rndOp1 = random [8, 12, 18];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [5, 25, 50];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// \_rndOp1 = random [4, 8, 10];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [25, 50, 75];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// };
// case 4: {
// for "\_i" from 1 to 2 do {
// \_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_G_Mortar_01_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning mortar opfor";
// sleep 1;
// };
// for "\_i" from 1 to 2 do {
// \_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_static_AT_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// \_rndOp1 = random [8, 12, 18];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [5, 25, 50];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// \_rndOp1 = random [8, 10, 14];
// \_grp = createGroup east;
// systemchat format ["op defencee: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [25, 50, 75];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// };
// case 5: {
// for "\_i" from 1 to 1 do {
// \_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_HMG_01_high_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// for "\_i" from 1 to 1 do {
// \_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_G_Mortar_01_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning mortar opfor";
// sleep 1;
// };
// for "\_i" from 1 to 1 do {
// \_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_static_AT_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// \_rndOp1 = random [10, 14, 20];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [5, 25, 50];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// \_rndOp1 = random [6, 10, 12];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [25, 50, 75];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// };
// case 6: {
// for "\_i" from 1 to 2 do {
// \_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_HMG_01_high_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// for "\_i" from 1 to 2 do {
// \_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_G_Mortar_01_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning mortar opfor";
// sleep 1;
// };
// for "\_i" from 1 to 2 do {
// \_pos = [RGG_patrol_obj, 0, 50] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_static_AT_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// \_rndOp1 = random [10, 14, 20];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [5, 25, 50];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// \_rndOp1 = random [6, 10, 12];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [25, 50, 75];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// \_rndOp1 = random [6, 10, 12];
// \_grp = createGroup east;
// systemchat format ["op defence: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [50, 75, 90];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// };
// // case 6: {
// // for "\_i" from 1 to 3 do {
// // \_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos;
// // \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// // \_static = "O_HMG_01_high_F" createVehicle \_pos;
// // \_unit moveInGunner \_static;
// // \_unit setBehaviour "COMBAT";
// // spawnedOpforUnit = spawnedOpforUnit + 1;
// // systemChat "spawning static opfor";
// // sleep 1;
// // };
// // for "\_i" from 1 to 3 do {
// // \_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos;
// // \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// // \_static = "O_G_Mortar_01_F" createVehicle \_pos;
// // \_unit moveInGunner \_static;
// // \_unit setBehaviour "COMBAT";
// // spawnedOpforUnit = spawnedOpforUnit + 1;
// // systemChat "spawning mortar opfor";
// // sleep 1;
// // };
// // };
// default {
// \_randomStatic = selectRandom [0,1,2,3,4];
// \_randomMortar = selectRandom [0,1,2,3,4];

// for "\_i" from 1 to \_randomStatic do {
// \_pos = [RGG_patrol_obj, 0, 75] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_HMG_01_high_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning static opfor";
// sleep 1;
// };
// for "\_i" from 1 to \_randomMortar do {
// \_pos = [RGG_patrol_obj, 0, 150] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit ["o_g_soldier_ar_f", \_pos, [], 1, "none"];
// \_static = "O_G_Mortar_01_F" createVehicle \_pos;
// \_unit moveInGunner \_static;
// \_unit setBehaviour "COMBAT";
// spawnedOpforUnit = spawnedOpforUnit + 1;
// systemChat "spawning mortar opfor";
// sleep 1;
// };
// \_rndOp1 = random [2, 8, 20];
// \_grp = createGroup east;
// systemchat format ["op defencee: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [5, 25, 50];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// \_rndOp1 = random [2, 8, 20];
// \_grp = createGroup east;
// systemchat format ["op defencee: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [25, 50, 75];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// \_rndOp1 = random [2, 8, 20];
// \_grp = createGroup east;
// systemchat format ["op defencee: %1", _rndOp1];
// for "\_i" from 1 to \_rndOp1 do {
// \_rndtype = selectRandom \_opforClass;
// \_pos = [RGG_patrol_obj, 0, 200] call BIS_fnc_findSafePos;
// \_unit = \_grp createUnit [\_rndtype, \_pos, [], 30, "none"];
// \_randomDir = selectRandom [270, 290, 01, 30, 90];
// \_randomDist = random [50, 75, 90];
// \_endPoint = RGG_patrol_obj getPos [_randomDist, _randomDir];
// \_unit setBehaviour "COMBAT";
// \_unit doMove \_endPoint;
// spawnedOpforUnit = spawnedOpforUnit +1;
// sleep 1;
// };
// };
// };

// systemChat "op defenders spawn complete .....................";

sleep 20; // changes from 5 to 20, in case this was the reasons for the logic glitching out

// HERE WE CHECK IF BLUFOR NEED RF
// execVM "autoPatrolSystem\reinforcementSystems\bluforRF.sqf";
// systemchat "debug --- checking for blufor RF";
// "MP debug --- checking for blufor RF" remoteExec ["systemChat", 0, true];
// this is one of two points where patrol reinforcements are considered - previously this was every 90 seconds, now it is more lean and cheap

// redirects any indifor units incorrectly sent to the old point as part of an RF action
// [_objPos] execVM "killChain\systems\insuranceSystems\indiforMovement.sqf";
// check if this ^^ is actually still needed ??

// check to see when indifor have taken patrol point, and when to trigger opfor rf

============================================================================

[RGG_Heli7] execVM "autoPatrolSystem\heliSystems\smokedrop.sqf";

============================================================================

heli1 addAction ["<t color='#FF0000'>Enable Damage</t>", {
heli1 setDamage true;
}];

heli1 addAction ["<t color='#FF0000'>Disable Damage</t>", {
heli1 setDamage false;
}];

heli1 addAction ["<t color='#FF0000'>Kill Engine</t>", {
private "_gas";
_gas = fuel heli1;
heli1 setFuel 0;
}];

heli1 addAction ["<t color='#FF0000'>Refuel Engine</t>", {
private "_gas";
_gas = fuel heli1;
heli1 setFuel 1;
}];

heli1 addAction ["<t color='#00FF00'>Speed Up</t>", {
heli1 setVelocity [0, 80, 0];
}];

heli1 addAction ["<t color='#00FF00'>Fix It Up</t>", {
heli1 setDamage 0;
}];

heli1 addAction ["<t color='#00FF00'>Set Height 200m</t>", {
[heli1, 200] call BIS_fnc_setHeight;
}];

heli1 addAction ["<t color='#FF0000'>Generate Enemy Infi 300m North</t>", {
\_pos = heli1 getPos [300, 0];
\_group1 = createGroup EAST;
\_unit1 = \_group1 createUnit ["O_Soldier_F", \_pos, [], 10, "NONE"];
}];

heli1 addAction ["<t color='#FF0000'>Generate Enemy APC 600m North</t>", {
\_pos = heli1 getPos [600, 0];
\_jeep = "O_R_APC_Wheeled_02_rcws_v2_ard_F" createVehicle \_pos;
}];

heli1 addAction ["<t color='#0000FF'>REARM</t>", {
heli1 setVehicleAmmo 1;
}];

============================================================================
[_this select 0] execVM "autoPatrolSystem\heliSystems\smokedrop.sqf";
was in the respawn field - fix this!
============================================================================
killchain\systems\ammoSystems\noAmmo.sqf
============================================================================

============================================================================
// \_heli addAction ["<t color='#FF0000'>Generate Enemy Infi 300m North</t>", {
// \_pos = \_heli getPos [300, 0];
// \_group1 = createGroup EAST;
// \_unit1 = \_group1 createUnit ["O_Soldier_F", \_pos, [], 10, "NONE"];
// }];

// \_heli addAction ["<t color='#FF0000'>Generate Enemy APC 600m North</t>", {
// \_pos = hel_helii1 getPos [600, 0];
// \_jeep = "O_R_APC_Wheeled_02_rcws_v2_ard_F" createVehicle \_pos;
// }];

// \_heli addAction ["<t color='#0000FF'>REARM</t>", {
// heli1 setVehicleAmmo 1;
// }];
============================================================================

============================================================================

v

v
