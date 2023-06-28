system"l game/howTo.q";
system"l game/joinCfg.q";
system"l game/joinWait.q";
system"l game/menu.q";
system"l game/nameCfg.q";
system"l game/play.q";

.game.menuDict:`scene`params!(`menu;());
.game.quitDict:`scene`params!(`;());

game:{[]
  gameDict:`scene`params!(`menu;());

  while[`<>gameDict`scene;
    gameDict:$[
      `howTo~        gameDict`scene;howTo[gameDict`params];
      `joinCfg~      gameDict`scene;joinCfg[gameDict`params];
      `joinWait~     gameDict`scene;joinWait[gameDict`params];
      `menu~         gameDict`scene;menu[gameDict`params];
      `nameCfg~      gameDict`scene;nameCfg[gameDict`params];
      `play~         gameDict`scene;play[gameDict`params];
      .game.quitDict
    ];
  ];
 };
