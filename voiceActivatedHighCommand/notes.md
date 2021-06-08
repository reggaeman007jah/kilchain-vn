VAHC - to enable the ordering around (move) of HC groups not under direct command.

To do:
need to determine group leader location
need to build system of direction and distance
need to create new marker location to move to

when ordering groups, I want to be able to get them to move by 8 compass directions N S E W NE SE SW NW
I also want to specify distances of 50m 100m 200m, 500m to start with

so the flow would be:

[activate VAHCO script by pressing - on numpad]
"open a channel"
systemChat "channel open"

[activate listener for keyDowns]
[activate bool state to listen out for which group - here we will hardcode two groups]
systemChat "press 1 for Bravo 1, press 2 for Bravo 2"
BOOL_CHOOSE_GROUP
    1 - group 1     "bravo one this is bravo nine seven"
    2 - group 2     "bravo two this is bravo nine seven"
    9 - all groups  "all groups this is bravo nine seven"



systemChat response "bravo one receiving, go ahead"

now the player needs to give an order.

1 "move out to a new position"      - this will prepare to send the group somewhere else 
2 "confirm - what's your sitrep?"   - this will confirm number of units, number of injured, ammo etc.
3 "fall back to my position"        - this will bring the group back to the playerPos 
4 "secure position"                 - this will send a group to a position, then order them to garrison
5 "conduct recon"                   - this will send a group to a position, and then order them to observe, only firing if fired upon
6 "retreat"                         - this will order the group to locate all enemies in near radius, and select a pos away from them, and move there

to start with we will just try out move to a new position.
so

1 - "stand by for move orders"

systemChat "understood / go ahead sir"

keyDowns go like this:

confirm distance
    1 - 50m
    2 - 100m
    3 - 200m
    4 - 500m
    5 - 1km
confirmDistance = 1 value in array

confirm heading 
    1 - SW
    2 - S
    3 - SE
    4 - W
    5 - 
    6 - E
    7 - NW
    8 - N
    9 - NE
    - - Cancel orders
confirmHeading = 1 value in array





so far we have:
"open a channel"
systemChat "channel open"
"bravo one this is bravo nine seven"
systemChat response "bravo one receiving, go ahead"
"stand by for move orders"
systemChat "go ahead sir"
"move 150m north east"
"understood, moving out sir"

the move order would trigger keyDowns of 3 then 9.
the hard part is writing all of the VA commands for this.

"COLUMN"
"STAG COLUMN"
"WEDGE"
"ECH LEFT"
"ECH RIGHT"
"VEE"
"LINE"
"FILE" (ArmA)
"DIAMOND" (ArmA)
_groupOne setFormation "LINE"

1 = Column, 2 = stag column, 3 = wedge, 4 = ech right, 5 = ech left, 6 = vee, 7 = line, 8 = file, 9 = diamond
