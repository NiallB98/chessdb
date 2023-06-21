.post.choices:`boolean$();

.post.reset:{[]
  .log.warn"Resetting post-game settings . . .";
  system"l server/updates/postgame.q";
  .log.info"Post-game settings reset";
 };

.post.makechoice:{[choice]
  .post.choices,:choice;
  if[all[.post.choices] and (2~count .subs.players) and 2~count .post.choices;  // If both players want a new game
    .post.reset[];
    .mid.startnew[];
    :();
  ];

  .eu.errormsg:"Rematch denied";  // If either do not want a rematch
  log_warn"Rematch request denied";
 };

.post.getupdate:{[id]  // For players to find out the game has been ended
  .log.debug"Player '",.pre.playernames[id],"' with handle [",string[.z.w],"] getting a post-game update";
  :(1b;`post;"...");
 };

.post.postupdate:{[id;choice]  // For players to send whether they want to play again 
  .log.info"Player '",.pre.playernames[id],"' with handle [",string[.z.w],"] pushed a post-game update";
  .post.makechoice[choice];
  :1b;
 };
