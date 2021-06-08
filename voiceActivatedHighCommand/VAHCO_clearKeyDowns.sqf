/*
from:		voiceactivatedhighcommand\VAHCO_OscarMike.sqf

purpose:
clears all currently assigned key down event handlers 
(will) also clears down all rendered UI 
lastly, turns VAMP back to 'active (false)'

notes:
add CANCEL!
add RSC removals 
*/

_ehVAHCO_Remove0 	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd0];
_ehVAHCO_Remove2 	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd1];
_ehVAHCO_Remove3 	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd2];
_ehVAHCO_Remove4 	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd3];
_ehVAHCO_Remove5 	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd4];
_ehVAHCO_Remove6 	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd5];
// _ehVAHCO_Remove7 	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd6];
// _ehVAHCO_Remove8 	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd7];
// _ehVAHCO_Remove9 	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd8];
// _ehVAHCO_Remove10	= (findDisplay 46) displayRemoveEventHandler ["keyDown",rgg_vahco_kd9];

VAHCO_numericalInputbool = false;

// sleep 3; // quick visual validation of accepted order 
// 1 cutRsc ["default","PLAIN"];

// sleep 0.5;
// systemChat "VAHCO RESET";

vamp = false;

execVM "voiceactivatedhighcommand\VAHCO_init.sqf";