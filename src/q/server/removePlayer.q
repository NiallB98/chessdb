removePlayer:{[id;msg] // Remove player and if the game has progress past the pre-game stage, flag an error
  doError:.pre.isComplete[id];

  .subs.players:raze[id] _ .subs.players;
  .subs.playerNames:raze[id] _ .subs.playerNames;

  $[doError;[.log.error msg;.eu.errorMsg:msg];.log.warn msg];
 };
