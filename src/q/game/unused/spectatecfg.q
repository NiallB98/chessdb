spectatecfg:{[params]
  gd:`scene`params!(`spectatecfg;()!());

  draw[.spectatecfg.level;"..."];

  while[`spectatecfg~gd`scene;
    input:getinput[];
    $[
      input~"q";:.game.quitdict;
      input~"m";:.game.menudict;
    ];

    draw[.spectatecfg.level;"..."];
  ];

  :gd;
 };
