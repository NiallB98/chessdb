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

.play.draw:{[iswhite;isturn;pname;logmsg;otherpname;haserrored]
  lvl:$[iswhite;.play.level;.playflipped.level];

  lvl:.play.showpiecestaken[lvl];
  lvl:.play.showturntaker[lvl;isturn;otherpname];
  lvl:.play.showpieces[lvl];
  lvl:autoshowmsg[lvl;logmsg;"^";`];

  prompt:$[
    haserrored;"Quit [Q], Menu [M] ";
    isturn;"Up/Left/Down/Right [W/A/S/D], Quit [Q], Menu [M] ";
    ""
  ];

  draw[lvl;prompt];
 };
