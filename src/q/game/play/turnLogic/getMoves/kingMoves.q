system"l game/play/turnLogic/getMoves/common/checkLimits.q";
system"l game/play/turnLogic/getMoves/common/generalLimits.q";

.king.addCastleMoves:{[moves;board;pickSq;isWhite]
  if[.play.isChecked[board;isWhite];:moves];  // Cannot castle if checked

  castleStr:(" " vs board)2;

  kSideStr:$[isWhite;"K";"k"];
  qSideStr:$[isWhite;"Q";"q"];

  if[all not (kSideStr,qSideStr) in castleStr;:moves];

  kSideMove:();
  qSideMove:();

  if[kSideStr in castleStr;
    mvs:pickSq+(1 2);
    mvs:.tl.notMovesonFriendly[mvs;board;1b];  // Ensuring moves wont be on white pieces
    mvs:.tl.notMovesonFriendly[mvs;board;0b];  // Ensuring moves wont be on black pieces
    mvs:.tl.checkLimits[mvs;board;pickSq;isWhite];

    if[2~count mvs;kSideMove:pickSq+2];        // If moves were ok, allow castling king-side
  ];

  if[qSideStr in castleStr;
    mvs:pickSq-(1 2);
    mvs:.tl.checkLimits[mvs;board;pickSq;isWhite];
    mvs,:pickSq-3;                             // Adding extra move to check that there is an empty space beside the rook (Doesn't matter if this square is checked)
    mvs:.tl.notMovesonFriendly[mvs;board;1b];  // Ensuring moves wont be on white pieces
    mvs:.tl.notMovesonFriendly[mvs;board;0b];  // Ensuring moves wont be on black pieces

    if[3~count mvs;qSideMove:pickSq-2];        // If moves were ok, allow castling king-side
  ];

  :raze moves,kSideMove,qSideMove;
 };

.tl.kingMoves:{[board;pickSq;isWhite]
  moves:.play.getMaxKingMoves pickSq;

  moves:.tl.notMovesonFriendly[moves;board;0N!isWhite];
  moves:.tl.checkLimits[moves;board;pickSq;isWhite];
  
  moves:.king.addCastleMoves[moves;board;pickSq;isWhite];

  :moves;
 };
