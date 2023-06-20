spectate:{[params]
  gd:`scene`params!(`spectate;()!());

  draw[.spectate.level;""];

  while[`spectate~gd`scene;
    input:getinput[];
    $[
      input~"q";:.game.quitdict;
      input~"m";:.game.menudict;
    ];

    draw[.spectate.level;""];
  ];

  :gd;
 };
