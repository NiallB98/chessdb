system"l game/play/turnlogic/getmoves/common/checklimits.q";

.pawn.addbasicmove:{[moves;board;picksq;iswhite]
  excludechars:WHITE_PIECES,BLACK_PIECES;
  bd:.play.getboard1d board;
  movesq:$[iswhite;picksq-8;picksq+8];

  :$[(movesq div 8) within 0 7;$[bd[movesq] in excludechars;moves;moves,movesq];moves];
 };

.pawn.addattackmoves:{[moves;board;picksq;iswhite]
  x:picksq mod 8;
  y:picksq div 8;
  sign:$[iswhite;1;-1];

  tgtx:x + (1, -1);
  tgty:y + sign * 2#-1;

  bd:.play.getboard1d board;

  :raze moves,{[bd;iswhite;x;y]
    if[any not within[;0 7]each x,y;:()];
    
    pos:x+8*y;

    $[iswhite;if[not bd[pos] in BLACK_PIECES;:()];if[not bd[pos] in WHITE_PIECES;:()]];  // Making sure attack squares have enemy pieces on them

    :pos;
  }[bd;iswhite]'[tgtx;tgty];
 };

.pawn.addenpassattackmove:{[moves;board;picksq;iswhite]
  x:picksq mod 8;
  y:picksq div 8;
  sign:$[iswhite;1;-1];

  tgtx:x + (1, -1);
  tgty:y + sign * 2#-1;

  bd:.play.getboard1d board;
  enpassstr:(" " vs board)3;

  :raze moves,{[bd;enpassstr;x;y]
    if[any not within[;0 7]each x,y;:()];
    
    posstr:("abcdefgh"`long$x),"87654321"`long$y;
    if[not posstr~enpassstr;:()];

    :x+8*y;
  }[bd;enpassstr]'[tgtx;tgty];
 };

.pawn.adddoublemove:{[moves;board;picksq;iswhite]
  excludechars:WHITE_PIECES,BLACK_PIECES;
  bd:.play.getboard1d board;
  movesq:$[iswhite;picksq-16;picksq+16];

  :$[
    iswhite and 6~picksq div 8;$[bd[movesq] in excludechars;moves;moves,movesq];
    not[iswhite] and 1~picksq div 8;$[bd[movesq] in excludechars;moves;moves,movesq];
    moves
  ];
 };

.tl.pawnmoves:{[board;picksq;iswhite]
  moves:();

  moves:.pawn.addbasicmove[moves;board;picksq;iswhite];
  moves:.pawn.addattackmoves[moves;board;picksq;iswhite];
  moves:.pawn.addenpassattackmove[moves;board;picksq;iswhite];
  moves:.pawn.adddoublemove[moves;board;picksq;iswhite];

  moves:.tl.checklimits[moves;board;picksq;iswhite];

  :moves;
 };
