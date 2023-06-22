system"l game/play/constants.q";
system"l game/play/common.q";
system"l game/play/turnlogic.q";
system"l game/play/initboard.q";
system"l game/play/getupdate.q";
system"l game/play/postupdate.q";
system"l game/play/draw.q";
system"l game/play/quitgame.q";

play:{[params]
  gd:`scene`params!(`play;()!());

  nd:`name`other!(params`pname;params`otherpname);  // Name dictionary, holds both player names
  cd:`bd`iswhite`turndone!("";params`iswhite;0b);   // Chess dictionary, holds the FEN board string, whether the player is playing as white and whether the player's turn is done
  qd:`h`id!(hopen params`address;params`id);        // Query dictionary, holds the handle and player id needed for querying the server
  csrd:`pos`picksq!0 -1;                            // Cursor dictionary, holds the position of the player's cursor and what square they have picked (-1 if none)

  logmsg:"Game started!";
  haserrored:0b;

  .play.draw[cd;nd;logmsg;haserrored];

  while[`play~gd`scene;
    sts:.z.p;

    input:$[haserrored or .play.isturn[cd];getinput[];""];          // Getting input if it is the player's turn or the server flagged an error

    $[                                                              // Checking standard input
      input~"q";:.play.quitgame[qd;`];
      input~"m";:.play.quitgame[qd;`menu]
    ];

    if[(not ""~cd`bd) and not[haserrored] and .play.isturn cd;      // If taking turn (and not errored)
      res:.play.turnlogic[input;cd;csrd];
      cd:res 0; csrd:res 1;
    ];

    if[cd`turndone;                                                 // If turn is done
          res:.play.postupdate[qd;cd`bd];  // Send updated board to server
          haserrored:not res 0; logmsg:res 1;

          cd[`turndone]:0b; csrd[`picksq]:-1;
    ];

    if[(not ""~cd`bd) and not[haserrored] and not .play.isturn cd;  // If other player's turn (and not errored)
      res:.play.getupdate[qd;cd`bd];
      haserrored:not res 0; logmsg:res 1;

      if[not haserrored;cd[`bd]:res 2];
    ];

    if[""~cd`bd;                                                    // If waiting to get initial board from server
      res:.play.initboard[qd];
      haserrored:not res 0; logmsg:res 1;

      if[not haserrored;cd[`bd]:res 2];
    ];

    .play.draw[cd;nd;logmsg;haserrored];

    if[(""~cd`bd) or not[haserrored] and not .play.isturn cd;limitfps sts];
  ];

  :gd;
 };
