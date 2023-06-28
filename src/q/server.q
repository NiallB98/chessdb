UPDATE_INTERVAL_MS:3000;                     // How often the server runs .z.ts (in milliseconds)

INACTIVE_PLAYER_TIMEOUT:0D00:00:05;          // Timeout for player who is not taking on their turn (They should be pinging the server constantly so set this low)
ACTIVE_PLAYER_TIMEOUT:0D00:10:00;            // Timeout for player whose turn it is, should be the larger of the two
POSTGAME_PLAYER_TIMEOUT:0D00:01:00;          // Timeout for players if server is waiting for a response after a game has finished

DEBUG:0b;                                    // Shows debug logs

system"l server/log.q";
system"l server/subscription.q";
system"l server/removePlayer.q";
system"l server/updates.q";
system"l server/timeout.q";

.z.ts:{[]
  .timeout.checkPlayerTimeouts[];
  .eu.resetOnEmpty[];
 };

.z.pg:{[qry]
  .log.debug"Received query:\n",-3!qry;
  :value qry;
 };

run:{[]  // Runs on the startup of the server
  .log.info"Chessdb+ server started on:";
  -1"- IP:    ","." sv string"i"$0x0 vs .z.a;
  -1"- Port:  ",string[value"\\p"],"\n";
  value"\\t ",string UPDATE_INTERVAL_MS;
 };

run[];
