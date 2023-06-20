spectatewait:{[params]
  gd:`scene`params!(`spectatewait;()!());

  draw[.spectatewait.level;""];

  while[`spectatewait~gd`scene;
    input:getinput[];
    $[
      input~"q";:.game.quitdict;
      input~"m";:.game.menudict;
    ];

    draw[.spectatewait.level;""];
  ];

  :gd;
 };
