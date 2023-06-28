system"l server/updates/errorUpdate.q";
system"l server/updates/preGame.q";
system"l server/updates/midGame.q";
system"l server/updates/postGame.q";

verifyPlayer:{[id]
  :id in key .subs.players;
 };

getUpdate:{[id]  // Game processes execute this query to get the latest updates
  if[not verifyPlayer id;
    .log.warn"Unverified instance tried to connect with handle [",string[.z.w],"]";
    :(0b;"Unverified instance");
  ];

  .log.debug"Player ",string[.subs.playerNames id],
           " with handle [",string[.z.w],"] requested an update";

  .subs.players[id]:.z.p;  // Update player's timestamp

  :$[
    .eu.hasErrored[];.eu.getUpdate id;
    .mid.isComplete;.post.getUpdate id;
    .pre.isComplete[id];["Trying to get mid update";.mid.getUpdate id];
    .pre.getUpdate id
  ];
 };

postUpdate:{[id;res]  // Game processes execute this query to update the server if they are leaving (They just pass 0b in res) or posting updates
  if[not verifyPlayer id;
    if[not res~0b;.log.warn"Unverified instance tried to connect with handle [",string[.z.w],"]"];  // If it isn't a timed out player sending a late quitting notification to the server, log a warning
    :(0b;"Unverified instance");
  ];

  .log.info"Player ",string[.subs.playerNames id],
          " with handle [",string[.z.w],"] sent an update";
  
  if[res~0b;
    msg:"Player '",string[.subs.playerNames id],"' left the game";
    removePlayer[id;msg];
    :1b;
  ];  // If the player is leaving, remove player then send back confirmation the server received the update

  .subs.players[id]:.z.p;  // Update player's timestamp

  :$[
    .mid.isComplete;.post.postUpdate[id;res];
    .pre.isComplete[id];.mid.postUpdate[id;res];
    0b  // There is no .pre.postUpdate
  ];
 };
