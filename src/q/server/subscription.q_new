.subs.players:(`symbol$())!`timestamp$();   // Player IDs paired with the most recent time they have queried the server
.subs.playerNames:(`symbol$())!`symbol$();  // Maps player IDs to their chosen names

.subs.generateID:{[]
  id:`$32?.Q.an;
  while[id in key .subs.players;id:`$32?.Q.an];  // On the very very small chance the same has been generated twice
  :id;
 };

.subs.chessPlayerSub:{[pName]
  if[2<=count .subs.players;
    .log.warn"Extra player with handle [",string[.z.w],"] tried to connect";:(0b;"Server full")];

  .log.info"New player '",pName,"' joined with handle [",string[.z.w],"]";

  id:.subs.generateID[];
  .subs.players[id]:.z.p;  // Update player's timestamp
  .subs.playerNames[id]:`$pName;
  
  :(1b;id);  // Passing 1b and the player's ID
 };
