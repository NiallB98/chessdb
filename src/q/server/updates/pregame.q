.pre.sides:(`$())!`char$();
.pre.hasothername:`$();  // List of players who have received the other player's name (ie. moved to play mode). Note: this can only possibly be >0 if there are currently 2 players connected

.pre.rmmissingplayers:{[]
  .pre.sides:key[.subs.players]#.pre.sides;
 };

.pre.assignside:{[id]
  .pre.rmmissingplayers[];

  .pre.sides[id]:$[
    any "wb" in .pre.sides[id];.pre.sides[id];                                   // If player already has their side set
    any "wb" in value .pre.sides;first "wb" where not "wb" in value .pre.sides;  // If other player has their side set
    first 1?"wb"                                                                 // If neither player has their side set, choose one at random
  ];
  
  :.pre.sides[id];
 };

.pre.iscomplete:{[]  // Tracks if both players have gotten the details needed for them to move to play mode
  :2~count .pre.receivedids;
 };

.pre.getotherpname:{[id]
  notpl:value[.subs.playernames] where not id=key .subs.playernames;
  :$[0~count notpl;"";[.pre.hasothername,:id;string first notpl]];
 };

.pre.getupdate:{[id]
  if[(2<>count .subs.players) and id in .pre.hasothername;  // In case this player has the other player's name but the other player lost connection just before receiving this player's name to move to the next stage (If this wasn't here this player would be stuck)
    .eu.errormsg:(0b;"Other player unavailable");
    :.eu.getupdate[];
  ];

  log_debug"Pre-game update received for player '",string[.subs.playernames[id]],
           "' with handle [",string[.z.w],"]";
  
  if[.pre.iscomplete[];log_info"Both players updated, game has started"];

  :(`pre;.pre.getotherpname id;.pre.assignside id);
 };
