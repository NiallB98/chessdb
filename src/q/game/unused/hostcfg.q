.hostcfg.tryport:{[num]
  res:@[{value "\\p ",string x;value"\\ p 0";1b};num;0b];
  if[not res;:0b];

  .game.startserver[num];

  :1b;
 };

.hostcfg.formatport:{[input]
  :`int$value limitlen[5;trim input];
 };

.hostcfg.isvalid:{[input]
  res:@[{(0<count x) and all x in .Q.n};input;0b];
  if[not res;:0b];

  :65535>=value input;
 };

.hostcfg.showport:{[lvl;port]
  :autoshowmsg[lvl;string port;"@";`left];
 };

.hostcfg.showmsg:{[lvl;haserrored;isediting]
  msg:$[
    haserrored;"ERROR: Port unusable, please try another";
    not isediting;"Confirm? [Y/N]";
    ""
  ];

  :autoshowmsg[lvl;msg;"&";`];
 };

.hostcfg.draw:{[isediting;port;haserrored]
  lvl:.hostcfg.level;
  lvl:.hostcfg.showport[lvl;port];
  lvl:.hostcfg.showmsg[lvl;haserrored;isediting];

  prompt:$[
    isediting;"> ";
    "Quit [Q], Menu [M], Yes [Y], No [N] "
  ];

  draw[lvl;prompt];
 };

hostcfg:{[params]
  gd:`scene`params!(`hostcfg;()!());
  gd[`params;`pname]:params`pname;
  gd[`params;`port]:0;

  confirmed:0b;
  isediting:1b;
  haserrored:0b;

  .hostcfg.draw[isediting;gd[`params;`port];haserrored];

  while[`hostcfg~gd`scene;
    input:$[isediting;-1 _ read0 0;getinput[]];

    $[
      not[isediting] and input~"q";[.game.killserver[];:.game.quitdict];
      not[isediting] and input~"m";[.game.killserver[];:.game.menudict];
      not[isediting] and input~"y";[confirmed:.hostcfg.tryport[gd[`params;`port]];haserrored:not confirmed];
      not[isediting] and input~"n";isediting:1b;
      isediting and .hostcfg.isvalid input;[gd[`params;`port]:.hostcfg.formatport input;isediting:0b];
      isediting and not .hostcfg.isvalid input;haserrored:1b;
    ];

    if[confirmed;gd[`scene]:`hostwait;:gd];

    .hostcfg.draw[isediting;gd[`params;`port];haserrored];

    haserrored:0b;
  ];

  :gd;
 };
