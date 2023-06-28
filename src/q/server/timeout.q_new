.timeout.timeoutPlayer:{[id]
  msg:"Player '",string[.subs.playerNames id],"' timed out";
  removePlayer[id;msg];
 };

.timeout.checkPlayerTimeout:{[id]
  res:$[.mid.isComplete;POSTGAME_PLAYER_TIMEOUT<.z.p-.subs.players id;
    .mid.isActivePlayer id;ACTIVE_PLAYER_TIMEOUT<.z.p-.subs.players id;
    INACTIVE_PLAYER_TIMEOUT<.z.p-.subs.players id
  ];

  if[res;.timeout.timeoutPlayer[id]];
 };

.timeout.checkPlayerTimeouts:{[]
  .timeout.checkPlayerTimeout each key .subs.players;
 };
