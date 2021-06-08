/*
from:
to:			voiceactivatedhighcommand\VAHCO_keyDowns.sqf
to: 		voiceactivatedhighcommand\VAHCO_keyDownMonitor.sqf

new purpose:
enables an indifor player to issue the following commands to indifor 

SL this is tinman 
- go ahead tinman 
I want you to 
	fall back on my position 
	fall back x meters 
	advance x m 
	move to attack objective
	move injured to last LZ 
	Rearm at nearest ammo crate
(or)
please
	confirm strength (numbers) 
	confirm injured 
	confirm ammo 
	confirm position (we need to get all units into one group here)
- wilco tinman, SL out 

for now this is based on only one group, but later versions - if this works - could enable switching between multiple groups 
formation setting is another option 

purpose:
declares arrays and states for the module 
creates initial keydownEH to trigger the module, then removes this initial trigger after being actioned
starts off the module-specific listener that determines what happens on each key press 
also starts off the monitor to loop-listen for changes and move states at key points in the data entry flow
vamp is a universal bool that is used to ensure that only one module can be run at any one time  

notes:
03 Sept:
added new array and bool - VAHCO_objectiveType/Bool - to enable management of different types of objective-based move orders 
1 = secure obj1, 2 = approach obj1, 3 = secure obj2, 4 = approach obj2, 5 = move to staging area 1, 6 = move to staging area 2
*/

sleep 2;
systemChat "VAHCO ACTIVATED!!";
// FALLBACKREMAIN = false; // used for one of the order types - declared here as false 

// vars and arrays initialisation
VAHCO_numericalInputbool	= false; 
VAHCO_orderSelectBool		= false;
VAHCO_orderSelect			= [];	

// key = "numpad 2"
rgg_vahco_Activate = (findDisplay 46) displayAddEventHandler ["KeyDown", "if ((!VAMP) && (_this select 1 == 80)) then {

	execVM 'voiceActivatedHighCommand\radioCheck.sqf';
	
}"];



 

/*
vamp = true;
_ehRemove1 = (findDisplay 46) displayRemoveEventHandler ['keyDown',rgg_vahco_Activate];
systemChat 'VAHC ACTIVATED';
systemChat 'Bravo Copies .. what do you need?';
systemChat 'OPTIONS:';
systemChat '1 fall back (or move to) on my position - send them to player location';
systemChat '2 fall back and (or move to) remain on my position - send them to player and always have them follow player';
systemChat '3 move to attack objective';
systemChat '4 confirm strength (numbers)';
systemChat '5 confirm position (we need to get all units into one group here)';
VAHCO_numericalInputbool = true; 
VAHCO_orderSelectBool = true;
execVM 'voiceactivatedhighcommand\VAHCO_keyDowns.sqf'; 
execVM 'voiceactivatedhighcommand\VAHCO_keyDownMonitor.sqf'; 




