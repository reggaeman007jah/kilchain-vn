if (!BESILENT) then {
	COMMANDSPEAKING = true;

	{playSound "pointTakenPrepare1"} remoteExec ["call",0];

	sleep 7;

	{playSound "commandOut"} remoteExec ["call",0];

	sleep 3;

	COMMANDSPEAKING = false;
};