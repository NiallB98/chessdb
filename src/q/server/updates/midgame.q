START_BOARD:"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";  // Board uses FEN notation which holds all the information the player processes need to update
.mid.board:START_BOARD;                                                  // Board variable that is modified throught the game
.mid.iscomplete:0b;                                                      // When 1b the server knows to run the post-game updates
.mid.wins:(`symbol$())!`long$();                                         // Tracks number of wins for both players

.mid.isactiveplayer:{[id]
  if[not .pre.iscomplete[id];:0b];

  :.pre.sides[id]~first vs[" ";.mid.board]1;
 };

.mid.initboard:{[id]
  if[not verifyplayer id;
    log_warn"Unverified instance tried to connect with handle [",string[.z.w],"]";
    :(0b;"Unverified instance");
  ];

  log_info"Player '",string[.subs.playernames id],
          "' with handle [",string[.z.w],"] requested the game board";
  
  :(1b;.mid.board);
 };

.mid.updateboard:{[board]
  .mid.board:board;
  log_info"Board updated";
 };

.mid.getupdate:{[id]  // For the players to get updates on the progress of the ongoing game
  log_debug"Player '",string[.subs.playernames id],
           "' with handle [",string[.z.w],"] getting a mid-game update";
  
  :(1b;`mid;.mid.board);
 };

.mid.postupdate:{[id;board]  // For the players to send updates after they move
  .mid.updateboard[board];
 };

.mid.startnew:{[]  // For the new game to start
  log_warn"Starting new game . . .";
  system"l server/updates/midgame.q";
  .pre.sides:key[.pre.sides]!reverse value .pre.sides;
  log_info"New game started";
 };
