UPDATE_INTERVAL_MS:3000;                     // How often the server runs .z.ts (in milliseconds)

INACTIVE_PLAYER_TIMEOUT:0D00:00:30;          // Timeout for player who is not taking on their turn
ACTIVE_PLAYER_TIMEOUT:0D00:10:00;            // Timeout for player whose turn it is, should be the larger of the two
INACTIVE_SPECTATOR_TIMEOUT:0D00:00:30;       // Timeout for spectators

DEBUG:0b;                                    // Shows debug logs

.server.players:(`int$())!`timestamp$();     // Player handles paired with the most recent time they have queried the server
.server.playernames:(`int$())!`symbol();     // Maps player handles to their chosen names
.server.spectators:(`int$())!`timestamp$();  // Spectator handles paired with the most recent time they have queried the server

.server.activeplayer:0Ni;                    // Holds the handle for the player that currently is taking their turn
.server.isplaying:0b;                        // If the game has started

.server.errorresult:(1b;"");                 // Keeps track of an error message to pass to subscribers if the first element is 0b

system"l server/log.q";
system"l server/subscription.q";
system"l server/updates.q";

.z.ts:{[]
  if[not first .server.errorresult;:()];  // Skip further execution if an error has already occurred
  removeinactivesubs[];
 };

shutdown:{[]
  log_warn"Shutting down . . .";
  exit 0;
 };

run:{[]  // Runs on the startup of the server
  log_info"Chessdb+ server started on port: ",string value"\\p";
  value"\\t ",string UPDATE_INTERVAL_MS;
 };

run[];
