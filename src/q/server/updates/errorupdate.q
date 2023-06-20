.eu.errormsg:"";  // Error message to pass to player(s) if an error has occurred

.eu.reset:{[]  // Resets global variables to their initial values by reloading the server's child scripts that initialise them
  log_warn"Server resetting . . . ";
  {system 0N!"l server/",x}each("subscription.q";"updates.q");
  log_info"Server reset";
 };

.eu.resetonempty:{[]  // Resets the server once the server encounters an error and no player's are connected anymore
  if[.eu.haserrored[] and 0~count .subs.players;.eu.reset[]];
 };

.eu.getupdate:{[id]
  .log.info"Player '",.pre.playernames[id],"' with handle [",string[.z.w],"] getting error message";
  :(1b;`error;"ERROR: ",.eu.errormsg);
 };

.eu.haserrored:{[]
  :not .eu.errormsg~"";
 };
