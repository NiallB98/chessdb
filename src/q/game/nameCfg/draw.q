.nameCfg.showMsg:{[lvl;isEditing]
  tgtChar:"&";

  :$[
    not isEditing;.common.levelEdit.autoShowMsg[lvl;"Confirm? [Y/N]";tgtChar;`];
    .common.levelEdit.autoShowMsg[lvl;"";tgtChar;`]
  ];
 };

.nameCfg.draw:{[pName;isEditing]
  lvl:.nameCfg.level;
  lvl:.common.levelEdit.autoShowMsg[lvl;pName;"@";`];
  lvl:.nameCfg.showMsg[lvl;isEditing];

  prompt:$[isEditing;"> ";"Quit [Q], Menu [M], Yes [Y], No [N] "];

  .common.draw[lvl;prompt];
 };
