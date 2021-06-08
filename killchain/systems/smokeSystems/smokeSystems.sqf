_heli = _this select 0;

[_heli, ["<t color='#FF0000'>DROP RED SMOKE</t>", {_smoke = "SmokeShellRed" createVehicle position (_this select 0);},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];
[_heli, ["<t color='#00FF00'>DROP GREEN SMOKE</t>", {_smoke = "SmokeShellGreen" createVehicle position (_this select 0);},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];
[_heli, ["<t color='#0000FF'>DROP BLUE SMOKE</t>", {_smoke = "SmokeShellBlue" createVehicle position (_this select 0);},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];
[_heli, ["<t color='#FFA500'>DROP ORANGE SMOKE</t>", {_smoke = "SmokeShellOrange" createVehicle position (_this select 0);},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];
[_heli, ["<t color='#FFFF00'>DROP YELLOW SMOKE</t>", {_smoke = "SmokeShellYellow" createVehicle position (_this select 0);},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];
[_heli, ["<t color='#6D00C1'>DROP PURPLE SMOKE</t>", {_smoke = "SmokeShellPurple" createVehicle position (_this select 0);},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];
[_heli, ["DROP WHITE SMOKE", {_smoke = "SmokeShellWhite" createVehicle position (_this select 0);},nil,0,false,true,"","true", 5]] remoteExec ["addAction"];

// if (REARMONSPAWN) then {

// 	_heli setVehicleAmmo 0;

// };
// note - no rearm on respwn now done via separate system 