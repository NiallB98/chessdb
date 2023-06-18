joinwait:{[params]
  address:params`address;

  gd:`scene`params!(`joinwait;()!());
  gd[`params;`pname]:params`pname;
  gd[`params;`otherpname]:"Other player";
  gd[`params;`iswhite]:0b;
  gd[`params;`ishost]:0b;

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
