system"l game/play/turnlogic/getmoves/pawnlimits.q";
system"l game/play/turnlogic/getmoves/generallimits.q";
system"l game/play/turnlogic/getmoves/checklimits.q";
system"l game/play/turnlogic/getmoves/addcastlemoves.q";

.tl.getpiece:{[board;pos]
  bd:.play.getboard1d[board];
  :bd[pos];
 };

.tl.getmoves:{[cd;csrd]
  piece:.tl.getpiece[cd`bd;csrd`picksq];

  moves:.play.getmaxmoves[csrd`picksq;piece;cd`iswhite];

  if[.play.ischecked[cd`bd;cd`iswhite];moves:.tl.stopscheckmoves[moves]];                           // If checked, make sure all possible moves block check
  .tl.notcausecheckmoves[moves];                                                                    // Block moves that go in to check
  if[("k"~lower piece) and not .play.ischecked[cd`bd;cd`iswhite];moves:.tl.addcastlemoves[moves]];  // If not checked and selected piece is a king, allow castle move if possible

  if["p"~lower piece;                                  // If selected piece is pawn
    moves:.tl.limitblockedpawn[moves];                 // Allows vertical pawn moves if the spaces to move to are empty
    moves:.tl.limitpawndoublemove[moves;csrd`picksq];  // Allow double move if possible
    moves:.tl.limitpawnattacks[moves];                 // Allow attack moves if possible (has to check if en passant attack is possible too)
    :moves;                                            // Return pawn's possible moves
  ];

  if[not "n"~lower piece;moves:.tl.notblockedmoves[moves]];  // If piece is not a knight, make sure moves have no pieces between the start and endpos
  moves:.tl.notmovesonfriendly[moves];                       // Make sure endpos is either an enemy or empty

  :moves;
 };
