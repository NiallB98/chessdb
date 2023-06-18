.play.showpieces:{[lvl]
  :lvl;
 };

.play.showmsg:{[lvl;msg]
  tgtstr:"LLLLLLLLLLLLLLLLLLLL";
  msg:setlen[count tgtstr;msg;`];

  :replaceall[lvl;tgtstr;msg];
 };

.play.showturntaker:{[lvl;isturn;otherpname]
  msg:$[isturn;"Your";otherpname,"'s"];

  tgtstr:"TTTTTTTTTTTTTTTTTTTT";
  msg:setlen[count tgtstr;msg;`];

  :replaceall[lvl;tgtstr;msg];
 };

.play.showspectating:{[lvl]
  :lvl;
 };

.play.showpiecestaken:{[lvl]
  :lvl;
 };

.play.showlastmoves:{[lvl]
  :lvl;
 };

.play.draw:{[iswhite;isturn;pname;logmsg;otherpname]
  lvl:$[iswhite;.play.level;.playflipped.level];

  lvl:.play.showpiecestaken[lvl];
  lvl:.play.showpieces[lvl];
  lvl:showmsg[lvl;logmsg;"LLLLLLLLLLLLLLLLLLLL"];
  lvl:.play.showturntaker[lvl;isturn;otherpname];
  lvl:.play.showspectating[lvl];
  lvl:.play.showpiecestaken[lvl];
  lvl:.play.showlastmoves[lvl];

  draw[lvl;"Up/Left/Down/Right [W/A/S/D], Quit [Q], Menu [M] "];
 };
