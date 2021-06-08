/*
from:		voiceactivatedhighcommand\initialiseVAHCO	
to:			voiceactivatedhighcommand\ --- ?? ---	

purpose:
listens to numpad keypresses, and sends respective values (numpad nums) into arrays 
the array the data is pushed into is dependent on the current state (bool) - this is managed by the monitor 

notes:
need to add a cancel to this!
*/

if (VAHCO_numericalInputbool) then {

	rgg_vahco_cnl = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 181) then {
		
		systemChat 'VAHC SYSTEM ABORTED';
		execVM 'voiceActivatedHighCommand\VAHCO_clearKeyDowns.sqf'; 
		_ehRemove1 = (findDisplay 46) displayRemoveEventHandler ['keyDown', rgg_vahco_cnl];
		VAHCO_numericalInputbool = false;
		execVM 'voiceActivatedHighCommand\VAHCO_Init.sqf';
	}"];

	rgg_vahco_kd0 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 82) then {
			
		systemChat 'VAHCO - 0';
		if (VAHCO_orderSelectBool) then {
			VAHCO_orderSelect pushback 0;
		};

	}"];

	rgg_vahco_kd1 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 79) then {

		systemChat 'VAHCO - 1';
		if (VAHCO_orderSelectBool) then {
			VAHCO_orderSelect pushback 1;
		};
		
	}"];

	rgg_vahco_kd2 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 80) then {
			
		systemChat 'VAHCO - 2';
		if (VAHCO_orderSelectBool) then {
			VAHCO_orderSelect pushback 2;
		};

	}"];

	rgg_vahco_kd3 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 81) then {
			
		systemChat 'VAHCO - 3';
		if (VAHCO_orderSelectBool) then {
			VAHCO_orderSelect pushback 3;
		};

	}"];

	rgg_vahco_kd4 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 75) then {
		
		systemChat 'VAHCO - 4';
		if (VAHCO_orderSelectBool) then {
			VAHCO_orderSelect pushback 4;
		};

	}"];

	rgg_vahco_kd5 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 76) then {
			
		systemChat 'VAHCO - 5';
		if (VAHCO_orderSelectBool) then {
			VAHCO_orderSelect pushback 5;
		};

	}"];

	// rgg_vahco_kd6 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 77) then {
			
	// 	systemChat 'VAHCO - 6';
	// 	if (VAHCO_orderSelectBool) then {
	// 		VAHCO_orderSelect pushback 6;
	// 	};


	// }"];

	// rgg_vahco_kd7 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 71) then {
			
	// 	systemChat 'VAHCO - 7';
	// 	if (VAHCO_orderSelectBool) then {
	// 		VAHCO_orderSelect pushback 7;
	// 	};

	// }"];

	// rgg_vahco_kd8 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 72) then {
			
	// 	systemChat 'VAHCO - 8';
	// 	if (VAHCO_orderSelectBool) then {
	// 		VAHCO_orderSelect pushback 8;
	// 	};

	// }"];

	// rgg_vahco_kd9 = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 73) then {
			
	// 	systemChat 'VAHCO - 9';
	// 	if (VAHCO_orderSelectBool) then {
	// 		VAHCO_orderSelect pushback 9;
	// 	};

	// }"];
};
		

