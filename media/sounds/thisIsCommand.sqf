if (!BESILENT) then {
	COMMANDSPEAKING = true;

	{playSound "thisIsCommand1"} remoteExec ["call",0];

	sleep 3;

	COMMANDSPEAKING = false;
};

