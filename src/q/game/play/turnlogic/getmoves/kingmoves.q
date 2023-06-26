system"l game/play/turnlogic/getmoves/common/checklimits.q";
system"l game/play/turnlogic/getmoves/common/generallimits.q";

.king.addcastlemoves:{[moves;board;picksq;iswhite]
  if[.play.ischecked[board;iswhite];:moves];  // Cannot castle if checked

  castlestr:(" " vs board)2;

  ksidestr:$[iswhite;"K";"k"];
  qsidestr:$[iswhite;"Q";"q"];

  if[all not (ksidestr,qsidestr) in castlestr];

  ksidemove:();
  qsidemove:();

  if[ksidestr in castlestr;
    mvs:picksq+(1 2);
    mvs:.tl.notmovesonfriendly[mvs;board;1b];  // Ensuring moves wont be on white pieces
    mvs:.tl.notmovesonfriendly[mvs;board;0b];  // Ensuring moves wont be on black pieces
    mvs:.tl.checklimits[moves;board;picksq;iswhite];

    if[2~count mvs;ksidemove:picksq+2];        // If both moves were ok, allow castling king-side
  ];

  if[qsidestr in castlestr;
    mvs:picksq+(1 2);
    mvs:.tl.notmovesonfriendly[mvs;board;1b];  // Ensuring moves wont be on white pieces
    mvs:.tl.notmovesonfriendly[mvs;board;0b];  // Ensuring moves wont be on black pieces
    mvs:.tl.checklimits[moves;board;picksq;iswhite];

    if[2~count mvs;qsidemove:picksq-2];        // If both moves were ok, allow castling king-side
  ];

  :raze moves,ksidemove,qsidemove;
 };

.tl.kingmoves:{[board;picksq;iswhite]
  moves:.play.getmaxkingmoves picksq;

  moves:.tl.notmovesonfriendly[moves;board;iswhite];
  moves:.tl.checklimits[moves;board;picksq;iswhite];
  
  moves:.king.addcastlemoves[moves;board;picksq;iswhite];

  :moves;
 };
