removeplayer:{[id]
  if[.mid.activeplayer~id;.mid.activeplayer:0Ni];
  .subs.players:raze[id] _ .subs.players;
  .subs.playernames:raze[id] _ .subs.playernames;

  log_warn"Player removed from player list";
 };
