.play.getmaxpawnmoves:{[pos;iswhite]
  xy:.play.get2dpos pos;
  sign:$[iswhite;1;-1];

  xy+:sign * flip ((1;-1);(-1;-1);(0;-1);(0;-2));

  xy:.play.rmoutofgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getmaxknightmoves:{[pos]
  xy:.play.get2dpos pos;

  xy+:flip ((1;2);(-1;2);(2;-1);(2;1);(1;-2);(-1;-2);(-2;1);(-2;-1));

  xy:.play.rmoutofgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getmaxbishopmoves:{[pos]
  xy:.play.get2dpos pos;

  xy+:(raze{x*y}[1+til 7]each 1 1 -1 -1;raze{x*y}[1+til 7]each 1 -1 1 -1);

  xy:.play.rmoutofgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getmaxrookmoves:{[pos]
  xy:.play.get2dpos pos;

  xy+:(raze{x*y}[1+til 7]each 1 -1 0 0;raze{x*y}[1+til 7]each 0 0 1 -1);

  xy:.play.rmoutofgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getmaxqueenmoves:{[pos]
  :.play.getmaxbishopmoves[pos],.play.getmaxrookmoves pos;
 };

.play.getmaxkingmoves:{[pos]
  xy:.play.get2dpos pos;

  xy+:flip ((1;0);(1;1);(1;-1);(-1;0);(-1;1);(-1;-1);(0;1);(0;-1));

  xy:.play.rmoutofgrid xy;

  :{x+8*y}'[first xy;last xy];
 };

.play.getmaxmoves:{[pos;piece;iswhite]
  piece:lower piece;

  :$[
    piece~"p";.play.getmaxpawnmoves[pos;iswhite];
    piece~"n";.play.getmaxknightmoves pos;
    piece~"b";.play.getmaxbishopmoves pos;
    piece~"r";.play.getmaxrookmoves pos;
    piece~"q";.play.getmaxqueenmoves pos;
    piece~"k";.play.getmaxkingmoves pos;
    ()
  ];
 };
