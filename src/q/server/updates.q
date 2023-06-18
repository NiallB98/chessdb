verifyplayer:{[handle]
  :handle in key .server.players;
 };

getplayerupdate:{[]  // Player processes execute this query to get the latest updates
  if[not verifyplayer .z.w;log_warn"Unverified player tried to connect";:()];

  .server.players[.z.w]:.z.p;  // Update player's timestamp
  log_debug"Player with handle [",string[.z.w],"] requested an update";

  :.server.errorresult; // Placeholder
 };

verifyspectator:{[handle]
  :handle in key .server.spectators;
 };

getspectatorupdate:{[]  // Spectator processes execute this query to get the latest updates
  if[not verifyspectator .z.w;log_warn"Unverified spectator tried to connect";:()];

  .server.spectators[.z.w]:.z.p;  // Update spectator's timestamp
  log_debug"Spectator with handle [",string[.z.w],"] requested an update";

  :.server.errorresult; // Placeholder
 };
