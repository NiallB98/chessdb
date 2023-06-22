.play.showpieces:{[lvl;board]
  indices:lvl ss "@";
  emptysqchars:64#{x,reverse x}8#WHITE_SQUARE_CHAR,BLACK_SQUARE_CHAR;

  if[board~"";
    lvl[indices]:emptysqchars;
    :lvl;
  ];

  sqs:{$[x~" ";y;x]}'[.play.getboard1d board;emptysqchars];
  lvl[indices]:sqs;

  :lvl;
 };

.play.showturntaker:{[lvl;isturn;otherpname]
  msg:$[isturn;"Your";otherpname,"'s"];
  :autoshowmsg[lvl;msg;"`";`];
 };

.play.showpiecestaken:{[lvl]
  lvl:showmsg[lvl;"";16#"w";`];
  lvl:showmsg[lvl;"";16#"b";`];

  :lvl;
 };

.play.showturnnum:{[lvl;board]
  msg:"Turn number: ",last " " vs board;
  :showmsg[lvl;msg;20#"T";`];
 };

.play.showwins:{[lvl;pname;otherpname;wins]
  lvl:showmsg[lvl;"You:";20#"P";`];
  lvl:autoshowmsg[lvl;string first wins;"!";`];
  lvl:showmsg[lvl;otherpname,":";20#"p";`];
  lvl:autoshowmsg[lvl;string last wins;";";`];

  :lvl;
 };

.play.draw:{[board;iswhite;pname;logmsg;otherpname;haserrored]
  lvl:$[iswhite;.play.level;.playflipped.level];

  0N!lvl:.play.showpiecestaken[lvl];
  0N!lvl:.play.showturntaker[lvl;.play.isturn[board;iswhite];otherpname];
  0N!lvl:.play.showpieces[lvl;board];
  0N!lvl:autoshowmsg[lvl;logmsg;"^";`];
  0N!lvl:.play.showturnnum[lvl;board];
  0N!lvl:.play.showwins[lvl;pname;otherpname;(0;0)];

  0N!prompt:$[
    haserrored;"Quit [Q], Menu [M] ";
    .play.isturn[board;iswhite];"Up/Left/Down/Right [W/A/S/D], Quit [Q], Menu [M] ";
    ""
  ];

  draw[lvl;prompt];
 };
