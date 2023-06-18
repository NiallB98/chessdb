.joincfg.tryquery:{[ip;port]
  res:@[{2~(`$":",x,":",string y)z}[ip;port];"1+1";0b];

  :$[res;(1b;"");(0b;"ERROR: Host unreachable")];
 };

.joincfg.confirm:{[ip;port]
  res:.joincfg.tryquery[ip;port];
  :(first res;first res;selected;last res);
 };

.joincfg.logic:{[input;selections;selected;ip;port]
  $[
    input~"w";selected:mod[selected-1;count selections];
    input~"s";selected:mod[selected+1;count selections];
    input~"e";:.joincfg.confirm[ip;port];
  ];

  :$[
    `join~selections selected;(0b;0b;selected;"Confirm? [E]");
    (0b;0b;selected;"")
  ];
 };

.joincfg.showselection:{[lvl;selected]
  lvl:replaceone[lvl;"%";">";selected;" "];
  :replaceone[lvl;"@";"<";selected;" "];
 };

.joincfg.draw:{[selections;selected;haserrored;msg]
  lvl:.joincfg.level;
  lvl:.joincfg.showselection[lvl;selected];
  lvl:showmsg[lvl;msg;56#"L";`];

  prompt:"Up/Down [W/S], Quit [Q], Menu [M]",$[`join~selections selected;", Confirm [E] ";" > "];
  
  draw[lvl;prompt];
 };

joincfg:{[params]
  pname:params`pname;

  gd:`scene`params!(`joincfg;()!());
  gd[`params;`pname]:params`pname;
  gd[`params;`address]:`::0;

  selections:`ip`port`join;
  selected:0;
  msg:"";

  confirmed:0b;
  haserrored:0b;

  port:0;
  ip:"XXX.XXX.XXX.XXX";

  .joincfg.draw[selections;selected;haserrored;msg];

  while[`joincfg~gd`scene;
    input:getinput[];
    $[
      input~"q";:.game.quitdict;
      input~"m";:.game.menudict;
    ];

    res:.joincfg.logic[input;selections;selected;ip;port];
    haserrored:res 0;
    confirmed:res 1;
    selected:res 2;
    msg:res 3;

    if[confirmed;
      :`scene`params!(`joinwait;`pname`address!(gd[`params;`pname];`$":",ip,":",string port))];

    .joincfg.draw[selections;selected;haserrored;msg];

    haserrored:0b;
    msg:"";
  ];

  :gd;
 };
