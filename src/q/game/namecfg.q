.namecfg.showpname:{[lvl;pname]
  :autoshowmsg[lvl;pname;"@";`];
 };

.namecfg.showmsg:{[lvl;isediting]
  tgtchar:"&";

  :$[
    not isediting;autoshowmsg[lvl;"Confirm? [Y/N]";tgtchar;`];
    autoshowmsg[lvl;"";tgtchar;`]
  ];
 };

.namecfg.draw:{[pname;isediting]
  lvl:.namecfg.level;
  lvl:.namecfg.showpname[lvl;pname];
  lvl:.namecfg.showmsg[lvl;isediting];

  prompt:$[isediting;"> ";"Quit [Q], Menu [M], Yes [Y], No [N] "];

  draw[lvl;prompt];
 };

.namecfg.confirmname:{[pname;passtoscene]
  :`scene`params!(passtoscene;enlist[`pname]!enlist pname);
 };

namecfg:{[params]
  passtoscene:params`passtoscene;

  gd:`scene`params!(`namecfg;()!());
  gd[`params;`pname]:18#"*";

  isediting:1b;

  .namecfg.draw[gd[`params;`pname];isediting];

  while[`namecfg~gd`scene;
    input:$[isediting;-1 _ read0 0;getinput[]];

    $[
      not[isediting] and 0N!input~"q";:.game.quitdict;
      not[isediting] and 0N!input~"m";:.game.menudict;
      not[isediting] and 0N!input~"y";:.namecfg.confirmname[gd[`params;`pname];passtoscene];
      not[isediting] and 0N!input~"n";isediting:1b;
      isediting and not ""~limitlen[18;trim raze input];
        [gd[`params;`pname]:limitlen[18;trim raze input];isediting:0b];
    ];

    .namecfg.draw[gd[`params;`pname];isediting];
  ];

  :gd;
 };
