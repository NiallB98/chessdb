system"l game/play/turnLogic/getMoves/common/checkLimits.q";

.pawn.addBasicMove:{[moves;board;pickSq;isWhite]
  excludeChars:WHITE_PIECES,BLACK_PIECES;
  bd:.common.game.getBoard1D board;
  moveSq:$[isWhite;pickSq-8;pickSq+8];

  :$[(moveSq div 8) within 0 7;$[bd[moveSq] in excludeChars;moves;moves,moveSq];moves];
 };

.pawn.addAttackMoves:{[moves;board;pickSq;isWhite]
  x:pickSq mod 8;
  y:pickSq div 8;
  sign:$[isWhite;1;-1];

  tgtX:x + (1, -1);
  tgtY:y + sign * 2#-1;

  bd:.common.game.getBoard1D board;

  :raze moves,{[bd;isWhite;x;y]
    if[any not within[;0 7]each x,y;:()];
    
    pos:x+8*y;

    $[isWhite;if[not bd[pos] in BLACK_PIECES;:()];if[not bd[pos] in WHITE_PIECES;:()]];  // Making sure attack squares have enemy pieces on them

    :pos;
  }[bd;isWhite]'[tgtX;tgtY];
 };

.pawn.addEnpassAttackMove:{[moves;board;pickSq;isWhite]
  x:pickSq mod 8;
  y:pickSq div 8;
  sign:$[isWhite;1;-1];

  tgtX:x + (1, -1);
  tgtY:y + sign * 2#-1;

  bd:.common.game.getBoard1D board;
  enpassStr:(" " vs board)3;

  :raze moves,{[bd;enpassStr;x;y]
    if[any not within[;0 7]each x,y;:()];
    
    posStr:("abcdefgh"`long$x),"87654321"`long$y;
    if[not posStr~enpassStr;:()];

    :x+8*y;
  }[bd;enpassStr]'[tgtX;tgtY];
 };

.pawn.addDoubleMove:{[moves;board;pickSq;isWhite]
  excludeChars:WHITE_PIECES,BLACK_PIECES;
  bd:.common.game.getBoard1D board;
  moveSq:$[isWhite;pickSq-16;pickSq+16];

  :$[
    isWhite and 6~pickSq div 8;$[bd[moveSq] in excludeChars;moves;moves,moveSq];
    not[isWhite] and 1~pickSq div 8;$[bd[moveSq] in excludeChars;moves;moves,moveSq];
    moves
  ];
 };

.tl.pawnMoves:{[board;pickSq;isWhite]
  moves:();

  moves:.pawn.addBasicMove[moves;board;pickSq;isWhite];
  moves:.pawn.addAttackMoves[moves;board;pickSq;isWhite];
  moves:.pawn.addEnpassAttackMove[moves;board;pickSq;isWhite];
  moves:.pawn.addDoubleMove[moves;board;pickSq;isWhite];

  moves:.tl.checkLimits[moves;board;pickSq;isWhite];

  :moves;
 };
