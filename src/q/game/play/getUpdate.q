.play.waitingNum:0;

.play.getPromotedMsg:{[bdStart;bdEnd;isWhite]
  bdStart1D:.play.getBoard1D bdStart;
  bdEnd1D:.play.getBoard1D bdEnd;

  case:$[not isWhite;upper;lower];  // What case the other player's pieces are

  piece:$[
    count[bdEnd1D ss case"q"]>count bdStart1D ss case"q";case"q";
    count[bdEnd1D ss case"q"]>count bdStart1D ss case"r";case"r";
    case"b"
  ];

  :case["p"]," to ",piece," promotion!";
 };

.play.hasPromoted:{[bdStart;bdEnd;isWhite]
  bdStart1D:.play.getBoard1D bdStart;
  bdEnd1D:.play.getBoard1D bdEnd;

  case:$[not isWhite;upper;lower];  // What case the other player's pieces are

  :$[
    count[bdEnd1D ss case"q"]>count bdStart1D ss case"q";1b;
    count[bdEnd1D ss case"r"]>count bdStart1D ss case"r";1b;
    count[bdEnd1D ss case"b"]>count bdStart1D ss case"b";1b;
    0b
  ];
 };

.play.getWaitingNum:{[]
  .play.waitingNum:(.play.waitingNum+1) mod 4;
  :.play.waitingNum;
 };

.play.generateMsg:{[bdStart;bdEnd;isWhite;startTknPcs;endTknPcs]
  msg:$[
    bdStart~bdEnd;(n#" "),"Waiting",(n:.play.getWaitingNum[])#".";
    .play.isChecked[bdEnd;isWhite];"You are checked!";
    .play.hasPromoted[bdStart;bdEnd;isWhite];.play.getPromotedMsg[bdStart;bdEnd;isWhite];
    not startTknPcs~endTknPcs;"Piece captured!";
    "It is your turn"
  ];

  :msg;
 };

.play.getUpdate:{[qd;board;takenPcs;isWhite]
  res:@[{x y}[qd`h];(`getUpdate;qd`id);(0b;`)];
  
  if[not[first res] or not `mid~res 1;:(0b;"<Lost connection>")];  // If error has occurred, return 0b along with the error message (Max 20 characters to display fully)

  :(1b;.play.generateMsg[board;res 2;isWhite;takenPcs;res 3];res 2;res 3;res 4);
 };
