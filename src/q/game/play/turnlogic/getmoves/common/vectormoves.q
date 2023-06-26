.tl.genvectormoves:{[moves;board1d;sidechars;xy;vector]
  xy+:vector;
  
  if[any (xy>7) or xy<0;:moves];  // If xy is outside the board grid, cannot move further

  pos:xy[0]+8*xy 1;
  poschar:board1d[pos];

  :$[
    poschar in sidechars;moves;                                             // Cannot move further, blocked by own side's piece
    poschar~" ";.tl.genvectormoves[moves,pos;board1d;sidechars;xy;vector];  // If position is an empty space, continue moving
    moves,pos                                                               // Otherwise poschar must be an enemy piece, do not allow further movement but append the current move
  ];
 };

.tl.adddiagonalmoves:{[moves;board;picksq;iswhite]
  sidechars:$[iswhite;WHITE_PIECES;BLACK_PIECES];
  xy:.play.get2dpos picksq;
  board1d:.play.getboard1d board;

  moves:.tl.genvectormoves[moves;board1d;sidechars;xy;(1,1)];
  moves:.tl.genvectormoves[moves;board1d;sidechars;xy;(1,-1)];
  moves:.tl.genvectormoves[moves;board1d;sidechars;xy;(-1,-1)];
  moves:.tl.genvectormoves[moves;board1d;sidechars;xy;(-1,1)];

  :moves;
 };

.tl.addorthogonalmoves:{[moves;board;picksq;iswhite]
  sidechars:$[iswhite;WHITE_PIECES;BLACK_PIECES];
  xy:.play.get2dpos picksq;
  board1d:.play.getboard1d board;

  moves:.tl.genvectormoves[moves;board1d;sidechars;xy;(1,0)];
  moves:.tl.genvectormoves[moves;board1d;sidechars;xy;(0,1)];
  moves:.tl.genvectormoves[moves;board1d;sidechars;xy;(-1,0)];
  moves:.tl.genvectormoves[moves;board1d;sidechars;xy;(0,-1)];

  :moves;
 };
