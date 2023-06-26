.play.attackedbypawn:{[pos;board1d;iswhite]
  x:pos mod 8;
  y:pos div 8;

  sign:$[iswhite;1;-1];

  checkxy:(x,y) + sign * flip ((1;-1);(-1;-1));
  checkxy:.play.rmoutofgrid checkxy;
  if[0~count checkxy;:0b];

  checkpos:{x+8*y}'[first checkxy;last checkxy];
  :any{$[x;BLACK_PAWN_CHAR;WHITE_PAWN_CHAR]~y z}[iswhite;board1d]each checkpos;
 };

.play.attackedbyknight:{[pos;board1d;iswhite]
  checkpos:.play.getmaxknightmoves pos;
  :any{$[x;BLACK_KNIGHT_CHAR;WHITE_KNIGHT_CHAR]~y z}[iswhite;board1d]each checkpos;
 };

.play.attackedbyking:{[pos;board1d;iswhite]
  checkpos:.play.getmaxkingmoves pos;
  :any{$[x;BLACK_KING_CHAR;WHITE_KING_CHAR]~y z}[iswhite;board1d]each checkpos;
 };

.play.attackedonvectorby:{[xy;board1d;vector;chars]
  xy+:vector;

  if[any (xy>7) or xy<0;:0b];  // If xy is outside the board grid, no attack on this vector is possible

  pos:xy[0]+8*xy 1;
  poschar:board1d[pos];
  
  $[
    poschar in chars;:1b;                                            // If the vector has ran into an piece from chars (ie. attacking piece), return 1b
    poschar~" ";:.play.attackedonvectorby[xy;board1d;vector;chars];  // If new position is on an empty space, run the function for the next step in the vetcor's direction
    :0b                                                              // If vector runs into piece not in chars (ie. non attacking piece) return 0b
  ];
 };

.play.attackedondiagonal:{[pos;board1d;iswhite]  // Checks for queen and bishop attacks in diagonal directions
  chars:$[iswhite;BLACK_QUEEN_CHAR,BLACK_BISHOP_CHAR;WHITE_QUEEN_CHAR,WHITE_BISHOP_CHAR];

  vectors:((1 1);(1 -1);(-1 -1);(-1 1));
  xy:(pos mod 8),pos div 8;
  :any .play.attackedonvectorby[xy;board1d;;chars]each vectors;
 };

.play.attackedonorthogonal:{[pos;board1d;iswhite]  // Checks for queen and rook attacks in orthogonal directions
  chars:$[iswhite;BLACK_QUEEN_CHAR,BLACK_ROOK_CHAR;WHITE_QUEEN_CHAR,WHITE_ROOK_CHAR];

  vectors:((1 0);(0 1);(-1 0);(0 -1));
  xy:(pos mod 8),pos div 8;
  :any .play.attackedonvectorby[xy;board1d;;chars]each vectors;
 };

.play.isattacked:{[pos;board;iswhite]
  board1d:.play.getboard1d board;

  :any(
    .play.attackedbypawn[pos;board1d;iswhite],
    .play.attackedbyknight[pos;board1d;iswhite],
    .play.attackedondiagonal[pos;board1d;iswhite],
    .play.attackedonorthogonal[pos;board1d;iswhite],
    .play.attackedbyking[pos;board1d;iswhite]
  );
 };
