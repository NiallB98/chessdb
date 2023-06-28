.nameCfg.showMsg:{[lvl;isEditing]
  tgtChar:"&";

  :$[
    not isEditing;autoShowMsg[lvl;"Confirm? [Y/N]";tgtChar;`];
    autoShowMsg[lvl;"";tgtChar;`]
  ];
 };

.nameCfg.draw:{[pName;isEditing]
  lvl:.nameCfg.level;
  lvl:autoShowMsg[lvl;pName;"@";`];
  lvl:.nameCfg.showMsg[lvl;isEditing];

  prompt:$[isEditing;"> ";"Quit [Q], Menu [M], Yes [Y], No [N] "];

  draw[lvl;prompt];
 };
