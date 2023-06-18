joinwait:{[params]  // Repeatedly tries to send a query to the host address until a response is made, it will then receive the final details needed to move onto playing the game
  address:params`address;

  gd:`scene`params!(`joinwait;()!());
  gd[`params;`pname]:params`pname;
  gd[`params;`otherpname]:"Other player";
  gd[`params;`iswhite]:0b;
  gd[`params;`ishost]:0b;
  gd[`params;`port]:params`port;

  draw[.joinwait.level;""];

  while[`joinwait~gd`scene;
    input:getinput[];
    $[
      input~"q";:.game.quitdict;
      input~"m";:.game.menudict;
    ];

    draw[.joinwait.level;""];
  ];

  :gd;
 };
