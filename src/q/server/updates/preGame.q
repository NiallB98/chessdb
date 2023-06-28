.pre.sides:(`$())!`char$();
.pre.hasOtherName:`$();  // List of players who have received the other player's name (ie. moved to play mode). Note: this can only possibly be >0 if there are currently 2 players connected

.pre.cleanSideCache:{[]  // Ensures only connected players are in the .pre.sides dictionary
  .pre.sides:key[.subs.players]#.pre.sides;
 };

.pre.assignSide:{[id]  // Either returns the side a player has already been assigned, the opposite of the other player or a random one if no one has been assigned a side yet
  .pre.cleanSideCache[];

  .pre.sides[id]:$[
    any "wb" in .pre.sides[id];.pre.sides[id];                                   // If player already has their side set
    any "wb" in value .pre.sides;first "wb" where not "wb" in value .pre.sides;  // If other player has their side set
    first 1?"wb"                                                                 // If neither player has their side set, choose one at random
  ];
  
  :.pre.sides[id];
 };

.pre.isComplete:{[id]  // Tracks if player has got the other player's name, ie. they have moved to play mode
  :id in .pre.hasOtherName;
 };

.pre.getOtherPName:{[id]                                              // If a player gets the other player's name they will be moved to play mode, if there is no other player right now "" will be returned instead
  notPl:value[.subs.playerNames] where not id=key .subs.playerNames;  // Get name of other player, but keep in list form for now
  
  :$[
    0~count notPl;"";                                                 // If there is no other player yet return ""
    [
      .pre.hasOtherName:distinct .pre.hasOtherName,id;                // If player gets the name of the other player add them to the list of .pre.hasOtherName
      string first notPl                                              // Name of the other player
    ]
  ];
 };

.pre.getUpdate:{[id]
  .log.debug"Pre-game update being received for player '",string[.subs.playerNames[id]],
           "' with handle [",string[.z.w],"]";
  
  otherPName:.pre.getOtherPName id;
  side:.pre.assignSide id;

  if[all .pre.isComplete each key .subs.players;.log.info"Both players updated, game has started"];

  :(1b;`pre;otherPName;side);
 };
