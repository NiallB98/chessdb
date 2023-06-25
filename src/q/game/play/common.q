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

.play.isownedpiece:{[board;pos;iswhite]
  bd:.play.getboard1d board;
  :bd[pos] in $[iswhite;WHITE_PIECES;BLACK_PIECES];
 };

.play.ispiece:{[board;pos]
  bd:.play.getboard1d board;
  :bd[pos] in WHITE_PIECES,BLACK_PIECES;
 };

.play.get2dpos:{[pos]
  x:pos mod 8;
  y:pos div 8;

  :x,y;
 };
