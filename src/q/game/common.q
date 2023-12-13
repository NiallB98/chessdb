.common.game.getBoard2D:{[board]
  bd:first " " vs board;

  n:8;
  while[n>0;
    bd:ssr[bd;string n;n#" "];  // Replacing numbers in board with the number amount of spaces
    n-:1;
  ];

  :"/" vs bd;  // Returns the whole board as a 2d list, can be indexed with [row;column] where [0;0] is the top left corner
 };

.common.game.getBoard1D:{[board]
  :raze .common.game.getBoard2D[board];
 };

.common.game.isWhiteTurn:{[board]
  :"w"~first vs[" ";board]1;
 };
