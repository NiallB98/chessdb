system"l game/play/turnLogic/getMoves/common/checkLimits.q";
system"l game/play/turnLogic/getMoves/common/vectorMoves.q";

.tl.queenMoves:{[board;pickSq;isWhite]
  moves:();
  
  moves:.tl.addOrthogonalMoves[moves;board;pickSq;isWhite];
  moves:.tl.addDiagonalMoves[moves;board;pickSq;isWhite];
  moves:.tl.checkLimits[moves;board;pickSq;isWhite];
  
  :moves;
 };
