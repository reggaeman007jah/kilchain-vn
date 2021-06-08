/*
This Function will decide which base should be attacked by a local camp 

Notes:
When all local bases are destroyed, this will stop (i.e. LOCALATTACK will be false)
This will run every x seconds until all camps are dealt with 

We check whether dead camps == 9, if 9 then process stops 
Else, we ID what bases are live, and from there what camps are near live bases 

Extended Notes:
we want to create local attacks against bases, which will continue until the camp is found and destroyed 
for each base created, a camp will be created 
each camp creation pushes a camp pos to a global array 
each camp destroyed deletes that pos from the candidates array and pushes to the destroyed camps array 
when destroyed camps == 9, job is done 

_campData = [_heliPad, _campSitePos, "barracks"];
RGG_potentialEnemyCamps pushBack _campData;

*/

// usse this - SatelliteAntenna_01_Sand_F

// so if we accept that there might be an active enemy base out there 
// LOCALATTACK bool will be false only when all 9 bases have been destroyed 
while {LOCALATTACKS} do {
	sleep 360; // so as not to trigger immediately on mission start 

	// check if any attacks can happen by counting RGG_destroyedEnemyCamps
	_destroyedCamps = count RGG_destroyedEnemyCamps;
	
	if (_destroyedCamps == 9) then {
		LOCALATTACK = false;
		// exitWith {}; // ?
	} else {
		systemChat "CHECKING FOR LOCAL ATTACKS";
		// first check number of opfor - as if too many, skip the spawn this time around 
		_totEnemy = { alive _x && side _x == EAST } count allUnits;
		systemChat format ["Number of OPFOR: %1", _totEnemy];

		if (_totEnemy <= 40) then {
			// decide which live base should be attacked and has a base nearby 
			// to do this we see which bases are in the relevant canididate array 
			_candidates = count RGG_potentialEnemyCamps;
			if (_candidates > 0) then {
				_attackingCamp = selectRandom RGG_potentialEnemyCamps;
				_campPos = _attackingCamp select 0;
				_targetPos = _attackingCamp select 1;
				_target = _attackingCamp select 2;
				systemChat format ["_campPos: %1, _targetPos: %2, _target: %3", _campPos, _targetPos, _target];
				systemChat ".....";
				_azimuth = _targetPos getDir _campPos;
				systemChat format ["Command, this is %1 - Enemy approaching from heading: %2", _target, _azimuth];
				sleep 1;
				[_campPos, _targetPos, _target] call RGGl_fnc_LocalAttacks_generate;
			};
		} else {
			systemChat "DEBUG - ATTACK SKIPPED AS THERE ARE ALREADY TOO MANY ALIVE OPFOR";
			systemChat str _totEnemy;
		};
	};	
};