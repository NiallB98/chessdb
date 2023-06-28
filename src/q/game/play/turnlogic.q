system"l game/play/turnlogic/movecursor.q";
system"l game/play/turnlogic/getmoves.q";

.tl.move:{[cd;startpos;endpos]
  res:.play.movepiece[cd`bd;startpos;endpos];

  cd[`bd]:first res;

  if[last res<>" ";
    $[cd`iswhite;cd[`takenpcs;0],:last res;cd[`takenpcs;1],:last res];
  ];

  cd[`turndone]:not .play.ispromoting cd`bd;  // Making sure to only say turn is done if not waiting for player to promote a pawn

  :cd;
 };

.tl.selectsq:{[cd;csrd]
  if[(csrd[`pos] in csrd`moves) and -1<>csrd`picksq;
    cd:.tl.move[cd;csrd`picksq;csrd`pos];
    :(cd;csrd);
  ];

  csrd[`picksq]:$[
    not[.play.isownedpiece[cd`bd;csrd`pos;cd`iswhite]] or csrd[`picksq]~csrd`pos;-1;
    csrd`pos
  ];

  :(cd;csrd);
 };

.tl.getpromotingpawn:{[board]
  bd:.play.getboard1d board;
  :$["P" in bd[til 8];first where bd[til 8]="P";56+first where bd[56+til 8]="p"];
 };

.tl.promotepawn:{[board;pawnpos;newpiece]
  if[newpiece~`;:(0b;board)];

  bd:.play.getboard1d board;
  case:$[pawnpos within 0 7;upper;lower];

  bd[pawnpos]:$[
    newpiece~`q;case"q";
    newpiece~`b;case"b";
    case"b"
  ];

  board:" " sv enlist[.play.fmtboard1d bd],1 _ " " vs board;

  (1b;board);
 };

.tl.getpromotion:{[input;board]
  pawnpos:.tl.getpromotingpawn board;

  choice:$[
    input~"q";`q;  // Queen
    input~"b";`b;  // Bishop
    input~"r";`r;  // Rook
    `              // If input matches none, ask again
  ];

  :.tl.promotepawn[board;pawnpos;choice];
 };

.play.turnlogic:{[input;cd;csrd]
  if[.play.ispromoting cd`bd;
    res:.tl.getpromotion[input;cd`bd];
    cd[`turndone]:res 0;
    cd[`bd]:res 1;
    :(cd;csrd);
  ];

  if[-1~csrd`pos;csrd[`pos]:$[cd`iswhite;63-11;12]];
  
  if[not input~"";
    if[input in "wasd";csrd:.tl.movecursor[input;csrd;cd`iswhite]];
    if[input~"e";res:.tl.selectsq[cd;csrd];cd:res 0;csrd:res 1];
  ];

  csrd[`moves]:$[-1~csrd`picksq;();.tl.getmoves[cd`bd;csrd`picksq;cd`iswhite]];

  :(cd;csrd);
 };
