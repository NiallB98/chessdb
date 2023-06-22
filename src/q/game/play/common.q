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
