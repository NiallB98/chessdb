.eu.errormsg:(1b;"");  // Error message to pass to player(s) if an error has occurred

.eu.reset:{[]  // Resets global variables to their initial values by reloading the server's child scripts that initialise them
  log_warn"Server resetting . . . ";
  {system 0N!"l server/",x}each("subscription.q";"updates.q");
  log_info"Server reset";
 };

.eu.resetonempty:{[]
  if[.pre.iscomplete[] and 0~count .subs.players;.eu.reset[]];
 };

.eu.getupdate:{[]
  :.eu.errormsg;
 };
