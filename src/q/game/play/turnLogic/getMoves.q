system"l game/play/turnLogic/getMoves/pawnMoves.q";
system"l game/play/turnLogic/getMoves/knightMoves.q";
system"l game/play/turnLogic/getMoves/bishopMoves.q";
system"l game/play/turnLogic/getMoves/rookMoves.q";
system"l game/play/turnLogic/getMoves/queenMoves.q";
system"l game/play/turnLogic/getMoves/kingMoves.q";


.tl.getPiece:{[board;pos]
  bd:.common.game.getBoard1D[board];
  :bd[pos];
 };

.tl.getMoves:{[board;pickSq;isWhite]
  piece:lower .tl.getPiece[board;pickSq];

  moves:$[
    piece~"p";.tl.pawnMoves[board;pickSq;isWhite];
    piece~"n";.tl.knightMoves[board;pickSq;isWhite];
    piece~"b";.tl.bishopMoves[board;pickSq;isWhite];
    piece~"r";.tl.rookMoves[board;pickSq;isWhite];
    piece~"q";.tl.queenMoves[board;pickSq;isWhite];
    piece~"k";.tl.kingMoves[board;pickSq;isWhite];
    ()
  ];

  :moves;
 };
