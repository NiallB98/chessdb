.common.play.rmCastle:{[castleStr;isWhite;side]
  rmstr:$[
    side~`;$[isWhite;"KQ";"kq"];
    side~`k;$[isWhite;"K";"q"];
    side~`q;$[isWhite;"Q";"q"];
    ""
  ];

  castleStr:castleStr except rmstr;
  if[castleStr~"";castleStr:raze"-"];

  :castleStr;
 };

.common.play.updateCastle:{[bd;castleStr;movePiece;startPos;endPos]
  isWhite:movePiece in WHITE_PIECES;

  $[
    (startPos~0) and movePiece~"r";castleStr:.common.play.rmCastle[castleStr;isWhite;`q];
    (startPos~7) and movePiece~"r";castleStr:.common.play.rmCastle[castleStr;isWhite;`k];
    (startPos~56) and movePiece~"R";castleStr:.common.play.rmCastle[castleStr;isWhite;`q];
    (startPos~63) and movePiece~"R";castleStr:.common.play.rmCastle[castleStr;isWhite;`k]
  ];

  if["k"<>lower movePiece;:(bd;castleStr)];

  castleStr:.common.play.rmCastle[castleStr;isWhite;`];

  if[2<>abs startPos-endPos;:(bd;castleStr)];

  dir:$[0<endPos-startPos;`k;`q];  // Determining whether king or queen side castling

  rookStartPos:$[dir~`k;startPos+3;startPos-4];
  rookEndPos:$[dir~`k;startPos+1;startPos-1];

  rookChar:bd[rookStartPos];

  bd[rookStartPos]:" ";
  bd[rookEndPos]:rookChar;

  :(bd;castleStr);
 };

.common.play.updateEnpass:{[movePiece;startPos;endPos]
  if["p"<>lower movePiece;:raze"-"];
  if[16<>abs startPos-endPos;:raze"-"];

  enpassPos:startPos+(endPos-startPos)%2;
  x:"abcdefgh"`long$enpassPos mod 8;
  y:"87654321"`long$enpassPos div 8;

  :x,y;
 };

.common.play.getEnpassPiece:{[bd;enpassStr]
  if[first[enpassStr]~"-";:" "];

  tgtX:first where (`$first enpassStr)=`a`b`c`d`e`f`g`h;
  tgtY:$["3"~last enpassStr;4;3];
  
  :bd tgtX+8*tgtY;
 };

.common.play.rmEnpassPiece:{[bd;enpassStr]
  tgtX:first where (`$first enpassStr)=`a`b`c`d`e`f`g`h;
  tgtY:$["3"~last enpassStr;4;3];

  bd[tgtX+8*tgtY]:" ";

  :bd;
 };

.common.play.isEnpassCapture:{[bd;enpassStr;movePiece;startPos;endPos]
  if[" "~.common.play.getEnpassPiece[bd;enpassStr];:0b];
  if["p"<>lower movePiece;:0b];
  if[not abs[endPos-startPos] in 7 9;:0b];

  tgtX:first where (`$first enpassStr)=`a`b`c`d`e`f`g`h;
  tgtY:8-value last enpassStr;

  :endPos~tgtX+8*tgtY;
 };

.common.play.movePiece:{[board;startPos;endPos]
  bd:.common.game.getBoard1D board;

  splitBd:" " vs board;
  sideStr:splitBd 1;
  castleStr:splitBd 2;
  enpassStr:splitBd 3;
  halfTurnStr:splitBd 4;
  fullTurnStr:splitBd 5;

  movePiece:bd[startPos];
  takenPiece:$[
    .common.play.isEnpassCapture[bd;enpassStr;movePiece;startPos;endPos];
      .common.play.getEnpassPiece[bd;enpassStr];
    bd[endPos]
  ];

  bd[startPos]:" ";
  bd[endPos]:movePiece;
  if[.common.play.isEnpassCapture[bd;enpassStr;movePiece;startPos;endPos];
    bd:.common.play.rmEnpassPiece[bd;enpassStr];
  ];

  sideStr:raze $[first[sideStr]~"w";"b";"w"];                                             // Switching sides
  res:.common.play.updateCastle[bd;castleStr;movePiece;startPos;endPos];                         // Update castling if it happened (If castling also move rook)
  bd:res 0; castleStr: res 1;
  enpassStr:.common.play.updateEnpass[movePiece;startPos;endPos];                                // Update enpassant square if it needs to change
  halfTurnStr:raze $[(movePiece~"p") or takenPiece<>" ";"0";string 1+value halfTurnStr];  // Update half turns since last pawn move or piece capture
  fullTurnStr:$[first[sideStr]~"w";string 1+value fullTurnStr;fullTurnStr];               // Update full move if new sideStr is white (ie. black just moved)

  board:" " sv (.common.play.fmtBoard1D bd;sideStr;castleStr;enpassStr;halfTurnStr;fullTurnStr);

  :(board;takenPiece);
 };
