system"l game/play/constants.q";
system"l game/play/common.q";
system"l game/play/turnLogic.q";
system"l game/play/initBoard.q";
system"l game/play/getUpdate.q";
system"l game/play/postUpdate.q";
system"l game/play/draw.q";
system"l game/play/quitGame.q";

rematchWait:{[params]
  gd:`scene`params!(`play;()!());

  nd:`name`other!(params`pName;params`otherPName);                              // Name dictionary, holds both player names
  cd:`bd`isWhite`turnDone`lastMove`takenPcs!("";params`isWhite;0b;();("";""));  // Chess dictionary, holds 1. the FEN board string, 2. whether the player is playing as white, 3. whether the player's turn is done, 4. last move start and end position (empty list if no last move), 5. Pieces that have been taken this game (First string for what white has taken and last for what black has taken)
  qd:`h`id!(hopen params`address;params`id);                                    // Query dictionary, holds the handle and player id needed for querying the server
  csrd:`pos`pickSq`moves!(-1;-1;());                                            // Cursor dictionary, holds 1. the position of the player's cursor, 2. what square they have picked (-1 if none and if picked can be 0-63 inclusive where 0 is top left (as white) and 63 bottom right), 3. the possible squares the player can move to
  wins:params`wins;                                                             // Number of wins for 1. this player and 2. the other player

  logMsg:"Game started!";
  hasErrored:0b;

  .play.draw[cd;nd;csrd;wins;logMsg;hasErrored];

  while[`play~gd`scene;
    sts:.z.p;

    input:$[hasErrored or .play.isTurn[cd];getInput[];""];          // Getting input if it is the player's turn or the server flagged an error

    

    .play.draw[cd;nd;csrd;wins;logMsg;hasErrored];

    if[(""~cd`bd) or not[hasErrored] and not .play.isTurn cd;limitFPS sts];
  ];

  :gd;
 };
