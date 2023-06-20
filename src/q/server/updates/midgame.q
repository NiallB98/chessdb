.mid.board:"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";  // Board uses FEN notation which holds all the information the player processes need to update
.mid.iscomplete:0b;                                                     // When 1b the server knows to run the post-game updates
.mid.wins:(`symbol$())!`long$();                                        // Tracks number of wins for both players
.mid.activeplayer:`;                                                    // For the server to track the active player

.mid.getupdate:{[]  // For the players to get updates on the progress of the ongoing game
  :(`mid;.mid.board);
 };

.mid.postupdate:{  // For the players to send updates after they move
  
 };

.mid.startnew:{[]  // For the new game to start
  .mid.haswon:0b;
 };
