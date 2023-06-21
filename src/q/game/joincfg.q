system"l game/joincfg/edit.q";
system"l game/joincfg/confirm.q";
system"l game/joincfg/draw.q";
system"l game/joincfg/logic.q";

joincfg:{[params]
  pname:params`pname;

  gd:`scene`params!(`joincfg;()!());
  gd[`params;`pname]:params`pname;
  gd[`params;`address]:`::0;
  gd[`params;`id]:`;

  selections:`ip`port`join;
  selected:0;
  msg:"";

  confirmed:0b;

  port:25565;
  ip:"." sv string"i"$0x0 vs .z.a;
  id:`;

  .joincfg.draw[selections;selected;msg;ip;port];

  while[`joincfg~gd`scene;
    input:trim -1 _ read0 0;
    $[
      "q"~lower last input;:.game.quitdict;
      "m"~lower last input;:.game.menudict
    ];

    res:.joincfg.logic[input;selections;selected;ip;port;gd[`params;`pname];id];
    confirmed:res 0; selected:res 1; msg:res 2; ip:res 3; port:res 4; id:res 5;

    if[confirmed;
      gd[`scene]:`joinwait;
      gd[`params;`address]:`$":",ip,":",string port;
      gd[`params;`id]:id;
      :gd;
    ];

    .joincfg.draw[selections;selected;msg;ip;port];

    msg:"";
  ];

  :gd;
 };
