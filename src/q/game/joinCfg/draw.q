.joinCfg.showSelection:{[lvl;selected]
  lvl:replaceOne[lvl;"%";">";selected;" "];
  :replaceOne[lvl;"@";"<";selected;" "];
 };

.joinCfg.draw:{[selections;selected;msg;ip;port]
  lvl:.joinCfg.level;
  lvl:.joinCfg.showSelection[lvl;selected];
  lvl:autoShowMsg[lvl;ip;"#";`left];           // Showing IP
  lvl:autoShowMsg[lvl;string port;"$";`left];  // Showing port
  lvl:autoShowMsg[lvl;msg;"&";`];              // Showing message

  prompt:"Up/Down [W/S], Quit [Q], Menu [M]",$[`join~selections selected;", Confirm [E] ";" > "];
  
  draw[lvl;prompt];
 };
