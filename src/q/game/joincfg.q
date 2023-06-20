system"l game/joincfg/edit.q";
system"l game/joincfg/confirm.q";
system"l game/joincfg/draw.q";

.joincfg.logic:{[input;selections;selected;ip;port;pname;id]
  $[
    "w"~last input;selected:mod[selected-1;count selections];
    "s"~last input;selected:mod[selected+1;count selections];
    (`join~selections selected) and "e"~last input;:.joincfg.confirm[ip;port;pname];
    (1<count input) and selections[selected] in `ip`port;
      :.joincfg.edit[input;selections;selected;ip;port];
  ];

  :$[
    `join~selections selected;(0b;selected;"Confirm? [E]";ip;port;id);
    (0b;selected;"";ip;port;id)
  ];
 };

joincfg:{[params]
  pname:params`pname;

  gd:`scene`params!(`joincfg;()!());
  gd[`params;`pname]:params`pname;
  gd[`params;`handle]:`::0;
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
      "q"~last input;:.game.quitdict;
      "m"~last input;:.game.menudict;
    ];

    res:.joincfg.logic[input;selections;selected;ip;port;gd[`params;`pname];id];
    confirmed:res 0; selected:res 1; msg:res 2; ip:res 3; port:res 4; id:res 5;

    if[confirmed;
      :`scene`params!(`joinwait;`pname`address`id!(gd[`params;`pname];`$":",ip,":",string port;id))];

    .joincfg.draw[selections;selected;msg;ip;port];

    msg:"";
  ];

  :gd;
 };
