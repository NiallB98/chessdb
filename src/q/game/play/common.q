system"l game/play/common/2dgrid.q";
system"l game/play/common/getmaxmoves.q";
system"l game/play/common/isattacked.q";
system"l game/play/common/movepiece.q";

.play.isturn:{[cd]
  :$[cd[`bd]~"";0b;cd[`iswhite]~"w"~first vs[" ";cd`bd]1];
 };

.play.getboard2d:{[board]
  bd:first " " vs board;

  n:8;
  while[n>0;
    bd:ssr[bd;string n;n#" "];  // Replacing numbers in board with the number amount of spaces
    n-:1;
  ];

  :"/" vs bd;  // Returns the whole board as a 2d list, can be indexed with [row;column] where [0;0] is the top left corner
 };

.play.getboard1d:{[board]
  :raze .play.getboard2d[board];
 };

.play.fmtboard1d:{[board1d]
  bd:-1 _ raze{x[(y*8)+til 8],"/"}[board1d]each til 8;
  :{ssr[x;y#" ";string y]}/[bd;reverse 1+til 8];
 };

.play.isownedpiece:{[board;pos;iswhite]
  bd:.play.getboard1d board;
  :bd[pos] in $[iswhite;WHITE_PIECES;BLACK_PIECES];
 };

.play.ispiece:{[board;pos]
  bd:.play.getboard1d board;
  :bd[pos] in WHITE_PIECES,BLACK_PIECES;
 };

.play.ischecked:{[board;iswhite]
  bd:.play.getboard1d board;
  kingpos:first bd ss $[iswhite;WHITE_KING_CHAR;BLACK_KING_CHAR];

  :$[kingpos~0N;0b;.play.isattacked[kingpos;board;iswhite]];
 };
