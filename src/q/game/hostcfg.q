.hostcfg.tryport:{[num]
  :@[{value "\\p ",string x;1b};num;0b];
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

  confirmed:0b;
  port:0;
  isediting:1b;
  haserrored:0b;

  .hostcfg.draw[isediting;port;haserrored];

  while[`hostcfg~gd`scene;
    input:$[isediting;-1 _ read0 0;getinput[]];

    $[
      not[isediting] and input~"q";[stophost[];:.game.quitdict];
      not[isediting] and input~"m";[stophost[];:.game.menudict];
      not[isediting] and input~"y";[confirmed:.hostcfg.tryport[port];haserrored:not confirmed];
      not[isediting] and input~"n";isediting:1b;
      isediting and .hostcfg.isvalid input;[port:.hostcfg.formatport input;isediting:0b];
      isediting and not .hostcfg.isvalid input;haserrored:1b;
    ];

    if[confirmed;:`scene`params!(`hostwait;enlist[`pname]!enlist gd[`params;`pname])];

    .hostcfg.draw[isediting;port;haserrored];

    haserrored:0b;
  ];

  :gd;
 };
