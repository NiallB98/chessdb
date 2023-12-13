system"l game/common.q";

system"l game/play/common/2DGrid.q";
system"l game/play/common/getMaxMoves.q";
system"l game/play/common/isAttacked.q";
system"l game/play/common/movePiece.q";

.common.play.isPromoting:{[board]
  bd:.common.game.getBoard1D board;
  :("P" in bd[til 8]) or "p" in bd[56+til 8];
 };

.common.play.isTurn:{[cd]
  if[.common.play.isPromoting cd`bd;:1b];

  :$[cd[`bd]~"";0b;cd[`isWhite]~.common.game.isWhiteTurn cd`bd];
 };

.common.play.fmtBoard1D:{[board1D]
  bd:-1 _ raze{x[(y*8)+til 8],"/"}[board1D]each til 8;
  :{ssr[x;y#" ";string y]}/[bd;reverse 1+til 8];
 };

.common.play.isOwnedPiece:{[board;pos;isWhite]
  bd:.common.game.getBoard1D board;
  :bd[pos] in $[isWhite;WHITE_PIECES;BLACK_PIECES];
 };

.common.play.isChecked:{[board;isWhite]
  bd:.common.game.getBoard1D board;
  kingPos:first bd ss $[isWhite;WHITE_KING_CHAR;BLACK_KING_CHAR];

  :$[kingPos~0N;0b;.common.play.isAttacked[kingPos;board;isWhite]];
 };

.common.play.canMakeMove:{[board;isWhite]
  bd:.common.game.getBoard1D board;
  pieceTypes:$[isWhite;WHITE_PIECES;BLACK_PIECES];

  piecesPos:where bd in pieceTypes;

  :0<sum count each .tl.getMoves[board;;isWhite]each piecesPos;
 };

.common.play.getStatus:{[board]
  if[board~"";:`starting];

  isWTurn:.common.game.isWhiteTurn board;

  :$[
    .common.play.canMakeMove[board;isWTurn];`playing;
    .common.play.isChecked[board;isWTurn];`checkmate;
    `stalemate
  ];
 };
