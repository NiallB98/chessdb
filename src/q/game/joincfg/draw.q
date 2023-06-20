.joincfg.showselection:{[lvl;selected]
  lvl:replaceone[lvl;"%";">";selected;" "];
  :replaceone[lvl;"@";"<";selected;" "];
 };

.joincfg.draw:{[selections;selected;msg;ip;port]
  lvl:.joincfg.level;
  lvl:.joincfg.showselection[lvl;selected];
  lvl:autoshowmsg[lvl;ip;"#";`left];           // Showing IP
  lvl:autoshowmsg[lvl;string port;"$";`left];  // Showing port
  lvl:autoshowmsg[lvl;msg;"&";`];              // Showing message

  prompt:"Up/Down [W/S], Quit [Q], Menu [M]",$[`join~selections selected;", Confirm [E] ";" > "];
  
  draw[lvl;prompt];
 };
