
// doing this here means it is outside of the heli loop 
// need to build in time for troopss to disembark 

sleep 300; // no base hits ideally 

_groups = _this select 0; // this array will contain hk groups

_arraySize = count _groups;  

for "_i" from 1 to _arraySize do {
	_group = _HKSQUADGP select (_i -1);
	_size = count units _group; 
	systemChat format ["Iteration / Group: %1, Size: %2", _group, _size];
	if (_size > 1) then {
		// HKSQUADGP deleteAt _i;
		[_group] execVM "killChain\systems\hunterKillerSystems\runHK.sqf";
		systemChat format ["sending this: %1", _group];
	};
};   
