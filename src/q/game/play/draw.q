system"l game/play/draw/showboardui.q";

.play.showpieces:{[lvl;board;iswhite]
  indices:lvl ss "@";
  emptysqchars:64#{x,reverse x}8#WHITE_SQUARE_CHAR,BLACK_SQUARE_CHAR;

  if[board~"";
    lvl[indices]:emptysqchars;
    :lvl;
  ];

  board1d:$[iswhite;.play.getboard1d board;reverse .play.getboard1d board];

  sqs:{$[x~" ";y;x]}'[board1d;emptysqchars];
  lvl[indices]:sqs;

  :lvl;
 };

.play.showturntaker:{[lvl;isturn;otherpname]
  msg:$[isturn;"Your";otherpname,"'s"];
  :autoshowmsg[lvl;msg;"`";`];
 };

.play.showpiecestaken:{[lvl;takenpcs]
  lvl:showmsg[lvl;asc takenpcs 0;16#"w";`];
  lvl:showmsg[lvl;asc takenpcs 1;16#"b";`];

  :lvl;
 };

.play.showturnnum:{[lvl;board]
  msg:"Turn number: ",last " " vs board;
  :showmsg[lvl;msg;20#"T";`];
 };

.play.showwins:{[lvl;otherpname;wins]
  lvl:showmsg[lvl;"You:";20#"P";`];
  lvl:showmsg[lvl;string first wins;18#"!";`];
  lvl:showmsg[lvl;otherpname,":";20#"p";`];
  lvl:showmsg[lvl;string last wins;18#";";`];

  :lvl;
 };

.play.showprompt:{[haserrored;cd;csrd]
  $[haserrored;:"Quit [Q], Menu [M] ";not .play.isturn cd;:""];

  if[.play.ispromoting cd;:"Promote to: Queen [Q], Rook [R], Bishop [B] ? "];

  prompt:"Up/Left/Down/Right [W/A/S/D], Quit [Q], Menu [M]";  // Base prompt

  prompt,:$[
    csrd[`pos]~csrd`picksq;", Deselect [E] ";
    .play.isownedpiece[cd`bd;csrd`pos;cd`iswhite];", Select [E] ";
    -1~csrd`picksq;" ";
    csrd[`pos] in csrd`moves;", Move [E] ";
    ", Deselect [E] "
  ];

  :prompt;
 };

.play.draw:{[cd;nd;csrd;logmsg;haserrored]
  lvl:$[cd`iswhite;.play.level;.playflipped.level];

  lvl:.play.showpiecestaken[lvl;cd`takenpcs];
  lvl:.play.showturntaker[lvl;.play.isturn[cd];nd`other];
  lvl:.play.showpieces[lvl;cd`bd;cd`iswhite];
  lvl:autoshowmsg[lvl;logmsg;"^";`];
  lvl:.play.showturnnum[lvl;cd`bd];
  lvl:.play.showwins[lvl;nd`other;(0;0)];  // Need to track wins
  lvl:.play.showboardui[lvl;cd;csrd];

  prompt:.play.showprompt[haserrored;cd;csrd];

  draw[lvl;prompt];
 };
