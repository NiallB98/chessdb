.common.play.getMaxPawnMoves:{[pos;isWhite]
  xy:.common.play.get2DPos pos;
  sign:$[isWhite;1;-1];

  xy+:sign * flip ((1;-1);(-1;-1);(0;-1);(0;-2));

  xy:.common.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.common.play.getMaxKnightMoves:{[pos]
  xy:.common.play.get2DPos pos;

  xy+:flip ((1;2);(-1;2);(2;-1);(2;1);(1;-2);(-1;-2);(-2;1);(-2;-1));

  xy:.common.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.common.play.getMaxBishopMoves:{[pos]
  xy:.common.play.get2DPos pos;

  xy+:(raze{x*y}[1+til 7]each 1 1 -1 -1;raze{x*y}[1+til 7]each 1 -1 1 -1);

  xy:.common.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.common.play.getMaxRookMoves:{[pos]
  xy:.common.play.get2DPos pos;

  xy+:(raze{x*y}[1+til 7]each 1 -1 0 0;raze{x*y}[1+til 7]each 0 0 1 -1);

  xy:.common.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.common.play.getMaxQueenMoves:{[pos]
  :.common.play.getMaxBishopMoves[pos],.common.play.getMaxRookMoves pos;
 };

.common.play.getMaxKingMoves:{[pos]
  xy:.common.play.get2DPos pos;

  xy+:flip ((1;0);(1;1);(1;-1);(-1;0);(-1;1);(-1;-1);(0;1);(0;-1));

  xy:.common.play.rmOutOfGrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.common.play.getMaxMoves:{[pos;piece;isWhite]
  piece:lower piece;

  :$[
    piece~"p";.common.play.getMaxPawnMoves[pos;isWhite];
    piece~"n";.common.play.getMaxKnightMoves pos;
    piece~"b";.common.play.getMaxBishopMoves pos;
    piece~"r";.common.play.getMaxRookMoves pos;
    piece~"q";.common.play.getMaxQueenMoves pos;
    piece~"k";.common.play.getMaxKingMoves pos;
    ()
  ];
 };
