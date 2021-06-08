COMMANDSPEAKING = true;

{playSound "thisIsCommand1"} remoteExec ["call",0];

sleep 2.8;

{playSound "patrolNowLive1"} remoteExec ["call",0];

sleep 4;

{playSound "commandOut"} remoteExec ["call",0];

sleep 2.9;

COMMANDSPEAKING = false;