
setTimeMultiplier 25;
remoteExec ["RGGa_fnc_ambient_timeManager", 2];  // execute only on server 

KILLCHAINISLIVE = false;

["Initialize", [true]] call BIS_fnc_dynamicGroups;

// load images 
// dontForget setObjectTextureGlobal [0, "media\images\reloadImage.jpg"];
dontForget setObjectTextureGlobal [0, "media\images\vnMap3.jpg"];
fobPathfinder setObjectTextureGlobal [0, "media\images\pathfinderImage.jpg"];
shootingRange setObjectTextureGlobal [0, "media\images\caution.jpg"];
// customFlag setObjectTextureGlobal [0, "media\images\flag1.jpg"];
customFlag2 setObjectTextureGlobal [0, "media\images\flag1.jpg"];
whiteBoard setObjectTextureGlobal [0, "media\images\whiteBoard2.jpg"];
// customFlag setObjectTexture [0,"media\images\flag1.jpg"]; // BROKEN
customFlag2 setObjectTexture [0,"media\images\flag1.jpg"];
// vnMapX setObjectTexture [0,"media\images\vnMap3.jpg"];
// vnMapX setObjectTexture [0,"media\images\reloadImage2.jpg"];

// blufor marker system 
// execVM "killchain\systems\markerSystems\bluforMarkers.sqf"; // will run even if Killchain does not run 

// Voice Activation Global Declaration - is this needed for jtac and voice markers?
VAA_Activate = true;

// this manages the start of the mission
KILLCHAINMISSIONSTART = false;
SIDEMISSIONSTART = false;
RAPTOROPS = false;

ROPEBREAK = false;

// initialise killchain 
execVM "killchain\mission\missionInit.sqf"; 
// execVM "killchain\sideMissions\sideMissionInit.sqf"; 
// execVM "killchain\sideMissions\raptorOpsInit.sqf"; 
sleep 0.5;



// slingload EH 
execVM "eventHandlers\slingLoadMonitor.sqf";

// event handlers 
execVM "eventHandlers\getInMonitor.sqf";

// // initialise counter system 
// execVM "killchain\systems\countingSystems\counter.sqf";
// dont need this any more I dont think 

// // initialise flybys 
// execVM "killchain\systems\ambientSystems\randomFlybys.sqf";
// done on cycle phases 

// // initialise pickup scripts 
// execVM "killchain\systems\pickupSystems\pickupSystems1\pickupInit.sqf";
// execVM "killchain\systems\pickupSystems\pickupSystems2\pickupInit.sqf";
// execVM "killchain\systems\pickupSystems\pickupSystems3\pickupInit.sqf";

// initiate pickup systems for blackhawks and littlebirds
// [RAIDER_1] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
// sleep 0.5;
// [RAIDER_2] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
// sleep 0.5;
// [RAIDER_3] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
// sleep 0.5;
// [RAIDER_4] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
// sleep 0.5;
[slick_1] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
[slick_2] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
[slick_3] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
[slick_4] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
[slick_5] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
[slick_6] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
[seahorse_1] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
[gunny1] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
[gunny2] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
[gunny3] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
sleep 0.5;
// [slick_4] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
// sleep 0.5;
// [RAIDER_5] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
// sleep 0.5;
// [BIGBIRD_1] execVM "killchain\systems\pickupSystems\pickUpSystemsMaster\pickupInit.sqf";
// sleep 0.5;

// initialise para spawner script 
// execVM "killchain\systems\spawnerSystems\spawnParas.sqf"; // i think these are the phu bar troops..?
// execVM "killchain\systems\spawnerSystems\spawnParas2.sqf";
// fix this ^^ currently gets caught in insurance move orders 

// execVM "killchain\systems\spawnerSystems\spawnGrunts.sqf";
// execVM "killchain\systems\spawnerSystems\spawnMrap.sqf"; - to do - fix this !!
/*
To-do - make the spawner system better 
make sure the renewal system works 
add a playerNear system 
also add a check when doing pickups NOT to change state if you lift off without passengers...
*/

// enables HK Team as default 
HUNTERKILLER = true;
CPD = false;
publicVariable "HUNTERKILLER";
publicVariable "CPD";
// theory here is that a mod can also change this 
// this works!

// this ensures that only one batch of indifor units are spawned at FOB at any one time 
CANBOARD = true;

/*
Day/ night management uses a global bool 
*/
RGG_isDay = true;
publicVariable "RGG_isDay";

/*
This system needs improvement
*/
// while {true} do {
// 	{ deleteVehicle _x } forEach allDead;
// 	systemChat "cleanup";
// 	sleep 30;
// };
// check that other system works ok 

/*
this bool is used to clear out ammo from helis on respawn - this should be with the other param settings 
*/
// to avoid errors 
REARMONSPAWN = true; // switch this to false to turn off the 'no-ammo on respawn' system 

// ----- this holds any sentry units waiting to spawn in (but can't due to lack of base food) -----
RGG_sentryQueue = []; // holds sentry respawn data 
RGG_supplyQueue = []; // holds supply respawn data 
RESPAWNQUEUE = false; // this tracks whether the sentry respawn system is active 
// this holds all relevant enemy camps, by holding their position 
RGG_potentialEnemyCamps = [];
// this holds enemy camp positions = when 9, job is done 
RGG_destroyedEnemyCamps = [];
// Barracks
RGG_Barracks_Food = 0;
RGG_Barracks_Ammo = 0;
RGG_Barracks_Fuel = 0;
RGG_Barracks_Sentries = 0;
publicVariable "RGG_Barracks_Food";
publicVariable "RGG_Barracks_Ammo";
publicVariable "RGG_Barracks_Fuel";
publicVariable "RGG_Barracks_Sentries";

// TEST

// _pack = "B_RadioBag_01_sage_F" createVehicle [12813.7,16690.2,0];
// private "_pack";

// _pack addAction ["Set up Sat-Dish from backpack", {
// 	params ["_target", "_caller", "_actionId", "_arguments"];
// 	_pos = _caller getRelPos [4,0];
// 	_dish = "SatelliteAntenna_01_Small_Sand_F" createVehicle _pos;
	
// 	systemChat "Finding signal ...";
// 	sleep 1;
// 	systemChat "Synchronising cryptographic hashes ...";
// 	sleep 1;
// 	systemChat "System ready";
// 	sleep 1;
	
// 	[_caller, _dish] execVM "activateRadar.sqf";
// 	_target removeAction _actionId;
// }];

// temp remove due to insurance issues 
// execVM "killchain\systems\ambientSystems\slowBys.sqf";


// spec ops mission bool for side mission 
DISRUPTEVADE = false;

// test position 
RGG_DynamicPatrolPosition = [15772.8,6874.21,0];

// create ammo boxes for in-field deployemnts 
[[20026.1,6550.86,0]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[20024.6,6556.53,0]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[20022.3,6562.37,0]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[20020.5,6567.75,0]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[20017.8,6572.95,0]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[20015.7,6579.05,0]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;

// more at dirt pile 
[[11909.9,9186.87,-0.000335693]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[11913.7,9191.42,-0.000305176]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[11917.3,9197.78,-0.000305176]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[11921.4,9203.95,-0.000274658]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[11925.6,9210.26,-0.000305176]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[11929.5,9215.19,-0.000305176]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[11932.7,9220.05,-0.000305176]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[11937.9,9227.21,-0.000305176]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[11944,9239.64,-0.000305176]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;
[[11949.9,9247.55,-0.000274658]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";
sleep 1;

// pathfinder 
[[17093,7137.33,0]] execVM "killchain\systems\spawnerSystems\createAmmoBox.sqf";

// testing sound sources
[soundSource] spawn RGGa_fnc_ambient_jungleSounds;


// [17113.8,7161.41,0]

// _ammoBoxVN = "CargoNet_01_box_F" createVehicle [17113.8,7161.41,0];
// sleep 1;
// clearMagazineCargoGlobal _ammoBoxVN;
// clearWeaponCargoGlobal _ammoBoxVN;
// clearItemCargoGlobal _ammoBoxVN;
// _ammoBoxVN addMagazineAmmoCargo ["vn_m16_20_t_mag", 50, 18];

// _ammoBoxVN = "CargoNet_01_box_F" createVehicle [17113.8,7161.41,0];
// sleep 1;
// clearMagazineCargoGlobal _ammoBoxVN;
// clearWeaponCargoGlobal _ammoBoxVN;
// clearItemCargoGlobal _ammoBoxVN;

// _ammoBoxVN addWeaponCargo ["vn_m16", 5];
// _ammoBoxVN addWeaponCargo ["vn_m72", 4];
// _ammoBoxVN addItemCargo ["vn_b_item_trapkit", 1];
// _ammoBoxVN addItemCargo ["vn_b_item_toolkit", 1];
// _ammoBoxVN addItemCargo ["FirstAidKit", 15];
// _ammoBoxVN addItemCargo ["Medikit", 1];

// // bullets and mags 
// _ammoBoxVN addMagazineAmmoCargo ["vn_m16_20_mag", 60, 18];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m60_100_mag", 15, 100];
// _ammoBoxVN addMagazineAmmoCargo ["vn_rpd_100_mag", 15, 100];
// _ammoBoxVN addMagazineAmmoCargo ["vn_mk22_mag", 5, 14];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m14_mag", 20, 20];
// _ammoBoxVN addMagazineAmmoCargo ["vn_carbine_30_mag", 20, 30];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m3a1_mag", 20, 30];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m38_mag", 10, 5];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m1911_mag", 20, 7];
// _ammoBoxVN addMagazineAmmoCargo ["vn_22mm_m19_wp_mag", 5, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_22mm_m1a2_frag_mag", 5, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_22mm_m22_smoke_mag", 5, 1];

// // 40mm 
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m406_he_mag", 30, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m680_smoke_w_mag", 6, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m682_smoke_r_mag", 6, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m715_smoke_g_mag", 6, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m716_smoke_y_mag", 6, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m717_smoke_p_mag", 6, 1];

// // buck
// _ammoBoxVN addMagazineAmmoCargo ["vn_m1897_buck_mag", 20, 6];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m1897_fl_mag", 5, 6];

// // To Be Classified
// _ammoBoxVN addMagazineAmmoCargo ["vn_welrod_mag", 5, 8];
// _ammoBoxVN addMagazineAmmoCargo ["vn_hd_mag", 10, 10];
// _ammoBoxVN addMagazineAmmoCargo ["vn_hp_mag", 10, 13];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m129_mag", 5, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m128_mag", 5, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m127_mag", 5, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m40a1_mag", 5,5];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m10_mag", 6, 6];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m14_grenade_mag", 5, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m34_grenade_mag", 12, 1];

// // bangs
// _ammoBoxVN addMagazineAmmoCargo ["vn_mine_m18_mag", 6];
// _ammoBoxVN addMagazineAmmoCargo ["vn_mine_satchel_remote_02_mag", 2, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_mine_tripwire_m16_04_mag", 6, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m61_grenade_mag", 20, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m72_mag", 10, 1];

// // colours
// _ammoBoxVN addMagazineAmmoCargo ["vn_m18_green_mag", 4, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m18_purple_mag", 4, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m18_red_mag", 4, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m18_yellow_mag", 4, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_m18_white_mag", 10, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_v40_grenade_mag", 6, 3];
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m583_flare_w_mag", 3, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m661_flare_g_mag", 3, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m695_flare_y_mag", 3, 1];
// _ammoBoxVN addMagazineAmmoCargo ["vn_40mm_m662_flare_r_mag", 3, 1];









// _ammoBoxVN addMagazineCargoGlobal ["vn_m16_20_t_mag", 150, 18];

// this allowDamage false;
// if (isServer) then {
// 	clearWeaponCargoGlobal this;
// 	clearMagazineCargoGlobal this;
// 	clearItemCargoGlobal this;
// 	this addMagazineCargoGlobal["RH_30Rnd_556x45_Mk262",250];
// 	this addMagazineCargoGlobal["1Rnd_HE_Grenade_shell",100];
// 	this addMagazineCargoGlobal["AT4_HEAT",7];
// 	this addMagazineCargoGlobal["AT4_HP",7];
// 	this addMagazineCargoGlobal["100Rnd_762_MAG_Belt",30];
// 	this addMagazineCargoGlobal["100_Rnd_762_Mag_Belt_TR",30];
// 	this addMagazineCargoGlobal["100_Rnd_762_Mag_Belt_TR5",30];
// 	this addMagazineCargoGlobal["hlc_100Rnd_762x51_B_M60E4",30];
// 	this addMagazineCargoGlobal["hlc_100Rnd_762x51_T_M60E4",30];
// 	this addMagazineCargoGlobal["hlc_100Rnd_762x51_M_M60E4",30];
// 	this addMagazineCargoGlobal["200Rnd_556_F89_Belt",30];
// 	this addMagazineCargoGlobal["200Rnd_556_F89_Belt_TR",30];
// 	this addMagazineCargoGlobal["200Rnd_556_F89_Belt_TR5",30];
// };