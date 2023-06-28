system"l game/joinCfg/edit.q";
system"l game/joinCfg/confirm.q";
system"l game/joinCfg/draw.q";
system"l game/joinCfg/logic.q";

joinCfg:{[params]
  pName:params`pName;

  gd:`scene`params!(`joinCfg;()!());
  gd[`params;`pName]:params`pName;
  gd[`params;`address]:`::0;
  gd[`params;`id]:`;

  selections:`ip`port`join;
  selected:0;
  msg:"";

  confirmed:0b;

  port:25565;
  ip:"." sv string"i"$0x0 vs .z.a;
  id:`;

  .joinCfg.draw[selections;selected;msg;ip;port];

  while[`joinCfg~gd`scene;
    input:getFullInput[];
    $[
      "q"~lower last input;:.game.quitDict;
      "m"~lower last input;:.game.menuDict
    ];

    res:.joinCfg.logic[input;selections;selected;ip;port;gd[`params;`pName];id];
    confirmed:res 0; selected:res 1; msg:res 2; ip:res 3; port:res 4; id:res 5;

    if[confirmed;
      gd[`scene]:`joinWait;
      gd[`params;`address]:`$":",ip,":",string port;
      gd[`params;`id]:id;
      :gd;
    ];

    .joinCfg.draw[selections;selected;msg;ip;port];

    msg:"";
  ];

  :gd;
 };
