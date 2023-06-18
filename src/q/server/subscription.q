chessplayersub:{[pname]
  if[2<=count .server.players;
    log_warn"Extra player with handle [",string[.z.w],"] tried to connect";:0b];

  log_info"New player '",pname,"' joined with handle [",string[.z.w],"]";
  .server.players[.z.w]:.z.p;  // Update player's timestamp
  .server.playernames[.z.w]:`$pname;
  .server.isplaying:2~count .server.players;
  
  :(1b;.server.isplaying);
 };

chessspectatorsub:{[]
  log_info"New spectator joined with handle [",string[.z.w],"]";
  .server.spectators[.z.w]:.z.p;  // Update spectator's timestamp
  :1b;
 };

removeinactiveplayers:{[]
  if[not .server.isplaying;:()];

  pl1:.server.activeplayer;
  pl2:first key[.server.players] except pl1;

  missingpl:$[
    ACTIVE_PLAYER_TIMEOUT<.z.p-.server.players pl1;pl1;
    INACTIVE_PLAYER_TIMEOUT<.z.p-.server.players pl2;pl2;
    0Ni
  ];

  if[not missingpl~0Ni;
    .server.players:raze[missingpl] _ .server.players;
    .server.playernames:raze[missingpl] _ .server.playernames;
    msg:"Player '",string[.server.playernames missingpl],"' timed out";
    log_error msg;
    .server.errorresult:(0b;msg);
    .server.activeplayer:0Ni;
  ];

  :();
 };

removeinactivespectators{[]
  missing:key[.server.spectators] where (.z.p-value .server.spectators)>INACTIVE_SPECTATOR_TIMEOUT;
  .server.spectators:missing _ .server.spectators;
 };

removeinactivesubs:{[]
  removeinactiveplayers[];
  removeinactivespectators[];
 };
