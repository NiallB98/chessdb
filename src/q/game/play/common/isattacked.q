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

.play.attackedbybishop:{[pos;board1d;iswhite]
  :0b;
 };

.play.attackedbyrook:{[pos;board1d;iswhite]
  :0b;
 };

.play.attackedbyqueen:{[pos;board1d;iswhite]
  :0b;
 };

.play.attackedbyking:{[pos;board1d;iswhite]
  checkpos:.play.getmaxkingmoves pos;
  :any{$[x;BLACK_KING_CHAR;WHITE_KING_CHAR]~y z}[iswhite;board1d]each checkpos;
 };

.play.isattacked:{[pos;board;iswhite]
  board1d:.play.getboard1d board;

  :any(
    .play.attackedbypawn[pos;board1d;iswhite],
    .play.attackedbyknight[pos;board1d;iswhite],
    .play.attackedbybishop[pos;board1d;iswhite],
    .play.attackedbyrook[pos;board1d;iswhite],
    .play.attackedbyqueen[pos;board1d;iswhite],
    .play.attackedbyking[pos;board1d;iswhite]
  );
 };
