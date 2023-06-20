.post.receivednum:0;  // Amount of players that have posted their choice

.post.getupdate:{[id]  // For players to find out the game has been ended
  .log.debug"Player '",.pre.playernames[id],"' with handle [",string[.z.w],"] received post-game update";
  :(`post;"...");
 };

.post.postupdate:{[id]  // For players to send whether they want to play again 
  .log.info"Player '",.pre.playernames[id],"' with handle [",string[.z.w],"] pushed a post-game update";
 };
