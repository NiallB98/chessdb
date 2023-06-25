.tl.rmoutof2dgrid:{[xylist]
  :flip flip[xylist] where {(x<8) and x>=0}[first xylist] and {(x<8) and x>=0}last xylist;
 };

.tl.getmaxpawnmoves:{[pos;iswhite]
  xy:.play.get2dpos pos;
  sign:$[iswhite;1;-1];

  xy+:sign * flip ((1;-1);(-1;-1);(0;-1);(0;-2));

  xy:.tl.rmoutof2dgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.tl.getmaxknightmoves:{[pos]
  xy:.play.get2dpos pos;

  xy+:flip ((1;2);(-1;2);(2;-1);(2;1);(1;-2);(-1;-2);(-2;1);(-2;-1));

  xy:.tl.rmoutof2dgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.tl.getmaxbishopmoves:{[pos]
  xy:.play.get2dpos pos;

  xy+:(raze{x*y}[1+til 7]each 1 1 -1 -1;raze{x*y}[1+til 7]each 1 -1 1 -1);

  xy:.tl.rmoutof2dgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.tl.getmaxrookmoves:{[pos]
  xy:.play.get2dpos pos;

  xy+:(raze{x*y}[1+til 7]each 1 -1 0 0;raze{x*y}[1+til 7]each 0 0 1 -1);

  xy:.tl.rmoutof2dgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.tl.getmaxqueenmoves:{[pos]
  :.tl.getmaxbishopmoves[pos],.tl.getmaxrookmoves pos;
 };

.tl.getmaxkingmoves:{[pos]
  xy:.play.get2dpos pos;

  xy+:flip ((1;0);(1;1);(1;-1);(-1;0);(-1;1);(-1;-1);(0;1);(0;-1));

  xy:.tl.rmoutof2dgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.tl.getmaxmoves:{[pos;piece;iswhite]
  piece:lower piece;

  :$[
    piece~"p";.tl.getmaxpawnmoves[pos;iswhite];
    piece~"n";.tl.getmaxknightmoves pos;
    piece~"b";.tl.getmaxbishopmoves pos;
    piece~"r";.tl.getmaxrookmoves pos;
    piece~"q";.tl.getmaxqueenmoves pos;
    piece~"k";.tl.getmaxkingmoves pos;
    ()
  ];
 };
