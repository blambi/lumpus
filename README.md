# Lumpus

Lumpus is in short a multiplayer hunt the wumpus inspired game.


## Idea

### World gen

  Random number of rooms (one or more entries, for later mp expansion?)

  Type A:
   1. Create array with room id repeated 3 times for each room ie: [1,1,1,2,2,2,3,3,3]

   2. Remove some of them but keep atleast one connection.

   3. itterate trough all rooms and assign random connections for them
   (tricky part will be having max 3 connections, maybe we should use
   a hash and ensure we don't break the link back.)


  Type B:

   1. Create array with room id's and shuffle it (these ids should be
   offset some to give some uncertainty of the room count)

   2. Populate a hash with Room ID -> [Connected, Rooms]. Also have
   seperate hash that counts referenses per room. Try to be smart and
   not assign more then 3 rooms but still atleast 1 connection for all
   rooms. (To make life easier we could start with making sure rooms count is dividable by 3 and always assign 3 tunnels)

Type B sounds far easier..

### Room content

### Old Lump/lidl ideas

> [W] Beasts and traps...
>    * MONSTER: kills, killable, no score yet
>    * BAT: skeleton
>    * TRAP/HOLE: kills, but no score reduction
>    * Placement: random but not all
>[ ] non player.c adder to score
>[ ] death reason (a int in player.c will work =) )
>[W] Diffrent bonus scores etc..
>[ ] Later: Storing score in a highscore file
>[ ] Opt: Randomize room ID's
>[ ] Opt: gems or coins to collect and get a bonus for eatch collected
>[ ] Opt: non-danger/combat beasts (rats, bugs that run and hide)
