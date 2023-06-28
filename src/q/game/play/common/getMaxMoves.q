.play.getMaxPawnMoves:{[pos;isWhite]
  xy:.play.get2DPos pos;
  sign:$[isWhite;1;-1];

  xy+:sign * flip ((1;-1);(-1;-1);(0;-1);(0;-2));

  xy:.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getMaxKnightMoves:{[pos]
  xy:.play.get2DPos pos;

  xy+:flip ((1;2);(-1;2);(2;-1);(2;1);(1;-2);(-1;-2);(-2;1);(-2;-1));

  xy:.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getMaxBishopMoves:{[pos]
  xy:.play.get2DPos pos;

  xy+:(raze{x*y}[1+til 7]each 1 1 -1 -1;raze{x*y}[1+til 7]each 1 -1 1 -1);

  xy:.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getMaxRookMoves:{[pos]
  xy:.play.get2DPos pos;

  xy+:(raze{x*y}[1+til 7]each 1 -1 0 0;raze{x*y}[1+til 7]each 0 0 1 -1);

  xy:.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getMaxQueenMoves:{[pos]
  :.play.getMaxBishopMoves[pos],.play.getMaxRookMoves pos;
 };

.play.getMaxKingMoves:{[pos]
  xy:.play.get2DPos pos;

  xy+:flip ((1;0);(1;1);(1;-1);(-1;0);(-1;1);(-1;-1);(0;1);(0;-1));

  xy:.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getMaxMoves:{[pos;piece;isWhite]
  piece:lower piece;

  :$[
    piece~"p";.play.getMaxPawnMoves[pos;isWhite];
    piece~"n";.play.getMaxKnightMoves pos;
    piece~"b";.play.getMaxBishopMoves pos;
    piece~"r";.play.getMaxRookMoves pos;
    piece~"q";.play.getMaxQueenMoves pos;
    piece~"k";.play.getMaxKingMoves pos;
    ()
  ];
 };
