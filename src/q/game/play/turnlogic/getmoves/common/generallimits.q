.tl.notonfriendly:{[bd;iswhite;move]
  :not iswhite~bd[move] in WHITE_PIECES;
 };

.tl.notmovesonfriendly:{[moves;board;iswhite]
  bd:.play.getboard1d board;
  :moves where .tl.notonfriendly[bd;iswhite]each moves;
 };
