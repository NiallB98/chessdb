.tl.notOnFriendly:{[bd;isWhite;move]
  sidepcs:$[isWhite;WHITE_PIECES;BLACK_PIECES];
  :not bd[move] in sidepcs;
 };

.tl.notMovesonFriendly:{[moves;board;isWhite]
  bd:.play.getBoard1D board;
  :moves where .tl.notOnFriendly[bd;isWhite]each moves;
 };
