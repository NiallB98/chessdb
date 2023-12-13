.menu.confirm:{[choice]
  :$[
    choice~`join;`scene`params!(`nameCfg;enlist[`passToScene]!enlist`joinCfg);
    `scene`params!(choice;()!())
  ];
 };

.menu.logic:{[input;selections;selected]
  $[
    input~"w";selected:mod[selected-1;count selections];
    input~"s";selected:mod[selected+1;count selections];
    input~"e";:(.menu.confirm[selections selected];selected);
  ];

  :(`scene`params!(`menu;());selected);
 };

.menu.showSelection:{[lvl;selected]
  lvl:.common.levelEdit.replaceOne[lvl;"%";">";selected;" "];
  :.common.levelEdit.replaceOne[lvl;"@";"<";selected;" "];
 };

.menu.draw:{[selected]
  lvl:.menu.level;
  lvl:.menu.showSelection[lvl;selected];

  .common.draw[lvl;"Up/Down [W/S], Quit [Q], Select [E] "];
 };

menu:{[params]
  gd:`scene`params!(`menu;()!());

  selections:`join`;
  selected:0;

  .menu.draw[selected];                                                                             // Initial draw step
  
  while[`menu~gd`scene;
    input:.common.getInput[];
    if[input~"q";:.game.quitDict];

    res:.menu.logic[input;selections;selected];
    gd:first res;
    selected:last res;

    .menu.draw[selected];
  ];

  :gd;
 };
