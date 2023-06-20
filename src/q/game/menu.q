.menu.confirm:{[choice]
  :$[
    choice~`join;`scene`params!(`namecfg;enlist[`passtoscene]!enlist`joincfg);
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

.menu.showselection:{[lvl;selected]
  lvl:replaceone[lvl;"%";">";selected;" "];
  :replaceone[lvl;"@";"<";selected;" "];
 };

.menu.draw:{[selected]
  lvl:.menu.level;
  lvl:.menu.showselection[lvl;selected];

  draw[lvl;"Up/Down [W/S], Quit [Q], Select [E] "];
 };

menu:{[params]
  gd:`scene`params!(`menu;()!());

  selections:`join`howto`;
  selected:0;

  .menu.draw[selected];                                                                             // Initial draw step
  
  while[`menu~gd`scene;
    st:.z.t;

    input:getinput[];
    if[input~"q";:.game.quitdict];

    res:.menu.logic[input;selections;selected];
    gd:first res;
    selected:last res;

    .menu.draw[selected];
  ];

  :gd;
 };
