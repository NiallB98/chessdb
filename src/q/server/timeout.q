.timeout.timeoutplayer:{[id]
  msg:"Player '",string[.subs.playernames id],"' timed out";
  removeplayer[id;msg];
 };

.timeout.checkplayertimeout:{[id]
  res:$[.mid.iscomplete;POSTGAME_PLAYER_TIMEOUT<.z.p-.subs.players id;
    .mid.isactiveplayer id;ACTIVE_PLAYER_TIMEOUT<.z.p-.subs.players id;
    INACTIVE_PLAYER_TIMEOUT<.z.p-.subs.players id
  ];

  if[res;.timeout.timeoutplayer[id]];
 };

.timeout.checkplayertimeouts:{[]
  .timeout.checkplayertimeout each key .subs.players;
 };
