system"l game/play/turnlogic/getmoves/common/checklimits.q";
system"l game/play/turnlogic/getmoves/common/vectormoves.q";

.tl.rookmoves:{[board;picksq;iswhite]
  moves:();
  
  moves:.tl.addorthogonalmoves[moves;board;picksq;iswhite];
  moves:.tl.checklimits[moves;board;picksq;iswhite];
  
  :moves;
 };
