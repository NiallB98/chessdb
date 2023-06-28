.eu.errorMsg:"";  // Error message to pass to player(s) if an error has occurred

.eu.reset:{[]  // Resets global variables to their initial values by reloading the server's child scripts that initialise them
  .log.warn"Server resetting . . . ";
  {system "l server/",x}each("subscription.q";"updates.q");
  .log.info"Server reset";
 };

.eu.resetOnEmpty:{[]  // Resets the server once the server encounters an error and no player's are connected anymore
  if[.eu.hasErrored[] and 0~count .subs.players;.eu.reset[]];
 };

.eu.getUpdate:{[id]
  .log.info"Player '",.pre.playerNames[id],"' with handle [",string[.z.w],"] getting error message";
  :(1b;`error;"ERROR: ",.eu.errorMsg);
 };

.eu.hasErrored:{[]
  :not .eu.errorMsg~"";
 };
