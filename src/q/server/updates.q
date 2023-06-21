system"l server/updates/errorupdate.q";
system"l server/updates/pregame.q";
system"l server/updates/midgame.q";
system"l server/updates/postgame.q";

verifyplayer:{[id]
  :id in key .subs.players;
 };

getupdate:{[id]  // Game processes execute this query to get the latest updates
  if[not verifyplayer id;
    log_warn"Unverified instance tried to connect with handle [",string[.z.w],"]";
    :();
  ];

  log_debug"Player ",string[.subs.playernames id],
           " with handle [",string[.z.w],"] requested an update";

  .subs.players[id]:.z.p;  // Update player's timestamp

  :$[
    .eu.haserrored[];.eu.getupdate id;
    .mid.iscomplete;.post.getupdate id;
    .pre.iscomplete[id];["Trying to get mid update";.mid.getupdate id];
    .pre.getupdate id
  ];
 };

postupdate:{[id;res]  // Game processes execute this query to update the server if they are leaving (They just pass 0b in res) or posting updates
  if[not verifyplayer id;
    if[not res~0b;log_warn"Unverified instance tried to connect with handle [",string[.z.w],"]"];  // If it isn't a timed out player sending a late quitting notification to the server, log a warning
    :();
  ];

  log_info"Player ",string[.subs.playernames id],
          " with handle [",string[.z.w],"] sent an update";
  
  if[res~0b;
    msg:"Player '",string[.subs.playernames id],"' left the game";
    removeplayer[id;msg];
    :1b;
  ];  // If the player is leaving, remove player then send back confirmation the server received the update

  .subs.players[id]:.z.p;  // Update player's timestamp

  :$[
    .mid.iscomplete;.post.postupdate[];
    .pre.iscomplete[id];.mid.postupdate[];
    0b  // There is no .pre.postupdate
  ];
 };
