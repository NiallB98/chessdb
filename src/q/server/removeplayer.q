removeplayer:{[id;msg] // Remove player and if the game has progress past the pre-game stage, flag an error
  doerror:.pre.iscomplete[id];

  .subs.players:raze[id] _ .subs.players;
  .subs.playernames:raze[id] _ .subs.playernames;

  if[doerror;[log_error msg;.eu.errormsg:msg;log_warn msg]];
 };
