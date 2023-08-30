system"l game/play/constants.q";
system"l game/play/common.q";
system"l game/play/turnLogic.q";
system"l game/play/initBoard.q";
system"l game/play/getUpdate.q";
system"l game/play/postUpdate.q";
system"l game/play/draw.q";
system"l game/play/quitGame.q";

.play.canPlay:{[hasErrored;bd]
  :not[hasErrored] and not ""~bd;
 };

play:{[params]
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

    $[                                                              // Checking standard input
      not[.play.isPromoting cd`bd] and input~"q";:.play.quitGame[qd;hasErrored;`];
      not[.play.isPromoting cd`bd] and input~"m";:.play.quitGame[qd;hasErrored;`menu]
    ];
  
    if[""~cd`bd;                                                    // If waiting to get initial board from server
      res:.play.initBoard[qd];
      hasErrored:not res 0; logMsg:res 1;

      if[not hasErrored;cd[`bd]:res 2];
    ];

    if[(not ""~cd`bd) and not[hasErrored] and .play.isTurn cd;      // If taking turn (and not errored)
      res:.play.turnLogic[input;cd;csrd];
      cd:res 0; csrd:res 1;
    ];

    if[not[hasErrored] and cd`turnDone;                             // If turn is done (and not errored)
          res:.play.postUpdate[qd;cd`bd;cd`takenPcs;cd`lastMove];   // Send updated board to server
          hasErrored:not res 0; logMsg:res 1;

          cd[`turnDone]:0b; csrd[`pickSq]:-1; csrd[`pos]: -1;
    ];

    if[.play.canPlay[hasErrored;cd`bd] and not .play.isTurn cd;     // If other player's turn (and not errored)
      res:.play.getUpdate[qd;cd`bd;cd`takenPcs;cd`isWhite];
      hasErrored:not res 0; logMsg:res 1;

      if[not hasErrored;
        cd[`bd]:res 2; cd[`takenPcs]:res 3; cd[`lastMove]:res 4; if[res 5;wins+:0 1]];
    ];

    if[(`playing~.play.getStatus cd`bd) and .play.isTurn[cd] and -1~csrd`pos;
      csrd[`pos]:$[cd`isWhite;63-11;11];
    ];

    .play.draw[cd;nd;csrd;wins;logMsg;hasErrored];

    if[(""~cd`bd) or not[hasErrored] and not .play.isTurn cd;limitFPS sts];
  ];

  :gd;
 };
