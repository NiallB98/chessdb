.play.showpieces:{[lvl]
  :lvl;
 };

.play.showturntaker:{[lvl;isturn;otherpname]
  msg:$[isturn;"Your";otherpname,"'s"];
  :autoshowmsg[lvl;msg;"`";`];
 };

.play.showpiecestaken:{[lvl]
  :lvl;
 };

.play.draw:{[iswhite;isturn;pname;logmsg;otherpname]
  lvl:$[iswhite;.play.level;.playflipped.level];

  lvl:0N!.play.showpiecestaken[lvl];
  lvl:0N!autoshowmsg[lvl;logmsg;"^";`];
  lvl:0N!.play.showturntaker[lvl;isturn;otherpname];
  lvl:0N!.play.showpieces[lvl];

  prompt:$[isturn;"Up/Left/Down/Right [W/A/S/D], Quit [Q], Menu [M] ";""];
  draw[lvl;prompt];
 };
