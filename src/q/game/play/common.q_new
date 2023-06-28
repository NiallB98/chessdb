system"l game/play/common/2DGrid.q";
system"l game/play/common/getMaxMoves.q";
system"l game/play/common/isAttacked.q";
system"l game/play/common/movePiece.q";

.play.isPromoting:{[board]
  bd:.play.getBoard1D board;
  :("P" in bd[til 8]) or "p" in bd[56+til 8];
 };

.play.isTurn:{[cd]
  if[.play.isPromoting cd`bd;:1b];

  :$[cd[`bd]~"";0b;cd[`isWhite]~"w"~first vs[" ";cd`bd]1];
 };

.play.getBoard2D:{[board]
  bd:first " " vs board;

  n:8;
  while[n>0;
    bd:ssr[bd;string n;n#" "];  // Replacing numbers in board with the number amount of spaces
    n-:1;
  ];

  :"/" vs bd;  // Returns the whole board as a 2d list, can be indexed with [row;column] where [0;0] is the top left corner
 };

.play.getBoard1D:{[board]
  :raze .play.getBoard2D[board];
 };

.play.fmtBoard1D:{[board1D]
  bd:-1 _ raze{x[(y*8)+til 8],"/"}[board1D]each til 8;
  :{ssr[x;y#" ";string y]}/[bd;reverse 1+til 8];
 };

.play.isOwnedPiece:{[board;pos;isWhite]
  bd:.play.getBoard1D board;
  :bd[pos] in $[isWhite;WHITE_PIECES;BLACK_PIECES];
 };

.play.isPiece:{[board;pos]
  bd:.play.getBoard1D board;
  :bd[pos] in WHITE_PIECES,BLACK_PIECES;
 };

.play.isChecked:{[board;isWhite]
  bd:.play.getBoard1D board;
  kingPos:first bd ss $[isWhite;WHITE_KING_CHAR;BLACK_KING_CHAR];

  :$[kingPos~0N;0b;.play.isAttacked[kingPos;board;isWhite]];
 };
