.subs.players:(`symbol$())!`timestamp$();   // Player IDs paired with the most recent time they have queried the server
.subs.playernames:(`symbol$())!`symbol$();  // Maps player IDs to their chosen names

.subs.generateid:{[]
  id:`$32?.Q.an;
  while[id in key .subs.players;id:`$32?.Q.an];  // On the very very small chance the same has been generated twice
  :id;
 };

.subs.chessplayersub:{[pname]
  if[2<=count .subs.players;
    log_warn"Extra player with handle [",string[.z.w],"] tried to connect";:0b];

  log_info"New player '",pname,"' joined with handle [",string[.z.w],"]";

  id:.subs.generateid[];
  .subs.players[id]:.z.p;  // Update player's timestamp
  .subs.playernames[id]:`$pname;
  
  :(1b;id);  // Passing 1b and the player's ID
 };
