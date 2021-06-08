/*
From: initServer.sqf 
*/

_heli = _this select 0;

waitUntil { isEngineOn _heli }; 
systemChat "Engine is on!";
// [_heli] execVM "killchain\systems\pickupSystems\pickupSystemsMaster\pickupMonitorJungle.sqf";
[_heli] execVM "killchain\systems\pickupSystems\pickupSystemsMaster\pickupMonitor.sqf";