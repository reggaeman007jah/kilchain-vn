
private ["_vic"];
_vic = param[0];
_freeCargoPositions = _vic emptyPositions "cargo";
systemChat format ["cargo available: %1", _freeCargoPositions];

_freeCargoPositions;
