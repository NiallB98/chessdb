.timeout.timeoutplayer:{[pl]
  doerror:.pre.iscomplete[];
  msg:"Player '",string[.subs.playernames pl],"' timed out";
  removeplayer[pl];
  if[doerror;[log_error msg;.eu.errormsg:(0b;msg);log_warn msg]]
 };

.timeout.checkplayertimeout:{[id]
  res:$[id~.mid.activeplayer;
    ACTIVE_PLAYER_TIMEOUT<.z.p-.subs.players id;
    INACTIVE_PLAYER_TIMEOUT<.z.p-.subs.players id
  ];

  if[res;.timeout.timeoutplayer[id]];
 };

.timeout.checkplayertimeouts:{[]
  .timeout.checkplayertimeout each key .subs.players;
 };
