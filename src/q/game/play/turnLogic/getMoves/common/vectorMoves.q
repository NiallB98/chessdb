.tl.genVectorMoves:{[moves;board1D;sidechars;xy;vector]
  xy+:vector;
  
  if[any (xy>7) or xy<0;:moves];  // If xy is outside the board grid, cannot move further

  pos:xy[0]+8*xy 1;
  posChar:board1D[pos];

  :$[
    posChar in sidechars;moves;                                             // Cannot move further, blocked by own side's piece
    posChar~" ";.tl.genVectorMoves[moves,pos;board1D;sidechars;xy;vector];  // If position is an empty space, continue moving
    moves,pos                                                               // Otherwise posChar must be an enemy piece, do not allow further movement but append the current move
  ];
 };

.tl.addDiagonalMoves:{[moves;board;pickSq;isWhite]
  sidechars:$[isWhite;WHITE_PIECES;BLACK_PIECES];
  xy:.common.play.get2DPos pickSq;
  board1D:.common.game.getBoard1D board;

  moves:.tl.genVectorMoves[moves;board1D;sidechars;xy;(1,1)];
  moves:.tl.genVectorMoves[moves;board1D;sidechars;xy;(1,-1)];
  moves:.tl.genVectorMoves[moves;board1D;sidechars;xy;(-1,-1)];
  moves:.tl.genVectorMoves[moves;board1D;sidechars;xy;(-1,1)];

  :moves;
 };

.tl.addOrthogonalMoves:{[moves;board;pickSq;isWhite]
  sidechars:$[isWhite;WHITE_PIECES;BLACK_PIECES];
  xy:.common.play.get2DPos pickSq;
  board1D:.common.game.getBoard1D board;

  moves:.tl.genVectorMoves[moves;board1D;sidechars;xy;(1,0)];
  moves:.tl.genVectorMoves[moves;board1D;sidechars;xy;(0,1)];
  moves:.tl.genVectorMoves[moves;board1D;sidechars;xy;(-1,0)];
  moves:.tl.genVectorMoves[moves;board1D;sidechars;xy;(0,-1)];

  :moves;
 };
