// REARMONSPAWN = true; // switch this to false to turn off the 'no-ammo on respawn' system 

_heli = _this select 0;

if (REARMONSPAWN) then {

	_heli setVehicleAmmo 0;

};