system"l game/play/draw/showBoardUI.q";

.play.showPieces:{[lvl;board;isWhite]
  indices:lvl ss "@";
  emptySqChars:64#{x,reverse x}8#WHITE_SQUARE_CHAR,BLACK_SQUARE_CHAR;

  if[board~"";
    lvl[indices]:emptySqChars;
    :lvl;
  ];

  board1D:$[isWhite;.play.getBoard1D board;reverse .play.getBoard1D board];

  sqs:{$[x~" ";y;x]}'[board1D;emptySqChars];
  lvl[indices]:sqs;

  :lvl;
 };

.play.showTurnTaker:{[lvl;isTurn;otherPName]
  msg:$[isTurn;"Your";otherPName,"'s"];
  :autoShowMsg[lvl;msg;"`";`];
 };

.play.showPiecestaken:{[lvl;takenPcs]
  lvl:showMsg[lvl;asc takenPcs 0;16#"w";`];
  lvl:showMsg[lvl;asc takenPcs 1;16#"b";`];

  :lvl;
 };

.play.showTurnNum:{[lvl;board]
  msg:"Turn number: ",last " " vs board;
  :showMsg[lvl;msg;20#"T";`];
 };

.play.showWins:{[lvl;otherPName;wins]
  lvl:showMsg[lvl;"You:";20#"P";`];
  lvl:showMsg[lvl;string first wins;18#"!";`];
  lvl:showMsg[lvl;otherPName,":";20#"p";`];
  lvl:showMsg[lvl;string last wins;18#";";`];

  :lvl;
 };

.play.showPrompt:{[hasErrored;cd;csrd]
  $[hasErrored;:"Quit [Q], Menu [M] ";not .play.isTurn cd;:""];

  if[.play.isPromoting cd`bd;:"Promote to: Queen [Q], Rook [R], Bishop [B] ? "];
  
  if[`playing<>.play.getStatus cd`bd;:"Rematch [Y/N] ? "];

  prompt:"Up/Left/Down/Right [W/A/S/D], Quit [Q], Menu [M]";  // Base prompt

  prompt,:$[
    csrd[`pos]~csrd`pickSq;", Deselect [E] ";
    .play.isOwnedPiece[cd`bd;csrd`pos;cd`isWhite];", Select [E] ";
    -1~csrd`pickSq;" ";
    csrd[`pos] in csrd`moves;", Move [E] ";
    ", Deselect [E] "
  ];

  :prompt;
 };

.play.draw:{[cd;nd;csrd;logMsg;hasErrored]
  lvl:$[cd`isWhite;.play.level;.playFlipped.level];

  lvl:.play.showPiecestaken[lvl;cd`takenPcs];
  lvl:.play.showTurnTaker[lvl;.play.isTurn[cd];nd`other];
  lvl:.play.showPieces[lvl;cd`bd;cd`isWhite];
  lvl:autoShowMsg[lvl;logMsg;"^";`];
  lvl:.play.showTurnNum[lvl;cd`bd];
  lvl:.play.showWins[lvl;nd`other;(0;0)];  // Need to track wins
  lvl:.play.showBoardUI[lvl;cd;csrd];

  prompt:.play.showPrompt[hasErrored;cd;csrd];

  draw[lvl;prompt];
 };
