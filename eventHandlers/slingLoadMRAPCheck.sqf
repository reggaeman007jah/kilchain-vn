
systemChat "running extra slingloading rope check";

_MRAP = _this select 0;

if (HUNTERKILLER) then {
	systemChat "HK";
	[_MRAP] execVM "killchain\systems\hunterKillerMRAPSystems\runMRAPHK.sqf"; 
	// Big_Lifter_2 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
};

if (CPD) then {
	systemChat "CPD";
	[_MRAP] execVM "killchain\systems\cpdMRAPSystems\runMRAPCPD.sqf"; 
	// Big_Lifter_2 removeEventHandler ["RopeBreak", 0]; // otherwise this triggers 4 times!
	// execVM "eventHandlers\slingLoadMonitor.sqf"; // reloads EH to the designated heli - currently "heli1"
};

sleep 2;
ROPEBREAK = false;
systemChat "ropebreak reset";