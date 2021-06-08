// one off order infor on numbers in AO - mayby other stuff later 

// FALLBACKREMAIN = false; // in case was running 

// get overall numbers of troops in redzone 
_unitsRedzone = allUnits inAreaArray "redzone";
	
// Redzone stats 
_redzoneIndi = 0;
{
	switch ((side _x)) do
	{
		case INDEPENDENT: {_redzoneIndi = _redzoneIndi + 1};
	};
} forEach _unitsRedzone;

if (_redzoneIndi > 0) then {
	format ["ARVN Units in AO: %1", _redzoneIndi] remoteExec ["systemChat", 0];
	"Bravo 3 out" remoteExec ["systemChat", 0, true];
} else {
	"No Response from Bravo 3" remoteExec ["systemChat", 0, true];
};

// use -2 here?
