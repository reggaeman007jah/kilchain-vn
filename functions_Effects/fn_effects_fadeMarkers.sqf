/*
Give this a pos and maybe type, it will place a time-limited marker on the map 
*/

_pos = _this select 0; // position  
_type = _this select 1; // marker className 
_name = _this select 2; // unique marker name 
_duration = _this select 3; // time to live before fading  

_tempMarker = createMarker [_name, _pos];
_tempMarker setMarkerType _type;

sleep _duration;

_tempMarker setMarkerAlpha 0.9;
sleep 1;
_tempMarker setMarkerAlpha 0.8;
sleep 1;
_tempMarker setMarkerAlpha 0.7;
sleep 1;
_tempMarker setMarkerAlpha 0.6;
sleep 1;
_tempMarker setMarkerAlpha 0.5;
sleep 1;
_tempMarker setMarkerAlpha 0.4;
sleep 1;
_tempMarker setMarkerAlpha 0.3;
sleep 1;
_tempMarker setMarkerAlpha 0.2;
sleep 1;
_tempMarker setMarkerAlpha 0.1;
sleep 1;
deleteMarker _name;