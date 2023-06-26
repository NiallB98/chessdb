system"l game/play/turnlogic/getmoves/common/checklimits.q";
system"l game/play/turnlogic/getmoves/common/generallimits.q";

.tl.knightmoves:{[board;picksq;iswhite]
  moves:.play.getmaxknightmoves picksq;
  moves:.tl.notmovesonfriendly[moves;board;iswhite];
  moves:.tl.checklimits[moves;board;picksq;iswhite];
  
  :moves;
 };
