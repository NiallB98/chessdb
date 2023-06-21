.play.showpieces:{[lvl;board]
  indices:lvl ss "@";
  emptysqchars:64#{x,reverse x}8#BLACK_SQUARE_CHAR,WHITE_SQUARE_CHAR;

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
  :lvl;
 };

.play.draw:{[board;iswhite;pname;logmsg;otherpname;haserrored]
  lvl:$[iswhite;.play.level;.playflipped.level];

  0N!lvl:.play.showpiecestaken[lvl];
  0N!lvl:.play.showturntaker[lvl;.play.isturn[board;iswhite];otherpname];
  0N!lvl:.play.showpieces[lvl;board];
  0N!lvl:autoshowmsg[lvl;logmsg;"^";`];

  0N!prompt:$[
    haserrored;"Quit [Q], Menu [M] ";
    .play.isturn[board;iswhite];"Up/Left/Down/Right [W/A/S/D], Quit [Q], Menu [M] ";
    ""
  ];

  draw[lvl;prompt];
 };
