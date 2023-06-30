.play.waitingNum:0;

.play.getPromotedMsg:{[bdStart;bdEnd;isWhite]
  bdStart1D:.play.getBoard1D bdStart;
  bdEnd1D:.play.getBoard1D bdEnd;

  case:$[not isWhite;upper;lower];  // What case the other player's pieces are

  piece:$[
    count[bdEnd1D ss case"q"]>count bdStart1D ss case"q";case"q";
    count[bdEnd1D ss case"q"]>count bdStart1D ss case"r";case"r";
    case"b"
  ];

  :case["p"]," to ",piece," promotion!";
 };

.play.hasPromoted:{[bdStart;bdEnd;isWhite]
  bdStart1D:.play.getBoard1D bdStart;
  bdEnd1D:.play.getBoard1D bdEnd;

  case:$[not isWhite;upper;lower];  // What case the other player's pieces are

  :$[
    count[bdEnd1D ss case"q"]>count bdStart1D ss case"q";1b;
    count[bdEnd1D ss case"r"]>count bdStart1D ss case"r";1b;
    count[bdEnd1D ss case"b"]>count bdStart1D ss case"b";1b;
    0b
  ];
 };

.play.getWaitingNum:{[]
  .play.waitingNum:(.play.waitingNum+1) mod 4;
  :.play.waitingNum;
 };

.play.getMovedPieceMsg:{[board;lastMove]
  if[0~count lastMove;:""];  // Only possible on the first turn for the waiting player, this won't show anyway

  bd:.play.getBoard1D board;
  piece:bd[last lastMove];

  pieceStr:("Pawn";"Knight";"Bishop";"Rook";"Queen";"King")first where "pnbrqk"=lower piece;

  :pieceStr," moved";
 };

.play.getTknPcsMsg:{[startTknPcs;endTknPcs]
  startTknPcs:lower raze startTknPcs;
  endTknPcs:lower raze endTknPcs;

  baseCounts:BLACK_PIECES!count[BLACK_PIECES]#0;  // (Since the black pieces are lowercase)

  startCounts:(count each group startTknPcs)+baseCounts;
  endCounts:(count each group endTknPcs)+baseCounts;

  piece:first where not startCounts=endCounts;

  pieceStr:("Pawn";"Knight";"Bishop";"Rook";"Queen";"King")first where "pnbrqk"=lower piece;

  :pieceStr," captured!";
 };

.play.hasCastled:{[bdEnd;lastMove]
  if[0~count lastMove;:0b];

  bd:.play.getBoard1D bdEnd;

  piece:lower bd[last lastMove];
  moveLen:abs last[lastMove]-first lastMove;

  :(moveLen~2) and piece~"k";
 };

.play.getCastledMsg:{[lastMove]
  :$[0<last[lastMove]-first lastMove;"Castled Kingside";"Castled Queenside"];
 };

.play.generateMsg:{[bdStart;bdEnd;isWhite;startTknPcs;endTknPcs;lastMove]
  msg:$[
    bdStart~bdEnd;(n#" "),"Waiting",(n:.play.getWaitingNum[])#".";
    .play.isChecked[bdEnd;isWhite];"You are checked!";
    .play.hasPromoted[bdStart;bdEnd;isWhite];.play.getPromotedMsg[bdStart;bdEnd;isWhite];
    not startTknPcs~endTknPcs;.play.getTknPcsMsg[startTknPcs;endTknPcs];
    .play.hasCastled[bdEnd;lastMove];.play.getCastledMsg[lastMove];
    .play.getMovedPieceMsg[bdEnd;lastMove]
  ];

  :msg;
 };

.play.getUpdate:{[qd;board;takenPcs;isWhite]
  res:@[{x y}[qd`h];(`getUpdate;qd`id);(0b;`)];
  
  if[not[first res] or not `mid~res 1;:(0b;"<Lost connection>")];  // If error has occurred, return 0b along with the error message (Max 20 characters to display fully)

  :(1b;.play.generateMsg[board;res 2;isWhite;takenPcs;res 3;res 4];res 2;res 3;res 4);
 };
