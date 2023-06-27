system"l game/play/turnlogic/getmoves/common/checklimits.q";
system"l game/play/turnlogic/getmoves/common/generallimits.q";

.king.addcastlemoves:{[moves;board;picksq;iswhite]
  if[.play.ischecked[board;iswhite];:moves];  // Cannot castle if checked

  castlestr:(" " vs board)2;

  ksidestr:$[iswhite;"K";"k"];
  qsidestr:$[iswhite;"Q";"q"];

  if[all not (ksidestr,qsidestr) in castlestr;:moves];

  ksidemove:();
  qsidemove:();

  if[ksidestr in castlestr;
    mvs:picksq+(1 2);
    mvs:.tl.notmovesonfriendly[mvs;board;1b];  // Ensuring moves wont be on white pieces
    mvs:.tl.notmovesonfriendly[mvs;board;0b];  // Ensuring moves wont be on black pieces
    mvs:.tl.checklimits[mvs;board;picksq;iswhite];

    if[2~count mvs;ksidemove:picksq+2];        // If moves were ok, allow castling king-side
  ];

  if[qsidestr in castlestr;
    mvs:picksq-(1 2);
    mvs:.tl.checklimits[mvs;board;picksq;iswhite];
    mvs,:picksq-3;                             // Adding extra move to check that there is an empty space beside the rook (Doesn't matter if this square is checked)
    mvs:.tl.notmovesonfriendly[mvs;board;1b];  // Ensuring moves wont be on white pieces
    mvs:.tl.notmovesonfriendly[mvs;board;0b];  // Ensuring moves wont be on black pieces

    if[3~count mvs;qsidemove:picksq-2];        // If moves were ok, allow castling king-side
  ];

  :raze moves,ksidemove,qsidemove;
 };

.tl.kingmoves:{[board;picksq;iswhite]
  moves:0N!.play.getmaxkingmoves picksq;

  moves:0N!.tl.notmovesonfriendly[moves;board;0N!iswhite];
  moves:0N!.tl.checklimits[moves;board;picksq;iswhite];
  
  moves:0N!.king.addcastlemoves[moves;board;picksq;iswhite];

  :moves;
 };
