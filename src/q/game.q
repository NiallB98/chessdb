system"l game/howto.q";
system"l game/joincfg.q";
system"l game/joinwait.q";
system"l game/menu.q";
system"l game/namecfg.q";
system"l game/play.q";
system"l game/spectate.q";
system"l game/spectatecfg.q";
system"l game/spectatewait.q";

.game.menudict:`scene`params!(`menu;());
.game.quitdict:`scene`params!(`;());

game:{[]
  gamedict:`scene`params!(`menu;());

  while[`<>gamedict`scene;
    gamedict:$[
      `hostcfg~      gamedict`scene;hostcfg[gamedict`params];
      `hostwait~     gamedict`scene;hostwait[gamedict`params];
      `howto~        gamedict`scene;howto[gamedict`params];
      `joincfg~      gamedict`scene;joincfg[gamedict`params];
      `joinwait~     gamedict`scene;joinwait[gamedict`params];
      `menu~         gamedict`scene;menu[gamedict`params];
      `namecfg~      gamedict`scene;namecfg[gamedict`params];
      `play~         gamedict`scene;play[gamedict`params];
      `spectate~     gamedict`scene;spectate[gamedict`params];
      `spectatecfg~  gamedict`scene;spectatecfg[gamedict`params];
      `spectatewait~ gamedict`scene;spectatewait[gamedict`params];
      .game.quitdict
    ];
  ];
 };
