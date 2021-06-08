hint "pickup config running";
"Transport Heli Init" remoteExec ["hint", 0, true];

sleep 2;
_heli = _this select 0;

_heli setVehicleVarName "transport1a"; 
transport1 = _heli;
deploymentMission = false;
initPhase = false;
pickup = false;
wait = false;
dropoff = false;
complete = false;

// initialise pickup scripts 
"Transport 1a Heli Ready" remoteExec ["hint", 0, true];
format ["Debug - Heli Var: %1", _heli] remoteExec ["systemChat", 0];

sleep 5;

waitUntil { isEngineOn transport1a; }; 
execVM "autoPatrolSystem\pickupSystems\pickup.sqf";
