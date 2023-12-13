.joinCfg.showSelection:{[lvl;selected]
  lvl:.common.levelEdit.replaceOne[lvl;"%";">";selected;" "];
  :.common.levelEdit.replaceOne[lvl;"@";"<";selected;" "];
 };

.joinCfg.draw:{[selections;selected;msg;ip;port]
  lvl:.joinCfg.level;
  lvl:.joinCfg.showSelection[lvl;selected];
  lvl:.common.levelEdit.autoShowMsg[lvl;ip;"#";`left];           // Showing IP
  lvl:.common.levelEdit.autoShowMsg[lvl;string port;"$";`left];  // Showing port
  lvl:.common.levelEdit.autoShowMsg[lvl;msg;"&";`];              // Showing message

  prompt:"Up/Down [W/S], Quit [Q], Menu [M]",$[`join~selections selected;", Confirm [E] ";" > "];
  
  .common.draw[lvl;prompt];
 };
