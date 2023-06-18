.hostwait.showport:{[lvl;port]
  :autoshowmsg[lvl;string port;"$";`left];
 };

.hostwait.showip:{[lvl;ip]
  :autoshowmsg[lvl;ip;"@";`left];
 };

.hostwait.draw:{[port;ip]
  lvl:.hostwait.level;
  lvl:.hostwait.showport[lvl;port];
  lvl:.hostwait.showip[lvl;ip];

  draw[lvl;""];
 };

hostwait:{[params]
  gd:`scene`params!(`hostwait;()!());
  gd[`params;`pname]:params`pname;
  gd[`params;`otherpname]:"Other player";
  gd[`params;`iswhite]:1b;
  gd[`params;`ishost]:1b;
  gd[`params;`port]:params`port;

  ip:"." sv string 256 vs .z.a;

  .hostwait.draw[gd[`params;`port];ip];

  while[`hostwait~gd`scene;
    input:getinput[];
    $[
      input~"q";[.game.killserver[];:.game.quitdict];
      input~"m";[.game.killserver[];:.game.menudict];
    ];

    .hostwait.draw[gd[`params;`port];ip];
  ];

  :gd;
 };