.tl.notonfriendly:{[bd;iswhite;move]
  sidepcs:$[iswhite;WHITE_PIECES;BLACK_PIECES];
  :not bd[move] in sidepcs;
 };

.tl.notmovesonfriendly:{[moves;board;iswhite]
  bd:.play.getboard1d board;
  :moves where .tl.notonfriendly[bd;iswhite]each moves;
 };
