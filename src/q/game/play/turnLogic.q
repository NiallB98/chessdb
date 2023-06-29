system"l game/play/turnLogic/moveCursor.q";
system"l game/play/turnLogic/getMoves.q";

.tl.move:{[cd;startPos;endPos]
  res:.play.movePiece[cd`bd;startPos;endPos];

  cd[`bd]:first res;
  cd[`lastMove]:startPos,endPos;

  if[last res<>" ";
    $[cd`isWhite;cd[`takenPcs;0],:last res;cd[`takenPcs;1],:last res];
  ];

  cd[`turnDone]:not .play.isPromoting cd`bd;  // Making sure to only say turn is done if not waiting for player to promote a pawn

  :cd;
 };

.tl.selectSq:{[cd;csrd]
  if[(csrd[`pos] in csrd`moves) and -1<>csrd`pickSq;
    cd:.tl.move[cd;csrd`pickSq;csrd`pos];
    :(cd;csrd);
  ];

  csrd[`pickSq]:$[
    not[.play.isOwnedPiece[cd`bd;csrd`pos;cd`isWhite]] or csrd[`pickSq]~csrd`pos;-1;
    csrd`pos
  ];

  :(cd;csrd);
 };

.tl.getPromotingPawn:{[board]
  bd:.play.getBoard1D board;
  :$["P" in bd[til 8];first where bd[til 8]="P";56+first where bd[56+til 8]="p"];
 };

.tl.promotePawn:{[board;pawnPos;newPiece]
  if[newPiece~`;:(0b;board)];

  bd:.play.getBoard1D board;
  case:$[pawnPos within 0 7;upper;lower];

  bd[pawnPos]:$[
    newPiece~`q;case"q";
    newPiece~`b;case"b";
    case"b"
  ];

  board:" " sv enlist[.play.fmtBoard1D bd],1 _ " " vs board;

  :(1b;board);
 };

.tl.getPromotion:{[input;board]
  pawnPos:.tl.getPromotingPawn board;

  choice:$[
    input~"q";`q;  // Queen
    input~"b";`b;  // Bishop
    input~"r";`r;  // Rook
    `              // If input matches none, ask again
  ];

  :.tl.promotePawn[board;pawnPos;choice];
 };

.play.turnLogic:{[input;cd;csrd]
  if[.play.isPromoting cd`bd;
    res:.tl.getPromotion[input;cd`bd];
    cd[`turnDone]:res 0;
    cd[`bd]:res 1;
    :(cd;csrd);
  ];

  if[-1~csrd`pos;csrd[`pos]:$[cd`isWhite;63-11;12]];
  
  if[not input~"";
    if[input in "wasd";csrd:.tl.moveCursor[input;csrd;cd`isWhite]];
    if[input~"e";res:.tl.selectSq[cd;csrd];cd:res 0;csrd:res 1];
  ];

  csrd[`moves]:$[-1~csrd`pickSq;();.tl.getMoves[cd`bd;csrd`pickSq;cd`isWhite]];

  :(cd;csrd);
 };
