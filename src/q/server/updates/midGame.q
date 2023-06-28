START_BOARD:"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";  // Board uses FEN notation which holds all the information the player processes need to update the sections seperated by spaces represent: 1. piece positions, 2. turn taker, 3. available castling moves, 4. enpassant target square for opposite pawns to capture the pawn that just moved two squares, 5. number of halfmoves since the last capture or pawn advance, 6. number of the full moves
.mid.board:START_BOARD;                                                  // Board variable that is modified throught the game
.mid.isComplete:0b;                                                      // When 1b the server knows to run the post-game updates
.mid.wins:(`symbol$())!`long$();                                         // Tracks number of wins for both players
.mid.takenPcs:("";"");

.mid.isActivePlayer:{[id]
  if[not .pre.isComplete[id];:0b];

  :.pre.sides[id]~first vs[" ";.mid.board]1;
 };

.mid.initBoard:{[id]
  if[not verifyPlayer id;
    .log.warn"Unverified instance tried to connect with handle [",string[.z.w],"]";
    :(0b;"Unverified instance");
  ];

  .log.info"Player '",string[.subs.playerNames id],
          "' with handle [",string[.z.w],"] requested the game board";
  
  :(1b;.mid.board);
 };

.mid.updateBoard:{[board]
  `.mid.board set board;
  .log.info"Board updated";
  .log.debug"Board is now:\n",.mid.board;
 };

.mid.updateTakenPcs:{[takenPcs]
  `.mid.takenPcs set takenPcs;
  .log.info"Taken pieces updated";
  .log.debug"Taken pieces are now:\n",-3!.mid.takenPcs;
 };

.mid.getUpdate:{[id]  // For the players to get updates on the progress of the ongoing game
  .log.debug"Player '",string[.subs.playerNames id],
           "' with handle [",string[.z.w],"] getting a mid-game update";
  
  :(1b;`mid;.mid.board;.mid.takenPcs);
 };

.mid.postUpdate:{[id;res]  // For the players to send updates after they move
  board:res 0;
  takenPcs:res 1;

  .mid.updateBoard board;
  .mid.updateTakenPcs takenPcs;
 };

.mid.startNew:{[]  // For the new game to start
  .log.warn"Starting new game . . .";
  system"l server/updates/midgame.q";
  .pre.sides:key[.pre.sides]!reverse value .pre.sides;
  .log.info"New game started";
 };