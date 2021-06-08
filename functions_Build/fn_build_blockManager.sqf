/*
This function manages the construction of blocks, rising them up from the ground and resetting the z-axis 
*/

// -------------------------------------------------------------------------------------------
// systemChat "RUNNING - build_blockManager";

params ["_block", "_pos", "_dir"];

_block enableSimulation false;
_pos set [2,-5];
_block setPos _pos;
_block setDir _dir; // ?

for [{_i = -5}, {_i < 0.1}, {_i = _i + 0.1}] do {
	_pos set [2,_i]; 
	
	_block setPos _pos;
	sleep 0.1;
};

_pos set [2,0];
_block setPos _pos;
sleep 2;

_block enableSimulation true;

// -------------------------------------------------------------------------------------------
