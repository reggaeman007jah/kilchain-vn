/*
from:		TBC
to:			voiceactivatedhighcommand\initialiseVAHCO.sqf

purpose:
basic initialiser, in case I need an additional 'staging' step - probably not and should probs remove this 

*/

execVM "voiceactivatedhighcommand\initialiseVAHCO.sqf";

// to do 
// below was just copied, I need to replace with relevanmt comments

// VAA_Init.sqf 		= entry point for app
// initialiseVAA.sqf 	= set up vars, trigger key EH to start script
// keyDowns.sqf 		= enables different EH actions based on particular bool states 
// keyDownMonitor.sqf 	= checks for changes to key trigger points and pushes bools forward if matched
// confirm.sqf 			= final prep, manages parsing coords and countdown info
// execute.sqf 			= createVehicle HE 
// clearKeyDowns.sqf 	= kills all EHs, to avoid second triggers hitting x2 x3 x4 etc 