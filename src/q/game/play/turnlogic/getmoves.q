system"l game/play/turnlogic/getmoves/getmaxmoves.q";

.tl.getpiece:{[board;pos]
  bd:.play.getboard1d[board];
  :bd[pos];
 };

.tl.getmoves:{[cd;csrd]
  piece:.tl.getpiece[cd`bd;csrd`picksq];

  moves:.tl.getmaxmoves[csrd`picksq;piece;cd`iswhite];

  :moves;
 };
