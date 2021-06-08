/*
from:		voiceactivatedhighcommand\initialiseVAHCO.sqf 
to:			voiceactivatedhighcommand\VAHCO_OscarMike.sqf

purpose:
loop-listener that validates user input, and changes state at correct times 

notes:
I use RGG_Grp_Num in my display - do I need this var in the display? If so, can I remove the global?

order type 1 = general move order --- needs stop, fall back and move to me in this bunch 
order type 2 = objective-based order 
order type 3 = order multiple units at the same time --- essentially a group order to be executed simultaneously
order type 4 = route order

03 Sept:
I think I need new arrays to hold instructions for objective-based movement 
I can do it with just one array, so if 'any' content, then we know obj-based task is being given, the content 
itself determines the actual type of instruction 
1 = secure obj1, 2 = approach obj1, 3 = secure obj2, 4 = approach obj2, 5 = move to staging area 1, 6 = move to staging area 2

Added new section for order type 2 = objectives - now both lead to oscarMike.sqf 


*/

while {VAHCO_numericalInputbool} do {

	VAHCO_Validate_Orders = count VAHCO_orderSelect; 		// should contain 1 value

	if (VAHCO_orderSelectBool) then {

		if (VAHCO_Validate_Orders == 1) then { 

			_orderType = VAHCO_orderSelect select 0;

			if (_orderType == 1) then {
				systemChat "Copy - we are moving to your location now";
				systemChat "bravo out";
				remoteExec ["RGGo_fnc_order_fallBack", 2]; 
				// spawn RGGo_fnc_order_fallBack;
				// execVM "voiceActivatedHighCommand\orders\fallBack.sqf";
				// issue order to send all redzone indifor units to player pos 
				// useful to consolidate troops before an assault or defence 
				// call FNC to do this 
			};
			if (_orderType == 2) then {
				systemChat "Copy - we are moving to your location now and will remain with you";
				systemChat "bravo out";
				remoteExec ["RGGo_fnc_order_fallBackRemain", 2]; 
				// execVM "voiceActivatedHighCommand\orders\fallBackRemain.sqf";
				// issue order to send all redzone indifor units to player pos - diff is that this will be a continuous movement around player pos 
				// good for protection, or moving with the pack - might be slow going though 
				// call FNC to do this 
			};
			if (_orderType == 3) then {
				systemChat "Copy - moving to attack objective";
				systemChat "Bravo 3 out";
				remoteExec ["RGGo_fnc_order_attack", 2]; 
				// execVM "voiceActivatedHighCommand\orders\attack.sqf";
				// issue order to send all indifor to attack the OBJ 
				// call FNC to do this
			};
			if (_orderType == 4) then {
				// systemChat "Copy = we have some units left";
				// systemChat "bravo out";
				remoteExec ["RGGo_fnc_order_sitrep", 2]; 
				// execVM "voiceActivatedHighCommand\orders\sitrep.sqf";
				// Get a report of how many units are left in the redzone 
				// useful to inform reinforcement requests 
				// call FNC to do this
			};
			if (_orderType == 5) then {
				systemChat "Copy we will hold position";
				systemChat "bravo out";
				remoteExec ["RGGo_fnc_order_hold", 2]; 
				// execVM "voiceActivatedHighCommand\orders\hold.sqf";
				// get report of group location or locations 
				// phase two
			};
			// if (_orderType == 6) then {
			// 	systemChat "Copy our position is here";
			// 	systemChat "bravo out";
			// 	// get report of group location or locations 
			// 	// phase two
			// };

			VAHCO_orderSelectBool = false;
			execVM "voiceactivatedhighcommand\VAHCO_clearKeyDowns.sqf";
		};
	};

	sleep 0.5;
};

