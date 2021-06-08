if (!BESILENT) then {
	
	COMMANDSPEAKING = true;

	sleep 1;

	{playSound "opforNeutralised1"} remoteExec ["call",0];

	sleep 3;

	{playSound "commandOut"} remoteExec ["call",0];

	sleep 3;

	COMMANDSPEAKING = false;

	sleep 100;

	COMMANDSPEAKING = true;

	sleep 20;

	{playSound "thisIsCommand1"} remoteExec ["call",0];

	sleep 3;

	{playSound "patrolMoving1"} remoteExec ["call",0];

	sleep 3.2;

	{playSound "commandOut"} remoteExec ["call",0];

	sleep 3;

	COMMANDSPEAKING = false;

};