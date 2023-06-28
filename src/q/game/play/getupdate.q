.play.waitingnum:0;

.play.getpromotedmsg:{[bdstart;bdend;iswhite]
  bd1dstart:.play.getboard1d bdstart;
  bd1dend:.play.getboard1d bdend;

  case:$[not iswhite;upper;lower];  // What case the other player's pieces are

  piece:$[
    count[bd1dend ss case"q"]>count bd1dstart ss case"q";case"q";
    count[bd1dend ss case"q"]>count bd1dstart ss case"r";case"r";
    case"b"
  ];

  :case["p"]," to ",piece," promotion!";
 };

.play.haspromoted:{[bdstart;bdend;iswhite]
  bd1dstart:.play.getboard1d bdstart;
  bd1dend:.play.getboard1d bdend;

  case:$[not iswhite;upper;lower];  // What case the other player's pieces are

  :$[
    count[bd1dend ss case"q"]>count bd1dstart ss case"q";1b;
    count[bd1dend ss case"r"]>count bd1dstart ss case"r";1b;
    count[bd1dend ss case"b"]>count bd1dstart ss case"b";1b;
    0b
  ];
 };

.play.getwaitingnum:{[]
  .play.waitingnum:(.play.waitingnum+1) mod 4;
  :.play.waitingnum;
 };

.play.generatemsg:{[bdstart;bdend;iswhite;starttknpcs;endtknpcs]
  msg:$[
    bdstart~bdend;(n#" "),"Waiting",(n:.play.getwaitingnum[])#".";
    .play.ischecked[bdend;iswhite];"You are checked!";
    .play.haspromoted[bdstart;bdend;iswhite];.play.getpromotedmsg[bdstart;bdend;iswhite];
    not starttknpcs~endtknpcs;"Piece captured!";
    "It is your turn"
  ];

  :msg;
 };

.play.getupdate:{[qd;board;takenpcs;iswhite]
  res:@[{x y}[qd`h];(`getupdate;qd`id);(0b;`)];
  
  if[not[first res] or not `mid~res 1;:(0b;"<Lost connection>")];  // If error has occurred, return 0b along with the error message (Max 20 characters to display fully)

  :(1b;.play.generatemsg[board;res 2;iswhite;takenpcs;res 3];res 2;res 3);
 };
