# killchainMissionFinal

Refactor of Killchain Mission

To start the mission, go to the office, walk up to the office, walk up to the clerk to start the mission

Once the mission starts, INDIFOR AI troops will move out automatically to assault the nearest objective

When they win the battle, they will defend that point against OPFOR QRF. Once the battle is won, INDIFOR will progress to the next objective.

There are 6 objectives, and one final fortress-level objective

## Critical Intel

Killchain Discord
https://discord.gg/wpJfHRVAh4

Game Server Modpack
https://steamcommunity.com/sharedfiles/filedetails/?id=1426383126

Teamspeak
Server: 144.76.113.253 port:9017
Password: Mercenary1

TFAR Frequencies and Callsigns
Ground Forces / Callsign Viking / sw C1 frq50
Air Support / Callsign Raptor / sw C1 frq51
Command Net / Callsign Padre / lw C1 frq 52

Detailed Briefing Note
https://docs.google.com/document/d/1dmfX49cl_oqsJiaX4IxqBNq7-c2KeGovWGZNn9y64F8/edit?usp=sharing

Website
https://killchain.netlify.app/

## Note for players

You can play alongside the ground forces (sniper, DMR, medic etc), or you can fly close air support

## Note for mission makers

You need to move the 7 markers around, to define the flow of the mission - make sure the numbers reflect the sequence

## To-Do

Reset mission bool after success .. enabling the mission to be restarted in the office

Add a system to enable storing of three different patrol routes - to be random but never the same as the last

Make a smoke system that works

Add statics and mortars in increasing numbers as players progress

Implement a medivac side mission

Add auto-medic system (on insertion)

Add a supply and rearm system - AI auto rearm on deployed crate

Make injured units hang back and not attack a point

Think about a limiting system for RF

Improve ambient aircraft system

Add a way to win the mission better than just killing everyone - MVP kill?

Make the mission able to run forever - but only on demand

Make an admin menu that enables more control of mission params

Make a padre system that adds mission-specific tasks to raptors

Make a stats system, including how many cycles over 5 there were

Prevent things from spawning on roads

## DONE / UNTESTED

Make burning vics work

## DONE / TESTED (PASSED)

Add catch-all opfor insurance move at stage switch

Ensure OPFOR will push to previous point (QRF stage) when there is a lot of them there

Prevent RF from happening if a point has opfor near it - making RF appear at the next available point

Improve spacing of QRF attack vectors

to:do

make a system that spawns indifor when heli has landed at main airbase and have them board auto
also make it so that when heli is on ground, indi disembark and move to latest position

so here you need a system to track latest obj position, as this will vary much more than before

while before, obj was specific points, now obj is very relative to pos of indifor player

make a system that links indifor movement to player movement when player is indifor

make a patrol point system that has a designated main LZ as the main anchor point - then next patrol point has an anchor reference

MLZ has to be created by mission maker, as well as other patrol points.

Make enemy camps suitable for terrain

Test and check numbers are suitable for terrain

task 1 - spawner and pickup system
wait until heli is landed at PZ
spawn troops relative to heli spaces and have them get in
wait until heli is landed - then check, is this is combat zone?
If not, do not disembark, if yes then get out
So, define comnbat zone - big circle
