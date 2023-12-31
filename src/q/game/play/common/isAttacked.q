.play.attackedByPawn:{[pos;board1D;isWhite]
  x:pos mod 8;
  y:pos div 8;

  sign:$[isWhite;1;-1];

  checkXY:(x,y) + sign * flip ((1;-1);(-1;-1));
  checkXY:.play.rmOutOfGrid checkXY;
  if[0~count checkXY;:0b];

  checkPos:{x+8*y}'[first checkXY;last checkXY];
  :any{$[x;BLACK_PAWN_CHAR;WHITE_PAWN_CHAR]~y z}[isWhite;board1D]each checkPos;
 };

.play.attackedByKnight:{[pos;board1D;isWhite]
  checkPos:.play.getMaxKnightMoves pos;
  :any{$[x;BLACK_KNIGHT_CHAR;WHITE_KNIGHT_CHAR]~y z}[isWhite;board1D]each checkPos;
 };

.play.attackedByKing:{[pos;board1D;isWhite]
  checkPos:.play.getMaxKingMoves pos;
  :any{$[x;BLACK_KING_CHAR;WHITE_KING_CHAR]~y z}[isWhite;board1D]each checkPos;
 };

.play.attackedOnVectorBy:{[xy;board1D;vector;chars]
  xy+:vector;

  if[any (xy>7) or xy<0;:0b];  // If xy is outside the board grid, no attack on this vector is possible

  pos:xy[0]+8*xy 1;
  posChar:board1D[pos];
  
  $[
    posChar in chars;:1b;                                            // If the vector has ran into an piece from chars (ie. attacking piece), return 1b
    posChar~" ";:.play.attackedOnVectorBy[xy;board1D;vector;chars];  // If new position is on an empty space, run the function for the next step in the vetcor's direction
    :0b                                                              // If vector runs into piece not in chars (ie. non attacking piece) return 0b
  ];
 };

.play.attackedOnDiagonal:{[pos;board1D;isWhite]  // Checks for queen and bishop attacks in diagonal directions
  chars:$[isWhite;BLACK_QUEEN_CHAR,BLACK_BISHOP_CHAR;WHITE_QUEEN_CHAR,WHITE_BISHOP_CHAR];

  vectors:((1 1);(1 -1);(-1 -1);(-1 1));
  xy:(pos mod 8),pos div 8;
  :any .play.attackedOnVectorBy[xy;board1D;;chars]each vectors;
 };

.play.attackedOnOrthogonal:{[pos;board1D;isWhite]  // Checks for queen and rook attacks in orthogonal directions
  chars:$[isWhite;BLACK_QUEEN_CHAR,BLACK_ROOK_CHAR;WHITE_QUEEN_CHAR,WHITE_ROOK_CHAR];

  vectors:((1 0);(0 1);(-1 0);(0 -1));
  xy:(pos mod 8),pos div 8;
  :any .play.attackedOnVectorBy[xy;board1D;;chars]each vectors;
 };

.play.isAttacked:{[pos;board;isWhite]
  board1D:.play.getBoard1D board;

  :any(
    .play.attackedByPawn[pos;board1D;isWhite],
    .play.attackedByKnight[pos;board1D;isWhite],
    .play.attackedOnDiagonal[pos;board1D;isWhite],
    .play.attackedOnOrthogonal[pos;board1D;isWhite],
    .play.attackedByKing[pos;board1D;isWhite]
  );
 };
