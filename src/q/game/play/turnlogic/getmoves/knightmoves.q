system"l game/play/turnLogic/getMoves/common/checkLimits.q";
system"l game/play/turnLogic/getMoves/common/generalLimits.q";

.tl.knightMoves:{[board;pickSq;isWhite]
  moves:.play.getMaxKnightMoves pickSq;
  moves:.tl.notMovesonFriendly[moves;board;isWhite];
  moves:.tl.checkLimits[moves;board;pickSq;isWhite];
  
  :moves;
 };
