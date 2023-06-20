UPDATE_INTERVAL_MS:3000;                     // How often the server runs .z.ts (in milliseconds)

INACTIVE_PLAYER_TIMEOUT:0D00:00:30;          // Timeout for player who is not taking on their turn
ACTIVE_PLAYER_TIMEOUT:0D00:10:00;            // Timeout for player whose turn it is, should be the larger of the two
INACTIVE_SPECTATOR_TIMEOUT:0D00:00:30;       // Timeout for spectators

DEBUG:0b;                                    // Shows debug logs

system"l server/log.q";
system"l server/subscription.q";
system"l server/removeplayer.q";
system"l server/updates.q";
system"l server/timeout.q";

.z.ts:{[]
  if[not first .eu.errormsg;:()];  // Skip further execution if an error has already occurred
  .timeout.checkplayertimeouts[];
  .eu.resetonempty[];
 };

run:{[]  // Runs on the startup of the server
  log_info"Chessdb+ server started on:";
  -1"- IP:    ","." sv string"i"$0x0 vs .z.a;
  -1"- Port:  ",string[value"\\p"],"\n";
  value"\\t ",string UPDATE_INTERVAL_MS;
 };

run[];
