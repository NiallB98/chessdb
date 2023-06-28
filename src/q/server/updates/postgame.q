.post.choices:`boolean$();

.post.reset:{[]
  .log.warn"Resetting post-game settings . . .";
  system"l server/updates/postgame.q";
  .log.info"Post-game settings reset";
 };

.post.makeChoice:{[choice]
  .post.choices,:choice;
  if[all[.post.choices] and (2~count .subs.players) and 2~count .post.choices;  // If both players want a new game
    .post.reset[];
    .mid.startNew[];
    :();
  ];

  .eu.errorMsg:"Rematch denied";  // If either do not want a rematch
  .log.warn"Rematch request denied";
 };

.post.getUpdate:{[id]  // For players to find out the game has been ended
  .log.debug"Player '",.pre.playerNames[id],"' with handle [",string[.z.w],"] getting a post-game update";
  :(1b;`post;"...");
 };

.post.postUpdate:{[id;choice]  // For players to send whether they want to play again 
  .log.info"Player '",.pre.playerNames[id],"' with handle [",string[.z.w],"] pushed a post-game update";
  .post.makeChoice[choice];
  :1b;
 };
