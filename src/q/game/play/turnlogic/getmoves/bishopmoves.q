system"l game/play/turnlogic/getmoves/common/checklimits.q";
system"l game/play/turnlogic/getmoves/common/vectormoves.q";

.tl.bishopmoves:{[board;picksq;iswhite]
  moves:();
  
  moves:.tl.adddiagonalmoves[moves;board;picksq;iswhite];
  moves:.tl.checklimits[moves;board;picksq;iswhite];
  
  :moves;
 };
