.namecfg.showmsg:{[lvl;isediting]
  tgtchar:"&";

  :$[
    not isediting;autoshowmsg[lvl;"Confirm? [Y/N]";tgtchar;`];
    autoshowmsg[lvl;"";tgtchar;`]
  ];
 };

.namecfg.draw:{[pname;isediting]
  lvl:.namecfg.level;
  lvl:autoshowmsg[lvl;pname;"@";`];
  lvl:.namecfg.showmsg[lvl;isediting];

  prompt:$[isediting;"> ";"Quit [Q], Menu [M], Yes [Y], No [N] "];

  draw[lvl;prompt];
 };
